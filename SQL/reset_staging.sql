use staging;
GO

-- 1. Xóa bảng Staging cũ nếu đã tồn tại (để làm sạch cho lần chạy mới)
IF OBJECT_ID('Staging_Sales', 'U') IS NOT NULL 
    DROP TABLE Staging_Sales;
GO

-- 2. Tạo lại bảng Staging với cấu trúc phẳng (Flat structure)
-- Bảng này mô phỏng y hệt file CSV nhưng có kiểu dữ liệu chuẩn
CREATE TABLE Staging_Sales (
    -- Thông tin đơn hàng
    OrderID VARCHAR(50),
    OrderDate DATE,          -- Lưu ý: Kiểu DATE để tiện xử lý thời gian
    
    -- Thông tin khách hàng
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(150),
    
    -- Thông tin sản phẩm
    ProductID VARCHAR(50),
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Brand VARCHAR(100),
    
    -- Các chỉ số định lượng (Measures)
    Quantity INT,
    UnitPrice DECIMAL(18,2),
    Discount DECIMAL(18,2),
    Tax DECIMAL(18,2),
    ShippingCost DECIMAL(18,2),
    TotalAmount DECIMAL(18,2),
    
    -- Các thông tin khác (Dimensions phụ)
    PaymentMethod VARCHAR(100),
    OrderStatus VARCHAR(100),
    
    -- Thông tin địa lý
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    
    -- Thông tin người bán
    SellerID VARCHAR(50)
);
GO