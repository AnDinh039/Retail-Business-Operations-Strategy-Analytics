-- Tinh doanh thu tung cua hang tu 2016-2020, neu doanh thu cua cua hang nao = 0 - da dong cua truoc 2016

-- Them cot status 
ALTER TABLE stores
ADD status nvarchar(50)
UPDATE stores
set status = (
				CASE 
					WHEN revenue is NULL THEN status = 'Closed'
					ELSE 'Active'
				END
				)


-- Them cot close_date	
ALTER TABLE stores
ADD close_date date
UPDATE stores
set close_date = (
				CASE 
					WHEN status 'Closed' THEN '2015-12-31'
					ELSE NULL
				END
				)

-- Tinh don hang cuoi cung cua cua hang, neu sau 6 thang ke tu ngay co don hang cuoi cung ma khong phat sinh them don hang - da dong cua ke tu sau 6 nam 
-- (VD: last_order = 2019-01-01, sau 6 thang 2019-07-01 van khong co don hang - dong cua)
ALTER TABLE stores
ADD last_order DATE;

WITH Store_Max_Date AS (
    SELECT 
        store_key, 
        MAX(order_date) AS Latest_Date
    FROM details_sales
    GROUP BY store_key
)
UPDATE s
SET s.last_order = smd.Latest_Date
FROM stores s
JOIN Store_Max_Date smd ON s.store_key = smd.store_key;

WITH Store_Last_Order AS (
    SELECT 
        store_key, 
        MAX(order_date) AS Last_Order
    FROM sales
    GROUP BY store_key
)


UPDATE s
SET 
    s.status = 'Closed',
    -- close_date = ngày cuối cùng + 6 tháng
    s.close_date = DATEADD(month, 6, s.Last_Order),
    s.reason = N'No orders in 6 months'
FROM stores s
-- Điều kiện: Nếu từ Last_Order đến hiện tại (hoặc mốc 31/12/2020) > 6 tháng
WHERE DATEDIFF(month, s.last_order, '2020-12-31') >= 6;

