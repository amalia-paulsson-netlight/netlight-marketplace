# 📊 Netlight Marketplace – Data Engineering Onboarding Case

In this exercise, you’ll work with a fictional client — **Netlight Marketplace** — to help them kick-start their data platform journey using modern open-source tools like **PostgreSQL**, **dbt**, **Docker**, and **pgAdmin**.

This is a hands-on, local project designed to simulate real-world work. You'll set up a data platform, explore messy raw data, transform it, and make it usable for analysis.

---

## 🏢 Background: The Client – Netlight Marketplace

**Netlight Marketplace** is a digital platform where freelance consultants and tech talent connect with clients for short- and long-term assignments. The business is growing fast, but the leadership team lacks visibility into platform performance and financials.

Currently, the client:
- Has **no formal data platform**
- Only uses **manually collected datasets**
- Has **batch-uploaded raw data** in CSVs (e.g. user activity, financial transactions)

They’ve come to your consulting team with a request to:
- Stand up a minimal data stack
- Load and transform the raw data
- Deliver actionable insights from clean, queryable models

---

## 🎯 Your Role

You’ll act as a data engineer tasked with:
- Setting up a **Postgres database** locally using Docker
- Loading raw CSV data into the database
- Building transformations using **dbt**
- Exploring and validating the data in **pgAdmin**

---

## 🧰 Tools You’ll Need

| Tool         | Purpose                      | Install Link |
|--------------|------------------------------|--------------|
| Docker       | Run Postgres locally          | [Docker Desktop](https://www.docker.com/products/docker-desktop) |
| Python 3.10+ | For running dbt               | [python.org](https://www.python.org/downloads/) |
| dbt-postgres | SQL-based transformation tool | Installed via pip |
| pgAdmin      | GUI to explore your database  | [pgAdmin Download](https://www.pgadmin.org/download/) |

---

## 🏗️ Project Setup

### 1. Clone the Project

```bash
git clone https://github.com/YOUR-USERNAME/netlight-marketplace.git
cd netlight-marketplace
```

Replace YOUR-USERNAME with your actual GitHub username if you forked the repo.

### 2. cd into this repository and start the Postgres Database

```bash
docker-compose up -d
```
This launches a Postgres container with:

- Database: dbt_db
- User: dbt_user
- Password: dbt_pass
- Port: 5432

### 3. Set Up Your dbt Environment

```bash
python3 -m venv dbt-env
source dbt-env/bin/activate

pip install --upgrade pip
pip install dbt-postgres
```

### 4. cd into the dbt_project folder in this project

### 5. Load the Raw Data

```bash
dbt seed
```

This loads the raw CSV files from /seeds/ into your local Postgres database.

### 6. Run DBT models

```bash
dbt run
```

This builds SQL models in /models/, cleaning and transforming the raw data into structured, analytical tables.

### 7. Explore Data in pgAdmin

#### 1. Open pgAdmin and create a new server:
- General > Name: Local Docker Postgres
- Connection > Host: localhost
- Connection > Port: 5432
- Connection > Username: dbt_user
- Connection > Password: dbt_pass

#### 2. Navigate to

```pgsql
Servers > Local Docker Postgres > Databases > dbt_db > Schemas > raw > Tables
```

#### 3. Right-click tables → View/Edit Data → All Rows


## 📂 Project Structure

netlight-marketplace/
├── dbt_project.yml         # dbt project config
├── docker-compose.yml      # Postgres container
├── models/                 # dbt models (SQL)
│   ├── staging/            # Raw -> cleaned models
│   └── marts/              # Clean -> analytics models
├── seeds/                  # Raw CSV data files
└── dbt-env/                # Python venv (in .gitignore)


## 🧪 Data Overview

The seeds/ folder contains various raw datasets from internal and external sources, simulating batch ingestion. They include:

- Consultants: profile info, skills, contact data (some fields are nested JSON)
- Sessions: usage logs from the platform
- Engagements: client-project connections
- Payments: transaction and fee data

Your job is to:

- Normalize JSON fields
- Handle missing values
- Join datasets where appropriate
- Build fact and dimension tables for analysis


## ✅ Deliverables

You should be able to:

- Seed raw data into the database
- Transform and model it using dbt
- Explore and validate the results in pgAdmin
- (Optional) Document models using dbt docs generate


## 📚 Learn More

- [dbt Docs](https://docs.getdbt.com/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [Docker Overview](https://www.docker.com/why-docker/)
- [pgAdmin Docs](https://www.pgadmin.org/docs/)
