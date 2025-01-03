--Date Dim 

CREATE TABLE public.date_dim (
	"date" date NOT NULL,
	"year" int4 NOT NULL,
	"month" int4 NOT NULL,
	"day" int4 NOT NULL,
	day_of_week int4 NOT NULL,
	week int4 NOT NULL,
	quarter int4 NOT NULL,
	is_weekend bool NOT NULL,
	month_name varchar(20) NOT NULL,
	day_name varchar(20) NOT NULL,
	season varchar(20) NOT NULL,
	date_id int4 NOT NULL,
	CONSTRAINT date_dim_pkey PRIMARY KEY (date_id)
);
---------------------------------------------------------------------------------------

-- Time Dim

CREATE TABLE public.time_dim (
	"hour" int4 NOT NULL,
	"minute" int4 NOT NULL,
	"second" int4 NOT NULL,
	"time" time NOT NULL,
	time_id int4 NOT NULL,
	CONSTRAINT time_dim_pkey PRIMARY KEY (time_id)
);
---------------------------------------------------------------------------------------

-- Customers Dim 

CREATE TABLE public.customers_dim (
	customer_internal_id serial4 NOT NULL,
	customer_name varchar(50) NOT NULL,
	customer_zip_code varchar(20) NOT NULL,
	customer_city varchar(50) NOT NULL,
	customer_state varchar(50) NOT NULL,
	CONSTRAINT customers_dim_pkey PRIMARY KEY (customer_internal_id)
);
---------------------------------------------------------------------------------------

-- Products Dim 

CREATE TABLE public.products_dim (
	product_internal_id serial4 NOT NULL,
	product_id varchar(50) NOT NULL,
	product_category varchar(50) NULL,
	product_name_lenght float8 NULL,
	product_description_lenght float8 NULL,
	product_photos_qty float8 NULL,
	product_weight_g float8 NULL,
	product_length_cm float8 NULL,
	product_height_cm float8 NULL,
	product_width_cm float8 NULL,
	CONSTRAINT products_dim_pkey PRIMARY KEY (product_internal_id)
);
---------------------------------------------------------------------------------------

-- Sellers Dim 

CREATE TABLE public.sellers_dim (
	seller_internal_id serial4 NOT NULL,
	seller_id varchar(50) NOT NULL,
	seller_zip_code varchar(20) NOT NULL,
	seller_city varchar(50) NOT NULL,
	seller_state varchar(50) NOT NULL,
	CONSTRAINT sellers_dim_pkey PRIMARY KEY (seller_internal_id)
);
---------------------------------------------------------------------------------------

-- Orders Dim 

CREATE TABLE public.orders_dim (
	order_internal_id serial4 NOT NULL,
	order_id varchar(50) NOT NULL,
	customer_internal_id int4 NULL,
	order_status varchar(50) NOT NULL,
	order_date_id int4 NULL,
	order_date_time_id int4 NULL,
	order_approved_at_date_id int4 NULL,
	order_approved_at_time_id int4 NULL,
	pickup_date_id int4 NULL,
	pickup_time_id int4 NULL,
	delivered_at_date_id int4 NULL,
	delivered_at_time_id int4 NULL,
	estimated_delivery_date_id int4 NULL,
	CONSTRAINT orders_dim_pkey PRIMARY KEY (order_internal_id)
);


