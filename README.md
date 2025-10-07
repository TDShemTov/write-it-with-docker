# Overview
I used one of my full stack projects to get familiarized with JFrog Artifactory and GitHub Actions.


## Running the Project with Docker

To simplify local development and deployment, this project includes Docker and Docker Compose configurations. The application runs in a Python 3.13 environment and uses MongoDB for local development (production uses Azure Cosmos MongoDB).

### Requirements
- **Docker** and **Docker Compose** installed on your machine.
- The application is built with **Python 3.13-slim** and dependencies listed in `requirements.txt`.

### Services and Ports
- **python-app**: Flask web application
  - Exposes port **5000** (mapped to host port 5000)
- **mongo**: MongoDB database for local development
  - Exposes port **27017** (mapped to host port 27017)

### Environment Variables
- No environment variables are strictly required by default. If you have a `.env` file for secrets or configuration, uncomment the `env_file` line in `docker-compose.yml`.

### Build and Run Instructions
1. **Clone the repository** and navigate to the project root.
2. **Build and start the services**:
   ```bash
   docker compose up --build
   ```
   This will build the Python app image and start both the Flask app and MongoDB containers.
3. **Access the application** at [http://localhost:5000](http://localhost:5000).

### Special Configuration
- For local development, MongoDB runs in a container. In production, the app connects to Azure Cosmos MongoDB.
- If you want MongoDB data to persist between runs, uncomment the `volumes` section for `mongo` in `docker-compose.yml`.
- The Dockerfile sets up a Python virtual environment and installs dependencies for isolation and reproducibility.

---
