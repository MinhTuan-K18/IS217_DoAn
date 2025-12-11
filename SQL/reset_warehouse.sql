USE AmazonSales;
GO

-----------------------------------------------------------
-- PHẦN 1: XÓA CÁC BẢNG CŨ (Theo thứ tự từ Fact đến Dim)
-----------------------------------------------------------
-- Xóa bảng Fact trước vì nó chứa khóa ngoại
IF OBJECT_ID('FactSales', 'U') IS NOT NULL DROP TABLE FactSales;

-- Xóa các bảng Dimension
IF OBJECT_ID('DimDate', 'U') IS NOT NULL DROP TABLE DimDate;
IF OBJECT_ID('DimCustomer', 'U') IS NOT NULL DROP TABLE DimCustomer;
IF OBJECT_ID('DimProduct', 'U') IS NOT NULL DROP TABLE DimProduct;
IF OBJECT_ID('DimSeller', 'U') IS NOT NULL DROP TABLE DimSeller;
IF OBJECT_ID('DimPayment', 'U') IS NOT NULL DROP TABLE DimPayment;
IF OBJECT_ID('DimOrderStatus', 'U') IS NOT NULL DROP TABLE DimOrderStatus;
IF OBJECT_ID('DimOrigin', 'U') IS NOT NULL DROP TABLE DimOrigin;
IF OBJECT_ID('DimDestination', 'U') IS NOT NULL DROP TABLE DimDestination;
GO

-----------------------------------------------------------
-- PHẦN 2: TẠO CÁC BẢNG DIMENSION (Bảng chiều)
-----------------------------------------------------------

CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(50), 
    CustomerName VARCHAR(150)
);

CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(50),
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Brand VARCHAR(100)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY, -- YYYYMMDD
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(50),
    Day INT,
    WeekOfYear INT
);

CREATE TABLE DimSeller (
    SellerKey INT IDENTITY(1,1) PRIMARY KEY,
    SellerID VARCHAR(50)
);

CREATE TABLE DimPayment (
    PaymentKey INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethod VARCHAR(100)
);

CREATE TABLE DimOrderStatus (
    StatusKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderStatus VARCHAR(100)
);

CREATE TABLE DimOrigin (
    OriginKey INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(100),  -- Nơi đóng gói
    State VARCHAR(100)  -- Bang đóng gói
);

CREATE TABLE DimDestination (
    DestKey INT IDENTITY(1,1) PRIMARY KEY,
    Country VARCHAR(100) -- Quốc gia giao đến
);
GO

-----------------------------------------------------------
-- PHẦN 3: TẠO BẢNG FACT
-----------------------------------------------------------
CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderID VARCHAR(50),
    
    -- Foreign Keys (Các khóa ngoại)
    DateKey INT REFERENCES DimDate(DateKey),
    CustomerKey INT REFERENCES DimCustomer(CustomerKey),
    ProductKey INT REFERENCES DimProduct(ProductKey),
    SellerKey INT REFERENCES DimSeller(SellerKey),
    PaymentKey INT REFERENCES DimPayment(PaymentKey),
    StatusKey INT REFERENCES DimOrderStatus(StatusKey),
    OriginKey INT REFERENCES DimOrigin(OriginKey),     
    DestKey INT REFERENCES DimDestination(DestKey),  
    
    -- Measures (Các chỉ số đo lường)
    Quantity INT,
    UnitPrice DECIMAL(18,2),
    GrossSales DECIMAL(18,2),    
    DiscountAmount DECIMAL(18,2),
    TaxAmount DECIMAL(18,2),
    ShippingCost DECIMAL(18,2),
    NetSales DECIMAL(18,2)        
);
GO