-- public.orders_dim foreign keys

ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_customer_internal_id_fkey FOREIGN KEY (customer_internal_id) REFERENCES public.customers_dim(customer_internal_id);
ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_delivered_at_date_id_fkey FOREIGN KEY (delivered_at_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_estimated_delivery_date_id_fkey FOREIGN KEY (estimated_delivery_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_order_approved_at_date_id_fkey FOREIGN KEY (order_approved_at_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_order_date_id_fkey FOREIGN KEY (order_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.orders_dim ADD CONSTRAINT orders_dim_pickup_date_id_fkey FOREIGN KEY (pickup_date_id) REFERENCES public.date_dim(date_id);
---------------------------------------------------------------------------------------

-- Orders Items Dim 

CREATE TABLE public.order_items_dim (
	order_internal_id int4 NOT NULL,
	order_item_id int4 NOT NULL,
	product_internal_id int4 NOT NULL,
	seller_internal_id int4 NOT NULL,
	pickup_limit_date_id int4 NOT NULL,
	pickup_limit_time_id int4 NOT NULL,
	price float8 NOT NULL,
	shipping_cost float8 NOT NULL,
	CONSTRAINT order_items_dim_pkey PRIMARY KEY (order_internal_id, order_item_id)
);


-- public.order_items_dim foreign keys

ALTER TABLE public.order_items_dim ADD CONSTRAINT order_items_dim_order_internal_id_fkey FOREIGN KEY (order_internal_id) REFERENCES public.orders_dim(order_internal_id);
ALTER TABLE public.order_items_dim ADD CONSTRAINT order_items_dim_pickup_limit_date_id_fkey FOREIGN KEY (pickup_limit_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.order_items_dim ADD CONSTRAINT order_items_dim_pickup_limit_time_id_fkey FOREIGN KEY (pickup_limit_time_id) REFERENCES public.time_dim(time_id);
ALTER TABLE public.order_items_dim ADD CONSTRAINT order_items_dim_product_internal_id_fkey FOREIGN KEY (product_internal_id) REFERENCES public.products_dim(product_internal_id);
ALTER TABLE public.order_items_dim ADD CONSTRAINT order_items_dim_seller_internal_id_fkey FOREIGN KEY (seller_internal_id) REFERENCES public.sellers_dim(seller_internal_id);
---------------------------------------------------------------------------------------


-- Payments Dim 

CREATE TABLE public.payments_dim (
	payment_internal_id serial4 NOT NULL,
	order_internal_id int4 NOT NULL,
	payment_sequential int4 NULL,
	payment_type varchar(50) NULL,
	payment_installments int4 NULL,
	payment_value float8 NULL,
	CONSTRAINT payments_dim_pkey PRIMARY KEY (payment_internal_id)
);


-- public.payments_dim foreign keys

ALTER TABLE public.payments_dim ADD CONSTRAINT payments_dim_order_internal_id_fkey FOREIGN KEY (order_internal_id) REFERENCES public.orders_dim(order_internal_id);
---------------------------------------------------------------------------------------


-- Sales Fact 

CREATE TABLE public.sales_fact (
	order_internal_id int4 NOT NULL,
	seller_internal_id int4 NULL,
	product_internal_id int4 NOT NULL,
	qyt int4 NULL,
	total_price float8 NULL,
	total_shipping_cost float8 NULL,
	CONSTRAINT sales_fact_pkey PRIMARY KEY (order_internal_id, product_internal_id)
);


-- public.sales_fact foreign keys

ALTER TABLE public.sales_fact ADD CONSTRAINT sales_fact_order_internal_id_fkey FOREIGN KEY (order_internal_id) REFERENCES public.orders_dim(order_internal_id);
ALTER TABLE public.sales_fact ADD CONSTRAINT sales_fact_seller_internal_id_fkey FOREIGN KEY (seller_internal_id) REFERENCES public.sellers_dim(seller_internal_id);

----------------------------------------------------------------------------------------------

-- Payments Fact 

CREATE TABLE public.payment_summary_fact (
	order_internal_id int4 NOT NULL,
	payment_type varchar(50) NOT NULL,
	payments_count int4 NULL,
	total_payment_installments int4 NULL,
	total_payment_value float8 NULL,
	CONSTRAINT payment_summary_fact_pkey PRIMARY KEY (order_internal_id, payment_type)
);


-- public.payment_summary_fact foreign keys

ALTER TABLE public.payment_summary_fact ADD CONSTRAINT payment_summary_fact_order_internal_id_fkey FOREIGN KEY (order_internal_id) REFERENCES public.orders_dim(order_internal_id);
----------------------------------------------------------------------------------------------

--Feedbacks 


CREATE TABLE public.feedbacks (
	feedback_internal_id serial4 NOT NULL,
	feedback_id varchar(50) NOT NULL,
	order_internal_id int4 NOT NULL,
	feedback_score int4 NULL,
	feedback_form_sent_date_id int4 NULL,
	feedback_form_answer_date_id int4 NULL,
	feedback_form_answer_time_id int4 NULL,
	CONSTRAINT feedbacks_pkey PRIMARY KEY (feedback_internal_id)
);


-- public.feedbacks foreign keys

ALTER TABLE public.feedbacks ADD CONSTRAINT feedbacks_feedback_form_answer_date_id_fkey FOREIGN KEY (feedback_form_answer_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.feedbacks ADD CONSTRAINT feedbacks_feedback_form_sent_date_id_fkey FOREIGN KEY (feedback_form_sent_date_id) REFERENCES public.date_dim(date_id);
ALTER TABLE public.feedbacks ADD CONSTRAINT feedbacks_order_internal_id_fkey FOREIGN KEY (order_internal_id) REFERENCES public.orders_dim(order_internal_id);
