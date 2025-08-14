require "active_support/concern"

module CombatantBehavior
  extend ActiveSupport::Concern

  class_methods do
    def behave_as_combatant
      delegate :armor_class, 
        :current_hit_points, 
        :current_hit_points=, 
        :dead?, 
        :initiative, 
        :initialize_for_combat, 
        :max_hit_points, 
        :max_hit_points=, 
        to: :combatant
    end
  end

  included do
  end
end
