CREATE VIEW  Sales AS
SELECT [order_number]
      ,[order_date]
      ,[delivery_date]
      ,[customer_key]
      ,[store_key],
	  SUM(order_value) as revenue,
	   SUM(order_value) as cogs,
	   count(line_item) as total_product,
	   sum(quantity) as unit_solds,
		DATEDIFF(day, order_date, delivery_date) AS number_of_delivery_days 
  FROM [retails].[dbo].[details_sales]
  GROUP BY [order_number]
      ,[order_date]
      ,[delivery_date]
      ,[customer_key]
      ,[store_key]
