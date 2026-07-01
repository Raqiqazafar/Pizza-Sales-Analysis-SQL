
create database Pizza_Sales_Analysis;

-- Retrieve the total number of orders placed.
    
    SELECT COUNT(order_id) AS Total_Orders 
        FROM orders;


-- Calculate the total revenue generated from pizza sales.

    select ROUND(sum(order_details.quantity * pizzas.price),2) as Total_Sales
	from order_details join pizzas
	on pizzas.pizza_id = order_details.pizza_id


--Identify the highest-priced pizza.
        
	  SELECT TOP 1  pizza_types.name, 
         ROUND(pizzas.price, 2) AS price
         FROM pizza_types JOIN pizzas 
         ON pizza_types.pizza_type_id = pizzas.pizza_type_id
         ORDER BY pizzas.price DESC;


--Identify the most common pizza size ordered.

      SELECT  pizzas.size, 
      COUNT(order_details.order_details_id) AS orders_count
      FROM pizzas JOIN order_details 
	  ON pizzas.pizza_id = order_details.pizza_id
      GROUP BY pizzas.size
      ORDER BY orders_count DESC;


--List the top 5 most ordered pizza types along with their quantities.

    SELECT TOP 5 pizza_types.name, 
    SUM(order_details.quantity) AS total_quantity_sold
    FROM pizza_types JOIN pizzas 
	ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY pizza_types.name
    ORDER BY total_quantity_sold DESC;


--Join the necessary tables to find the total quantity of each pizza category ordered.

       SELECT pt.category, SUM(od.quantity) AS total_quantity
       FROM pizza_types pt
       JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
       JOIN order_details od ON p.pizza_id = od.pizza_id
       GROUP BY pt.category;


--Determine the distribution of orders by hour of the day.
      
	  SELECT DATEPART(HOUR, time) AS order_hour, COUNT(order_id) AS total_orders
       FROM orders
       GROUP BY DATEPART(HOUR, time)
       ORDER BY order_hour;


--Join relevant tables to find the category-wise distribution of pizzas.

      SELECT category, COUNT(name) AS Total_pizzas
      FROM pizza_types
      GROUP BY category;


--Group the orders by date and calculate the average number of pizzas ordered per day.
         
		SELECT ROUND(AVG(quantity), 0) AS Avg_Pizzas_Per_Day
FROM (
    SELECT o.date, SUM(od.quantity) AS quantity
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.date
) AS order_quantity;


--Determine the top 3 most ordered pizza types based on revenue.

         SELECT TOP 3 pt.name, SUM(od.quantity * p.price) AS total_revenue
         FROM pizza_types pt JOIN pizzas p 
         ON pt.pizza_type_id = p.pizza_type_id
         JOIN order_details od ON p.pizza_id = od.pizza_id
         GROUP BY pt.name
         ORDER BY total_revenue DESC;


--Calculate the percentage contribution of each pizza type to total revenue.

    SELECT pt.name, 
   SUM(od.quantity * p.price) AS revenue,
  (SUM(od.quantity * p.price) / (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id)) * 100 AS percentage_contribution
   FROM pizza_types pt JOIN pizzas p 
   ON pt.pizza_type_id = p.pizza_type_id
   JOIN order_details od ON p.pizza_id = od.pizza_id
   GROUP BY pt.name
   ORDER BY percentage_contribution DESC;


--Analyze the cumulative revenue generated over time.

           SELECT date, 
       SUM(revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM (
    SELECT o.date, SUM(od.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY o.date
)   AS daily_revenue;


--Determine the top 3 most ordered pizza types based on revenue for each pizza category.

           SELECT category, name, revenue
FROM (
    SELECT category, name, revenue,
           RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM (
        SELECT pizza_types.category, pizza_types.name, 
               SUM(order_details.quantity * pizzas.price) AS revenue
        FROM pizza_types 
        JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category, pizza_types.name
    ) AS a
) AS b
WHERE rn <= 3;