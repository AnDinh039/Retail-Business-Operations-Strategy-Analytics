 # Dự án BI & Tư Vấn Chiến Lược: Tối Ưu Hóa Vận Hành Chuỗi Bán Lẻ Công Nghệ Toàn Cầu Sau Khủng Hoảng (2016 - 2020)

## Thông Tin Tác Giả
* **Họ và tên:** Đinh Hữu An
* **Vai trò:** Data Analyst | Business Intelligence Professional
* **Thời gian thực hiện:** Tháng 04/2026
* **Công cụ sử dụng:** Power BI, SQL, Excel
* **Nguồn dữ liệu:** Xóm Data |https://dataset.xomdata.com/datasets/schema/retails | https://www.facebook.com/groups/1707916343455196

---

## 1. Kiến Trúc Dữ Liệu & Mô Tả Hệ Thống (Data Architecture & Metadata)

Hệ thống cơ sở dữ liệu được tổ chức theo mô hình **Sơ đồ hình sao (Star Schema)**, tối ưu hóa cho tốc độ truy vấn và trực quan hóa dữ liệu trên các công cụ Business Intelligence. Hệ thống bao gồm 1 bảng sự kiện (`sales`) đóng vai trò trung tâm và 3 bảng thứ nguyên (`customers`, `products`, `stores`).

### 1.1. Từ Điển Dữ Liệu Chi Tiết (Data Dictionary)

#### Bảng `sales` (Fact Table - Bảng Sự Kiện Doanh Số)
Lưu trữ toàn bộ dữ liệu giao dịch lịch sử ở cấp độ chi tiết nhất (Granular Level).

| Tên Cột (Column Name) | Kiểu Dữ Liệu (Data Type) | Mô Tả Ý Nghĩa (Description) |
| :--- | :--- | :--- |
| `order_number` | Int64 / Grain | Mã định danh duy nhất của hóa đơn. |
| `line_item` | Int64 / Grain | Số thứ tự dòng sản phẩm trong cùng một hóa đơn. |
| `order_date` | Date | Ngày phát sinh giao dịch mua hàng. |
| `delivery_date` | Date / Nullable | Ngày hoàn thành giao hàng (để trống nếu giao dịch trực tiếp tại cửa hàng). |
| `customer_key` | Int64 / Foreign Key | Mã liên kết sang bảng khách hàng (`customers`). |
| `store_key` | Int64 / Foreign Key | Mã liên kết sang bảng cửa hàng (`stores`) - Giá trị `0` là kênh Online. |
| `product_key` | Int64 / Foreign Key | Mã liên kết sang bảng sản phẩm (`products`). |
| `quantity` | Int64 | Số lượng sản phẩm tiêu thụ trên từng dòng hóa đơn. |

#### Bảng `customers` (Dimension Table - Thứ Nguyên Khách Hàng)
Lưu trữ thông tin nhân khẩu học và địa lý hành chính của tập khách hàng.

| Tên Cột (Column Name) | Kiểu Dữ Liệu (Data Type) | Mô Tả Ý Nghĩa (Description) |
| :--- | :--- | :--- |
| `customer_key` | Int64 / Primary Key | Mã định danh duy nhất của từng khách hàng. |
| `name` | String | Họ và tên đầy đủ của khách hàng. |
| `gender` | String | Giới tính khách hàng (Male/Female). |
| `birthday` | Date | Ngày sinh của khách hàng. |
| `city` | String | Thành phố nơi khách hàng cư trú. |
| `state_code` | String | Mã viết tắt của bang/tỉnh thành. |
| `state` | String | Tên đầy đủ của bang/tỉnh thành. |
| `zip_code` | String | Mã bưu chính. |
| `country` | String | Quốc gia nơi khách hàng cư trú. |
| `continent` | String | Châu lục/Khu vực địa lý vĩ mô. |

#### Bảng `products` (Dimension Table - Thứ Nguyên Sản Phẩm)
Hệ thống hóa danh mục thiết bị công nghệ, cấu trúc giá bán và chi phí gốc.

