ReSkill+

Sobre o Projeto
A ReSkill+ é uma solução tecnológica desenvolvida como parte de uma plataforma inteligente de requalificação profissional. Alinhada ao tema "O Futuro do Trabalho", a API serve como backend para registrar sessões de estudo provenientes de dispositivos IoT, 
permitindo o monitoramento de hábitos de aprendizado e a personalização de trilhas de carreira.

## 🚀 Tecnologias Utilizadas
- .NET 8.0 (ASP.NET Core Web API)
- Entity Framework Core (ORM)
- SQL Server (Banco de Dados)
- xUnit (Testes Integrados/Unitários)
- Swagger/OpenAPI (Documentação)

## ⚙️ Funcionalidades e Requisitos Atendidos

1. Boas Práticas REST
- Implementação completa dos verbos HTTP: `GET`, `POST`, `PUT`, `DELETE`.
- Paginação: Endpoint de listagem suporta parâmetros `page` e `pageSize`.
- HATEOAS: As respostas da API incluem links de navegação (`self`, `update`, `delete`) para guiar o cliente.
- Códigos de status HTTP corretos (`200`, `201`, `404`, etc.).

2. Monitoramento e Observabilidade
- Health Check: Endpoint acessível em `/health` para verificar a saúde da aplicação.
- Logging: Logs implementados no Controller para rastreabilidade de operações.

3. Versionamento da API
- Versionamento por URL implementado.
- Rota padrão: `/api/v1/[controller]`.

4. Persistência de Dados
- Utilização do SQL Server via Entity Framework Core.
- Uso de Migrations para controle de versão do banco de dados.

## 🛠️ Como Rodar o Projeto

1. Configurar Banco de Dados:
   Certifique-se de ter o SQL Server (ou LocalDB) instalado. A connection string padrão está configurada no `appsettings.json`.

2. Aplicar Migrations:
   Pelo Console do Gerenciador de Pacotes do Visual Studio, execute:
   "Update-Database"

3. Executar a API:
   Abra a solução no Visual Studio 2022 e execute o projeto ReSkill.API. O Swagger será aberto automaticamente em: https://localhost:7226/swagger

4. Rodar Testes:
   Utilize o Test Explorer do Visual Studio para executar a suíte de testes ReSkill.Tests

## 📝 Exemplo de Requisição (JSON)

Para testar a criação de uma nova sessão de estudo (POST), envie o seguinte JSON no corpo da requisição para o endpoint `/api/v1/Sessions`:
{
  "topic": "Estudo de Arquitetura de Software",
  "durationMinutes": 120,
  "isCompleted": true
}

## Integrantes do grupo 
- Vinícius De Souza Sant Anna (556841)
- Felipe Rosa Peres (557636)
- Pedro Henrique De Souza (555533)