read -n2048 -s -p 'Please enter your Tyk Pro License key: ' license_key
echo LICENSE_KEY=$license_key >> .env
echo

tput setaf 2; echo "Tyk Pro configured. Navigate to the the tyk folder to run Tyk Pro using docker-compose."