| Tên Cột (Column Name) | Kiểu Dữ Liệu (Data Type) | Mô Tả Ý Nghĩa (Description) |
| :--- | :--- | :--- |
| `product_key` | Int64 / Primary Key | Mã định danh duy nhất của mỗi sản phẩm. |
| `product_name` | String | Tên chi tiết của sản phẩm trên hệ thống. |
| `brand` | String | Thương hiệu sản xuất của sản phẩm. |
| `color` | String | Thuộc tính màu sắc của sản phẩm. |
| `unit_cost_usd` | Float64 | Giá vốn hàng bán trên một đơn vị sản phẩm ($USD$). |
| `unit_price_usd` | Float64 | Giá bán lẻ niêm yết trên một đơn vị sản phẩm ($USD$). |
| `subcategory_key` | Int64 | Mã định danh phân nhóm sản phẩm phụ. |
| `subcategory` | String | Tên chi tiết của phân nhóm sản phẩm phụ. |
| `category_key` | Int64 | Mã định danh danh mục sản phẩm chính. |
| `category` | String | Tên danh mục chính (*Computers, Audio, Home Appliances...*). |

#### Bảng `stores` (Dimension Table - Thứ Nguyên Cửa Hàng)
Quản lý hạ tầng mạng lưới phân phối vật lý trực tiếp và trực tuyến.

| Tên Cột (Column Name) | Kiểu Dữ Liệu (Data Type) | Mô Tả Ý Nghĩa (Description) |
| :--- | :--- | :--- |
| `store_key` | Int64 / Primary Key | Mã định danh duy nhất của cửa hàng. |
| `country` | String | Quốc gia nơi đặt điểm bán lẻ lẻ. |
| `state` | String | Vùng lãnh thổ/Bang đặt cửa hàng vật lý. |
| `square_meters` | Float64 / Nullable | Diện tích mặt bằng kinh doanh của cửa hàng ($m^2$). |
| `open_date` | Date | Ngày cửa hàng chính thức khai trương đi vào vận hành. |

### 1.2. Mối Quan Hệ Giữa Các Bảng (Entity-Relationship Diagram)
Hệ thống thiết lập mối quan hệ vật lý **Một - Nhiều ($1:\infty$)** hướng từ các bảng thứ nguyên vào bảng sự kiện trung tâm:
* `customers.customer_key` ($1$) $\rightarrow$ `sales.customer_key` ($\infty$)
* `products.product_key` ($1$) $\rightarrow$ `sales.product_key` ($\infty$)
* `stores.store_key` ($1$) $\rightarrow$ `sales.store_key` ($\infty$)

---

## 2. Quy Trình Giải Quyết Vấn Đề Theo Khung 7 Bước McKinsey (McKinsey 7-Step Problem Solving Framework)

### Bước 1: Phát biểu Vấn đề (Define the Problem)
* **Bối cảnh:** Giai đoạn 2016 - 2019 tăng trưởng bền vững. Đỉnh doanh thu năm 2019 đạt **18.3 triệu USD** với biên lợi nhuận ổn định **~58%**. Quý 1/2020 khởi đầu thành công với **5 triệu USD** (cao hơn cùng kỳ năm trước).
* **Vấn đề cốt lõi:** Kết thúc năm tài chính 2020, doanh thu toàn chuỗi sụt giảm nghiêm trọng xuống chỉ còn **9 triệu USD** (Tăng trưởng âm **-49.1%**). Doanh thu bốc hơi gần một nửa chỉ sau 1 năm.
* **Phạm vi giới hạn thời gian:** Phân tích tập trung vào biến động dữ liệu giao dịch từ tháng 01/2020 đến tháng 12/2020.

### Bước 2: Cấu trúc hóa Vấn đề (Structure the Problem) - Nguyên tắc MECE & Issue Tree
Để đảm bảo tính toàn diện, không trùng lặp và không bỏ sót (Mutually Exclusive and Collectively Exhaustive), dòng doanh thu được phân rã theo công thức toán học và chuyển hóa thành sơ đồ cây vấn đề dưới đây:

