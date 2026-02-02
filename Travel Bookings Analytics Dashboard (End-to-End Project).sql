use customer;
desc bookings_2025_20000_rows;
rename table  bookings_2025_20000_rows to customers;
desc customers;
select * from customers;

# Show all bookings made in 2025
SELECT *
FROM customers
WHERE YEAR(booking_date) = 2025;

# Total number of bookings
SELECT COUNT(*) AS total_bookings
FROM customers;

# Total revenue from all bookings
SELECT SUM(booking_amount) AS total_revenue
FROM customers;

# List all distinct cities
SELECT DISTINCT city
FROM customers;

#Show cancelled bookings
SELECT *
FROM customers
WHERE booking_status = 'Cancelled';

#Bookings with amount greater than 10,000
SELECT *
FROM customers
WHERE booking_amount > 10000;

#Total bookings by service type
SELECT service_type, COUNT(*) AS total_bookings
FROM customers
GROUP BY service_type;

#Total revenue by city
SELECT city, SUM(booking_amount) AS total_revenue
FROM customers
GROUP BY city;

#Average booking amount per service
SELECT service_type, AVG(booking_amount) AS avg_amount
FROM customers
GROUP BY service_type;

#Bookings count by payment mode
SELECT payment_mode, COUNT(*) AS total_bookings
FROM customers
GROUP BY payment_mode;

#Month-wise total bookings
SELECT 
    MONTHNAME(booking_date) AS month,
    COUNT(*) AS total_bookings
FROM customers
GROUP BY MONTH(booking_date), MONTHNAME(booking_date)
ORDER BY MONTH(booking_date);

#Month-wise total revenue
SELECT 
    MONTHNAME(booking_date) AS month,
    SUM(booking_amount) AS total_revenue
FROM customers
GROUP BY MONTH(booking_date), MONTHNAME(booking_date)
ORDER BY MONTH(booking_date);

#Top 5 cities by revenue
SELECT city, SUM(booking_amount) AS revenue
FROM customers
GROUP BY city
ORDER BY revenue DESC
LIMIT 5;

#Cancelled bookings by city
SELECT city, COUNT(*) AS cancelled_bookings
FROM customers
WHERE booking_status = 'Cancelled'
GROUP BY city;

#Cancellation rate (%)
SELECT 
    (SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) 
    / COUNT(*)) * 100 AS cancellation_rate
FROM customers;

#Customers with more than 5 bookings
SELECT customer_id, COUNT(*) AS total_bookings
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 5;

#Rank cities based on revenue
SELECT 
    city,
    SUM(booking_amount) AS revenue,
    RANK() OVER (ORDER BY SUM(booking_amount) DESC) AS city_rank
FROM customers
GROUP BY city;

#Peak booking month
SELECT 
    MONTHNAME(booking_date) AS month,
    COUNT(*) AS total_bookings
FROM customers
GROUP BY MONTH(booking_date), MONTHNAME(booking_date)
ORDER BY total_bookings DESC
LIMIT 1;

#Service type with highest cancellations
SELECT service_type, COUNT(*) AS cancelled_count
FROM customers
WHERE booking_status = 'Cancelled'
GROUP BY service_type
ORDER BY cancelled_count DESC
LIMIT 1;

#Running total of revenue (month-wise)
SELECT
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month) AS running_total
FROM (
    SELECT 
        MONTH(booking_date) AS month,
        SUM(booking_amount) AS monthly_revenue
    FROM customers
    GROUP BY MONTH(booking_date)) t;
    
    















