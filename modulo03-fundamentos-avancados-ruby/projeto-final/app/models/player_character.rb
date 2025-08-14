class PlayerCharacter < ApplicationRecord
  include AbilityScores
  include CombatantBehavior

  behave_as_combatant
  delegate_ability_scores_to :combatant

  has_one :combatant, as: :combatable, touch: true, dependent: :destroy

  def attack(target:)
    raise ArgumentError, "Target must be a Combatant" unless target.respond_to?(:combatant)

    attack_roll = rand(1..20)
    if attack_roll >= target.armor_class
      damage = rand(1..4) + strength_modifier
      target.take_damage(amount: damage)
      { success: true, attack_roll: attack_roll, damage: damage, message: "Hit!" }
    else
      { success: false, attack_roll: attack_roll, message: "Miss!" }
    end
  end

  def take_damage(amount:)
    raise ArgumentError, "Amount must be a positive Integer" unless amount.is_a?(Integer) && amount.positive?

    self.current_hit_points ||= max_hit_points
    self.current_hit_points -= amount

    if current_hit_points <= 0
      self.current_hit_points = 0
    end
  end
end