$$\text{Doanh thu} = \text{Số lượng đơn hàng} \times \text{Giá trị trung bình đơn hàng (AOV)}$$
### Bước 3: Ưu tiên hóa các Nhánh Phân tích (Prioritize Issues)
Dựa trên cấu trúc cây vấn đề, các giả thuyết nghiên cứu được ưu tiên xử lý bao gồm:
* *Giả thuyết ưu tiên 1:* Sự sụt giảm không đến từ việc suy giảm sức mua trên từng đơn (AOV) mà do số lượng giao dịch bị triệt tiêu đột ngột bởi yếu tố phong tỏa xã hội từ tháng 05/2020.
* *Giả thuyết ưu tiên 2:* Điểm gãy lớn nhất của bộ máy nằm ở việc "tê liệt" năng lực thu hút khách hàng mới trực tuyến, ép doanh nghiệp phụ thuộc vào tệp khách cũ.
* *Giả thuyết ưu tiên 3:* Các danh mục sản phẩm có biên lợi nhuận cao nhưng kích thước lớn (Gia dụng, Âm thanh) bị tổn thất nặng nhất do sự đóng băng của các mô hình store diện tích lớn (Flagship, Mall Center).

### Bước 4: Lập Kế hoạch Phân tích & Triển khai (Issue Analysis & Data Gathering)
Sử dụng SQL để truy vấn dữ liệu thô từ các bảng `sales`, `customers`, `products`, và `stores`. Chuyển đổi dữ liệu sang Power BI để xây dựng các mô hình đo lường DAX nâng cao, bóc tách mối liên hệ giữa các biến số theo Kênh - Thị trường - Nhóm sản phẩm.

### Bước 5: Phân tích sâu & Diễn giải Dữ liệu (Deep-Dive Interpretation)

#### 5.1. Phân hóa Hiệu suất Địa lý và Mô hình Cửa hàng
* **Thị trường Đức (Suy thoái toàn diện):** Đứng đầu hệ thống về tốc độ suy giảm doanh thu (**-59.01%**), thu hẹp dòng tiền từ 2.4 triệu USD (2019) xuống còn 1 triệu USD (2020). Đức chịu cuộc khủng hoảng kép khi vừa mất lượng khách hàng mới nhiều nhất mạng lưới (**-76.19%**), vừa chứng kiến mô hình **Compact** tại đây sụt giảm nghiêm trọng nhất chuỗi (**-93.10%** khách mới). Các thị trường chịu mức giảm sâu trên 50% cùng với Đức bao gồm Ý (-53.58%), Úc (-53.37%), Anh (-53.06%), và Hà Lan (-51.52%).
* **Thị trường Mỹ (Tổn thất tuyệt đối lớn nhất):** Xét về giá trị tuyệt đối, Mỹ là nơi chịu thiệt hại nặng nề nhất. Dù tốc độ giảm doanh thu (-47.05%) thấp hơn Đức, nhưng do đây là thị trường trọng điểm đóng góp tới 6.3 triệu USD trong năm 2019, mức giảm này đã làm hụt mất **2.9 triệu USD** của toàn hệ thống. Điểm tựa giữ lại dòng tiền cho Mỹ là năng lực giữ chân khách cũ tốt nhất thế giới (lượng khách cũ quay lại chỉ giảm nhẹ **-16.98%**), bất chấp việc dòng khách mới đến phân khúc Flagship giảm -75.39% và Mall Center giảm -73.96%.
* **Thị trường Ý (Đứt gãy liên kết vận hành):** Ý ghi nhận khối lượng đơn hàng sụt giảm mạnh nhất toàn chuỗi với mức **-61.59%**. Hệ quả trực tiếp từ việc Ý có tốc độ giảm khách cũ cao nhất hệ thống (**-48.09%**), đặc biệt đứt gãy nặng nề ở các cấu trúc cửa hàng trong trung tâm thương mại lớn như Mall Center (-56.96% khách cũ).
* **Thị trường Hà Lan (Dịch chuyển hành vi chi tiêu):** Hà Lan ghi nhận doanh thu sụt giảm tận **-51.52%** nhưng lượng đơn hàng chỉ giảm **-46.09%**. Khách hàng tại đây vẫn duy trì tần suất lên đơn tương đối tốt hơn dòng tiền, phản ánh xu hướng người tiêu dùng chủ động dịch chuyển sang lựa chọn các nhóm sản phẩm có giá trị thấp hơn để tiết kiệm chi tiêu.
* **Thị trường Pháp (Kháng cự và thích ứng xuất sắc):** Pháp là điểm sáng lớn nhất của chuỗi khi ghi nhận mức sụt giảm doanh thu thấp nhất hệ thống (**-32.52%**). Đây là quốc gia duy nhất vận hành thành công mô hình cửa hàng nhỏ tiện lợi **Compact** trong dịch bệnh, đạt mức tăng trưởng dương duy nhất toàn cầu về lượng khách hàng cũ quay lại với **+3.57%** và giữ mức giảm khách mới ở mức thấp nhất chuỗi (-50.00%).

