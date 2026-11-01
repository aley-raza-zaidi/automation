import os
import time

import psycopg2
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# PostgreSQL connection settings
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "persondb")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "123")
DB_PORT = os.getenv("DB_PORT", "5432")


# Connect to PostgreSQL
def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT
    )


# Create database table
def create_table():
    for attempt in range(10):
        try:
            conn = get_db_connection()
            cur = conn.cursor()

            cur.execute("""
                CREATE TABLE IF NOT EXISTS persons (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    age INTEGER NOT NULL,
                    telephone VARCHAR(30) NOT NULL,
                    city VARCHAR(100) NOT NULL
                )
            """)

            conn.commit()
            cur.close()
            conn.close()

            print("Persons table is ready!")
            return

        except psycopg2.OperationalError:
            print("Waiting for PostgreSQL...")
            time.sleep(3)

    raise RuntimeError("Could not connect to PostgreSQL")


# Main web page
@app.route("/", methods=["GET", "POST"])
def index():

    if request.method == "POST":

        name = request.form["name"].strip()
        age = request.form["age"]
        telephone = request.form["telephone"].strip()
        city = request.form["city"].strip()

        if not name or not telephone or not city:
            return "All fields are required", 400

        try:
            age = int(age)
            if age < 0 or age > 150:
                return "Please enter a valid age", 400
        except ValueError:
            return "Age must be a number", 400

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute(
            """
            INSERT INTO persons (name, age, telephone, city)
            VALUES (%s, %s, %s, %s)
            """,
            (name, age, telephone, city)
        )

        conn.commit()
        cur.close()
        conn.close()

        return redirect(url_for("index"))

    # Retrieve all persons from database
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT id, name, age, telephone, city
        FROM persons
        ORDER BY id DESC
    """)

    persons = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("index.html", persons=persons)


if __name__ == "__main__":
    create_table()
    app.run(host="0.0.0.0", port=5000)