# mlflow-prod-server
Clone and Run mlflow ready server with minio s3 artifact storage and postgresql persist storage

## Quick Start
```bash
git clone https://github.com/4ug-aug/mlflow-prod-server.git
```
Enter directory
```bash
cd mlflow-prod-server
```
Compose docker containers
```bash
docker compose up -d --build
```
Access the minio storage on port **9001** by ip of server running docker (possibly localhost if you are running locally).
Example:
[http://localhost:9001](http://localhost:9001)

Login with:
*Username:* miniouser
*Password* miniospw

Create an access key and paste these into the docker compose file:
```yml
[...]

  mlflow:
    restart: always
    build: 
      context: .
      dockerfile: Dockerfile
    container_name: mlflow
    networks:
      - frontend
      - backend
    ports:
      - 3001:3001
    environment:
      - MLFLOW_TRACKING_URI=http://0.0.0.0:3001
      - MLFLOW_BACKEND_STORE_URI=postgresql://mlflow_user:mlflow_password@postgres:5432/mlflow
      - MLFLOW_S3_ENDPOINT_URL=http://minio:9000
      - AWS_ACCESS_KEY_ID=<ACCESS_KEY>              <-------------- Here
      - AWS_SECRET_ACCESS_KEY=<ACCESS_KEY_SECRET>   <-------------- And Here
      - MLFLOW_S3_IGNORE_TLS=true
    volumes:
      - ./mlruns:/mlruns
    depends_on:

[...]
```
Restart the docker containers:
```bash
docker compose down
```
```bash
docker compose up -d
```
## Test
You can now test the configuration by running the notebook **logging-first-model.ipynb**
