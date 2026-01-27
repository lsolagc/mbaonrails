module Mutations
  class CreateCharacter < BaseMutation
    argument :name, String, required: true
    argument :klass, String, required: true
    argument :player, String, required: true

    type Types::CharacterType

    def resolve(name:, klass:, player:)
      Character.create!(name:, klass:, player:)
    end
  end
end
