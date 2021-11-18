./raava -bootstrap -user="$PORTAL_EMAIL" -pass="$PORTAL_PASSWORD" -provider-name "TykPro@localhost" -provider-type "tyk-pro" -provider-data "{\"URL\":\"http://${DASHBOARD_HOST}:${DASHBOARD_PORT}\",\"Secret\":\"$PORTAL_USER_TOKEN\",\"OrgID\":\"$PORTAL_ORG_ID\"}" &

# Wait for dashboard to open connection.
/bin/wait-for-it.sh -t 300 localhost:$PORTAL_PORT

echo "./raava" > /bin/start.sh

# Restart Raava Portal
echo "\nRestarting Raava...\n"
kill `ps | grep "raava" | awk '{ print $1 }'`
./raava
