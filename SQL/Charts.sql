select * from pizza_sales

--daily trend for total orders

select DATENAME (dw, order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME (dw, order_date)
/*
datename is an argument used to get name of the date dw is used to get sun, mon,...
we can't use use an aggregate function (COUNT, SUM, etc.) inside a GROUP BY clause.
GROUP BY must contain columns or expressions, not aggregate results.
*/

--monthly trend for total orders

select DATENAME(MONTH, order_date) as Month_name , count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_orders desc

--Percentage of pizza sales by category

select pizza_category, sum(total_price) * 100/
(select sum(total_price) from pizza_sales)
as percentage_total_sales_based_on_category
from pizza_sales
group by pizza_category

select pizza_category, sum(total_price) * 100/
(select sum(total_price) from pizza_sales where MONTH(order_date)=1)
as percentage_total_sales_based_on_category
from pizza_sales
where MONTH(order_date)=1 -- 1 means january
group by pizza_category

--Percentage of sales by pizza size

select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100/
(select sum(total_price) from pizza_sales WHERE DATEPART(quarter, order_date)=1) as decimal(10,2))
as percentage_total_sales_based_on_size
from pizza_sales
WHERE DATEPART(quarter, order_date)=1
group by pizza_size
order by percentage_total_sales_based_on_size desc

--Total pizzas sold by pizza category
select pizza_name, count(distinct order_id) as pizza_sold_each_cate from pizza_sales
group by pizza_name

--top 5 best selling pizzas by revenue
select top 5 pizza_name, sum(total_price) as total_revenue_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_revenue_wrt_pizza_name desc

--top 5 worst selling pizzas by revenue
select top 5 pizza_name, sum(total_price) as total_revenue_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_revenue_wrt_pizza_name asc

--top 5 best selling pizzas by quantity
select top 5 pizza_name, sum(quantity) as total_quantity_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_quantity_wrt_pizza_name desc


--top 5 worst selling pizzas by quantity
select top 5 pizza_name, sum(quantity) as total_quantity_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_quantity_wrt_pizza_name asc

--Top 5 best sellers by total orders
select top 5 pizza_name, count(distinct order_id) as total_orders_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_orders_wrt_pizza_name desc

--Top 5 worst sellers by total orders
select top 5 pizza_name, count(distinct order_id) as total_orders_wrt_pizza_name from pizza_sales
group by pizza_name
order by total_orders_wrt_pizza_name asc