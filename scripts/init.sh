cp .env.example .env
vim .env

sleep 1

if grep -q "TYK_LICENSE_KEY=." .env
then
  tput setaf 2; echo "Tyk Pro configured."
fi

if grep -q "DATADOG_API_KEY=." .env
then
  tput setaf 2; echo "Datadog configured."
fi
