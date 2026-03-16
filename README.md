🚇 Urban Transportation Data Analysis (SQL Project)
📌 Project Overview

This project analyzes urban transportation system data using SQL to extract meaningful insights about commuter behavior, route usage, vehicle efficiency, and revenue patterns.

The database simulates a public transportation network (Metro & Bus) and demonstrates how relational databases and SQL analytics can support operational and business decision-making.

This project is part of my Data Science learning journey, focusing on:

Data modeling

SQL-based data analysis

Transportation analytics

🎯 Project Objectives

Design a relational database schema

Analyze commuter travel patterns

Identify high-traffic stations and routes

Evaluate vehicle utilization

Analyze revenue and operational performance

Generate data-driven insights

🗂️ Dataset Overview

The system is built using multiple relational tables that represent different components of a transportation network.

Table	Description
commuters	Stores commuter demographic information
stations	Contains station details and city zones
vehicles	Stores vehicle specifications and capacity
routes	Defines transportation routes between stations
routes_assignment	Maps vehicles to routes
trips	Records trip details including fare and timing
maintenance	Tracks vehicle maintenance and costs

These tables collectively simulate real-world transportation operational data.

🧩 Entity Relationship Diagram

The following ER diagram represents the relationships between different tables in the database.

(Add your ER diagram image here)

commuters → trips → routes → stations
                 ↓
            routes_assignment → vehicles → maintenance
Key Relationships

A commuter can take multiple trips

Each trip belongs to a specific route

A route connects two stations

Vehicles are assigned to routes

Vehicles undergo periodic maintenance

🛠️ Tools & Technologies
Technology	Purpose
MySQL	Database management
SQL	Data analysis and querying
DBDiagram	ER diagram design
GitHub	Project documentation
📊 Analysis Performed

The project performs multiple analytical tasks including:

Total trips and commuter activity

Revenue analysis by route

Station traffic analysis

Commuter spending patterns

Route performance evaluation

Vehicle maintenance cost analysis

Zone-wise revenue contribution

These analyses help simulate transport system performance monitoring.

📊 Business Insights

The project helps answer several real-world questions such as:

Which routes generate the most revenue

Which stations have the highest passenger traffic

Which vehicle types are most cost efficient

Which commuters contribute the most revenue

Which zones generate the highest income

Which routes may require more vehicles

These insights can help transport authorities optimize operations.

🚀 Skills Demonstrated

This project demonstrates practical experience with:

Relational database design

SQL data analysis

Joins and subqueries

Aggregations and filtering

Window functions

Analytical thinking with structured data

👨‍💻 Author

Dhruv Rapariya

Aspiring Data Scientist / Data Analyst

⭐ Feedback

Feedback and suggestions are always welcome.

If you find this project useful, consider starring ⭐ the repository.
