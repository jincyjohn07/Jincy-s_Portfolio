select * from pizza_sales --selecting all datas from the csv file we imported
--total revenue
select sum(total_price) AS Total_Revenue from pizza_sales --sum of total sales
--Average sales values
select sum(total_price) / count(distinct order_id) as Average_order_values from pizza_sales --order id is repeating thats y distinct is given
--total pizzas sold
select sum(quantity) as Total_pizzas_sold from pizza_sales
--total orders
select count(distinct order_id) as Total_Orders from pizza_sales
--average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) 
as Avg_pizzas_per_order from pizza_sales

--use cast for sum(quantity), count(order_id) take the result and the result is casted

/*

--if the result gives an decimal value, we need onlu upto 2 decimal values
select cast(sum(quantity) as decimal(10,2)) / count(distinct order_id) as Avg_pizzas_per_order from pizza_sales
that means from 10 decimal points, only 2 will show, 10.78765433 --10.78

*/
