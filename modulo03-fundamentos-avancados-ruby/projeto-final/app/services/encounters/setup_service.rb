module Encounters
  class SetupService
    def initialize(params)
      @params = params
    end

    def call
      combatant_one_type = @params.dig(:combatant_one, :type)
      combatant_one_id = @params.dig(:combatant_one, :id)
      combatant_one = combatant_one_type.constantize.find(combatant_one_id)

      combatant_two_type = @params.dig(:combatant_two, :type)
      combatant_two_id = @params.dig(:combatant_two, :id)
      combatant_two = combatant_two_type.constantize.find(combatant_two_id)

      [combatant_one, combatant_two]
    end
  end
end