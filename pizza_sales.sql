create database pizzahut;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) );

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id) );

-- Retrieve the total number of orders placed.
USE pizzahut;

select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
USE pizzahut;
select round(SUM(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas
on pizzas.pizza_id=order_details.pizza_id

-- Identify the highest-priced pizza.
USE pizzahut;

select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
order by pizzas.price desc limit 1;

select max(price) from pizzas;

-- Identify the most common pizza size ordered.
USE pizzahut;

select quantity, count(order_details_id) 
from order_details group by quantity;

select pizzas.size , count(order_details.order_details_id)
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size;

-- List the top 5 most ordered pizza types along with their quantities.

USE pizzahut;

select pizza_types.name, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity  desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
USE pizzahut;

select pizza_types.category, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on pizzas.pizza_id=order_details.pizza_id
group by pizza_types.category order by quantity desc ;

-- Determine the distribution of orders by hour of the day.
select hour(time), count(order_id) from orders
group by hour(time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity) from
(select orders.date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.date) as  quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas


-- Calculate the percentage contribution of each pizza type to total revenue.
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;


