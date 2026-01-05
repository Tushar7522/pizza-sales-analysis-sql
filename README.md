# 🍕 Pizza Sales Analysis | SQL Project

## 📌 Project Summary
The **Pizza Sales Analysis** project is a data analytics case study focused on analyzing a pizza restaurant’s sales data using **SQL**.  
The goal of this project is to extract **actionable business insights** from raw transactional data related to **orders, revenue, customer behavior, and product performance**.

This project demonstrates the **practical use of SQL in real-world business scenarios**, making it suitable for **Data Analyst and Business Analyst roles**.

---

## 🎯 Project Objectives
- 📦 Analyze total orders and overall revenue  
- 🥇 Identify top-selling and highest-priced pizzas  
- 📏 Understand customer preferences by pizza size and category  
- ⏰ Examine order patterns across different times of the day  
- 📈 Track revenue growth and contribution by pizza type and category  

---

## 🗂️ Dataset Overview
The project uses a **relational dataset** consisting of four tables:

- 🧾 **orders** – Contains order date and time information  
- 📄 **order_details** – Stores pizza quantities per order  
- 🍕 **pizzas** – Includes pizza size and price details  
- 🏷️ **pizza_types** – Defines pizza names, categories, and ingredients  

These tables are connected using **primary and foreign keys**, enabling advanced SQL analysis using **joins and aggregations**.

---

## 🛠️ Tools & Technologies Used
- 🗄️ **Database:** MySQL  
- 💻 **Query Language:** SQL  

### ⚙️ Key Concepts Applied
- 🔗 INNER JOINs  
- ➕ Aggregate functions (SUM, AVG, COUNT)  
- 🧮 GROUP BY & HAVING clauses  
- 🔁 Subqueries  
- 🪟 Window functions  
- 🕒 Date & Time functions  

---

## 🧠 SQL Queries
All SQL queries used for analysis are available here:  
➡️ 📂 [Click here to download](./pizza_sales_sql_report.pdf)


---

## 📊 Key Performance Indicators (KPIs)
- 🧮 Total Orders  
- 💰 Total Revenue  
- 🍕 Total Pizzas Sold  
- 🛒 Average Order Value  
- 📆 Average Pizzas Ordered Per Day  

---

## 🧠 Business Questions Addressed

### 🟢 Basic Analysis
- 📊 Total number of orders placed  
- 💵 Total revenue generated  
- 💎 Highest-priced pizza  
- 📏 Most commonly ordered pizza size  
- ⭐ Top 5 most ordered pizzas  

---

### 🟡 Intermediate Analysis
- 📦 Total quantity ordered per pizza category  
- ⏰ Order distribution by hour of the day  
- 🏷️ Category-wise pizza distribution  
- 📅 Average pizzas ordered per day  
- 🥉 Top 3 pizzas based on revenue  

---

### 🔴 Advanced Analysis
- 📈 Percentage contribution of each pizza type to total revenue  
- 📊 Cumulative revenue analysis over time  
- 🏆 Top 3 pizzas by revenue within each category  

--- 
## 🔍 Sample SQL Queries

Below are a few **sample SQL queries** from the project that demonstrate how business insights were derived from the dataset.

---

```sql
-- 💰 Total Revenue Generated
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id;


-- 🍕 Top 5 Most Ordered Pizza Types
SELECT 
    pt.name,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


-- 📈 Cumulative Revenue Over Time
SELECT 
    o.order_date,
    ROUND(
        SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.order_date),
        2
    ) AS cumulative_revenue
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_date;

```
---
## 📈 Key Insights
- 🔑 A small number of pizza types generate a significant portion of total revenue  
- 📏 Medium and Large pizza sizes are the most preferred by customers  
- ⏱️ Orders peak during lunch and dinner hours  
- 📈 Revenue shows a steady upward trend over time  
- 🏷️ Category-level analysis highlights top-performing pizzas

---
## 🏁 Conclusion
This project highlights how **SQL can be used to analyze transactional sales data and derive meaningful business insights**.  
It reflects **real-world data analysis practices** and showcases the analytical skills required for a **Data Analyst role**.

---

## 🚀 Future Scope
- 📊 Develop a Power BI / Tableau dashboard  
- 📆 Perform monthly and yearly trend analysis  
- 👥 Apply customer segmentation techniques  
- 💹 Include profitability and cost analysis  
  





