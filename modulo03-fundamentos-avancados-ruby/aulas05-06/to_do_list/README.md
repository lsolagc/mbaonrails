# Exercicio Aula 05 e 06

## Criando uma API de Tarefas com Rails

### Tecnologias

- Ruby 3.4
- Rails 8.0
- psql (PostgreSQL) 16.9
- SolidQueue
- Ransack

### Setup

Clone o repositório
```bash
git clone git@github.com:lsolagc/mbaonrails.git
```

Entre na pasta da aplicação
```bash
cd mbaonrails/modulo03-fundamentos-avancados-ruby/aulas05-06/to_do_list/
```

Execute os seguintes comandos para criar e executar as migrações, e povoar o banco com algumas tarefas de teste
```bash
rails db:migrate
rails db:seed
```

Inicie o servidor local
```bash
rails s
```

### Exemplos de utilização da API

#### Listar todas as tarefas
```bash
curl -X GET localhost:3000/tasks
```

O comando acima retorna
```json
[
  {"id":1,"title":"Comprar pão","description":"Ir à padaria","status":"in_progress","due_date":"2025-07-20"},
  {"id":2,"title":"Enviar relatório","description":"Relatório mensal","status":"overdue","due_date":"2025-07-15"},
  {"id":3,"title":"Limpar mesa","description":"Organizar papéis","status":"overdue","due_date":"2025-07-17"}
  // e assim vai
]
```

#### Listar tarefas que atendem algum critério específico
Você pode filtrar a lista de tarefas usando os [Search Matchers do Ransack](https://activerecord-hackery.github.io/ransack/getting-started/search-matches/) em conjunto com um dos seguintes campos: `title`, `description`, `status`, `created_at`, `due_date`.
```bash
curl -X GET localhost:3000/tasks -d 'q[status_eq]=completed'
curl -X GET localhost:3000/tasks -d 'q[due_date_lt]=2025-07-18'
curl -X GET localhost:3000/tasks -d 'q[created_at]=2025-07-18'
```

Para buscar tarefas criadas em uma data específica, você pode usar o `created_on`, um ransacker customizado.
```bash
curl -X GET localhost:3000/tasks -d 'q[created_on]=2025-07-18'
```

#### Exibindo detalhes de uma tarefa
```bash
curl -X GET localhost:3000/tasks/1
```

O comando acima retorna 
```json
{
  "id": 1,
  "title": "Comprar pão",
  "description": "Ir à padaria",
  "status": "in_progress",
  "due_date": "2025-07-20",
  "created_at": "2025-07-19T02:24:55.899Z",
  "updated_at": "2025-07-19T02:24:55.899Z"
}
```

#### Criar nova tarefa
```bash
curl -X POST localhost:3000/tasks \
-H "Content-Type: application/json" \
-d '{ "task": {"title": "Tarefa vencida", "description": "Tarefa vencida", "due_date": "2025-07-15"}}'
```

O comando acima retorna a tarefa criada
```json
{
  "id": 21,
  "title": "Tarefa vencida",
  "description": "Tarefa vencida",
  "status": "in_progress",
  "due_date": "2025-07-15",
  "created_at": "2025-07-19T02:40:29.087Z",
  "updated_at": "2025-07-19T02:40:29.087Z"
}
```

#### Atualizar tarefa
```bash
curl -X PUT localhost:3000/tasks/21 \
-H "Content-Type: application/json" \
-d '{ "task": {"status": "completed"}}'
```

O comando acima retorna a tarefa atualizada
```json
{
  "status": "completed",
  "id": 21,
  "title": "Tarefa vencida",
  "description": "Tarefa vencida",
  "due_date": "2025-07-15",
  "created_at": "2025-07-19T02:40:29.087Z",
  "updated_at": "2025-07-19T02:41:42.072Z"
}
```

#### Deletar tarefa
```bash
curl -X DELETE localhost:3000/tasks/21 \
-H "Content-Type: application/json"
```

Deletar uma tarefa apenas marca ela como "cancelada", e não retorna a tarefa em si. Para checar que ela está cancelada, é necessário consultar a tarefa "destruída".
```json
{
  "id": 21,
  "title": "Tarefa vencida",
  "description": "Tarefa vencida",
  "status": "cancelled",
  "due_date": "2025-07-15",
  "created_at": "2025-07-19T02:40:29.087Z",
  "updated_at": "2025-07-19T02:43:12.103Z"
}
```

#### Tarefas vencidas
A aplicação possui um job que marca todas as tarefas em progresso com data de entrega no passado como `overdue` (vencidas).

Para ver o job rodando automaticamente e ao vivo, execute o seguinte comando em seu terminal e aguarde alguns minutos. O job está programado para rodar a cada minuto.
```bash
bin/jobs start
```