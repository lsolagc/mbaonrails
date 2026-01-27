# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  {
    title: "Revisar e-mails",
    description: "Revisar e-mails",
    deadline: "2026-01-20"
  },
  {
    title: "Exercícios matinais",
    description: "Sessão completa de exercícios físicos para manter a saúde e a disposição ao longo do dia",
    deadline: "2026-01-22"
  },
  {
    title: "Alongamento diário",
    description: "Alongamento diário",
    deadline: "2026-01-24"
  },
  {
    title: "Organizar finanças pessoais",
    description: "Atualizar planilha de gastos, conferir contas e planejar o orçamento do próximo mês",
    deadline: "2026-01-25"
  },
  {
    title: "Backup do celular",
    description: "Backup do celular",
    deadline: "2026-01-27"
  }
].each do |hash|
  Task.create(
    title: hash[:title],
    description: hash[:description],
    deadline: Date.parse(hash[:deadline])
  )
end
