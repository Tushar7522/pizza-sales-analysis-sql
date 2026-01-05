create database Pizza_Sales ;

create table orders 
(order_id int not null,
order_Date date not null,
order_time time not null, 
primary key(order_id));

create table Orders_details 
(Orders_details_id int not null,
order_id int not null ,
Pizza_id text not null ,
quantity int not null,primary key(orders_details_id));


-- Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) As Total_orders
FROM
    orders;






-- Calculate the total revenue generated from pizza sales
SELECT 
    CONCAT(ROUND(SUM(o.quantity * p.price) / 1000, 1),
            'K') AS Total_Revenue
FROM
    orders_details AS O
        LEFT JOIN
    pizzas AS P ON O.Pizza_id = P.pizza_id;




-- Identify the highest-priced pizza.


SELECT 
    t.name as Pizza_Name , p.price
FROM
    pizza_types AS t
        LEFT JOIN
    pizzas P ON t.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;



-- Identify the most common pizza size ordered.


SELECT 
    p.size, COUNT(o.order_id) AS Order_count
FROM
    orders_details AS o
        LEFT JOIN
    pizzas AS p ON o.Pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;





-- List the top 5 most ordered pizza types along with their quantities.

with Pizza_Name as
(select pizza_type_id,sum(quantity) as quantity from orders_details as D
left join pizzas as P
on D.Pizza_id=p.pizza_id
group by pizza_type_id 
order by quantity desc limit 5) 
 select  pizza_types.name,Pizza_name.quantity from Pizza_name 
 left join pizza_types 
 on Pizza_name.pizza_type_id=pizza_types.pizza_type_id ; 
 
 
 
 
 
 
 
 -- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS Quantity
FROM
    orders_details
        JOIN
    pizzas ON orders_details.Pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
ORDER BY Quantity DESC; 





-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS orders
FROM
    orders
GROUP BY hour
ORDER BY orders DESC; 



-- how many orders were placed in each hour of each day
 SELECT 
    order_date AS date,
    HOUR(order_time) AS hour,
    COUNT(order_id) AS orders
FROM orders
GROUP BY order_date, HOUR(order_time)
ORDER BY orders DESC;  



-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS Pizza_count
FROM
    pizza_types
GROUP BY category; 



-- Group the orders by date and calculate the average number of pizzas ordered per day.

with Orders_quantity as 
(select orders.order_date as Date, sum(orders_details.quantity) As Total_orders from orders
left join orders_details 
on orders.order_id=orders_details.order_id 
group by Date )
select round(avg(Total_orders),2) as Avg_orders from orders_quantity ;





-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name AS Pizza_Name,
    SUM(pizzas.price * orders_details.quantity) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.Pizza_id = pizzas.pizza_id
GROUP BY Pizza_name
ORDER BY revenue DESC
LIMIT 3;




-- Calculate the percentage contribution of each pizza type to total revenue.


 with pizza_Percentage as
 (with tu as 
(select pizza_types.category as Pizza_Category,
sum(pizzas.price*orders_details.quantity) as revenue  
from pizza_types
join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join orders_details 
on orders_details.Pizza_id=pizzas.pizza_id 
group by Pizza_Category)  
 select *, sum(revenue) over(),(revenue/sum(revenue) over())*100 as Total_revenue from tu)
  select Pizza_Category, concat(round(Total_revenue,2),"%") as "%_Category"  from pizza_Percentage ;




-- Analyze the cumulative revenue generated over time.


with Sales as
(select orders.order_Date as Date ,
round(sum(pizzas.price*orders_details.quantity),2) as revenue from orders_details
join orders 
on orders_details.order_id=orders.order_id 
join pizzas 
on orders_details.Pizza_id=pizzas.pizza_id 
group by Date) 
select Date,concat("$"," ",revenue)as Sales ,
concat("$"," ",round(sum(revenue) over(order by date ),2)) as cumulative_revenue
 from Sales ;
 
 
 
 
 -- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
 
with Rnk_pizzas as 
 (with tu as 
 (select pizza_types.category as p_category,pizza_types.name,
 sum(pizzas.price*orders_details.quantity) as revenue
 from orders_details
 join pizzas 
 on orders_details.Pizza_id=pizzas.pizza_id
 join pizza_types
 on pizzas.pizza_type_id=pizza_types.pizza_type_id 
 group by P_category , name)
 select *,rank() over(partition by p_category order by revenue desc  ) as Rnk  from tu)
 select p_category,Name,round(Revenue,2) as P_Revenue from Rnk_Pizzas
 where Rnk <= 3;
 

















