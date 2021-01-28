/opt/tyk-dashboard/tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf &
/bin/wait-for-it.sh -t 30 localhost:3000 && \
curl \
  --data "owner_name=$ORG" \
  --data "owner_slug=$SLUG" \
  --data "email_address=$EMAIL" \
  --data "first_name=$FIRST" \
  --data "last_name=$LAST" \
  --data "password=$PASSWORD" \
  --data "confirm_password=$PASSWORD" \
  --data "terms=on" \
  localhost:3000/bootstrap

echo "/opt/tyk-dashboard/tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf" > /bin/start.sh

tail -f /dev/null
