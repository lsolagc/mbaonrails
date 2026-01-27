# Configuração do PostgreSQL - Passo a Passo

## Problema Encontrado
Ao executar `rails db:create`, o seguinte erro ocorria:
```
connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: 
FATAL: password authentication failed for user "backend_development"
```

## Solução Aplicada

### Passo 1: Criar o Usuário PostgreSQL
Execute o comando abaixo como superusuário do PostgreSQL:
```bash
sudo -u postgres psql -c "CREATE USER backend_development WITH PASSWORD 'backend_development';"
```

**O que faz:** Cria um novo usuário chamado `backend_development` com a senha `backend_development` no PostgreSQL.

---

### Passo 2: Conceder Permissão de Criar Banco de Dados
```bash
sudo -u postgres psql -c "ALTER USER backend_development WITH CREATEDB;"
```

**O que faz:** Concede ao usuário `backend_development` a permissão de criar novos bancos de dados.

---

### Passo 3: Atualizar o arquivo `config/database.yml`

#### 3.1 Seção `development`
Descomente a linha `host: localhost` para forçar o uso de conexão TCP em vez de socket Unix:

```yaml
development:
  <<: *default
  database: backend_development
  username: backend_development
  password: backend_development
  host: localhost  # ← Descomente esta linha
```

#### 3.2 Seção `test`
Adicione as credenciais explicitamente:

```yaml
test:
  <<: *default
  database: backend_test
  host: localhost
  username: backend_development
  password: backend_development
```

---

### Passo 4: Criar os Bancos de Dados
```bash
rails db:create
```

**Saída esperada:**
```
Database 'backend_development' already exists
Created database 'backend_test'
```

---

## Por que isso funcionou?

1. **Problema de autenticação**: O usuário `backend_development` não existia no PostgreSQL
2. **Problema de socket vs TCP**: O Rails estava tentando usar socket Unix (`/var/run/postgresql/.s.PGSQL.5432`), que tinha problemas de autenticação
3. **Solução**: Ao habilitar `host: localhost`, forçamos o Rails a usar conexão TCP com as credenciais de usuário/senha, que funcionam corretamente

---

## Próximos Passos
Agora você pode:
- Executar migrações: `rails db:migrate`
- Iniciar o servidor: `rails s -p 3000`
- Rodar testes: `rails test`

