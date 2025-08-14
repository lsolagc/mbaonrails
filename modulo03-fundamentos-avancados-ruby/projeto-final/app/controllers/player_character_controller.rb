class PlayerCharacterController < ApplicationController
  before_action :set_player_character, only: %i[ show destroy ]

  def index
    @player_characters = PlayerCharacter.all

    render json: @player_characters.as_json(only: [:id, :name, :max_hitpoints])
  end

  def show
    render json: @player_character
  end

  def create
    create_service = PlayerCharacters::CreateService.new(player_character_params).call

    if create_service.success?
      render json: create_service.player_character, status: :created
    else
      render json: create_service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    destroy_service = PlayerCharacters::DestroyService.new(@player_character).call
    if destroy_service.success?
      head :no_content
    else
      render json: destroy_service.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_character
      @player_character = PlayerCharacter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def player_character_params
      params.expect(player_character: [ :name, :armor_class, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :max_hitpoints ])
    end
end
