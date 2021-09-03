#!/bin/sh

source $HOME/.bashrc

curl -X POST localhost:$TYK_DB_LISTENPORT/api/apis \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
    \"api_definition\":{
      \"active\":true,
      \"name\":\"My Internal API\",
      \"slug\":\"internal-api\",
      \"proxy\":{
        \"target_url\":\"http://httpbin.org\",
        \"strip_listen_path\":true,
        \"listen_path\":\"/api/internal\"
      },
      \"version_data\":{
        \"not_versioned\":true,
        \"versions\":{
          \"Default\":{
            \"name\":\"Default\",
            \"use_extended_paths\":true,
            \"global_headers\":{
              \"Authorization\":\"\$tyk_meta.jwt\"
            }
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

APIID=`curl -X GET localhost:$TYK_DB_LISTENPORT/api/apis/search?q=My+Internal+API \
  --header "Authorization: $TYK_TOKEN" | \
  jq -r '.apis[0].api_definition.api_id'`

POLID=`curl -X POST localhost:$TYK_DB_LISTENPORT/api/portal/policies/ \
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
        \"api_name\":\"My Internal API\",
        \"versions\":[
          \"Default\"
        ]
      }
    },
    \"name\":\"My Internal API Policy\",
    \"active\":true
  }" | \
  jq -r '.Message'`

FUNC=`echo "function getToken(request, session, config) {

  var getJWT = {
    \"Method\": \"POST\",
    \"Body\": JSON.stringify(request.body),
    \"Headers\": {},
    \"Domain\": \"http://internal-auth:3030\",
    \"Resource\": \"/login\"
  };

  var metaJWT = JSON.parse(JSON.parse(TykMakeHttpRequest(JSON.stringify(getJWT))).Body).jwt;

  var getAuthToken = {
    \"Method\": \"POST\",
    \"Body\": JSON.stringify({
      \"alias\": \"\",
      \"tags\": [],
      \"meta_data\": {
        \"jwt\": metaJWT
      },
      \"allowance\": 1000,
      \"rate\": 1000,
      \"per\": 60,
      \"throttle_interval\": -1,
      \"throttle_retry_limit\": -1,
      \"quota_max\": -1,
      \"quota_renewal_rate\": -1,
      \"max_query_depth\": -1,
      \"access_rights_array\": [
        {
          \"api_id\": \"$APIID\",
          \"api_name\": \"My Internal API\",
          \"allowed_urls\": null,
          \"field_access_rights\": [],
          \"restricted_types\": [],
          \"limit\": null,
          \"auth\": {
            \"use_certificate\": false
          },
          \"available_auth_types\": [
            \"authToken\"
          ],
          \"versions\": []
        }
      ],
      \"apply_policies\": [
        \"$POLID\"
      ],
      \"hmac_enabled\": false,
      \"hmac_string\": \"\"
    }),
    \"Headers\": {
      \"Authorization\": \"$TYK_TOKEN\"
    },
    \"Domain\": \"http://tyk-dashboard:3000\",
    \"Resource\": \"/api/keys\"
  };

  var token = JSON.parse(JSON.parse(TykMakeHttpRequest(JSON.stringify(getAuthToken))).Body).key_id;

  return TykJsResponse({
    Body: token,
    Code: 200
  }, session.meta_data)

}" | base64 -w 0`

curl -X POST localhost:$TYK_DB_LISTENPORT/api/apis \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
    \"api_definition\":{
      \"use_keyless\":true,
      \"active\":true,
      \"name\":\"Login\",
      \"slug\":\"login\",
      \"proxy\":{
        \"target_url\":\"http://httpbin.org\",
        \"strip_listen_path\":true,
        \"listen_path\":\"/token/get\"
      },
      \"version_data\":{
        \"not_versioned\":true,
        \"versions\":{
          \"Default\":{
            \"name\":\"Default\",
            \"use_extended_paths\":true,
            \"extended_paths\":{
              \"virtual\":[
                {
                  \"response_function_name\": \"getToken\",
                  \"function_source_type\": \"blob\",
                  \"function_source_uri\": \"$FUNC\",
                  \"path\": \"\",
                  \"method\": \"POST\",
                  \"use_session\": false,
                  \"proxy_on_error\": false
                }
              ]
            }
          }
        }
      }
    }
  }"
