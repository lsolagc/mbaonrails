module PlayerCharacters
  class DestroyService
    Result = Data.define(:success?, :player_character, :errors)

    def initialize(player_character)
      @player_character = player_character
    end

    def call
      if @player_character.destroy
        Result.new(success?: true, player_character: @player_character)
      else
        Result.new(success?: false, errors: @player_character.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotFound => e
      Result.new(success?: false, errors: [e.message])
    end
  end
end