if [ ! -f .env ]
then
  cp .env.example .env
  tput setaf 2; echo "Created .env file."
fi

vim .env

sleep 1

if grep -q "TYK_LICENSE_KEY=." .env
then
  tput setaf 2; echo "Tyk Pro is configured."
fi

if grep -q "DATADOG_API_KEY=." .env
then
  tput setaf 2; echo "Datadog is configured."
fi
