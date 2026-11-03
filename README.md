# Airbnb Data Engineering Project using Snowflake and dbt

## About the Project

This is an Airbnb data engineering project that I built using **Amazon S3, Snowflake, and dbt**.

The main purpose of this project is to take Airbnb data from Amazon S3, load it into Snowflake, and transform it into a clean and structured format that can be used for analysis.

I have followed the Medallion Architecture, which divides the data into three layers: Bronze, Silver, and Gold.

I have also used dbt features like Jinja SQL, macros, snapshots, and a metadata-driven approach to make the transformation process easier to manage and reuse.

## Project Architecture

The data flows through the following stages:

**Amazon S3 → Snowflake Staging → Bronze → Silver → Gold**

### 1. Amazon S3 (Data Source)

Amazon S3 is the source of my Airbnb data.

I store the source CSV files in an S3 bucket. These files contain information about Airbnb bookings, hosts, and listings.

The data is loaded from S3 into Snowflake staging tables before the transformation process begins.

### 2. Snowflake Staging Layer

In this stage, the source data from Amazon S3 is loaded into staging tables in Snowflake.

This layer acts as the starting point for further transformations. The data is kept close to its original structure so that it can be processed in the next layer.

### 3. Bronze Layer

The Bronze layer contains the initial data models created from the staging data.

I have created separate models for:

- `bronze_bookings.sql`
- `bronze_hosts.sql`
- `bronze_listings.sql`

This layer keeps the data organized and provides the base for further transformations.

### 4. Silver Layer

The Silver layer is used to clean and transform the Bronze data.

In this layer, I have created separate models for bookings, hosts, and listings.

- `silver_bookings.sql`
- `silver_hosts.sql`
- `silver_listings.sql`

The purpose of this layer is to prepare cleaner and more structured data for the final reporting layer.

### 5. Gold Layer

The Gold layer contains the final data models, which are prepared for analysis.

In this project, I have used an **ephemeral model** and a metadata-driven approach to build the final OBT (One Big Table).

The `obt.sql` model combines data from the Silver bookings, listings, and hosts tables using LEFT JOINs.

The final OBT brings related Airbnb information together in one place, making it easier to use for reporting and analysis.

## Metadata-Driven Pipeline using Jinja SQL

One of the important parts of this project is the metadata-driven approach used in the Gold layer.

Instead of writing separate SQL queries for every table and join, I have created a Jinja configuration list inside `obt.sql`.

This configuration contains information such as:

- Source table name
- Columns to select
- Table alias
- Join condition

Jinja loops are then used to generate the final SQL query dynamically.

For example, the configuration defines the Silver bookings table as the starting table, followed by the Silver listings and Silver hosts tables.

The Jinja loop automatically generates the SELECT statements and LEFT JOINs based on the configuration.

This makes the query easier to maintain. If I need to add another table or change a join, I can update the configuration instead of rewriting the entire SQL query.

## Jinja SQL and Macros

I have also used Jinja SQL in dbt to make my SQL models more dynamic and reusable.

Some of the macros used in this project are:

- `generate_schema_name.sql` – Used to customize schema naming.
- `multiply.sql` – A reusable macro for multiplication.
- `tag.sql` – A custom macro used in the project.

Jinja helps in writing dynamic SQL, while macros allow me to reuse SQL logic in different models.

## Snapshots

I have also included dbt snapshots in the project.

The snapshot files are:

- `dim_bookings.yml`
- `dim_hosts.yml`
- `dim_listings.yml`

These are used to define snapshot configurations for tracking changes in source records over time.

## Project Folder Structure

```text
AWS_DBT_Snowflake/
│
├── aws_dbt_snowflake_project/
│   │
│   ├── analyses/
│   │   ├── if_else.sql
│   │   └── loop.sql
│   │
│   ├── macros/
│   │   ├── generate_schema_name.sql
│   │   ├── multiply.sql
│   │   └── tag.sql
│   │
│   ├── models/
│   │   ├── bronze/
│   │   │   ├── bronze_bookings.sql
│   │   │   ├── bronze_hosts.sql
│   │   │   └── bronze_listings.sql
│   │   │
│   │   ├── silver/
│   │   │   ├── silver_bookings.sql
│   │   │   ├── silver_hosts.sql
│   │   │   └── silver_listings.sql
│   │   │
│   │   ├── gold/
│   │   │   ├── ephemeral/
│   │   │   │   ├── bookings.sql
│   │   │   │   ├── hosts.sql
│   │   │   │   └── listings.sql
│   │   │   └── obt.sql
│   │   │
│   │   └── properties.yml
│   │
│   ├── seeds/
│   ├── snapshots/
│   │   ├── dim_bookings.yml
│   │   ├── dim_hosts.yml
│   │   └── dim_listings.yml
│   │
│   ├── tests/
│   ├── dbt_project.yml
│   └── profiles.yml.example
│
├── src/
├── config.json
├── pyproject.toml
├── uv.lock
└── README.md
```

## Technologies Used

- **Amazon S3** – Stores the source Airbnb CSV files.
- **Snowflake** – Used as the cloud data warehouse.
- **dbt** – Used to transform and manage data models.
- **SQL** – Used for data transformations.
- **Jinja SQL** – Used to generate dynamic SQL queries.
- **Python** – Used in the project environment and supporting setup.
- **UV** – Used for Python dependency and environment management.

## Running the dbt Project

After configuring the Snowflake connection and project settings, you can run the following commands from the dbt project directory.

1. Install the required dependencies:

```bash
uv sync
```

2. Check the Snowflake connection:

```bash
uv run dbt debug
```

3. Run the dbt models:

```bash
uv run dbt run
```

4. Execute the tests:

```bash
uv run dbt test
```

5. Run snapshots:

```bash
uv run dbt snapshot
```

## What I Learned

While building this project, I got practical experience with:

- Loading data from Amazon S3 into Snowflake.
- Working with Snowflake databases, schemas, and tables.
- Understanding the Bronze, Silver, and Gold architecture.
- Creating and managing dbt models.
- Writing reusable SQL using Jinja and macros.
- Building metadata-driven SQL pipelines.
- Creating an OBT by joining multiple datasets.
- Using dbt snapshots to track data changes.

## Conclusion

This project helped me understand how a data engineering pipeline works in a real-world scenario. I learned how raw data can be loaded from cloud storage, transformed through different layers, and finally prepared for analysis using Snowflake and dbt.

This is a learning project, and I plan to improve it further as I explore more data engineering concepts.
