class PlayerCharacter < ApplicationRecord
  include AbilityScores
  delegate_ability_scores_to :combatant

  has_one :combatant, as: :combatable, touch: true, dependent: :destroy

end