#### 5.2. Phân Nhóm Ma Trận Danh Mục Sản Phẩm (Product Portfolio Matrix)
* **Hạc mục cốt lõi (Core Driver) - Computers:** Ngành hàng đóng góp quy mô dòng tiền lớn nhất. Mặc dù lượng đơn giảm **-49.27%** và doanh thu giảm **-47.33%**, ngành hàng vẫn bảo toàn biên lợi nhuận vững chắc **~58%** và giữ chân khách cũ ổn định (-36.15%) nhờ làn sóng học tập và làm việc từ xa (*Work From Home*).
* **Ưu tiên xử lý khủng hoảng - Home Appliances & Audio:**
    * *Home Appliances* (Trụ cột doanh thu lớn thứ 2) rơi tự do: đơn hàng giảm **-60.91%**, doanh thu giảm **-58.99%**, lượng khách cũ sụt giảm mạnh nhất chuỗi (**-48.62%**).
    * *Audio* mất khách mới mạnh nhất hệ thống (**-76.46%**).
    * *Đặc trưng:* Nhóm hàng giá trị cao, chu kỳ dài và phụ thuộc vào trải nghiệm trực tiếp bị đóng băng hoàn toàn khi các store lớn bị phong tỏa. Tuy nhiên, biên lợi nhuận của nhóm rất dày (**~58.35%**).
* **Khai thác thặng dư ngắn hạn - TV & Video, Media & Entertainment:** Đáp ứng đúng hành vi giải trí tại nhà (*Stay-at-home*). Ngành hàng TV & Video ổn định đơn tốt nhất toàn chuỗi (chỉ giảm **-42.24%**) và giữ chân khách cũ đỉnh nhất (**-24.49%**). Nhóm Music/Movies sở hữu biên lợi nhuận cao nhất ma trận (**~61%**).
* **Sản phẩm dẫn tạo Traffic - Cell Phones:** Ghi nhận mức giảm doanh thu thấp nhất chuỗi (**-43.86%**) do là công cụ thiết yếu. Tuy biên lợi nhuận thấp nhưng tốc độ quay vòng dòng tiền nhanh, đóng vai trò giữ tần suất tương tác trực tuyến cho hệ thống.

### Bước 6: Tổng hợp Kết luận (Synthesize Findings)
Khủng hoảng sụt giảm 49.1% doanh thu của doanh nghiệp trong năm 2020 không xuất phát từ sản phẩm hay giá bán (AOV ổn định, Margin giữ vững ~58%). Lỗ hổng cốt lõi nằm ở **sự phụ thuộc cực đoan vào hạ tầng cửa hàng vật lý truyền thống** và **sự thiếu chuẩn bị cho nền tảng Omnichannel**, khiến phễu thu hút khách hàng mới bị chặn đứng hoàn toàn (-72.3% số đơn từ khách mới) khi các lệnh phong tỏa xã hội đóng băng các mô hình cửa hàng lớn (Flagship, Mall Center).

### Bước 7: Đề xuất Giải pháp Hành động Chiến lược (Actionable Recommendations)

