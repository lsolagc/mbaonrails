class AvaliacaoAlfabetizacaoUf < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[sigla_uf ano]
  end
end
