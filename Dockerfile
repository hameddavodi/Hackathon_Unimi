# Use a Python 3.9 slim base image
FROM python:3.9-slim

WORKDIR /~
ENV DEBIAN_FRONTEND=noninteractive
COPY . .
# Update the system packages and install gcc
RUN apt-get update && apt-get install -y gcc

# Install apt-utils for package management
RUN apt-get install -y apt-utils

# Install build-essential for building C extensions
RUN apt-get install -y build-essential

# Install Java Development Kit (JDK)
RUN apt-get update && apt-get install -y default-jdk

# Install H2O dependencies
RUN apt-get install -y libatlas3-base libgomp1

RUN pip install --upgrade pip
RUN pip install poetry

# Configure poetry to not create a virtual environment
RUN poetry config virtualenvs.create false

# Install project dependencies using poetry
RUN poetry install
# Set the command to run the application

# Set the command to run the application
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8080"]
