# ReSkill+ API (Global Solution)

![Build Status](https://dev.azure.com/{SUA_ORG_NO_AZURE}/ReSkill/_apis/build/status/ReSkill-CI?branchName=main)
## 📋 Sobre o Projeto
A **ReSkill+** é uma solução tecnológica desenvolvida como parte de uma plataforma inteligente de requalificação profissional, alinhada ao tema "O Futuro do Trabalho". 

Esta API RESTful serve como backend para registrar sessões de estudo (provenientes de dispositivos IoT ou Web), permitindo o monitoramento de hábitos de aprendizado e a personalização de trilhas de carreira. A infraestrutura é totalmente hospedada no Microsoft Azure utilizando serviços PaaS (Platform as a Service).

---

## 👨‍💻 Integrantes do Grupo
* **Vinícius De Souza Sant Anna** - RM: 556841
* **Felipe Rosa Peres** - RM: 557636
* **Pedro Henrique De Souza** - RM: 555533

---

## 🔗 Links Importantes (Entrega)
* **Azure DevOps (Board, Repos, Pipelines):** [LINK_DA_SUA_ORGANIZACAO_AQUI]
* **Vídeo de Apresentação (YouTube):** [LINK_DO_VIDEO_AQUI]
* **URL da API em Produção (Azure Web App):** `https://app-reskill-api-{SEU_NOME}.azurewebsites.net/swagger`

---

## 🏗️ Arquitetura da Solução
A solução segue uma arquitetura monolítica escalável hospedada em nuvem (PaaS).

* **API:** .NET 8.0 (Web App Service Linux)
* **Banco de Dados:** Azure SQL Database (SQL Server)
* **CI/CD:** Azure Pipelines (YAML)

### Diagrama Macro
![Desenho da Arquitetura](https://via.placeholder.com/800x400?text=Inserir+Desenho+da+Arquitetura+Aqui)
---

## 🚀 Tecnologias Utilizadas
* **.NET 8.0** (ASP.NET Core Web API)
* **Entity Framework Core 8.0** (ORM)
* **SQL Server / Azure SQL** (Persistência)
* **xUnit** (Testes Unitários e de Integração)
* **Swagger/OpenAPI** (Documentação Interativa)
* **Azure CLI** (Provisionamento de Infraestrutura)

---

## ⚙️ Configuração e Execução Local

### Pré-requisitos
* .NET SDK 8.0
* SQL Server (LocalDB ou Docker)
* Visual Studio 2022 ou VS Code

### Passo a Passo
1.  **Clonar o Repositório**
    ```bash
    git clone [https://dev.azure.com/](https://dev.azure.com/){SUA_ORG}/ReSkill/_git/ReSkill
    cd ReSkill
    ```

2.  **Configurar Banco de Dados**
    Verifique a string de conexão no `appsettings.json`. Para rodar localmente com LocalDB:
    ```json
    "ConnectionStrings": {
        "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=ReSkillDB;Trusted_Connection=True;MultipleActiveResultSets=true"
    }
    ```

3.  **Aplicar Migrations**
    No terminal, na raiz do projeto `ReSkill.API`:
    ```bash
    dotnet ef database update
    ```

4.  **Executar a Aplicação**
    ```bash
    dotnet run --project ReSkill.API
    ```
    Acesse o Swagger em: `https://localhost:7226/swagger`

5.  **Rodar Testes**
    ```bash
    dotnet test
    ```

---

## 📚 Documentação da API (JSON CRUD)

Conforme requisitos da entrega, abaixo estão os exemplos de JSON para operações de CRUD nas tabelas do sistema.

### 1. Usuários (`tb_users`)

**POST /api/v1/Auth/register** (Cadastro)
```json
{
  "email": "fiap@teste.com",
  "password": "Password123!"
}

POST /api/v1/Auth/login (Autenticação)

{
  "email": "fiap@teste.com",
  "password": "Password123!"
}

Sessões de Estudo (tb_study_sessions)
POST /api/v1/Sessions (Criação - Create)

{
  "topic": "Estudo de Azure DevOps e Pipelines",
  "durationMinutes": 120,
  "isCompleted": false
}

GET /api/v1/Sessions (Listagem - Read) Não requer corpo na requisição. Retorno:

JSON gerado:

{
  "totalItems": 1,
  "page": 1,
  "pageSize": 10,
  "items": [
    {
      "data": {
        "id": 1,
        "topic": "Estudo de Azure DevOps e Pipelines",
        "durationMinutes": 120,
        "createdAt": "2025-11-22T10:00:00",
        "isCompleted": false
      },
      "links": [ ... ]
    }
  ]
}

PUT /api/v1/Sessions/{id} (Atualização - Update) Exemplo ID 1:

JSON

{
  "id": 1,
  "topic": "Estudo de Azure DevOps - Finalizado",
  "durationMinutes": 120,
  "isCompleted": true
}

DELETE /api/v1/Sessions/{id} (Exclusão - Delete) Não requer corpo na requisição, apenas o ID na URL.

☁️ Deploy (Azure DevOps)
O deploy é realizado automaticamente via Pipeline CI/CD.

Infraestrutura: Provisionada via script (/scripts/script-infra.sh) utilizando Azure CLI.

Build: O pipeline compila o projeto e roda os testes xUnit.

Release: O artefato gerado é publicado no Azure Web App e as migrações de banco podem ser aplicadas via script SQL (/scripts/script-bd.sql).