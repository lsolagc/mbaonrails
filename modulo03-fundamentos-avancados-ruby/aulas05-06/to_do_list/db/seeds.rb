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
  { title: "Comprar pão", description: "Ir à padaria", status: :in_progress, due_date: Date.today + 2 },
  { title: "Enviar relatório", description: "Relatório mensal", status: :in_progress, due_date: Date.today - 3 },
  { title: "Limpar mesa", description: "Organizar papéis", status: :in_progress, due_date: Date.today - 1 },
  { title: "Cancelar assinatura", description: "Cancelar serviço X", status: :cancelled, due_date: Date.today + 5 },
  { title: "Pagar contas", description: "Luz e água", status: :in_progress, due_date: Date.today + 1 },
  { title: "Estudar Ruby", description: "Praticar exercícios", status: :completed, due_date: Date.today - 7 },
  { title: "Reunião", description: "Equipe de vendas", status: :overdue, due_date: Date.today - 2 },
  { title: "Fazer compras", description: "Supermercado", status: :in_progress, due_date: Date.today + 3 },
  { title: "Atualizar CV", description: "Adicionar experiência", status: :completed, due_date: Date.today - 10 },
  { title: "Lavar carro", description: "Limpeza geral", status: :cancelled, due_date: Date.today + 4 },
  { title: "Enviar e-mail", description: "Para o cliente", status: :in_progress, due_date: Date.today + 7 },
  { title: "Preparar aula", description: "Conteúdo de Rails", status: :in_progress, due_date: Date.today - 5 },
  { title: "Consulta médica", description: "Check-up anual", status: :overdue, due_date: Date.today - 1 },
  { title: "Planejar viagem", description: "Roteiro e reservas", status: :in_progress, due_date: Date.today + 10 },
  { title: "Trocar senha", description: "Portal da empresa", status: :completed, due_date: Date.today - 3 },
  { title: "Renovar CNH", description: "Agendar Detran", status: :cancelled, due_date: Date.today + 8 },
  { title: "Fazer backup", description: "Arquivos importantes", status: :in_progress, due_date: Date.today + 6 },
  { title: "Comprar presente", description: "Aniversário", status: :overdue, due_date: Date.today - 4 },
  { title: "Revisar código", description: "Pull request", status: :in_progress, due_date: Date.today - 2 },
  { title: "Montar móvel", description: "Estante nova", status: :cancelled, due_date: Date.today + 9 }
].each do |task_attributes|
  Task.find_or_create_by!(task_attributes)
end
