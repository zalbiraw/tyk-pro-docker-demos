#!/bin/sh

source $HOME/.bashrc

curl -X POST localhost:$TYK_DB_LISTENPORT/api/apis \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
    \"api_definition\":{
      \"active\":true,
      \"name\":\"Auth Token\",
      \"slug\":\"auth-token\",
      \"proxy\":{
        \"target_url\":\"http://httpbin.org\",
        \"strip_listen_path\":true,
        \"listen_path\":\"/auth-token/\"
      },
      \"version_data\":{
        \"not_versioned\":true,
        \"versions\":{
          \"Default\":{
            \"name\":\"Default\"
          }
        }
      },
      \"auth_configs\":{
        \"authToken\":{
          \"auth_header_name\":\"Authorization\"
        }
      }
    }
  }"

APIID=`curl -X GET localhost:$TYK_DB_LISTENPORT/api/apis/search?q=Auth+Token \
  --header "Authorization: $TYK_TOKEN" | \
  jq -r '.apis[0].api_definition.api_id'`

curl -X POST localhost:$TYK_DB_LISTENPORT/api/portal/policies/ \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
    \"rate\":1000,
    \"per\":60,
    \"quota_max\":-1,
    \"quota_renews\":1481546970,
    \"quota_remaining\":0,
    \"quota_renewal_rate\":60,
    \"access_rights\":{
      \"$APIID\":{
        \"apiid\":\"$APIID\",
        \"api_name\":\"Auth Token\",
        \"versions\":[
          \"Default\"
        ]
      }
    },
    \"name\":\"Auth Token Policy\",
    \"active\":true
  }"
