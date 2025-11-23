#!/bin/bash

# --- CONFIGURAÇÃO ---
# Mude o SUFIXO para algo único (seu RM, por exemplo) para evitar conflito de nomes
SUFIXO="rm55555" 
RG_NAME="rg-gs-2025-reskill"
LOCATION="eastus2"  # Alterado de eastus para eastus2 para evitar o bloqueio
SQL_SERVER_NAME="sql-reskill-$SUFIXO"
DB_NAME="ReSkillDB"
PLAN_NAME="plan-reskill-$SUFIXO"
WEBAPP_NAME="app-reskill-$SUFIXO"
SKU="F1"

echo "--- INICIANDO PROVISIONAMENTO ($LOCATION) ---"

# 1. Criar Resource Group
echo "1. Criando Resource Group: $RG_NAME..."
az group create --name $RG_NAME --location $LOCATION

# 2. Criar Servidor SQL
echo "2. Criando SQL Server: $SQL_SERVER_NAME..."
az sql server create --name $SQL_SERVER_NAME --resource-group $RG_NAME --location $LOCATION --admin-user "fiapadmin" --admin-password "Fiap@123456"

# 3. Configurar Firewall do SQL
echo "3. Configurando Firewall..."
az sql server firewall-rule create --resource-group $RG_NAME --server $SQL_SERVER_NAME --name AllowAzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

# 4. Criar Banco de Dados
echo "4. Criando Banco de Dados: $DB_NAME..."
az sql db create --resource-group $RG_NAME --server $SQL_SERVER_NAME --name $DB_NAME --service-objective Basic

# 5. Criar App Service Plan
echo "5. Criando App Service Plan..."
az appservice plan create --name $PLAN_NAME --resource-group $RG_NAME --sku $SKU --is-linux

# 6. Criar Web App
echo "6. Criando Web App: $WEBAPP_NAME..."
az webapp create --resource-group $RG_NAME --plan $PLAN_NAME --name $WEBAPP_NAME --runtime "DOTNETCORE:8.0"

# 7. Configurar Connection String
echo "7. Configurando Connection String..."
# Atenção: As aspas aqui são cruciais. Copie exatamente até o fechamento.
CONN_STR="Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=$DB_NAME;Persist Security Info=False;User ID=fiapadmin;Password=Fiap@123456;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config connection-string set --resource-group $RG_NAME --name $WEBAPP_NAME --settings DefaultConnection="$CONN_STR" --connection-string-type SQLAzure

echo "--- SUCESSO! ---"
echo "Infraestrutura criada."
echo "Nome do Web App para usar no DevOps: $WEBAPP_NAME"