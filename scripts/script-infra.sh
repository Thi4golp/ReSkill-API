
SUFIXO="gs2025devops-$RANDOM"
RG_NAME="rg-reskill-gs"
LOCATION="eastus2"
SQL_SERVER="sql-server-$SUFIXO"
DB_NAME="ReSkillDB"
PLAN_NAME="plan-linux-$SUFIXO"
WEB_APP="app-reskill-$SUFIXO"

echo "Criando RG..."
az group create --name $RG_NAME --location $LOCATION

echo "Criando SQL Server ($SQL_SERVER)..."
az sql server create --name $SQL_SERVER --resource-group $RG_NAME --location $LOCATION --admin-user "fiapadmin" --admin-password "Fiap@123456"

echo "Configurando Firewall..."
az sql server firewall-rule create --resource-group $RG_NAME --server $SQL_SERVER --name AllowAzure --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

echo "Criando Banco ($DB_NAME)..."
az sql db create --resource-group $RG_NAME --server $SQL_SERVER --name $DB_NAME --service-objective Basic

echo "Criando Plan (Linux)..."
az appservice plan create --name $PLAN_NAME --resource-group $RG_NAME --sku F1 --is-linux

echo "Criando Web App ($WEB_APP)..."
az webapp create --resource-group $RG_NAME --plan $PLAN_NAME --name $WEB_APP --runtime "DOTNETCORE:8.0"

echo "Configurando Connection String..."
STR="Server=tcp:$SQL_SERVER.database.windows.net,1433;Initial Catalog=$DB_NAME;Persist Security Info=False;User ID=fiapadmin;Password=Fiap@123456;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
az webapp config connection-string set --resource-group $RG_NAME --name $WEB_APP --settings DefaultConnection="$STR" --connection-string-type SQLAzure

echo "CONCLUIDO! Seu Web App: $WEB_APP"