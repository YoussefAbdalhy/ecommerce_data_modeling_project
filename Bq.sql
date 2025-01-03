--When is the peak season of our ecommerce ?
select 
--	dd.year,
	dd.season,
	sum(total_price) as total_GMV
from
	sales_fact sf 
left join 
	orders_dim od  
	using(order_internal_id)
left join 
	date_dim dd on 
	od.order_date_id = dd.date_id
where 
	order_status ='delivered'
group by 1
order by 2 desc
limit 1


--What time users are most likely make an order or using the ecommerce app?
select 
	td.hour,
	count(order_internal_id) as orders_count
from 
	orders_dim od 
left join 
	time_dim td on 
	od.order_date_time_id = td.time_id
group by 1 
order by 2 desc 
limit 1

-- What is the preferred way to pay in the ecommerce?
select 
	payment_type,
	count(distinct (order_internal_id)) as count_of_orders 
from 
	payment_summary_fact 
group by 1 
order by 2 desc 
limit 1


-- What is the preferred way to pay in the ecommerce?
select 
	payment_type,
	sum (total_payment_value) as total_payments
from 
	payment_summary_fact 
group by 1 
order by 2 desc 
limit 1

-- How many installment is usually done when paying in the ecommerce?
select 
	avg(total_payment_installments) avg_installments
from 
	payment_summary_fact
where 
	payment_type = 'credit_card'
	
-- What is the average spending time for user for our ecommerce?

-- What is the frequency of purchase on each state?
select 
	customer_state,
	dd.year,
	count(order_internal_id) as orders_count
from 
	orders_dim od 
left join 
	date_dim dd on 
	od.order_date_id = dd.date_id
left join 
	customers_dim cd on 
	cd.customer_internal_id = od.customer_internal_id
where 
	order_status ='delivered'
group by 1,2
order  by 1,2

-- Which logistic route that have heavy traffic in our ecommerce?
select 
	customer_city,
	seller_city,
	count(sf.order_internal_id) as count_of_orders
from 
	sales_fact sf 
left join 
	sellers_dim sd on 
	sf.seller_internal_id = sd.seller_internal_id
left join 
	orders_dim od on 
	od.order_internal_id = sf.order_internal_id
left join customers_dim cd on 
	cd.customer_internal_id = od.customer_internal_id
group by 1,2 
order by 3 desc

-- How many late delivered order in our ecommerce? Are late order affecting the customer satisfaction?
select 
	count(*) as late_orders_count
from orders_dim od 
where delivered_at_date_id > estimated_delivery_date_id

with late_orders as (
select 
	order_internal_id as late_order_inernal_id 
from orders_dim od 
where delivered_at_date_id > estimated_delivery_date_id
)
select 
	avg(feedback_score) as avg_feedback_score_for_late_orders
from feedbacks
where order_internal_id in (select late_order_inernal_id from late_orders)

-- How long are the difference between estimated delivery time and actual delivery time in each state?
select 
	customer_state,
	avg(dd1.date-dd2.date) as avg_diff_between_delivery_estimate_dates 
from orders_dim od 
left join customers_dim
using(customer_internal_id)
left join date_dim dd1 on 
dd1.date_id = delivered_at_date_id
left join date_dim dd2 on 
dd1.date_id = estimated_delivery_date_id
group by 1
