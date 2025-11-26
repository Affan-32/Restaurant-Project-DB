use restaurant_db;

-- View the menu_items table,
select * from menu_items;

-- find the number of items on the menu
select count(*) from menu_items;

-- What are the least and most expensive items on the menu?
select * from menu_items
order by price;

select * from menu_items
order by price desc;

-- How many Italian dishes are on the menu?

select count(*) from menu_items
where category= 'Italian';

-- what are the least and most expensive Italian dishes on the menu?
select * 
from menu_items
where category= 'Italian'
order by price;

select * 
from menu_items
where category= 'Italian'
order by price desc;

-- How many dishes are there in each category?
select category, count(item_name) as num_dishes
from menu_items
group by category;

-- Avergae dish price within each catoegory

select category, avg(price) as avg_price 
from menu_items
group by category;

-- View the order_details table.
select* from order_details;

-- what is the range of the table?
select min(order_date), max(order_date) from order_details;

-- How many orders were named within this date range
select count(distinct order_id) from order_details;

-- how many items were ordered within this date range
select count(*) from order_details;

-- which orders had the most number of items?
select order_id, count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

-- How many orders had more than 12 items?
select count(*) from
(select order_id, count(item_id) as num_items
from order_details
group by order_id
having num_items > 12 ) as num_orders;

-- Combine the menu_items and order_details tables into a single table.
select * from menu_items;
select* from order_details;

select *
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id;

-- What were the least and most ordered items? what categories were they in?
select item_name, category, count(order_details_id) as num_purchases
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by item_name, category
order by num_purchases;

-- what were the top 5 orders that spent the most money?
select order_id, sum(price) as total_spend
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

-- View the details of the highest spend order. 
select category, count(item_id) as num_items
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
where order_id = 440
group by category;

-- View the details of the top 5 highest spend orders.
select order_id, category, count(item_id) as num_items
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
where order_id IN (440,2075, 1957, 330, 2675)
group by order_id, category;