# Módulo 03 - Projeto Final

## Simulador de Combate!
Este projeto expõe uma API para criar personagens baseados na quinta edição do sistema de RPG Dungeons and Dragons, e simular combates entre dois personagens selecionados pelo usuário.

Os combates simulados são simples:
- todos os participantes só podem utilizar a ação de Ataque;
- todos os ataques causam (1d4 + modificador de força do atacante) de dano;
- um ataque atinge seu alvo se a rolagem de acerto for igual ou maior que a `armor_class` do alvo;
- movimento, ações bônus e reações não são simulados.

A simulação de combate retorna um JSON contendo a quantidade de combates simulados, a quantidade e porcentagem de vitórias de cada combatente, e a duração média dos combates (em rounds).

### Tecnologias

- Ruby 3.4
- Rails 8.0
- psql (PostgreSQL) 16.9

### Setup

Clone o repositório
```bash
git clone git@github.com:lsolagc/mbaonrails.git
```

Entre na pasta da aplicação
```bash
cd mbaonrails/modulo03-fundamentos-avancados-ruby/projeto-final
```

Execute os seguintes comandos para criar e executar as migrações, e povoar o banco com algumas tarefas de teste
```bash
rails db:create
rails db:migrate
```

Inicie o servidor local
```bash
rails s
```

### Exemplos de utilização da API

#### Criar um personagem
```bash
curl -X POST localhost:3000/player_characters \
  -H "Content-Type: application/json" \
  -d '{
    "player_character": {
      "name": "Aragorn",
      "armor_class": 13,
      "strength": 15,
      "dexterity": 12,
      "constitution": 14,
      "intelligence": 9,
      "wisdom": 11,
      "charisma": 10,
      "max_hitpoints": 20
    }
  }'
```

O comando acima retorna
```json
{
  "id": 1,
  "name": "Aragorn",
  "created_at": "2025-08-15T23:20:53.959Z",
  "updated_at": "2025-08-15T23:20:53.959Z"
}
```

#### Listar todos os personagens
```bash
curl -X GET localhost:3000/player_characters
```

O comando acima retorna
```json
[
  {
    "id": 1,
    "name": "Aragorn"
  },
  {
    "id": 2,
    "name": "Legolas"
  }
]
```

#### Exibir detalhes de um personagem
```bash
curl -X GET localhost:3000/player_characters/1
```

O comando acima retorna
```json
{
  "id": 1,
  "name": "Aragorn",
  "created_at": "2025-08-15T23:20:53.959Z",
  "updated_at": "2025-08-15T23:20:53.959Z"
}
```

#### Deletar personagem
```bash
curl -X DELETE localhost:3000/player_characters/1 \
-H "Content-Type: application/json"
```

O comando acima retorna 204 No Content. Para confirmar que o personagem foi deletado, é necessário consultar o personagem específico ou a lista de personagens.

#### Simular combate entre dois personagens
```bash
curl -X POST localhost:3000/simulate_encounter \
  -H "Content-Type: application/json" \
  -d '{
    "encounter": {
      "combatant_one": {
        "type": "PlayerCharacter",
        "id": 1
      },
      "combatant_two": {
        "type": "PlayerCharacter",
        "id": 2
      }
    }
  }'
```

O comando acima retorna
```json
{
  "total_combats": 2000,
  "number_of_wins": {
    "combatant_one_Legolas": 1017,
    "combatant_two_Aragorn": 983
  },
  "percentage_of_wins": {
    "combatant_one_Legolas": 50.85,
    "combatant_two_Aragorn": 49.15
  },
  "average_rounds_per_combat": 10
}
```
