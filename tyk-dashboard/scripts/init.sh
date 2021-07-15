# Start Tyk Dashboard.
if [ "$1" = "dev" ]; then
  echo "Development mode selected"
  go run main.go &
else
  /opt/tyk-dashboard/tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf &
fi

# Wait for dashboard to open connection.
/bin/wait-for-it.sh -t 300 localhost:$TYK_DB_LISTENPORT

# Bootstrap Tyk dashboard with default organisation.
curl -X POST localhost:$TYK_DB_LISTENPORT/bootstrap \
  --data "owner_name=$ORG" \
  --data "owner_slug=$SLUG" \
  --data "email_address=$EMAIL" \
  --data "first_name=$FIRST" \
  --data "last_name=$LAST" \
  --data "password=$PASSWORD" \
  --data "confirm_password=$PASSWORD" \
  --data "terms=on"

# Get organisation ID.
ORG=`curl -X GET localhost:$TYK_DB_LISTENPORT/admin/organisations \
  --header "admin-auth: 12345" | \
  jq -r '.organisations[0].id'`

# Create a new admin user and get user access token.
TOKEN=`curl -X POST localhost:$TYK_DB_LISTENPORT/admin/users \
  --header "admin-auth: 12345" \
  --data "{
    \"org_id\": \"$ORG\",
    \"first_name\": \"Admin\",
    \"last_name\": \"User\",
    \"email_address\": \"admin@tyk.io\",
    \"active\": true,
    \"user_permissions\": { \"IsAdmin\": \"admin\" }
  }" | \
  jq -r '.Message'`

# Create Portal.
curl -X POST localhost:$TYK_DB_LISTENPORT/api/portal/configuration \
  --header "Authorization: $TOKEN" \
  --data "{}"

# Initialize Catalogue.
curl -X POST localhost:$TYK_DB_LISTENPORT/api/portal/catalogue \
  --header "Authorization: $TOKEN" \
  --data "{
    \"org_id\": \"$ORG\"
  }"

# Create Portal Home Page.
curl -X POST localhost:$TYK_DB_LISTENPORT/api/portal/pages \
  --header "Authorization: $TOKEN" \
  --data "{
    \"is_homepage\": true,
    \"template_name\": \"\",
    \"title\": \"Developer Portal Home\",
    \"slug\": \"/\",
    \"fields\": {
      \"JumboCTATitle\": \"Tyk Developer Portal\",
      \"SubHeading\": \"Sub Header\",
      \"JumboCTALink\": \"#cta\",
      \"JumboCTALinkTitle\": \"Your awesome APIs, hosted with Tyk!\",
      \"PanelOneContent\": \"Panel 1 content.\",
      \"PanelOneLink\": \"#panel1\",
      \"PanelOneLinkTitle\": \"Panel 1 Button\",
      \"PanelOneTitle\": \"Panel 1 Title\",
      \"PanelThereeContent\": \"\",
      \"PanelThreeContent\": \"Panel 3 content.\",
      \"PanelThreeLink\": \"#panel3\",
      \"PanelThreeLinkTitle\": \"Panel 3 Button\",
      \"PanelThreeTitle\": \"Panel 3 Title\",
      \"PanelTwoContent\": \"Panel 2 content.\",
      \"PanelTwoLink\": \"#panel2\",
      \"PanelTwoLinkTitle\": \"Panel 2 Button\",
      \"PanelTwoTitle\": \"Panel 2 Title\"
    }
  }"

# Set Protal CNAME.
curl -X PUT localhost:$TYK_DB_LISTENPORT/api/portal/cname \
  --header "Authorization: $TOKEN" \
  --data "{
    \"cname\": \"\"
  }"

# Overwrite init script.
if [ "$1" = "dev" ]; then
  echo "go run main.go" > /bin/start.sh
else
  echo "/opt/tyk-dashboard/tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf" > /bin/start.sh
fi

echo "\nRestarting Dashboard...\n"
echo TYK_TOKEN="$TOKEN" >> $HOME/.bashrc

bash /opt/tyk-dashboard/resources/apply.sh

# Restart Tyk Dashboard
if [ "$1" = "dev" ]; then
  kill `ps | grep "go run main.go" | awk '{ print $1 }'`
  go run main.go
else
  kill `ps | grep "tyk-analytics" | awk '{ print $1 }'`
  /opt/tyk-dashboard/tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf
fi
