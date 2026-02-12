# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "csv"

csv_path = Rails.root.join("db", "base_de_dados", "br_inep_avaliacao_alfabetizacao_uf.csv")

if File.exist?(csv_path)
	AvaliacaoAlfabetizacaoUf.delete_all

	CSV.foreach(csv_path, headers: true) do |row|
		attributes = row.to_h.transform_values do |value|
			value = value&.strip
			value == "" ? nil : value
		end

		AvaliacaoAlfabetizacaoUf.create!(attributes)
	end
else
	warn "CSV not found at #{csv_path}"
end
