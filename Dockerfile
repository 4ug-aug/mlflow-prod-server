# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /mlflow

# Install MLflow
COPY ./requirements.txt requirements.txt

RUN pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 3001

CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "3001", "--backend-store-uri", "postgresql://mlflow_user:mlflow_password@postgres:5432/mlflow_db", "--artifacts-destination", "s3://mlflow"]
