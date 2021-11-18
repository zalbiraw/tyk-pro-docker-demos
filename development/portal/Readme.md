## Getting Started
1. Update the `GH_USERNAME` `GH_TOKEN` values under the `.env` file in the root of the repository to give the container access to clone the raava repository.

2. If you already bootstrapped the dashboard. Get the `Tyk Dashboard API Access Credentials` and `Organisation ID` values and place them into the `.env` file under `PORTAL_USER_TOKEN` and `PORTAL_ORG_ID` respectively.

3. If you did not bootstrap the dashboard then you can do so by running `docker-compose -f docker-compose.yml up`. Then you can access the dashboard via [http://localhost:3000](http://localhost:3000) and obtain the required values in step 2.

4. Run docker-compose from the repo root using the following command `docker-compose -f docker-compose.yml -f development/portal/docker-compose.yml up`.

4. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard.

5. Navigate to [http://localhost:8080](http://localhost:8080) in your browser to access the Tyk Gateway.

6. Navigate to [http://localhost:3001](http://localhost:3001) in your browser to access the Tyk Portal.
