#!/bin/sh

source $HOME/.bashrc

curl -X POST localhost:$TYK_DB_LISTENPORT/api/apis \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
    \"api_definition\":{
      \"active\":true,
      \"use_keyless\":true,
      \"name\":\"Keyless\",
      \"slug\":\"keyless\",
      \"proxy\":{
        \"target_url\":\"http://httpbin.org\",
        \"strip_listen_path\":true,
        \"listen_path\":\"/keyless/\"
      },
      \"version_data\":{
        \"not_versioned\":true,
        \"versions\":{
          \"Default\":{
            \"name\":\"Default\"
          }
        }
      }
    }
  }"
