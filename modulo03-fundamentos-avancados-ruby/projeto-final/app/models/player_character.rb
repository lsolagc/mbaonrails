class PlayerCharacter < ApplicationRecord
  include AbilityScores
  include CombatantBehavior

  behave_as_combatant
  delegate_ability_scores_to :combatant

  has_one :combatant, as: :combatable, touch: true, dependent: :destroy

end
