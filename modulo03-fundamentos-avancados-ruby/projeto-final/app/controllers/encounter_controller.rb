class EncounterController < ApplicationController
  def simulate_encounter
    combatant_one, combatant_two = Encounters::SetupService.new(encounter_params).call

    encounter_simulator = EncounterSimulator.new(combatant_one:, combatant_two:)
    encounter_result = encounter_simulator.call

    render json: encounter_result.to_json
  end

  private
    def encounter_params
      params.expect(encounter: [ combatant_one: [ :type, :id ], combatant_two: [ :type, :id ] ])
    end
end
