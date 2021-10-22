## Getting Started
1. Update the `GH_USERNAME` `GH_TOKEN` values under the `.env` file in the root of the repository to give the container access to clone the tyk-analytics repository.

2. Run docker-compose from the repo root using the following command `docker-compose -f docker-compose.yml -f demos/development/dashboard/docker-compose.yml up`.

3. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard.

4. Navigate to [http://localhost:8080](http://localhost:8080) in your browser to access the Tyk Gateway.
