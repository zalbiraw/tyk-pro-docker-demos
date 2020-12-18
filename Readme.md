# Tyk/Docker Demos Repo
A repo for all different Tyk + different platforms demo.

## Requirements
1. [Tyk Pro](https://pages.tyk.io/en/sign-up-for-tyk-on-prem-licence) trial license key.
2. [Docker](https://docs.docker.com/get-docker/).

## Getting Started
1. Clone repo and navigate to the repo directory.
2. Run initalization script to initialize environment `sh scripts/init.sh`.
3. Run docker-compose using the following command `docker-compose up`.<br />
**NOTE:** This will only run the Tyk Pro tools. If you want to run any of the other demos please check out the readme file inside their respective folders.
4. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard.

## Platforms
- Analytics `/analytics`
    - **Datadog** `/datadog`

- Backend Servers `/backend-servers`
    - **Express.js** API `/express-js`
