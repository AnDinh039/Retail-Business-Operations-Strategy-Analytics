# Retail Business Operations Strategy Analytics | Power BI
**Tác giả:** Đinh Hữu An

**Ngày:** Apr 2026

**BI tool:** Power BI

## MỤC LỤC
### 1. Bối Cảnh Kinh Doanh 
### 2. Cấu Trúc Dữ Liệu
### 3. Luồng Tư Duy Thiết Kế
### 4. Key Insight & Trực Quan Hoá Dữ Liệu
### 5. Kết Luận & Hướng Giải Quyết

## 1. BỐI CẢNH KINH DOANH
### 1.1. Tổng Quan Công Ty
Doanh nghiệp là một chuỗi bán lẻ thiết bị điện tử toàn cầu, sở hữu mạng lưới gồm 67 điểm bán vật lý trải dài tại Bắc Mỹ, Châu Âu và Châu Úc. Hệ thống cửa hàng được phân chia thành 4 mô hình chiến lược: Flagship (Quy mô lớn, trải nghiệm cao cấp), Mall Center (Trung tâm thương mại), Standard (Tiêu chuẩn) và Compact (Nhỏ gọn, tối ưu diện tích).

### 1.2. Vấn đề đang gặp phải

 **Pha "Đốt cháy giai đoạn" (2016 - 2019)**
 
 <img width="1302" height="377" alt="image" src="https://github.com/user-attachments/assets/c1893c90-4b23-414a-b16b-125cf657f02b" />
 
 - Công ty theo đuổi chiến lược bành trướng bằng "bê tông và cốt thép" (mở cửa hàng liên tục). Đỉnh điểm là năm 2018 với mức tăng trưởng bùng nổ 72.32%. Tới năm 2019, doanh thu chạm đỉnh $18.3M, nhưng tốc độ tăng trưởng đã bắt đầu chậm lại (42.81%), báo hiệu thị trường bán lẻ truyền thống đang tiến tới điểm bão hòa. 
   
   <img width="966" height="396" alt="image" src="https://github.com/user-attachments/assets/b2abb617-8314-4317-8a10-279476cf788b" /> 
  **Cú sốc Khủng hoảng doanh thu (2020 - Đầu 2021):**

   - Doanh thu chủ yếu tăng mạnh vào Quý 4 và  Quý 1, cho thấy nhu cầu mua sắm ở thời điểm cuối năm và đầu năm rất cao. Doanh thu Quý 1 2020 thậm chỉ nhỉnh hơn so với năm kỷ lục 2019 ($5M so mới $4.9M), hứa hẹn một cột mốc kỷ lục mới về doanh thu cho công ty.
   - Tuy nhiên, đây cũng là thời điểm bắt đầu cho khoảng thời gian đen tối nhất trong giai đoạn phát triển. Mặc dù khởi đầu khá tốt, doanh thu năm 2020 bốc hơi gần một nửa (-49.11%). Tình trạng này tiếp diễn qua năm 2021 và thậm chí còn trầm trọng hơn khi tổng kết tốc độ tăng trưởng của Quý 1 2021 chỉ là -70.23%

<img width="1319" height="299" alt="image" src="https://github.com/user-attachments/assets/c4df6d1b-b65f-47fc-a2c2-128d84f88fc6" />

<img width="1311" height="302" alt="image" src="https://github.com/user-attachments/assets/b8bd6101-408e-40d0-96fc-d305aed3de21" />

- Đại dịch bùng phát. Cú "lao dốc" thể hiện rõ từ tháng 4/2020 khi hệ thống cửa hàng vật lý (In-store) tê liệt.
  
- Lẽ ra đây là lúc Kênh Online phải gánh vác doanh số, nhưng dữ liệu lại chỉ ra: Kênh Online lao dốc song song cùng In-store.

  <img width="1321" height="391" alt="image" src="https://github.com/user-attachments/assets/2a6f9a99-1dd0-44aa-8cc4-088fdec0f434" />

- Hệ thống thiếu vắng nền tảng Omnichannel (Đa kênh) vững chắc.
  
### 1.3. Nguyên nhân khách quan 
**Cú sốc đại dịch Covid-19 bùng nổ trên toàn thế giới**

  <img width="578" height="367" alt="image" src="https://github.com/user-attachments/assets/f5004c49-adaf-4663-8dcf-37432c36d365" />

- **Tê liệt hệ thống vật lý**: Cần phải biết rằng công ty hoạt động chủ yếu tại các cửa hàng hệ thống vật lý, tập trung nhiều ở khu vực Bắc Mỹ và Châu Âu, song các lệnh phong tỏa đột ngột vào Quý 2/2020 đã "đóng băng" lưu lượng khách hàng trực tiếp, đánh trúng vào mạch máu doanh thu chính của công ty.
  
<img width="848" height="549" alt="image" src="https://github.com/user-attachments/assets/e314b149-3348-4cb6-9ed1-276d086476f0" />

- **Đứt gãy chuỗi cung ứng**: Tình trạng thiếu hụt nguồn cung linh kiện/sản phẩm toàn cầu kéo dài sang đầu năm 2021 giải thích cho việc tại sao doanh thu Q1/2021 lại chạm đáy (chỉ còn $1M) dù các lệnh phong tỏa đã được nới lỏng.

### 1.4. Yêu cầu giải quyết vấn đề

- **Vận hành:** Xây dựng báo cáo theo dõi tổng quan kinh doanh, phân tích hiệu suất của khác khu vực.
- **Kinh doanh:** Phân tích sản phẩm chủ chốt, xu hướng mua sắm và hành vi khách hàng. 
- **Chiến lược:** Nhận định rõ được nguyên nhân, đề xuất chiến lược thúc đẩy bán hàng và tối ưu hoá thị trường. 
