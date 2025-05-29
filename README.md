# 📊 Netlight Marketplace – Data Engineering Onboarding Case

In this exercise, you’ll work with a fictional client — **Netlight Marketplace** — to help them kick-start their data platform journey using modern open-source tools like **PostgreSQL**, **dbt**, **Docker**, and **DBeaver**.

This is a hands-on, local project designed to simulate real-world work. You'll set up a data platform, explore messy raw data, transform it, and make it usable for analysis.

---

## 🏢 Background: The Client – Netlight Marketplace

**Netlight Marketplace** is a digital platform where consumers can sell and buy items. The business is growing fast, but the leadership team lacks visibility into platform performance and financials.

- How many sellers and buyers are there on the platform?
- Categorisation of items?

sails:
sellers, buyers, order_id, order_item

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
- Exploring and validating the data in **DBeaver**

---

## 🧰 Tools You’ll Need

| Tool         | Purpose                      | Install Link |
|--------------|------------------------------|--------------|
| Docker       | Run Postgres locally          | [Docker Desktop](https://www.docker.com/products/docker-desktop) |
| Python 3.10+ | For running dbt               | [python.org](https://www.python.org/downloads/) |
| dbt-postgres | SQL-based transformation tool | Installed via pip |
| DBeaver      | GUI to explore your database  | [DBeaver Download](https://dbeaver.io/download/) |

---

## 🏗️ Project Setup

### 1. Clone the Project

```bash
git clone https://github.com/amalia-paulsson-netlight/netlight-marketplace.git
cd netlight-marketplace
```

### 2. cd into this repository and start the Postgres Database

Make sure you have started docker, then run: 

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

This builds SQL models in /models/, cleaning and transforming the raw data into structured, analytical tables. In order to materialize the dbt models that you will define yourself in the tasks below, you run this command again. Make sure to run dbt in your dbt environmenet that was set up in step 3 (```bash source dbt-env/bin/activate ```). Read more about dbt [here](https://docs.getdbt.com/).

### 7. Explore Data in DBeaver

#### 1. Open DBeaver and create a new connection:
- Click "New Database Connection"
- Select PostgreSQL and click Next

#### 2. Connection Settings:
- Host: localhost
- Port: 5432
- Database: dbt_db
- Authentication: Database Native
- Username: dbt_user
- Password: dbt_pass
Click Test Connection, then Finish if successful.

#### 3. Navigate to the Schemas
In the Database Navigator:
```pgsql
dbt_db > Schemas > raw > Tables
dbt_db > Schemas > raw > Views
```

Right-click on any table or view and choose:

View Data → All Rows
Or open the SQL Editor to write custom queries

## 🧪 Data Overview

The seeds/ folder contains various raw datasets from internal and external sources, simulating batch ingestion. They include:

- listings: Contains all marketplace listings, including product name, listing status, seller and buyer references, location details, pricing, and sales information. Some listings are unsold.
- listing_views: Logs of individual views for each listing, including device type, viewer ID, view timestamp, and viewer location. This simulates user engagement on the platform.
- sellers: Information about sellers on the platform, including seller ID, associated user ID, name, email, join date, and average seller rating.
- buyers: Information about buyers, including buyer ID, associated user ID, name, email, join date, and historical purchase count.

## Discover the Raw Data

Discover the raw data by querying it in as SQL Editor in DBeaver and reflect around the following topics:
- Are all there any overlap between users that are in the seller data and the buyer data? What does that mean?
- In all raw data there's a field batch_loaded_at which is the timestamp of when the data was fetched from the source system and appended to the raw dataset. Hence each set of data with a specific batch_loaded_at value represents a snapshot of how the data looked like in the source system at that point.
    - How many batch uploads have been made?
    - How does the number of sellers and buyers differ accross batches?
    - What does it mean if a seller or buyer occurs in one batch and not in the subsequent one? - What does it mean if the email has changed?
- Is there uniqueness in the raw data?
- What other data quality issues do you see?

## ✅ Tasks

As part of this case, we encourage you to complete the following tasks using dbt models. The goal is to simulate how real data engineers work with raw ingested data and turn it into actionable analytics.

### 1. 🧹 Staging Layer
Create staging models in models/staging/ to clean and prepare the raw data. Create one staging model on each raw data table.

- Filter the data
    — For each record only include data from the latest batch using the batch_loaded_at column. Make sure you include deleted sellers and buyers.
    - Filter out and/or fix data that you think is broken.
- Apply consistent naming and typing conventions.
- Extract or split relevant fields (e.g. sale_timestamp → sale_date, sale_time).

### 2. 🧱 Intermediate Layer
Build intermediate models in models/intermediate/ to normalize and restructure your data.

- Split stg_listing into two models:
int_listing: includes listing details (always present)
int_sale: only includes rows where a sale occurred, linked to int_listing via listing_id
- Move location fields (city, region, country) into a new int_location model.
Build a hashed composite key to represent location_id and replace the location fields in listings and sales to use that key instead.
- Consolidate seller and buyer into a unified int_user model:
Primary key: user_id
Consider flags like is_seller and is_buyer if helpful
- Update references:
Replace seller_id and buyer_id with seller_user_id and buyer_user_id (from int_user)
- Build a model for the listing_view data and make sure redudancy is minized across all intermediate models.

### 3. 🧠 Mart Layer
Create final, analysis-ready tables in models/marts/.

- Materialisation: Configure these models to be materialised as tables instead of views (default in dbt)
- Prefix table names: prefix models with "fact_" or "dim_" to indicate whether the data is fact or dimensional
- Update the listing table: add aggregate view counts per listed item
- Optional: create dbt tests to check uniqueness, relationships and that mandatory fields are not null in your mart models. Read more on [dbt Tests](https://docs.getdbt.com/docs/build/data-tests)

### 4. 📊 Business Questions
Use your mart models (or dbt exposures) to answer questions such as:

🏙️ Which locations have the most listings?
💸 Which locations have the most completed sales?
👀 Which product names get the most views?
🔄 What is the conversion rate (sold vs unsold listings)?
⏳ What is the average time to sell, by product or location?
📈 How have sales trended across the three batch loads?
🔁 Are there users who are both buyers and sellers?
You can document your insights as .md files, as comments in your dbt models, or in a new folder like analysis/.

### 5. 🧠 Bonus Task – Product Categorization with Python
Some product names are inconsistent or vague (e.g. "Used iPhone 12" vs "iPhone"). Your task is to improve reporting by assigning categories to product names.

🎯 Task: Use Python (e.g. scikit-learn, spaCy, or simple keyword rules) to classify listings into product categories (e.g. Electronics, Furniture, Sports, etc.)
- Output a file or table with: listing_id, product_name, and product_category
- Load the data into your warehouse (e.g. using dbt seed or as an external table)
- Join it into your mart models
- Use this to answer:
Which product categories are the most viewed or generate the most sales?

## 📚 Learn More

- [dbt Docs](https://docs.getdbt.com/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [Docker Overview](https://www.docker.com/why-docker/)
- [DBeaver Docs](https://dbeaver.io/docs/)
