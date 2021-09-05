#!/bin/sh

source $HOME/.bashrc

curl -X POST localhost:$TYK_DB_LISTENPORT/api/apis \
  --header "Authorization: $TYK_TOKEN" \
  --header "Content-Type: application/json" \
  --data "{
   \"api_definition\":{
      \"active\":true,
      \"use_keyless\":true,
      \"graphql\":{
         \"schema\":\"type Post {\n  id: ID\n  userId: ID\n  title: String\n  body: String\n}\n\ntype Query {\n  user(id: ID!): User\n}\n\ntype User {\n  id: ID\n  name: String\n  email: String\n  username: String\n  posts: [Post]\n}\n\",
         \"enabled\":true,
         \"engine\":{
            \"field_configs\":[
               {
                  \"type_name\":\"Query\",
                  \"field_name\":\"user\",
                  \"disable_default_mapping\":true,
                  \"path\":[
                     \"\"
                  ]
               },
               {
                  \"type_name\":\"User\",
                  \"field_name\":\"posts\",
                  \"disable_default_mapping\":true,
                  \"path\":[
                     \"\"
                  ]
               }
            ],
            \"data_sources\":[
               {
                  \"config\":{
                     \"url\":\"https://jsonplaceholder.typicode.com/users/{{.arguments.id}}\",
                     \"method\":\"GET\",
                     \"body\":\"\",
                     \"headers\":{

                     },
                     \"default_type_name\":\"User\"
                  },
                  \"isLinked\":false,
                  \"parentMapping\":[

                  ],
                  \"meta\":{
                     \"key\":\"Query-user\"
                  },
                  \"name\":\"users\",
                  \"mapping\":{
                     \"type_name\":\"Query\",
                     \"field_name\":\"user\",
                     \"disable_default_mapping\":true,
                     \"path\":\"\"
                  },
                  \"kind\":\"REST\",
                  \"root_fields\":[
                     {
                        \"type\":\"Query\",
                        \"fields\":[
                           \"user\"
                        ]
                     }
                  ],
                  \"internal\":false
               },
               {
                  \"kind\":\"REST\",
                  \"name\":\"user-posts\",
                  \"internal\":false,
                  \"root_fields\":[
                     {
                        \"type\":\"User\",
                        \"fields\":[
                           \"posts\"
                        ]
                     }
                  ],
                  \"config\":{
                     \"url\":\"https://jsonplaceholder.typicode.com/users/{{.object.id}}/posts\",
                     \"method\":\"GET\",
                     \"body\":\"\",
                     \"headers\":{

                     },
                     \"default_type_name\":\"Post\"
                  },
                  \"isLinked\":false,
                  \"mapping\":{
                     \"disable_default_mapping\":true,
                     \"path\":\"\",
                     \"type_name\":\"User\",
                     \"field_name\":\"posts\"
                  },
                  \"parentMapping\":[

                  ]
               }
            ]
         },
         \"type_field_configurations\":[

         ],
         \"execution_mode\":\"executionEngine\",
         \"proxy\":{
            \"auth_headers\":{

            }
         },
         \"version\":\"2\",
         \"playground\":{
            \"enabled\":false,
            \"path\":\"\"
         }
      },
      \"name\":\"UDG\",
      \"slug\":\"udg\",
      \"proxy\":{
         \"target_url\":\"\",
         \"strip_listen_path\":true,
         \"listen_path\":\"/udg/\"
      },
      \"version_data\":{
         \"not_versioned\":true,
         \"versions\":{
            \"Default\":{
               \"name\":\"Default\"
            }
         },
         \"default_version\":\"\"
      }
    }
  }"
