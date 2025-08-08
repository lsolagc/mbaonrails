class Combatant < ApplicationRecord
  belongs_to :combatable, polymorphic: true
end
