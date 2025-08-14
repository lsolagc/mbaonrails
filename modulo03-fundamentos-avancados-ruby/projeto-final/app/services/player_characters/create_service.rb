module PlayerCharacters
  class CreateService
    Result = Data.define(:success?, :player_character, :errors)

    def initialize(params)
      @params = params
    end

    def call
      @player_character = PlayerCharacter.new
      @player_character.combatant = Combatant.new(combatable: @player_character)
      @player_character.name = @params[:name]

      set_combatant_attributes

      if @player_character.save
        Result.new(success?: true, player_character: @player_character, errors: nil)
      else
        Result.new(success?: false, player_character: @player_character, errors: @player_character.errors.full_messages)
      end
    end

    def set_combatant_attributes
      @player_character.combatant.armor_class = @params[:armor_class] || 10
      @player_character.combatant.strength = @params[:strength] || 10
      @player_character.combatant.dexterity = @params[:dexterity] || 10
      @player_character.combatant.constitution = @params[:constitution] || 10
      @player_character.combatant.intelligence = @params[:intelligence] || 10
      @player_character.combatant.wisdom = @params[:wisdom] || 10
      @player_character.combatant.charisma = @params[:charisma] || 10
      @player_character.combatant.max_hitpoints = @params[:max_hitpoints] || 10
    end
  end
end