#### 1. Điều chỉnh Hạ tầng Vật lý theo Đặc thù từng Quốc gia
* **Tại thị trường Mỹ:** Tập trung toàn bộ ngân sách hoạt động tiếp thị vào hệ thống CRM để chăm sóc và khai thác tệp khách hàng cũ (nhóm chống chịu tốt nhất chuỗi, chỉ giảm -17%). Chủ động cắt giảm chi phí cố định bằng cách thu hẹp tỷ trọng vận hành của các mô hình cửa hàng không gian lớn (Flagship/Mall) tại các khu trung tâm.
* **Tại thị trường Pháp:** Triển khai nhân rộng và mở rộng chuỗi cửa hàng tiện lợi quy mô nhỏ gần nhà (**Compact**). Tiến hành luân chuyển nguồn cung hàng hóa và nhân lực từ các mô hình lớn hiệu suất kém sang chuỗi này để đón đầu xu hướng mua sắm an toàn, gần khu dân cư của người tiêu dùng.
* **Tại thị trường Úc & Hà Lan:** Duy trì mô hình cửa hàng tiêu chuẩn **Standard** cốt lõi tại Úc để bảo vệ 100% tệp khách cũ hiện hữu và ngưng đẩy mạnh Flagship. Đối với Hà Lan, thực hiện chiến lược hạ phân khúc giá tại chuỗi Standard; ngừng đẩy mạnh hàng cao cấp và thay thế bằng các danh mục sản phẩm có mức giá trung bình để kích cầu tiêu dùng phù hợp với xu hướng thắt chặt chi tiêu.
* **Tại thị trường Đức & Ý:** Áp dụng chiến lược phòng thủ nghiêm ngặt để dừng việc thâm hụt vốn kéo dài. Quyết liệt thu hẹp diện tích mặt bằng, cắt giảm nhân sự vận hành trực tiếp, đóng cửa hoặc đóng băng tạm thời các mặt bằng Flagship và Mall Center hoạt động thâm hụt vốn (Đức suy thoái toàn diện, Ý mất tới 57% khách cũ tại phân khúc Mall).

#### 2. Tối Ưu Chiến Lược Phục Hồi Danh Mục Sản Phẩm Theo Biên Lợi Nhuận
* **Số hóa quy trình mảng Gia dụng (Home Appliances & Audio):** Dịch chuyển quy trình tiếp cận sang kênh tư vấn trực tuyến chuyên sâu (Video call tư vấn, thực tế ảo phối cảnh), thiết lập chính sách hỗ trợ giao hàng nhanh, lắp đặt và bảo trì tận nhà để giải cứu ngành hàng có biên lợi nhuận dày (~58.35%).
* **Khơi thông dòng tiền mảng Máy tính (Computers):** Đảm bảo tính liên tục của chuỗi cung ứng thiết bị làm việc từ xa. Phối hợp phối hợp với các tổ chức tín dụng triển khai giải pháp trả góp 0% hoặc Mua trước trả sau (BNPL) trên kênh online nhằm giải tỏa áp lực tài chính một lần, kéo lại lượng đơn hàng đang âm.
* **Nuôi bộ máy bằng mảng Giải trí:** Duy trì nguồn cung ổn định cho nhóm thiết bị nghe nhìn, tận dụng lợi thế margin cao (61%) của nhóm Media để duy trì thặng dư tài chính ngắn hạn.

#### 3. Tái Thiết Phễu Khách Hàng Mới Qua Mô Hình Bán Lẻ Omnichannel (Online-First & BOPIS)
* **Chuyển dịch sang mô hình Online-first:** Tái phân bổ ngân sách marketing từ hình thức truyền thống sang Digital Performance Marketing, tối ưu hóa SEO/SEM và xây dựng lại toàn bộ phễu thu hút khách hàng mới trực tuyến nhằm thay thế hoàn toàn cho kênh tiếp cận vật lý đã bị triệt tiêu.
* **Triển khai giải pháp bán hàng đa kênh BOPIS (Buy Online, Pick-up In Store):** Xây dựng tính năng cho phép khách hàng thực hiện mua sắm trực tuyến và nhận hàng trực tiếp tại hệ thống cửa hàng vật lý gần nhất. Giải pháp này giúp doanh nghiệp tối ưu hóa công năng hệ thống kho bãi sẵn có, tiết giảm chi phí logistics chặng cuối, giải phóng hàng tồn kho và tạo trải nghiệm mua sắm linh hoạt, an toàn tuyệt đối cho tệp khách hàng mới.

