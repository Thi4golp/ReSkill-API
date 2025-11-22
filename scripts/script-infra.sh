#!/bin/bash
# [cite: 28, 80, 147] Script para provisionar infraestrutura PaaS no Azure

# Variáveis - ALTERE O SUFIXO PARA SEU NOME/RM PARA SER ÚNICO
RG_NAME="rg-gs-2025-reskill"
LOCATION="eastus"
SQL_SERVER_NAME="sql-reskill-server" # Deve ser único globalmente
DB_NAME="ReSkillDB"
PLAN_NAME="plan-reskill-api"
WEBAPP_NAME="app-reskill-api" # Deve ser único globalmente
SKU="F1" # Free tier

# 1. Criar Resource Group
echo "Criando Resource Group..."
az group create --name $RG_NAME --location $LOCATION

# 2. Criar Servidor SQL
echo "Criando SQL Server..."
az sql server create --name $SQL_SERVER_NAME --resource-group $RG_NAME --location $LOCATION --admin-user "fiapadmin" --admin-password "Fiap@123456"

# 3. Configurar Firewall do SQL (Permitir Azure Services)
echo "Configurando Firewall..."
az sql server firewall-rule create --resource-group $RG_NAME --server $SQL_SERVER_NAME --name AllowAzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

# 4. Criar Banco de Dados
echo "Criando Banco de Dados..."
az sql db create --resource-group $RG_NAME --server $SQL_SERVER_NAME --name $DB_NAME --service-objective Basic

# 5. Criar App Service Plan
echo "Criando App Service Plan..."
az appservice plan create --name $PLAN_NAME --resource-group $RG_NAME --sku $SKU --is-linux

# 6. Criar Web App
echo "Criando Web App..."
az webapp create --resource-group $RG_NAME --plan $PLAN_NAME --name $WEBAPP_NAME --runtime "DOTNETCORE:8.0"

# 7. Configurar Connection String no Web App
echo "Configurando Connection String..."
CONN_STR="Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=$DB_NAME;Persist Security Info=False;User ID=fiapadmin;Password=Fiap@123456;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config connection-string set --resource-group $RG_NAME --name $WEBAPP_NAME --settings DefaultConnection="$CONN_STR" --connection-string-type SQLAzure

echo "Infraestrutura provisionada com sucesso!"