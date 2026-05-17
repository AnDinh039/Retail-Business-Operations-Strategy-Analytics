CREATE VIEW View_Customer_RFM_Analysis AS
WITH Customer_Stats AS (
    SELECT 
        customer_key,
        -- Monetary: Tổng doanh thu
        SUM(revenue) AS Monetary, 
        
        -- Frequency: Tổng số đơn hàng duy nhất
        COUNT(DISTINCT order_number) AS Frequency,
        
        -- Tính ngày mua hàng cuối cùng
        MAX(order_date) AS Last_Purchase_Date,
        
        -- Recency: Số ngày từ lần mua cuối đến mốc 31/12/2020
        DATEDIFF(day, MAX(order_date), '2020-12-31') AS Recency

    FROM sales
    -- Chỉ lấy dữ liệu đến hết năm 2020 để khớp với báo cáo của bạn
    WHERE order_date <= '2020-12-31'
    GROUP BY customer_key
)
SELECT 
    c.customer_key, 
    c.name, 
    c.gender, 
    c.city, 
    c.state, 
    c.country, 
    c.continent,
    COALESCE(rs.Recency, 9999) AS Recency,    
    COALESCE(rs.Frequency, 0) AS Frequency,  
    COALESCE(rs.Monetary, 0) AS Monetary     -- ĐÃ XÓA DẤU PHẨY Ở ĐÂY
FROM customers c
LEFT JOIN Customer_Stats rs ON c.customer_key = rs.customer_key;