---

## 📊 3. Kiến Trúc Hệ Thống Báo Cáo Chiến Lược (Dashboard Purpose & Business Value)

Hệ thống báo cáo được thiết kế theo tư duy phân tầng thông tin quản trị (Top-down Approach), đi từ bức tranh tài chính tổng quan vĩ mô đến các góc nhìn bóc tách chi tiết theo thực tế vận hành. Hệ thống gồm 3 trang chiến lược tương ứng với các cấp ra quyết định trong doanh nghiệp.

---

### Trang 1: Executive Overview (Quản Trị Chiến Lược Tổng Quan)
<img width="1919" height="1063" alt="Executive Overview" src="https://github.com/user-attachments/assets/60e33752-5cac-4296-9649-78670fba0d90" />
<br>


#### A. Mục đích chiến lược
* Cung cấp một góc nhìn toàn cảnh tức thời (At-a-glance) về "sức khỏe" tài chính và hiệu suất cốt lõi của doanh nghiệp qua các năm. 
* Đóng vai trò là công cụ giám sát cấp cao, giúp phát hiện sớm các tín hiệu bất thường hoặc các điểm gãy đột ngột của dòng tiền trên quy mô toàn cầu.

#### B. Trang này làm những gì?
* Theo dõi và hợp nhất 4 chỉ số sinh mệnh của chuỗi bán lẻ: Doanh thu, Lợi nhuận, Khối lượng đơn hàng và Biên lợi nhuận gộp.
* Thực hiện kiểm định so sánh (Trend Analysis) hiệu suất dòng tiền theo chuỗi thời gian giữa năm khủng hoảng (2020) với các năm tăng trưởng đỉnh cao trước đó (2018 - 2019).
* Phân rã nhanh cơ cấu doanh thu theo các cấu trúc cốt lõi: Nhóm ngành hàng đóng góp và Phễu chuyển đổi khách hàng (Khách hàng mới vs. Khách hàng quay lại).

#### C. Ý nghĩa kinh doanh
* Phơi bày bản chất thực tế của cuộc khủng hoảng: Giúp nhà quản trị nhận diện nghịch lý vận hành khi **Biên lợi nhuận gộp vẫn giữ vững ở mức lý tưởng (58.61%) nhưng tổng doanh thu bốc hơi gần 50%**. 
* Ý nghĩa dữ liệu khẳng định doanh nghiệp không gặp vấn đề về chính sách giá hay giá vốn, mà hệ thống bị tổn thương sâu sắc do **Sản lượng giao dịch rơi tự do**, khoanh vùng thời điểm đứt gãy chính xác vào tháng 5/2020 để kích hoạt các kịch bản ứng phó.

---

### Trang 2: Market Analysis (Phân Tích & Điều Phối Hạ Tầng Thị Trường)
<img width="1918" height="1065" alt="Market Analysis" src="https://github.com/user-attachments/assets/eaef3940-c053-47c1-bd67-61a95390729f" />
<br>


#### A. Mục đích chiến lược
* Bản đồ hóa và bóc tách hiệu suất kinh doanh theo lát cắt Địa lý và Mô hình vận hành điểm bán lẻ.
* Mục tiêu giúp điều phối, tái cấu trúc mạng lưới phân phối (Store Network Re-structuring), xác định rõ thị trường nào cần phòng thủ, điểm bán nào cần đóng băng và mô hình nào thích ứng tốt với bối cảnh dịch bệnh để nhân rộng.

#### B. Trang này làm những gì?
* Kiểm toán chi tiết hiệu suất của từng Quốc gia thông qua ma trận đo lường tốc độ tăng trưởng cùng kỳ ($YoY\ Growth\ \%$) trên cả 4 khía cạnh: Dòng tiền, Khối lượng đơn, Tỷ lệ mất khách mới và Năng lực giữ chân khách cũ.
* Bóc tách hiệu suất giao dịch chéo giữa Quốc gia và 4 mô hình cửa hàng vật lý (*Flagship, Mall Center, Standard, Compact*) để tìm ra điểm nghẽn cục bộ.

