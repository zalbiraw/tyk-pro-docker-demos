# Tyk Pro Docker Demos Repo
A repo for Tyk Pro with different platforms demos.

## Requirements
1. [Tyk Pro](https://pages.tyk.io/en/sign-up-for-tyk-on-prem-licence) trial license key.
2. [Docker](https://docs.docker.com/get-docker/).

## Getting Started
1. Clone repo and navigate to the repo directory.
2. Run initalization script to initialize environment `sh scripts/init.sh`.
3. Run docker-compose using the following command `docker-compose -f docker-compose.yml up`.<br />
**NOTE:** add `-f docker-compose.local.yml` to run this on localhost.
**NOTE:** This will only run the Tyk Pro tools. If you want to run any of the other demos please check out the readme file inside their respective folders.
4. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard.

## Docker Compose files
- `docker-compose.local.yml`: allows you to run environment locally
- `docker-compose.dev.dashboard.yml`: allows you to run dashboard dev environment

## Platforms
- Analytics `demos/analytics`
    - **Datadog** `/datadog`

- Backend Servers `demos/backend-servers`
    - **Express.js** `/express-js`

- Security `demos/security`
    - **HMAC Upstream** `/hmac-upstream`

- Portal `demos/portal`
    - **Custom Templates** `/custom-templates`

- Services `demos/services`
    - **ElastiCache Redis Cluster** `/elasticache-redis-cluster`
