# 🍕 Pizza Sales Analysis - SQL Project

## 📌 Project Overview
This project focuses on analyzing pizza sales data using **SQL** to extract meaningful business insights. The dataset includes information about orders, order details, pizza types, and pricing. The goal is to answer key business questions related to sales performance, customer ordering patterns, and revenue trends.

## 🎯 Objectives
- Analyze total orders and revenue generated
- Identify top-performing and highest-priced pizzas
- Understand customer ordering behavior (size preference, peak hours)
- Calculate revenue contribution by pizza category and type
- Track cumulative revenue trends over time

## 🛠️ Tools Used
- **SQL Server (T-SQL)**
- Joins, Aggregate Functions, Window Functions, Subqueries, CTEs

## 📊 Key Business Questions Solved
1. Total number of orders placed
2. Total revenue generated from pizza sales
3. Highest-priced pizza
4. Most common pizza size ordered
5. Top 5 most ordered pizza types by quantity
6. Total quantity of each pizza category ordered
7. Distribution of orders by hour of the day
8. Category-wise distribution of pizzas
9. Average number of pizzas ordered per day
10. Top 3 most ordered pizza types by revenue
11. Percentage contribution of each pizza type to total revenue
12. Cumulative revenue generated over time
13. Top 3 most ordered pizza types by revenue within each category

## 🗂️ Database Structure
The analysis uses the following tables:
- **orders** – order id, date, and time information
- **order_details** – order id, pizza id, and quantity ordered
- **pizzas** – pizza id, size, and price
- **pizza_types** – pizza id, name, and category

## 💡 Key Insights
- Identified the most profitable pizza categories and types
- Determined peak ordering hours to help optimize staffing
- Found the most and least popular pizza sizes
- Calculated each pizza type's percentage share in total revenue

## 📈 Future Improvements
- Connect results to Power BI / Tableau for dashboard visualization
- Automate reporting with stored procedures
- Add customer segmentation analysis
