# Netlight Acceleration Programme Pre-Assignment

## Goal of the Pre-Assignment

To spin up a local data environment using Docker + PostgreSQL, seed raw data into the database using dbt, and then build basic dbt models to transform the data.

## Background:
Netlight marketplace is a retail platform where consumers can sell and buy items. Currently Netlight marketplace has no data on how the business is performing. They therefore aim to setup a data platform using postgres and dbt to gain better business ingsights for decision making. This project contains 

## 🔧 Prerequisites
- Docker
- Python + dbt installed (`pip install dbt-postgres`)

## 🚀 Getting Started

1. Clone this repo.
2. Run: `docker-compose up -d`
3. In another terminal, go into `dbt_project/` and run:

```bash
dbt seed          # Load raw data
dbt run           # Run transformations
dbt test          # (Optional) Run tests