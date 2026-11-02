# Application to enter person data and display on the same page 

---

## Overview

This project demonstrage a python flask application with postgress database table. it stores person name, age telephone and city. The application is designed to work as container application with docker images with docker compose service file. on the same page where i enter person data which goes in to databse, in the below part the person entries from database are shown as a table


This project demonstrates power of docker, runnign a container.


---

## Application Architecture
Python Flask – creating a simple web application.
PostgreSQL – storing and retrieving data.
HTML – creating a form and displaying database records in a table.
Docker – packaging your application into a Docker image.
Docker Compose – running Flask and PostgreSQL together in separate containers.

flask-person-app/
  app.py
  requirements.txt
  Dockerfile
  docker-compose.yml
  templates/
   index.html

---

## Workflow

Web browser <-> Container 1 - Flask Application (Python + Flask + HTML) Port 5000 <-> PostgreSQL (Database, Table:pesondb, Port 5432) > Docker Volumn (Persistent Database Storage)

---


---

## 🛠️ Installation

```bash
sudo docker-compose up --build -d


### To see database definition, table name, table entries

```bash
sudo docker exec -it postgres_db psql -U postgres -d persondb


1. List all databases
\l

2. Connect to a database
\c persondb


3. List all tables
\dt


























