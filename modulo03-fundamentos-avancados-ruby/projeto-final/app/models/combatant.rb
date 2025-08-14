class Combatant < ApplicationRecord
  delegated_type :combatable, types: %w[ PlayerCharacter ]
end