#### C. Ý nghĩa kinh doanh
* Chứng minh giả thuyết: **Tác động của đại dịch không diễn ra đồng đều giữa các cấu trúc địa lý và mô hình phân phối.** * Ý nghĩa dữ liệu chỉ ra các Insights cốt lõi để phân bổ lại nguồn vốn:
    * Chỉ ra Mỹ là thị trường trọng điểm phải ưu tiên bảo vệ vì quy mô hụt dòng tiền tuyệt đối lớn nhất toàn cầu (2.9M USD), dù tỷ lệ giảm thấp hơn các nước khác.
    * Khẳng định sự lỗi thời của các mô hình không gian rộng (Flagship, Mall Center) tại Đức và Ý trong mùa dịch khi các chỉ số đều báo động đỏ.
    * Chứng minh năng lực thích ứng vượt trội của mô hình tiện lợi quy mô nhỏ (**Compact**) tại Pháp nhờ tăng trưởng dương tệp khách cũ (+3.57%) và mô hình **Standard** tại Úc (bảo toàn 100% khách cũ), làm cơ sở dữ liệu để doanh nghiệp dịch chuyển tỷ trọng hạ tầng vật lý.

---

### Trang 3: Category Performance (Tối Ưu Hóa Danh Mục Sản Phẩm)
<img width="1919" height="1066" alt="Category Performance" src="https://github.com/user-attachments/assets/c6055f16-c7e7-47ed-b2b7-c951034886a5" />
<br>


#### A. Mục đích chiến lược
* Quản trị và tối ưu hóa danh mục sản phẩm (Category Management) dựa trên sự thay đổi trong hành vi, mục đích sử dụng thực tế của người tiêu dùng qua mùa dịch.
* Định vị các ngành hàng chiến lược cần ưu tiên khôi phục, bảo vệ hoặc khai thác ngắn hạn nhằm tối đa hóa thặng dư biên lợi nhuận, gián tiếp nuôi bộ máy vận hành trong giai đoạn dòng tiền tổng bị suy thoái.

#### B. Trang này làm những gì?
* Phân định 8 ngành hàng công nghệ lên Ma trận Phục hồi (Priority Recovery Matrix) dựa trên việc đối chiếu song song hai biến số: Biên lợi nhuận ($Profit\ Margin\ \%$) và Tốc độ tăng trưởng doanh số ($YoY\ Growth\ \%$).
* Đo lường trực tiếp mức độ tổn thất khách hàng số (Customer Loss metrics) của từng ngành hàng, tách biệt rõ ràng tỷ lệ sụt giảm giữa phễu tiếp cận (Khách hàng mới) và phễu giữ chân (Khách hàng quay lại).
* Cho phép xem sâu dữ liệu (Drill-down) đến cấp độ danh mục phụ (Subcategory) và Thương hiệu (Brand) để xử lý các điểm nghẽn hàng tồn kho.

#### C. Ý nghĩa kinh doanh
* Giải mã chính xác sự dịch chuyển tâm lý mua sắm của thị trường thành 3 nhóm hành vi dựa trên số liệu thực tế: *Work From Home* (Thiết yếu, sẵn sàng chi đậm giữ vững AOV như mảng Computers); *Stay-at-home Entertainment* (Tăng tần suất tiêu dùng giải trí nhưng thắt chặt chi tiêu chọn phân khúc giá rẻ như mảng Media/TV); và *Deferred Spending* (Trì hoãn chi tiêu các sản phẩm gia dụng giá trị lớn, cồng kềnh như Home Appliances do mất kênh tiếp cận vật lý).
* Insights từ trang này giúp Giám đốc Mua hàng và Chuỗi cung ứng đưa ra quyết định hành động chính xác: Tập trung số hóa kênh tư vấn trực tuyến cho ngành hàng biên lợi nhuận cao nhưng đang giảm sâu (Home Appliances); tích hợp các giải pháp tài chính trả góp kích cầu cho ngành hàng lõi (Computers); và duy trì nguồn cung ổn định cho ngành hàng giải trí (Media đạt 61% margin) để lấy thặng dư ngắn hạn duy trì dòng vòng quay tiền mặt.
