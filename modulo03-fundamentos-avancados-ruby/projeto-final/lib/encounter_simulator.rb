class EncounterSimulator
  include Enumerable

  THREAD_LIMIT = 20
  COMBATS_PER_THREAD = 100

  def initialize(combatant_one:, combatant_two:)
    @mutex = Mutex.new
    @simulation_results = []
    @combatant_one = combatant_one
    @combatant_two = combatant_two
    @combatant_assc_one = @combatant_one.combatant
    @combatant_assc_two = @combatant_two.combatant
  end

  def each(&)
    @simulation_results.each(&)
  end

  def call
    # Eu quero executar dois mil combates
    # Cada thread deve executar 100 combates sequencialmente
    # O resultado de cada combate deve ser inserido em um array, sem ordem específica
    # Pelo meu entendimento, a inserção do resultado no array deve ser thread-sage, então deve estar encapsulada em um Mutex
    # Ao final, o array deve estar disponível para ser usado em outros métodos chamados no objeto EncounterSimulator
    @threads = Array.new(THREAD_LIMIT)
    THREAD_LIMIT.times do |i|
      @threads[i] = Thread.new do
        initialize_thread_variables

        COMBATS_PER_THREAD.times do
          result = run_single_combat(Thread.current[:combatant_one], Thread.current[:combatant_two])
          @mutex.synchronize do
            @simulation_results << result
          end
        end
      end
    end
    @threads.each(&:join)

    consolidate_results
  end

  def initialize_thread_variables
    Thread.current[:combatant_one] = @combatant_one.deep_dup
    Thread.current[:combatant_one].combatant = @combatant_assc_one.deep_dup

    Thread.current[:combatant_two] = @combatant_two.deep_dup
    Thread.current[:combatant_two].combatant = @combatant_assc_two.deep_dup
  end

  def run_single_combat(c1, c2)
    # Aqui deve estar a lógica de um único combate
    initialize_hit_points(c1, c2)

    roll_initiative(c1, c2)

    Thread.current[:round_number] = 0

    loop do
      break if encounter_over?(c1, c2)

      Thread.current[:round_number] = Thread.current[:round_number] + 1
      execute_round(c1, c2)
    end

    cleanup(c1, c2)
  end

  private

    def initialize_hit_points(c1, c2)
      c1.initialize_for_combat
      c2.initialize_for_combat
    end

    def roll_initiative(c1, c2)
      initiative_rolls = {}

      initiative_rolls[c1] = c1.initiative + rand(1..20)
      initiative_rolls[c2] = c2.initiative + rand(1..20)

      Thread.current[:round_order] = initiative_rolls.sort_by { |_, roll| -roll }.to_h
      Thread.current[:round_order]
    end

    def execute_round(c1, c2)
      Thread.current[:round_order].each do |combatant, _initiative_roll|
        next if combatant.dead?

        target = combatant == c1 ? c2 : c1

        combatant.attack(target: target)
      end
    end

    def encounter_over?(c1, c2)
      c1.dead? || c2.dead?
    end

    def cleanup(c1, c2)
      if c1.dead?
        winner = @combatant_two
      elsif c2.dead?
        winner = @combatant_one
      else
        winner = [ Struct.new(:name) { "No winner" } ]
      end

      {
        winner: winner,
        number_of_rounds: Thread.current[:round_number],
      }
    end

    def consolidate_results
      combatant_one_key = "combatant_one_#{@combatant_one.name}".to_sym
      combatant_two_key = "combatant_two_#{@combatant_two.name}".to_sym
      combatant_one_wins = @simulation_results.count { |result| result[:winner] == @combatant_one}

      combatant_two_wins = @simulation_results.count { |result| result[:winner] == @combatant_two}

      average_rounds = (@simulation_results.sum{ |sr| sr[:number_of_rounds] }.to_f / @simulation_results.size).ceil

      {
        total_combats: @simulation_results.size,
        number_of_wins: {
          combatant_one_key => combatant_one_wins,
          combatant_two_key => combatant_two_wins,
        },
        percentage_of_wins: {
          combatant_one_key => (combatant_one_wins.to_f / @simulation_results.size * 100).round(2),
          combatant_two_key => (combatant_two_wins.to_f / @simulation_results.size * 100).round(2),
        },
        average_rounds_per_combat: average_rounds,
      }
    end
end