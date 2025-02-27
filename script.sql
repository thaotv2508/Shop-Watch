USE [master]
GO
/****** Object:  Database [betashop]    Script Date: 8/7/2024 3:38:28 AM ******/
CREATE DATABASE [betashop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'betashop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TRANVANTHAO\MSSQL\DATA\betashop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'betashop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TRANVANTHAO\MSSQL\DATA\betashop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [betashop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [betashop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [betashop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [betashop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [betashop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [betashop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [betashop] SET ARITHABORT OFF 
GO
ALTER DATABASE [betashop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [betashop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [betashop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [betashop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [betashop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [betashop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [betashop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [betashop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [betashop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [betashop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [betashop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [betashop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [betashop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [betashop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [betashop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [betashop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [betashop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [betashop] SET RECOVERY FULL 
GO
ALTER DATABASE [betashop] SET  MULTI_USER 
GO
ALTER DATABASE [betashop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [betashop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [betashop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [betashop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [betashop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [betashop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'betashop', N'ON'
GO
ALTER DATABASE [betashop] SET QUERY_STORE = OFF
GO
USE [betashop]
GO
/****** Object:  UserDefinedFunction [dbo].[LevenshteinDistance]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LevenshteinDistance]
(
    @source NVARCHAR(MAX),
    @target NVARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
    DECLARE @distance INT;
    DECLARE @sourceLength INT = LEN(@source);
    DECLARE @targetLength INT = LEN(@target);
    DECLARE @distanceMatrix TABLE
    (
        RowIndex INT,
        ColumnIndex INT,
        Distance INT
    );

    -- Initialize matrix
    INSERT INTO @distanceMatrix (RowIndex, ColumnIndex, Distance)
    VALUES
    (0, 0, 0);

    DECLARE @i INT = 1;
    WHILE @i <= @sourceLength
    BEGIN
        INSERT INTO @distanceMatrix (RowIndex, ColumnIndex, Distance)
        VALUES
        (@i, 0, @i);

        SET @i = @i + 1;
    END;

    DECLARE @j INT = 1;
    WHILE @j <= @targetLength
    BEGIN
        INSERT INTO @distanceMatrix (RowIndex, ColumnIndex, Distance)
        VALUES
        (0, @j, @j);

        SET @j = @j + 1;
    END;

    SET @i = 1;
    WHILE @i <= @sourceLength
    BEGIN
        SET @j = 1;
        WHILE @j <= @targetLength
        BEGIN
            DECLARE @cost INT;
            IF SUBSTRING(@source, @i, 1) = SUBSTRING(@target, @j, 1)
                SET @cost = 0;
            ELSE
                SET @cost = 1;

            DECLARE @above INT = (SELECT Distance FROM @distanceMatrix WHERE RowIndex = @i - 1 AND ColumnIndex = @j) + 1;
            DECLARE @left INT = (SELECT Distance FROM @distanceMatrix WHERE RowIndex = @i AND ColumnIndex = @j - 1) + 1;
            DECLARE @diagonal INT = (SELECT Distance FROM @distanceMatrix WHERE RowIndex = @i - 1 AND ColumnIndex = @j - 1) + @cost;

            DECLARE @minDistance INT = 
                CASE
                    WHEN @above < @left AND @above < @diagonal THEN @above
                    WHEN @left < @diagonal THEN @left
                    ELSE @diagonal
                END;

            INSERT INTO @distanceMatrix (RowIndex, ColumnIndex, Distance)
            VALUES
            (@i, @j, @minDistance);

            SET @j = @j + 1;
        END;

        SET @i = @i + 1;
    END;

    SET @distance = (SELECT Distance FROM @distanceMatrix WHERE RowIndex = @sourceLength AND ColumnIndex = @targetLength);
    RETURN @distance;
END;
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[acc_name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](250) NOT NULL,
	[adress] [nvarchar](500) NOT NULL,
	[cus_password] [nvarchar](16) NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](25) NULL,
	[role_id] [int] NOT NULL,
	[avatar] [nvarchar](500) NULL,
	[ques_id] [int] NULL,
	[answer] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Block]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[proid] [int] NULL,
	[accid] [int] NULL,
	[brandid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](150) NULL,
	[createOn] [date] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[createBy] [int] NULL,
	[img] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](100) NULL,
	[brand_img] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ca_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountID] [nvarchar](8) NOT NULL,
	[DiscountRate] [float] NULL,
	[Amount] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cus_id] [int] NULL,
	[orderDate] [date] NULL,
	[status_id] [int] NULL,
	[adress] [nvarchar](500) NULL,
	[phone] [nvarchar](16) NULL,
	[deliverDate] [date] NULL,
	[payment_id] [int] NULL,
	[totalAmount] [money] NULL,
	[cus_name] [varchar](255) NULL,
	[ship_id] [int] NULL,
	[shipstatus] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderDetail]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[total_price] [money] NULL,
	[quantity] [int] NULL,
	[proName] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[proimg] [nvarchar](255) NULL,
	[caid] [int] NULL,
	[brand_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[StatusID] [int] NOT NULL,
	[Name] [nchar](10) NULL,
	[Description] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[PaymentMethodID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[proName] [nvarchar](250) NOT NULL,
	[caid] [int] NULL,
	[description] [nvarchar](500) NULL,
	[img] [nvarchar](max) NULL,
	[price] [money] NULL,
	[rate] [decimal](3, 2) NULL,
	[brand_id] [int] NULL,
	[stockQuantity] [int] NULL,
	[publication_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductComment]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductComment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[ProId] [int] NOT NULL,
	[CommentText] [nvarchar](200) NOT NULL,
	[Rating] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImg]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pro_id] [int] NOT NULL,
	[img_link] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[OrderDetailID] [int] NOT NULL,
	[RefundDate] [date] NULL,
	[Reason] [varchar](max) NULL,
	[Image] [text] NULL,
	[ReturnStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResponseComment]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResponseComment](
	[ResponseId] [int] IDENTITY(1,1) NOT NULL,
	[CommentId] [int] NOT NULL,
	[ResponseText] [nvarchar](200) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityQuestions]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityQuestions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ques_name] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShipStatus]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipStatus](
	[ShipStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NULL,
	[Reason] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ShipStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCart]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCart](
	[UserCartID] [int] NOT NULL,
	[UserID] [int] NULL,
	[WatchID] [int] NULL,
	[Quantity] [int] NULL,
	[TotalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserWishlist]    Script Date: 8/7/2024 3:38:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWishlist](
	[UserID] [int] NOT NULL,
	[WatchID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[WatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blog] ADD  DEFAULT (getdate()) FOR [createOn]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Customer_Role]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Customer_SecurityQuestions] FOREIGN KEY([ques_id])
REFERENCES [dbo].[SecurityQuestions] ([id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Customer_SecurityQuestions]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Account] FOREIGN KEY([createBy])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_Account]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Account] FOREIGN KEY([cus_id])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([status_id])
REFERENCES [dbo].[OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PaymentMethod] FOREIGN KEY([payment_id])
REFERENCES [dbo].[PaymentMethod] ([PaymentMethodID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PaymentMethod]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [fk_brand_id] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([id])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [fk_brand_id]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [fk_caid] FOREIGN KEY([caid])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [fk_caid]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [FK_orderDetail_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [FK_orderDetail_Order]
GO
ALTER TABLE [dbo].[orderDetail]  WITH CHECK ADD  CONSTRAINT [FK_orderDetail_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[orderDetail] CHECK CONSTRAINT [FK_orderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_brand] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_brand]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Categories] FOREIGN KEY([caid])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Categories]
GO
ALTER TABLE [dbo].[ProductComment]  WITH CHECK ADD  CONSTRAINT [FK_ProductComment_Product] FOREIGN KEY([ProId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[ProductComment] CHECK CONSTRAINT [FK_ProductComment_Product]
GO
ALTER TABLE [dbo].[ProductImg]  WITH CHECK ADD  CONSTRAINT [FK_ProductImg_Product] FOREIGN KEY([pro_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[ProductImg] CHECK CONSTRAINT [FK_ProductImg_Product]
GO
ALTER TABLE [dbo].[ResponseComment]  WITH CHECK ADD  CONSTRAINT [FK_ResponseComment_ProductComment] FOREIGN KEY([ResponseId])
REFERENCES [dbo].[ProductComment] ([CommentId])
GO
ALTER TABLE [dbo].[ResponseComment] CHECK CONSTRAINT [FK_ResponseComment_ProductComment]
GO
ALTER TABLE [dbo].[UserCart]  WITH CHECK ADD  CONSTRAINT [FK_UserCart_Account] FOREIGN KEY([UserID])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[UserCart] CHECK CONSTRAINT [FK_UserCart_Account]
GO
ALTER TABLE [dbo].[UserCart]  WITH CHECK ADD  CONSTRAINT [FK_UserCart_Product] FOREIGN KEY([WatchID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[UserCart] CHECK CONSTRAINT [FK_UserCart_Product]
GO
ALTER TABLE [dbo].[UserWishlist]  WITH CHECK ADD  CONSTRAINT [FK_UserWishlist_Account] FOREIGN KEY([UserID])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[UserWishlist] CHECK CONSTRAINT [FK_UserWishlist_Account]
GO
ALTER TABLE [dbo].[UserWishlist]  WITH CHECK ADD  CONSTRAINT [FK_UserWishlist_Product] FOREIGN KEY([WatchID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[UserWishlist] CHECK CONSTRAINT [FK_UserWishlist_Product]
GO
USE [master]
GO
ALTER DATABASE [betashop] SET  READ_WRITE 
GO
