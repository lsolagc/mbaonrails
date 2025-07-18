# Exercício: ThreadPool dinâmica com fila de prioridade
# 
# Contexto:
# Você está desenvolvendo um sistema de processamento de tarefas em background que deve lidar com múltiplas prioridades. Para isso, deseja implementar sua própria ThreadPool dinâmica, capaz de:
#   - Executar tarefas concorrentes com múltiplas Threads.
# - Usar filas de prioridade (:high, :medium, :low) para
# gerenciar a ordem de execução
#   - Permitir o aumento ou redução do número de Threads
# ativamente consumindo tarefas
#
# Objetivo:
# Implemente as seguintes classes:
#   1. PriorityQueue
#     Uma classe thread-safe que:
#       - Mantém várias filas (Queue) associadas a diferentes prioridades
#       - Permite adicionar tarefas com prioridade específica
#       - Retorna a próxima tarefa disponível com a mais alta prioridade disponível
#   2. DynamicThreadPool
#     Uma classe com:
#       - Um número inicial de Threads (ex: 2).
#       - Capacidade de crescer até um número máximo de Threads (ex: até 10) dinamicamente
#       - Acesso a métodos como schedule(priority = :medium, &block) para adicionar tarefas.
#       - Remoção de threads mortas dinamicamente
#
# Exemplo de uso:
# pool = DynamicThreadPool.new(max_threads: 3)
# 10.times do |i|
#   pool.schedule(:default) { sleep 1; puts "Tarefa padrão #{i} concluída" }
# end
# 5.times do |i|
#   pool.schedule(:high) { sleep 0.5; puts "Tarefa prioritária #{i} concluída" }
# end
# pool.shutdown # => termina a execução de todas as Threads
# 

class PriorityQueue
  def initialize
    @queues = {
      high: Queue.new,
      medium: Queue.new,
      low: Queue.new
    }
    @mutex = Mutex.new
  end

  def add(priority, &block)
    priority = priority.to_sym
    priority = :medium if priority == :default
    raise ArgumentError, "Prioridade inválida. Escolha entre :high, :medium, :low, ou :default" unless @queues.key?(priority)

    @mutex.synchronize do
      @queues[priority].push(block)
    end
  end

  def next_task
    @mutex.synchronize do
      [:high, :medium, :low].each do |priority|
        if !@queues[priority].empty?
          return @queues[priority].pop(true) rescue nil 
        end
      end
      nil
    end
  end

  def empty?
    @queues.values.all?(&:empty?)
  end
end

class DynamicThreadPool
  INITIAL_THREADS = 2

  def initialize(max_threads: 10)
    @max_threads = max_threads
    @current_threads = 0
    @queue = PriorityQueue.new
    @mutex = Mutex.new
    @threads = []
    @running = true
    
    INITIAL_THREADS.times { create_thread }

    monitor_threads
  end

  def schedule(priority, &block)
    @mutex.synchronize do
      @queue.add(priority, &block)
      create_thread if @current_threads < @max_threads && @threads.all?(&:stop?)
    end
  end

  def shutdown
    @running = false
    @threads.each(&:join) # Aguarda todas as threads terminarem
    @threads = []
    @current_threads = 0
  end

  private
    def create_thread
      return if @current_threads >= @max_threads

      thread = Thread.new do
        loop do
          task = @queue.next_task
          if task
            task.call
          else
            break unless @running || !@queue.empty?
            sleep 0.1 # Evita busy-waiting
          end
        end
      end

      @threads << thread
      @current_threads += 1
    end

    def monitor_threads
      Thread.new do
        loop do
          @mutex.synchronize do
            @threads.reject! do |thread|
              if thread.alive?
                false
              else
                @current_threads -= 1
                true
              end
            end
          end
          break unless @running
        end
      end
    end
end

pool = DynamicThreadPool.new(max_threads: 3)
10.times do |i|
  pool.schedule(:default) { sleep 1; puts "Tarefa padrão #{i} concluída" }
end
5.times do |i|
  pool.schedule(:high) { sleep 0.5; puts "Tarefa prioritária #{i} concluída" }
end
10.times do |i|
  pool.schedule(:default) { sleep 1; puts "Tarefa padrão #{i + 10} concluída" }
end
pool.shutdown
