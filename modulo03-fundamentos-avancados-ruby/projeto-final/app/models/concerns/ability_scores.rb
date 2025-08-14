require "active_support/concern"

module AbilityScores
  extend ActiveSupport::Concern

  ABILITY_SCORE_COLUMNS = %w[
    strength dexterity constitution intelligence wisdom charisma
  ].freeze

  included do
    ABILITY_SCORE_COLUMNS.each do |ability_score|
      define_method("#{ability_score}_modifier") do
        score = send(ability_score)
        (score - 10) / 2
      end
    end
  end

  class_methods do
    def delegate_ability_scores_to(target)
      ABILITY_SCORE_COLUMNS.each do |attr|
        delegate attr, "#{attr}=", "#{attr}_modifier", to: target
      end
    end
  end
end
