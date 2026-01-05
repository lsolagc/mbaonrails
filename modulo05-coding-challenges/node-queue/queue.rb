class Node
  attr_accessor :val, :next

  def initialize(val)
    @val = val
    @next = nil
  end
end

class Queue
  attr_accessor :head, :tail, :size

  # pode receber um array para criar a fila
  def initialize(arr = [])
    @size = arr.length
    @queue = Array.new(@size)
    
    arr.each_with_index do |el, index|
      node = Node.new(el)
      @head ||= node
      @queue[index - 1].next = node if index > 0
      @queue[index] = node
    end

    @tail = @queue[@size - 1]
  end

  # adiciona um nó no final da fila
  def push(val)
    node = Node.new(val)
    @queue.last.next = node if @queue.last
    @queue << node
    
    @tail = node
    @size += 1
    @queue
  end

  # remove o nó do começo da fila e retorna seu valor
  def pop
    popped = @queue.pop
    @head = @queue[0]
    @size -= 1
    
    popped.val
  end

  # informa o valor no começo da fila
  def front
    @queue[0].val
  end
end
