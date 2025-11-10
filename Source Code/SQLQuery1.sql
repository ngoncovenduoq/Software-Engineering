USE [master]
GO
/****** Object:  Database [QuanLyNhaKhoa]    Script Date: 5/13/2024 11:01:21 PM ******/
CREATE DATABASE [QuanLyNhaKhoa]

ALTER DATABASE [QuanLyNhaKhoa] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaKhoa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaKhoa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyNhaKhoa] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyNhaKhoa] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyNhaKhoa] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyNhaKhoa]
GO
/****** Object:  UserDefinedFunction [dbo].[HashPassword]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[HashPassword](@Password NVARCHAR(4000))
RETURNS VARBINARY(64)
AS
BEGIN
    RETURN HASHBYTES('SHA2_512', @Password); -- Sử dụng thuật toán băm SHA-512
END;
GO
/****** Object:  UserDefinedFunction [dbo].[Tao_ngay]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Tao_ngay] (@ngay date)
returns varchar(6)
as 
begin
	declare @day varchar(2), @month varchar(2), @year varchar(2),@temp varchar(12)
	set @temp = cast(@ngay as varchar(12))
	set @day = SUBSTRING(@temp,6,2)
	set @month = SUBSTRING(@temp,9,2)
	set @year = SUBSTRING(@temp,3,2)
	return @day + @month + @year
end
GO
/****** Object:  Table [dbo].[HD_Thuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Thuoc](
	[ID] [varchar](15) NOT NULL,
	[STT] [varchar](15) NOT NULL,
	[Ten_thuoc] [nvarchar](30) NOT NULL,
	[So_luong] [int] NULL,
	[Thanh_tien] [float] NULL,
	[Ghi_chu] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[STT] ASC,
	[Ten_thuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TongHDT]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[TongHDT]
as
	select ID,STT,sum(Thanh_tien) as Tong from HD_Thuoc
	group by ID,STT
GO
/****** Object:  Table [dbo].[HD_Dich_vu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Dich_vu](
	[ID] [varchar](15) NOT NULL,
	[STT] [varchar](15) NOT NULL,
	[Ten_dich_vu] [nvarchar](50) NOT NULL,
	[So_luong] [int] NULL,
	[Thanh_tien] [float] NULL,
	[Ghi_chu] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[STT] ASC,
	[Ten_dich_vu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TongHDDV]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TongHDDV]
as
	select ID,STT,sum(Thanh_tien) as Tong from HD_Dich_vu
	group by ID,STT


GO
/****** Object:  Table [dbo].[Nguoi_kham]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nguoi_kham](
	[STT] [varchar](15) NOT NULL,
	[Ngay] [date] NULL,
	[Ca] [int] NULL,
	[Ma_benh_nhan] [varchar](12) NULL,
	[Ma_le_tan] [varchar](10) NULL,
	[Ma_bac_si] [varchar](10) NULL,
	[Trang_thai] [nvarchar](15) NULL,
	[Ghi_chu] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thanh_toan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thanh_toan](
	[ID] [varchar](30) NOT NULL,
	[STT] [varchar](15) NULL,
	[Gio] [datetime] NULL,
	[Tongtien] [float] NULL,
	[Hinhthuc] [nvarchar](30) NULL,
	[Tinhtrang] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[luongBonus]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[luongBonus] AS
    SELECT 
        Ma_bac_si,
        MONTH(Gio) AS Thang,
        YEAR(Gio) AS Nam,
        SUM(tongtien)*0.3 AS TotalTien
    FROM 
        Thanh_toan tt,
        Nguoi_kham nk
    WHERE 
        nk.STT = tt.STT
    GROUP BY 
        Ma_bac_si, 
        MONTH(Gio), 
        YEAR(Gio);
GO
/****** Object:  Table [dbo].[Luong_co_dinh]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Luong_co_dinh](
	[Ma] [varchar](10) NOT NULL,
	[So_tien] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nguoi_dung]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nguoi_dung](
	[Ma_nhan_vien] [varchar](10) NOT NULL,
	[Ho] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[Gioi_tinh] [nvarchar](3) NULL,
	[Ngay_sinh] [date] NULL,
	[email] [varchar](50) NOT NULL,
	[Que_quan] [nvarchar](30) NULL,
	[CCCD] [nvarchar](12) NULL,
	[Maluong] [varchar](10) NULL,
	[Hoatdong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma_nhan_vien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Tong_luong]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tong_luong] AS
SELECT 
    nd.Ma_nhan_vien,
    nd.Ho,
    nd.Ten,
    lb.Thang AS Thang,
    lb.Nam AS Nam,
    lc.So_tien AS Luong_co_dinh,
    ISNULL(SUM(lb.TotalTien), 0) AS Tong_thuong,
    (lc.So_tien + ISNULL(SUM(lb.TotalTien), 0)) AS Tong_luong
FROM 
    Nguoi_dung nd
LEFT JOIN 
    Luong_co_dinh lc ON nd.Maluong = lc.Ma
LEFT JOIN 
    luongBonus lb ON nd.Ma_nhan_vien = lb.Ma_bac_si
GROUP BY 
    nd.Ma_nhan_vien, nd.Ho, nd.Ten, lb.Thang, lb.Nam, lc.So_tien;
GO
/****** Object:  Table [dbo].[Bac_si]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bac_si](
	[Ma_bac_si] [varchar](10) NOT NULL,
	[Chuyen_nganh] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma_bac_si] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Benh_an]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benh_an](
	[So_Benh_an] [int] IDENTITY(1,1) NOT NULL,
	[Ly_do_den_kham] [nvarchar](100) NULL,
	[Benh_su] [nvarchar](max) NULL,
	[Tien_su_gia_dinh] [nvarchar](max) NULL,
	[Tien_su_noi_khoa] [nvarchar](max) NULL,
	[Tien_su_rang_ham_mat] [nvarchar](max) NULL,
	[Kham_ngoai_mat] [nvarchar](100) NULL,
	[Tinh_trang_ve_sinh_rang_mieng] [nvarchar](100) NULL,
	[Mo_mem] [nvarchar](100) NULL,
	[Mo_nha_chu] [nvarchar](100) NULL,
	[Rang] [nvarchar](100) NULL,
	[Khop_can] [nvarchar](100) NULL,
	[Can_lam_sang] [nvarchar](max) NULL,
	[Ket_qua_can_lam_sang] [nvarchar](200) NULL,
	[Chuan_doan] [nvarchar](200) NULL,
	[Ke_hoach_dieu_tri] [nvarchar](200) NULL,
	[MaBN] [varchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[So_Benh_an] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Benh_nhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benh_nhan](
	[MaBN] [varchar](12) NOT NULL,
	[CCCD] [nvarchar](12) NULL,
	[Ho] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[Gioi_tinh] [nvarchar](3) NULL,
	[NgaySinh] [datetime] NULL,
	[Dia_chi] [nvarchar](100) NULL,
	[Nghe_nghiep] [nvarchar](50) NULL,
	[So_dien_thoai] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ca_lam]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ca_lam](
	[Ca] [int] NOT NULL,
	[Gio_bat_dau] [time](7) NULL,
	[Gio_ket_thuc] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chi_tieu_dung_cu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chi_tieu_dung_cu](
	[ID] [varchar](15) NOT NULL,
	[Ten_dung_cu] [nvarchar](30) NOT NULL,
	[So_luong] [int] NULL,
	[Tong_tien] [float] NULL,
	[STT] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[STT] ASC,
	[Ten_dung_cu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chu](
	[Ma_chu] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma_chu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Danh_muc_ki_thuat]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Danh_muc_ki_thuat](
	[Ten_danh_muc] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_danh_muc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dich_vu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dich_vu](
	[Ten_dich_vu] [nvarchar](50) NOT NULL,
	[Don_vi_tinh] [nvarchar](15) NULL,
	[Don_gia] [float] NOT NULL,
	[Ghi_chu] [nvarchar](150) NULL,
	[Ten_danh_muc] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_dich_vu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[image]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten] [varchar](50) NULL,
	[bin] [varbinary](max) NULL,
	[Taikhoan] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[Ten] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lam_viec]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lam_viec](
	[Ngay] [date] NOT NULL,
	[Ca] [int] NOT NULL,
	[Ma_bac_si] [varchar](10) NOT NULL,
	[Diemdanh] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ngay] ASC,
	[Ma_bac_si] ASC,
	[Ca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Le_tan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Le_tan](
	[Ma_le_tan] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma_le_tan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai_thuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai_thuoc](
	[Ten_loai] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_loai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai_vat_lieu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai_vat_lieu](
	[Ten_loai] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_loai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phuong_thuc_thanh_toan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phuong_thuc_thanh_toan](
	[Ten] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tai_khoan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tai_khoan](
	[Taikhoan] [varchar](30) NOT NULL,
	[Matkhau] [varbinary](64) NOT NULL,
	[MaNV] [varchar](10) NULL,
	[SoLan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Taikhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theo_doi_dieu_tri]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theo_doi_dieu_tri](
	[Ngay_tao] [date] NOT NULL,
	[Cong_viec_dieu_tri] [nvarchar](max) NULL,
	[MaBN] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ngay_tao] ASC,
	[MaBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuoc](
	[Ten_thuoc] [nvarchar](30) NOT NULL,
	[DVT] [nvarchar](15) NULL,
	[So_luong] [int] NOT NULL,
	[Gia_ban] [float] NOT NULL,
	[Ham_luong] [nvarchar](10) NOT NULL,
	[Ghi_chu] [nvarchar](150) NULL,
	[Ten_loai] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_thuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vat_lieu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vat_lieu](
	[Ten_dung_cu] [nvarchar](30) NOT NULL,
	[Mau_sac] [nvarchar](15) NULL,
	[Kich_co] [float] NULL,
	[DVT] [nvarchar](15) NULL,
	[Gia] [float] NOT NULL,
	[So_luong] [int] NOT NULL,
	[Ghi_chu] [nvarchar](150) NULL,
	[Loai] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ten_dung_cu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Bac_si] ([Ma_bac_si], [Chuyen_nganh]) VALUES (N'BSRTE01', N'Răng trẻ em')
INSERT [dbo].[Bac_si] ([Ma_bac_si], [Chuyen_nganh]) VALUES (N'BSRTE02', N'Răng trẻ em')
INSERT [dbo].[Bac_si] ([Ma_bac_si], [Chuyen_nganh]) VALUES (N'BSTQ01', N'Tổng quát')
INSERT [dbo].[Bac_si] ([Ma_bac_si], [Chuyen_nganh]) VALUES (N'BSTQ02', N'Tổng quát')
GO
INSERT [dbo].[Benh_nhan] ([MaBN], [CCCD], [Ho], [Ten], [Gioi_tinh], [NgaySinh], [Dia_chi], [Nghe_nghiep], [So_dien_thoai]) VALUES (N'202405100001', N'123', N'123', N'123', N'Nam', CAST(N'2022-11-11T00:00:00.000' AS DateTime), N'123', N'123', N'123')
INSERT [dbo].[Benh_nhan] ([MaBN], [CCCD], [Ho], [Ten], [Gioi_tinh], [NgaySinh], [Dia_chi], [Nghe_nghiep], [So_dien_thoai]) VALUES (N'202405100002', N'1111', N'11', N'123', N'Nam', CAST(N'2222-11-11T00:00:00.000' AS DateTime), N'11', N'123', N'123')
GO
INSERT [dbo].[Ca_lam] ([Ca], [Gio_bat_dau], [Gio_ket_thuc]) VALUES (1, CAST(N'08:00:00' AS Time), CAST(N'11:00:00' AS Time))
INSERT [dbo].[Ca_lam] ([Ca], [Gio_bat_dau], [Gio_ket_thuc]) VALUES (2, CAST(N'11:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Ca_lam] ([Ca], [Gio_bat_dau], [Gio_ket_thuc]) VALUES (3, CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time))
GO
INSERT [dbo].[Chi_tieu_dung_cu] ([ID], [Ten_dung_cu], [So_luong], [Tong_tien], [STT]) VALUES (N'CT0001', N'Chỉ khâu', 1, 40000, N'051324Ca101')
GO
INSERT [dbo].[Chu] ([Ma_chu]) VALUES (N'CPK01')
GO
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Chỉnh hình răng mặt')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Chữa răng - Nội nha')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Chữa tủy')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Điều trị loạn năng hệ thống nhai')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Điều trị răng sữa')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Điều trị tiền phục hình')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Khám-Hồ sơ')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Khí cụ cố định')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Khí cụ tháo lắp')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Nha chu')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Nha công cộng')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Nhổ răng')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Phục hình cố định')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Phục hình tháo lắp')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Sửa chữa hàm')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'Tiểu phẫu thuật')
INSERT [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc]) VALUES (N'X-quang răng')
GO
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'1 hàm', N'Hàm', 1500000, NULL, N'Khí cụ tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'1 hàm (Khí cụ cố định)', N'Hàm', 10000000, NULL, N'Khí cụ cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'1 hàm toàn hàm', N'Hàm', 1500000, NULL, N'Phục hình tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'1 máng nhai', N'Máng', 500000, NULL, N'Điều trị loạn năng hệ thống nhai')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'1 răng', N'Răng', 100000, NULL, N'Phục hình tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm', N'Hàm', 3000000, NULL, N'Khí cụ tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm (Khí cụ cố định)', N'Hàm', 20000000, NULL, N'Khí cụ cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm điều trị trên 2 năm', N'Hàm', 26000000, NULL, N'Khí cụ cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm sử dụng mắc cài sứ', N'Hàm', 28000000, NULL, N'Khí cụ cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm sử dụng mắc cài thế hệ mới', N'Hàm', 28000000, NULL, N'Khí cụ cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'2 hàm toàn hàm', N'Hàm', 3000000, NULL, N'Phục hình tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Bộ giữ khoảng cố định 2 bên', N'Bộ', 800000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Bộ giữ khoảng tháo lắp', N'Hàm', 250000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Cạo vôi răng', N'2 hàm', 50000, NULL, N'Nha chu')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Cắt thắng', N'Lần', 100000, NULL, N'Nha chu')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Cầu răng tạm', N'Răng', 15000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Chữa đau', N'Lần', 50000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Chữa tủy lại(đóng thêm)', N'Ống tủy', 150000, NULL, N'Chữa tủy')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Cùi giả đúc', N'Cái', 100000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Đặt gel Fluour phòng ngừa', N'Hàm', 50000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Đệm hàm nhựa nấu', N'Hàm', 250000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Đệm hàm nhựa tự cứng(Hàm cũ)', N'Hàm', 100000, NULL, N'Điều trị tiền phục hình')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Điều chỉnh khớp cắn(Hàm cũ)', N'Hàm', 100000, NULL, N'Điều trị tiền phục hình')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Điều chỉnh, gắn lại, tháo PHCĐ', N'Răng', 100000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Điều trị viêm nha chu không phẫu thuật', N'Vùng hàm', 100000, N'Nạo túi nha chu', N'Nha chu')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Giữ khoảng cố định 1 bên', N'Cái', 400000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'hàm dẻo', N'Cái', 700000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Hàm khung bộ(Răng tính riêng)', N'Cái', 750000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Hàm khung Ti(chưa bao gồm răng)', NULL, 1500000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Hàm tạm', N'Răng', 50000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Khí cụ đẩy môi(lip bumper)', N'Cái', 1000000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Khí cụ duy trì kết quả 1 hàm', N'Hàm', 300000, NULL, N'Khí cụ tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Khí cụ Quad Helix', N'Cái', 1000000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Khí cụ tháo lắp điều trị cắn chéo 1 răng', N'Cái', 1000000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Làm lại khí cụ 1 hàm', N'Hàm', 300000, NULL, N'Khí cụ tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Làm lại khí cụ 2 hàm', N'Hàm', 600000, NULL, N'Khí cụ tháo lắp')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Lấy tủy chân răng sữa', N'Răng', 200000, N'2 phim', N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Màng chỉnh khớp cắn đơn giản', N'Lần', 150000, NULL, N'Điều trị loạn năng hệ thống nhai')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Màng chỉnh khớp cắn phức tạp', N'Lần', 300000, NULL, N'Điều trị loạn năng hệ thống nhai')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Máng Fluor không thuốc', N'Máng', 100000, N'2 hàm', N'Nha công cộng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mão kim loại làm sẵn', N'Răng', 250000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mão nhựa răng cửa(Strip crown)', N'Răng', 200000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mão tạm', N'Răng', 15000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mão, cầu răng kim loại - sứ', N'Răng', 500000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mão, cầu răng kim loại toàn diện', N'Răng', 350000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Mặt phẳng nghiêng', N'Cái', 500000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Móc dẻo', N'Cái', 200000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Nhổ chân răng vĩnh viễn', N'Cái', 60000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Nhổ răng lung lay', N'Cái', 50000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Nhổ răng sữa(tê bôi)', N'Răng', 20000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Nhổ răng sữa(tê chích)', N'Răng', 50000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phẫu thuật cắt chóp', N'Cái', 300000, NULL, N'Tiểu phẫu thuật')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phẫu thuật điều chỉnh xương ổ răng', N'Cái', 200000, NULL, N'Tiểu phẫu thuật')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phẫu thuật lật vạt làm sạch', N'Lần', 100000, NULL, N'Nha chu')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phẫu thuật nướu', N'Răng', 500000, NULL, N'Nha chu')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phim quanh chóp', N'Phim', 30000, NULL, N'X-quang răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Phim toàn cảnh', N'Phim', 100000, NULL, N'X-quang răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cối lớn', N'Cái', 400000, N'5 phim', N'Chữa tủy')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cối lớn dưới', N'Cái', 90000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cối lớn trên', N'Cái', 70000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cối nhỏ', N'Cái', 60000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cối nhỏ (Chữa tủy)', N'Cái', 300000, N'4 phim', N'Chữa tủy')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cửa, răng nanh', N'Cái', 50000, NULL, N'Nhổ răng')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng cửa, răng nanh (Chữa tủy)', N'Cái', 250000, N'4 phim', N'Chữa tủy')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Răng khôn mọc lệch nhổ tiểu phẫu', N'Cái', 300000, NULL, N'Tiểu phẫu thuật')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Sứ cercon', NULL, 3500000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Sứ titan', NULL, 700000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Sứ zirconia', NULL, 2500000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Tái tạo cùi răng(có chốt)', N'Răng', 150000, NULL, N'Phục hình cố định')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Tái tạo thân răng', N'Răng', 150000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Tấm chặn môi', N'Cái', 500000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Thay nền', N'Hàm', 300000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Thêm, thay móc', N'Cái', 50000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Thêm, thay răng', N'Cái', 50000, NULL, N'Sửa chữa hàm')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Tiểu phẫu', N'Lần', 250000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám composite xoang I, III', N'Xoang', 100000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám composite xoang II, IV, V', N'Xoang', 120000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám đắp mặt, hở kẽ', N'Cái', 200000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám dự phòng hố rãnh mặt nhai', N'Răng', 80000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám GIC', N'Xoang', 100000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám phòng ngừa', N'Cái', 80000, NULL, N'Chữa răng - Nội nha')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám răng sữa bằng composite', N'Răng', 80000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Trám răng sữa bằng GIC', N'Răng', 50000, NULL, N'Điều trị răng sữa')
INSERT [dbo].[Dich_vu] ([Ten_dich_vu], [Don_vi_tinh], [Don_gia], [Ghi_chu], [Ten_danh_muc]) VALUES (N'Vá hàm', N'Hàm', 100000, NULL, N'Sửa chữa hàm')
GO
INSERT [dbo].[HD_Dich_vu] ([ID], [STT], [Ten_dich_vu], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDDV0001', N'051024Ca102', N'1 răng', 1, 100000, NULL)
INSERT [dbo].[HD_Dich_vu] ([ID], [STT], [Ten_dich_vu], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDDV0002', N'051124Ca201', N'1 hàm toàn hàm', 12, 18000000, NULL)
INSERT [dbo].[HD_Dich_vu] ([ID], [STT], [Ten_dich_vu], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDDV0003', N'051324Ca102', N'2 hàm toàn hàm', 0, 0, NULL)
INSERT [dbo].[HD_Dich_vu] ([ID], [STT], [Ten_dich_vu], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDDV0003', N'051324Ca102', N'Bộ giữ khoảng cố định 2 bên', 0, 0, NULL)
INSERT [dbo].[HD_Dich_vu] ([ID], [STT], [Ten_dich_vu], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDDV0003', N'051324Ca102', N'Bộ giữ khoảng tháo lắp', 0, 0, NULL)
GO
INSERT [dbo].[HD_Thuoc] ([ID], [STT], [Ten_thuoc], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDT0001', N'051024Ca103', N'Amoxicillin 875', 1, 126000, N'Uống sau khi ăn')
INSERT [dbo].[HD_Thuoc] ([ID], [STT], [Ten_thuoc], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDT0002', N'051124Ca201', N'Dexamethasone', 1, 150000, N'')
INSERT [dbo].[HD_Thuoc] ([ID], [STT], [Ten_thuoc], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDT0003', N'051124Ca102', N'Cephalexin', 0, 0, N'')
INSERT [dbo].[HD_Thuoc] ([ID], [STT], [Ten_thuoc], [So_luong], [Thanh_tien], [Ghi_chu]) VALUES (N'HDT0004', N'051324Ca101', N'Amoxicillin 625', 1, 0, N'')
GO
SET IDENTITY_INSERT [dbo].[image] ON 

INSERT [dbo].[image] ([id], [ten], [bin], [Taikhoan]) VALUES (2, NULL, 0x89504E470D0A1A0A0000000D4948445200000064000000640803000000473C6566000000017352474200AECE1CE90000000467414D410000B18F0BFC610500000300504C54450000000101010202020303030404040505050606060707070808080909090A0A0A0B0B0B0C0C0C0D0D0D0E0E0E0F0F0F1010101111111212121313131414141515151616161717171818181919191A1A1A1B1B1B1C1C1C1D1D1D1E1E1E1F1F1F2020202121212222222323232424242525252626262727272828282929292A2A2A2B2B2B2C2C2C2D2D2D2E2E2E2F2F2F3030303131313232323333333434343535353636363737373838383939393A3A3A3B3B3B3C3C3C3D3D3D3E3E3E3F3F3F4040404141414242424343434444444545454646464747474848484949494A4A4A4B4B4B4C4C4C4D4D4D4E4E4E4F4F4F5050505151515252525353535454545555555656565757575858585959595A5A5A5B5B5B5C5C5C5D5D5D5E5E5E5F5F5F6060606161616262626363636464646565656666666767676868686969696A6A6A6B6B6B6C6C6C6D6D6D6E6E6E6F6F6F7070707171717272727373737474747575757676767777777878787979797A7A7A7B7B7B7C7C7C7D7D7D7E7E7E7F7F7F8080808181818282828383838484848585858686868787878888888989898A8A8A8B8B8B8C8C8C8D8D8D8E8E8E8F8F8F9090909191919292929393939494949595959696969797979898989999999A9A9A9B9B9B9C9C9C9D9D9D9E9E9E9F9F9FA0A0A0A1A1A1A2A2A2A3A3A3A4A4A4A5A5A5A6A6A6A7A7A7A8A8A8A9A9A9AAAAAAABABABACACACADADADAEAEAEAFAFAFB0B0B0B1B1B1B2B2B2B3B3B3B4B4B4B5B5B5B6B6B6B7B7B7B8B8B8B9B9B9BABABABBBBBBBCBCBCBDBDBDBEBEBEBFBFBFC0C0C0C1C1C1C2C2C2C3C3C3C4C4C4C5C5C5C6C6C6C7C7C7C8C8C8C9C9C9CACACACBCBCBCCCCCCCDCDCDCECECECFCFCFD0D0D0D1D1D1D2D2D2D3D3D3D4D4D4D5D5D5D6D6D6D7D7D7D8D8D8D9D9D9DADADADBDBDBDCDCDCDDDDDDDEDEDEDFDFDFE0E0E0E1E1E1E2E2E2E3E3E3E4E4E4E5E5E5E6E6E6E7E7E7E8E8E8E9E9E9EAEAEAEBEBEBECECECEDEDEDEEEEEEEFEFEFF0F0F0F1F1F1F2F2F2F3F3F3F4F4F4F5F5F5F6F6F6F7F7F7F8F8F8F9F9F9FAFAFAFBFBFBFCFCFCFDFDFDFEFEFEFFFFFFE2B05D7D000000097048597300000EC300000EC301C76FA86400001B914944415468435D5AE77AE2DA96EC37B0C92044CE1901022109E544122207E36C773EE7BB73DFFFC7D406BBCF99D976BB3186BDF64AB5AA24BEDC5E97CF77FDDF1F0C8543017FC04FA5B3C54CB158AC37CAD96C2693A6A3D1583C4651D150903C88C4A85838E00F07FDA1502812F4077CB77E5F28E4F763279F9F6C74DDEFB23E8D9045ECF803E16820108E44B3A574AEDCA8D79AED56B99A4DA4682A4A25A2D1782C1C81A5186C44612F14C4FEF8110890BD43C1006C90C71F87FE38F9C508798CD7DCE085BE6008270A4792A5723E57E9761B558661BB4CBD54A6A3743A9B4D26D3A9782C16A793F1388C4522B1305E1D0DC1834020026B88C5C52BB2EFE7BA7A02DFFCFE104E10BABD0DC0FD5034974C144A9D4EAFD5E8B0C2B03FE8750A89642A97C8A412A96436432753718A8E27629168241C894411B940E496441A1B0570643FCCFE595F6012AEF96F6F10DECB33FE7038144BA6E3C96A8FED76DB4C9F1D0EB801DFAFE6B2D962A390CDA50BE54A2695A222B14422168D84C2173BE1084210813162818484C4E74FB8AEB1BA257F25CB170885299ACE14EACD16DFED0EBAFD1EA748B2C6F7EB9552A952ABD46AA54A258F5AA0C314158BC1975804EF89C42241988B206EC4CE755DB724E1F25F027873F9D30D6C040308375DADD7DA4C971D0C863C2FAAA6AAA8CAA04A655BCCA0D76E314CB59A4ED0484E2C82150BF9E04838124610C2FE00B28F3DFDBE205270B103239F3EC01CFE120A8422112A51E9F598368374702359962D4B551559EC15CBAD2EDBC7578F1F31954A311D8B8491E74000092545160EF89077726E3C459EBE6E0D231F4EF9F0149E0CA080A3F1428DE974B9FE409407A2AAEA8E6D4D2C4D378BD546BBDBEA0902C72B02CB348AA834F4862F10898402C1602814447906433E52D62432977D61E4F331F91505100C2287413A5FAE315546E0556D245A8E3D73E7EE743299AB4DA65162FA9C2CEAB6A571B554A99A0A87FC418429E80B1023B728B120169A25E0BB413193F5C517B8C55F3E1609225E1B2FE4D0EAED5A179E18BA3D994DA6EEC25B2CBDB12131F56A4B18C9FA64E6DA72B7DA6EC543A19B60185FE8C55014D6F0187945D30402C10F23979F9F0B09F3FB011BA89D7CB95AC8949A7D4E1015C79A2DBDCD7E3171271ADFA02BFD91644E5C6F391D711C578D4662FE4090D40FD008C10A2272784CD6A727979F97852790ABA02F148B1552742A572AE772B57667D0654573B2D8DDDF1F3687EDD211EAF536AF4F57DBDDEEE89AAAD0CE85E17C046D8C3392DC0723E8918F62FA93F8CF858A4327864261BA084829E4992682D16707AD0EAF98B3F5DDC3F9743C1E56D6A0D9166C6F7B773AED366B73C436E8305A248CC2254D8670A1EFE1C267A6B1FE650445074BE158325F6C75186E38E4BB9CAE89A45344D9D93C3FDC3F3C3C3F3F9FA643C97496F74FCF8FFBD572AC485C211E21954BCA06D946D689C58B1717477C1723049B611927C0EBA8443AC7F647A2A1ABD67CB9F21C4DB354CD9A2CB7FBBBE76F5FDF5EDF5EB69A3D5DBE7DFFFE725ABA3353EA6568743B8E086025ED1240EB904A251B5F6C1023082471EF16FD8102A6CBB58E242B966D4C37DE7AB79D8D17D3F174365D2C56C7A76F7FFDCFAFEF4F8789397DFCF9F7EFD7F3DE9B1822534B62BE840361184059C1D2B5A071F64BFA7DBE8B915B82991822A15094CE355A0351D12DC376379BFD61B77417AB95B7DD7ADBDDF1F9C77FFFFBF77F7E3F7BE3F38F1F3F7FBE9DF72B471D74DBF542928A507402C7842BE84D003ADC801112365F90848BE402A104D045A2F1748B1D8A8A35B6DCD5F6783E9F8FA8A9CD7ABF3B6EB7C7E79F7FFDFAF9EBF78FF3F6FDC7D76FAFE7E3C69B39323F1CB2A56428DDAAE74364BAF88368E760207883AD2F8B78420085204F2014C5F0AB74FBBCA8D9CEDC5DAD5777AFAFF777C7ED71B7BFDBEF0E770F4FEF70E0EBFBE3DDD3D76F5FEF8FFB95E7CD2C644F562547D779A65ECC661274928AD3C8CB2726FA494EE0079027108B0660A4D965F8113FD24C73EECE36BBE3D3FBCBE3FDE9B03BDE9FF6DBD3FDDBFBDBEBF3E3E3DDCBD7D7FBC371BF5E6D96EED899E01BEFB0258E6FE772B94C320598454E48DEE1C2D513D2A570034335CFB0436E286B8663CD77B071F7F8F2ED1DEEECF76891CDE1E1FCF8F2727E787EC1175CDC1F0EFBCD72EEAD0EBBF57CECB98E2AA92CDB2C65295442F0035390A38B2704AF2251B08444A1D1E7079C3052747BEA79CBE3F3CBEBFBFBDBCBFD617F3CED17BBED1DB67F7A24561E2FADB9DF7BEEF6B8DFA34236EED436744916D856399F44B9456085249F9430B107AC263C2496A8B6BBFDFE602849BA668EA79BFBD7D79757B221F63BED5670EDE5F9FDEDE1747E7EBA3B1ED1F2FBE36177BABB3BEDD6CBF5743CB675411C7283562D43619405D03C40B1CF8EC7708E60C8C5F24D86693559B12FE9C6C4DD9CEEEE1F61E3E1F1F961BF592F17CBD5F9E1E9E5F5F17CBE3FDFA31A96EBED76BB3B9DCFFBE37AE14D1CC756785EE0D84E358BFE8C82925D6C5C8D802BC1112A59A8B5BBF506008B573131DCFDE9B05A6F77EBE3E9EEBCDCEF96EBF5728F1D1F5E9197E3F1B85F7ACBDDF1B4C59FF79BED7A31B34C5315878301DBA917690A0D71E17C9F4660264C2541821A6D10AC4AA3CD60BAB3BDC170C0CA63B4FC6AB3596E76DBDDE17038DFDFBF00C0CE78B8BBACC30685BC725D6F666A9A2AF25C8FE976DAAD7C020CF39316C108CCF9FC91442C912FD6D9561100DC065518E41345186404CBB0EC390066475AE5846AFBF18E241DF667928ADD16415C2050186CB6A609031041A6DE62CA175708685E8DDC5C3A3E426793A55AABD3A995328962AD31EC2412A576BB5834D686222BF3EDE170DA2C0F87FB976FDFD123470C9313FA67B35A38A665281A2B4846AFC676C16A316F3AB54A260EDA0CE2723542CAD94F4593A954AE5C673A4C2B9FC9D607AA12A3AB6C2953D657DE44159CF51E030BBD777A44152054AB3550E0EEB8746DC334665E259AAF6652857AA35EAD160BB566B58ECEA7620092AB1124C4EF0BD3A954365B6A32F55AB994CF7644C32A465231BA5019CF1C53196977E7A7CD029D037041D2778BE97A03AFEEA6B6399D6F4E2EB8A0148E671B8D62225F29979876E9929440F8D2F53042FE0BC452C56AB9DE616A2530F97AA33F329D44364BE507B22E8BA2A8DF3D1D9693E9C45D6CF6FBCD663DF3D6EBDDFDFBFB5A5266EBD56991CFD4FBA97881ED15D29972A502F257480226C15A3F8C60F922742A5FADD65BB56ABDD36AB75ADD9E20318D6EADD61B0882A08CD7A7C3623C06462DDCD572E6188EB3F0E687E7E7953AB4A693833BC4A6D97459D41BB964A1522C771BA52C48EB070FBA1A0950894CA9D66C55729501DBEF0DFBA2ACA8FCC0928D916138F6D85BAD3DDB342DCB9E790B77361B9BD678EA2C4EF79BB16D2B9AE98C8A894CBEC53B1253CD144AA57ABB514C2763D495A5127287B005A964BA50A996515F92D0137455372C673AC332EC1906E37C3E194F4D5D3734636A4F2613DBD460D05DAF515DB633B5B461B7D5AA77BAFC002DD2A8970BF56A299706C18005D821D28114702255AE563BDD2E4402C8AF664E660EC23371E68BC572391F13FE68CAB26E3A265C730C59D1708E898781B65A3ACED8B2B52140AFDFEF320DA6592E369BD5620614F63253AE288C4142E7AA953AD3EBA1DE65C534ACF1C591F97C81E9BB9E38BA3CB60D49062BB64CC48DB48E62D8A6335FED56CBD5728E9A30C591AE886CBBC1B42AB54613E38B8E129685F505B3FED6178B50D942A5D2607AFDE14831107DB8E1829AAE166B8CA58983674C4B33001C2A8CE8AA04C5829869E61CD9F21670776EC24F5516E04DBB010D93C9A6209030B93E8CF8FD91783253A832A07123114A44B726E3893399AC80E0A0C0D3F1C436D0D6234555550B19D1254156355DB76DC75D1E4EDBF566BD5E4C6DD07E53E5B961B7DE825ECAA613B1181929C40856045D572CD6A03D86922CAABAED4CA64B6F3E5B6C962B9C74B998CF1D4BC7E9155DB316CB99A5482345C134984E17EBE37EB73B1D96CB9969620E1BEA08C90102568AD9041521E0752577B7FE588CCE670AC5666F389455D93161C6597920F3F3D56A8960CC1D14962C28AAE18C0D670244477138A82BD0A6F5EEB4C5F8F5E6A8391B68AFC87CBF5D4A2632E964FCB38461C91F8E4593C57AB5D1E104C207A62E323EF7303FBCF57E3D9B4F9056C73024494545900A86B81315C51C4F7006F03F00FE7EBF72493D1AAA81EC0FBAB57C3147A4F8B51B317EC12CE2743A51ACD73BFD91A64DA7D3F9D443CDACF79BC57AB741DC5C773619CBD24835340B956B2126BAAA203A7394C67AB75E6D0F47603E297345914723744DB59AA16908D76B75A1DD43A1583A53426D71235E9D2F70F4E9046FC697B7844240F94C6D0BE44A52559497264A2AB88F3852AD317AC85B61300392B79B25060B5E254A507AED5A219988C7A357C6427202AA9D84E669B7BBE00FF674325D6C36AB3926BA87010B20DC7A1E28024E384205ABA39128CA020F48D3E76B9C64BBD92268DB2DDAC59B3B6334A9C471BD7A259FA66184D820B002E648D1851224679F578C0982B3C5E698A9DE72B2F0D6C7E316C62C4984D6D61DC3B474245D1386FC509E2271DBD5160DB95E622DC60B0F69B1C8A06F5773E938F52727C02E2870BA5801F20892369ECFDD25A80A90102DB2DA6EC1E0B6EB893CE4FABD81AC02242D4D9624E0283F34F0025088151640CC0372A2428039A23068E433295089EB9047E203E170249AAC36983E8F804C01E9DEC4C4E16165B93FEE41F01EB60EDF6C8358A896EDA04D558DEF767AFDBE012E832E018BF1D6CBB9EB6D17C038C75054814315D3717225845CA180277E88F0189DAB3599A134925407A3C99D225E900CBB1378DCB7F79769AFD964FA82654D17EE7C3ED5A4D1806198667779B83B817F0124D14DA87B52EBBAA229D2B05B03F5222492F0537812060F8BD38526C3722819641E35BC5CBA08C4113CFBE9E5EBFB5EE8F787A20A27E6CBDD760BDCB5E43E8CB4B4EDE1740FD6B541B83CD773E7337732363555E2BB35E404A747B02E9E0410BB180DDDDE85D2901110C0AFE7419D3C80293E41B63D982C2F1339EFBAABC3D3CBE369B9706C59E43AACE8DD3D3DA1DDE109820B276773C084A389FD5EB350A062D712BE28AD70D0178E176B4D48504C1280FC026FDAED4F90A1EF5FBF7F7F3F3343D5806768D0DDC3D79FBF5FB7CBCDCAD2047EC84F1FDF9E1F40C8B6C88B0B232EE0C156791ED144BCAEF3D71FC4D0BA21FA874A35DADC70C0C940A70532B2D91DCE8F4F2FEF3F7EFFF56B2CA99A7BC68117DBD3F3F79FDFDFEFD11A8BB9258D46D6DDD76FCF8F0FA7ED06EE2C9CD91C03CCD1B861BFD3ADA508BD43A022517872037614A50B65A6DB23574DD4C98CB4FBFE78FF023F7EFCFAF5C3D0CDF5F96EED81071DCE2F90410F3B0F75BB731DC538BD7D7B7B3E9F0E0006C0CA74EC0023D1AF7CA75A4779454340AD48ECD227A15024428307330340866CBBE8E4F5F1FEFEF92BF4214EEE4CBCC37EA909A269AFB660DCA78D379962F2AE5DC7DEBDBC7F7B7BBD03B1075EA3516618709230EA63D4E713B130FA241CA5BE40D20542FE60BC5CADB507C321E4E26C0E12B73E3E3CBCFFFAFBEF5FDF9EEF26D67C7F543B98E1EA7841B06CEE48FDBEB9DE2D1D73FBF4FEFEF5EDF18068EEB7F3F16C8666544722DB620AA97814CD188624219E80E785E874A5DDEE735DC9305144A8ADD3FDE3DB5FBF7FFEF5FBF5DE36BDC36965AABA6EA2513C6F3E5586AD010FEA3AB5D7E7D7F7EF10C2772794F60263606CA31587FD7A39071426974EC15661E4F6C6EF0F50E96ABDC90E5855B366EE6C41A4EEE3D7DFB0F2E37D37B3E72BD2D8EE02B001123F070732CC0960D49D78E7E7B7772220CFC83C069C3BD1D089DD4EAB568074F3A1D3217C8891DB1B64255E6DB43A9C2419136F893DF777F7CFEF3FFFF3F7F7A7C3D69B8DE790281E191FEE6607B49A4F6744B0781809C7A797B7B7E77B228E379029F3B122700396EDB6CA60F53E3FC0374E5D79571089CF953B3D24DE1CBBDE74B9DADF3F3F7DFBF9FBD7DBD371BB9DA230513830B2DC9DCF87F50CF8E912D8351D777FFFF202057961E1B3197ADE944481EB362A0930225F280CBD4B4A18CB1F0AC793B90EB043526D840B62F0FCF0F2F5C7AF6F8F50B85B9754BFA259D8F204B1B8F1BC9933716CDB1E4F17D3FDE3D7F7A787D3118305536B0C2A301206DD56290DE540AE808423A1AB11F44A225D2877079CA86893D90C6364777C78FDFAF60A85BB5ECE26B3F9188977168713F4EE76ED5960C89AA619F6743183EC7EBC3FED30259720358E29F3BD2ED4413A090CF6F9C8B5C26BB86E7D413A5F6D11FA282B2021E40DDBE323842F241BB28958598601D18D31B901524DF0D8D2408ED1E3DEEEFC78FF70075D4426A36D8C4481CCAC6A2A4EAECB93CB6C0420C90A8423A946A7DD198E64D5B0A62E907E05087E442FEF9177CB0095C3C698CC84C84C605023FC08665127DBBBD3E17820C3DA1D6BC8FB70C8B6CBD9C47564A1092F33FED2F454B248582AE0D63026B3A9BB0205399D112C601E8829A63B98A56968E8B731312989200496858A70D780B53DE80628313A51E03143EB99643A120C12D18BED3F8CDCDE86E87C93E90C0561A4E90021D28F6086FBDD1A4D4C38882269860A9E4DFE033B92457EA49AB206D68AE1030406237220567419539103D027A8D0E556C93F46C8788C15CACD2E70658477E278E05D901F18DD683D5593784935C697C12A48235E94249117462349B1C664CCB80B488C29C0111E0A436ED06ED6D21428FD85095FAF7791E50B46B3956667381C0A23D986276038E0201E19DA2A240B3CB0C18775CD30744DD3159085212F2BB20E2AEB0108A6B329540512A582D7B79BE53C1DC19E57858DC45FCB0BB2315BAA4203B1389F8EE3CD5CC0F97C369DA28C408164103B1DC99FB953DB066751E01DF817A49C3D5B2EA78E8BC44121698A023EC4544B053A8469F579B1E0C306E6239D83D26F31038588C0317AC5436F41B501166581B0B911F2613A86AE826EA04774156411153FC7DC25A62D644401F517DA6CAD908943F97E848B48878B8DDBDB68B1546E75EA5D1E0A05CD3D21C3746C82CC8D444518B0283C494066E0017063C4C35F5D00F1B06790C3C045CBC68174451989188B8D3C1509919B1EE476DDBF3CB909250AC546ABCD74184957744C7AE473AC82FC70835EAF0B0E8B69D31B480A2F0DD941170452180C25D22C53777E61FD98048A0C11C476EAA55212C4815CB1F791887D26FEF626184F95EBA057ED96A6C832F002FAC491B95E0FA5D2EA300C8CF59BBC2C717D34023FE47A2C8B0293894881EC9E58AA0CBE0537D84EAB5ECE90E94E82045FFE6504F14A64B3F95AB3C1B202A97FD0B8890523B0DA6CB360067DAEDF19F07C7FC08BE288EB763A9D1E5824D8D8944818083E4B1EF15CA7CD341AD5C495CEC3C8255CD7C7244181189DAE31782F0BCE6B4342107623B2784FBBCFF77BED0E3B24CD01873AAD6E97EDB59A4D0C5381D0345057A8634D429238A6D5AC64515B9F79C0FAE3097CA331531A988FBD81006684DA3550913CDBAE7745AEDDE3C0EA21AC95D170C022824CAFD36C545AAC28635ECF2051490DF2A0DABD4E1D4D820EF9B4F2A119C942B505A3C972BDDAEEF4AA1CE2359BD816B916C7759B2DB6D3E107A289050C2371EF759866B3D1EC0CA0F148EA81A1182422B411C732F52AEAF75F8EFC535DE8149F8F2E552AF546B33994750D904B68AD2CF6BB587044B46678C630141174B6CF346AF5363B4079198605124E388AC0F35072B57A29FA7163F463911B67FFAC703E9B2F146A5D4ED45493503574B6341C0EBABD01C7CB32E4BD0511240D396ED069B5DB2C2F29DAD831EC31B4B53212048EAD30C848E25FB7C9C8FA57E2F11DA4728562B9D6840C5634DDB181F00A408A1D0CB92127D8B3B10D6C37641EFD86C6E9724062686FCD01F86860E02CCB91EB8B14F6FAE8F56B9CFE9513B22274B502F5C8F4867DE902852A7694012223441035E44CC6631D85CA8174B082A81898301A54F7148E0CFBDD010ABE74A14264C73F41FA574EC8F2C752A5620929657AE2489235543EAA56B7600C90083F00E750737D6E04CC1FF1127117CA1FB34AE2B91EEA9A29A729825997F5B9F71FECBA1ABF89248A9542A1DA42BC0588685D9650B51A6A59C5C4C50436818B8621899A32221826EBC05E5D03668A104ADD6EB594BF88D13FE1BA78F3275CD79B5CB7C1583295CC161A88060F7283B1248F54038D46AE46580624363102358F2F20954A80196E4A80E93EDBEFD74BD9E81F0788A5CBE37F8C5C96EF36124B15CAA522CB0DC4511FF9965405F4071E3848081AD4B46CE292855A566592765DC3EC1AF2E20028D3AA66287261E8235ED7AB5D17239F862FCB771B4DA70BC50A14E400B403D30FCC02DB622C625E4234121E0143160CC32DCC48348E22F3483930A09E8BFB2F779661E513BDB0FE5FE2B17C54229DCA965A0C41430E702E6A96A660C09B44B1BA0043C86C881DB02E9439BE6559928134F556AB594E862EC900D1C6F76537F2E3FF84EB9A2D006532556C4277C1115E188E44B29DA19A983010DEE4CA3C8A8C5C22C4FC42D246E8D65EB759AD560B290A63E463E7CB4FC2213F8D5C9FBD2C70BE304D63B4D43B1C08D270886D749B5C1DC4F1C16216E848FC766562237184DA10069D2ED3AA94F3599A8AFAC99DFE9B8F32FAD8F8FF251ED1F4FB89ACCF556A8D419FE3007AA02A000E673C5F202108D9A50C9008459565B4398E0220632077CB34C87510E4141A34443CB87E83AD90F0915F2EC5E6F387FDFE60988AC5E972B1D603A84247A35F4C002D489C47640E5012940190A3A35BD11E034C49C8CD5EAB9202A18B862140A3A1CB1D2DFFE5462C5A857882C3937A0890BBA6A1301C09C7281A0DD9831514F15022D3650E16EA91CB1BB3C514A4C1D175F4898421C9F731245B8D7A299D8953F108F9AC4C388A7F702A88D841FD0688919B6B27E28930F2160804235494222C9FE9707DA80918B97CB4C05D2CC8D580F16C6AEB4808B22EF0239EED355ACD6A29934ED1D118F6C78A5190F0E42341A0C341286B6284740FA1487E9C204A2EE6E22745A74B650C4922BE44C59A91ACCF160B50CAC96CEC98C40B641CE1ECC10853CE6492C9449C8201286A2A1EC3C33816B9AF18BD5C2CF0E1F8370860948E4523110A8EE22C74329929D61AE8628C5D452701B24DA891F96C8229A313FE8881AE08C31EDB2C15AB99543A9548909B65C408453E6714271F398AC4E2B168EC0BA9641F39C187A7B118B97410A51374AA5029377BFD01340BA1C0005BCD8444813580245077881E623B7D4CA9743299249F2E8A4463E130B68826D3542241C3954C026E45BF909BF0C1682C0A072388659CA623E170249EC965D31892AD3E7A7E04866D62DE83662B26E944844BBE0C014CFB76BD5428668B995832074FC839A944329B4DA5B2292A914A25E3092AFA2514252E908F6B8551B8F1582271B9B149A5D2093A0B0CEB0C041E5CDDB431C479284ACBC2B7AEA00B79A1CF32DD6A369D055F2BA6D2392A09235434964C66F3B94CAE086712C938051D1F416CF03FAA8FA2683A014FC20857844A2533E96CB1546A6012F122B9348F6185C9A1AB00191922841B809032D5623E972F174B996C1211268513A5693A9DCBA3DA5299542289DF625F90A0443A8E62CA655378199D484483C8482C97831F857CA9CA60D2F282AA634CA90A98BCAC131AC7A37FFADD76B694CF92CF4AD1855C229A4C211EB1188D80A4E15E3A93CD6473344DD1FF0BB66AC0E5D6AE7D130000000049454E44AE426082, N'CPK01')
SET IDENTITY_INSERT [dbo].[image] OFF
GO
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Chữa răng và nội nha')
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Nha chu')
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Nhổ răng và tiểu phẫu')
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Phục hình')
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Răng trẻ em')
INSERT [dbo].[Khoa] ([Ten]) VALUES (N'Tổng quát')
GO
INSERT [dbo].[Lam_viec] ([Ngay], [Ca], [Ma_bac_si], [Diemdanh]) VALUES (CAST(N'2024-05-10' AS Date), 1, N'BSTQ02', N'Có mặt')
INSERT [dbo].[Lam_viec] ([Ngay], [Ca], [Ma_bac_si], [Diemdanh]) VALUES (CAST(N'2024-05-10' AS Date), 3, N'BSTQ02', N'Chưa điểm danh')
INSERT [dbo].[Lam_viec] ([Ngay], [Ca], [Ma_bac_si], [Diemdanh]) VALUES (CAST(N'2024-05-12' AS Date), 1, N'BSTQ02', N'Chưa điểm danh')
INSERT [dbo].[Lam_viec] ([Ngay], [Ca], [Ma_bac_si], [Diemdanh]) VALUES (CAST(N'2024-05-12' AS Date), 3, N'BSTQ02', N'Có mặt')
GO
INSERT [dbo].[Le_tan] ([Ma_le_tan]) VALUES (N'LT01')
GO
INSERT [dbo].[Loai_thuoc] ([Ten_loai]) VALUES (N'Giảm đau')
INSERT [dbo].[Loai_thuoc] ([Ten_loai]) VALUES (N'Kháng sinh')
INSERT [dbo].[Loai_thuoc] ([Ten_loai]) VALUES (N'Kháng viêm')
GO
INSERT [dbo].[Loai_vat_lieu] ([Ten_loai]) VALUES (N'Vật liệu cố định')
INSERT [dbo].[Loai_vat_lieu] ([Ten_loai]) VALUES (N'Vật liệu tiêu hao')
GO
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSCRVNN', 7500000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSNC', 7000000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSNRVTP', 7500000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSPH', 8000000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSRTE', 7000000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'BSTQ', 8000000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'CPK', 50000000)
INSERT [dbo].[Luong_co_dinh] ([Ma], [So_tien]) VALUES (N'LT', 5000000)
GO
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'BSNRVTP01', N'Trần', N'Nhi', N'Nữ', CAST(N'2005-04-12' AS Date), N'123@gmail.com', N'Đồng Tháp', N'123', N'BSNRVTP', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'BSRTE01', N'Nguyễn', N'A', N'Nữ', CAST(N'2005-04-12' AS Date), N'123@gmail.com', N'Đồng Tháp', N'1234', N'BSRTE', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'BSRTE02', N'Trần', N'B', N'Nữ', CAST(N'2005-04-12' AS Date), N'uchihaha3169@gmail.com', N'Đồng Tháp', N'12322', N'BSRTE', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'BSTQ01', N'Nguyễn Minh', N'Quân', N'Nam', CAST(N'2004-01-07' AS Date), N'123@gmail.com', N'Bến Tre', N'1234', N'BSTQ', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'BSTQ02', N'Đỗ', N'C', N'Nam', CAST(N'2004-11-07' AS Date), N'uchihaha3169@gmail.com', N'Đồng Tháp', N'1234', N'BSTQ', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'CPK01', N'Nguyễn', N'D', N'Nam', CAST(N'2004-01-07' AS Date), N'123@gmail.com', N'Quảng Ngãi', N'1234', N'CPK', 1)
INSERT [dbo].[Nguoi_dung] ([Ma_nhan_vien], [Ho], [Ten], [Gioi_tinh], [Ngay_sinh], [email], [Que_quan], [CCCD], [Maluong], [Hoatdong]) VALUES (N'LT01', N'Nguyễn', N'E', N'Nữ', CAST(N'2004-02-03' AS Date), N'123@gmail.com', N'Kiên Giang', N'1234', N'LT', 1)
GO
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051024Ca101', CAST(N'2024-05-10' AS Date), 1, N'202405100001', N'LT01', N'BSTQ01', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051024Ca102', CAST(N'2024-05-10' AS Date), 1, N'202405100001', N'LT01', N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051024Ca103', CAST(N'2024-05-10' AS Date), 1, N'202405100002', N'LT01', N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051024Ca301', CAST(N'2024-05-10' AS Date), 3, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca101', CAST(N'2024-05-11' AS Date), 1, N'202405100002', N'LT01', N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca102', CAST(N'2024-05-11' AS Date), 1, N'202405100002', NULL, N'BSTQ02', N'Đã điều trị', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca201', CAST(N'2024-05-11' AS Date), 2, N'202405100002', N'LT01', N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca202', CAST(N'2024-05-11' AS Date), 2, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca301', CAST(N'2024-05-11' AS Date), 3, N'202405100002', NULL, N'BSTQ01', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051124Ca302', CAST(N'2024-05-11' AS Date), 3, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051324Ca101', CAST(N'2024-05-13' AS Date), 1, N'202405100001', N'LT01', N'BSTQ02', N'Đã điều trị', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051324Ca102', CAST(N'2024-05-13' AS Date), 1, N'202405100002', N'LT01', N'BSTQ02', N'Đã tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051524Ca101', CAST(N'2024-05-15' AS Date), 1, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'051624Ca101', CAST(N'2024-05-16' AS Date), 1, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'100524Ca301', CAST(N'2024-10-05' AS Date), 3, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
INSERT [dbo].[Nguoi_kham] ([STT], [Ngay], [Ca], [Ma_benh_nhan], [Ma_le_tan], [Ma_bac_si], [Trang_thai], [Ghi_chu]) VALUES (N'110524Ca301', CAST(N'2024-11-05' AS Date), 3, N'202405100002', NULL, N'BSTQ02', N'Chưa tiếp nhận', NULL)
GO
INSERT [dbo].[Phuong_thuc_thanh_toan] ([Ten]) VALUES (N'Chuyển khoản')
INSERT [dbo].[Phuong_thuc_thanh_toan] ([Ten]) VALUES (N'Tiền mặt')
GO
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'BSNRVTP01', 0xA94B1F10C472E110C9C245FB81FD0DE01D3C5B33787504F2BEE9B63C4F11CE70CDD76AC4BBC472264AA06A1AB1638E15AB9338C3F5C9D5BD0DFA95A7B4B54716, N'BSNRVTP01', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'BSRTE01', 0xF484AF43207FD998D1687EBDD1C244E5E74481F5B45A6A13E10E4DAB455957419A8AA9B1BAC7DF854B725B1163F3B1F8B85C8BEE6DCF1689367C3CFCBD5C5DCB, N'BSRTE01', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'BSRTE02', 0x9C631AA40C2AE4B32A9F2A6AC1F7FC8FE7247A982960D6F467A5D83DE1D05D970164BD6B023D8B9ADB3BF42ACBBD8BF3739E14E3A6B16E1F477684C66AC2C811, N'BSRTE02', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'BSTQ01', 0xB5184C2D0C78606103E68594AF86245EF1D8865E05981F6E5B243032B902D1CF5E75F69D7C3E2E0BB4C5FA6DEEC70DD4D9DDDD094770DCCB1E17FC3E6F82AB56, N'BSTQ01', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'BSTQ02', 0x8152898C9659AA41C0DBA481EBD487E283C33113D1D918BABF605FFF3385FD3C93F187E79BEAD003C8A4AB911C4A93B4D8509CDB0E122E9025BD3DD8F312A4D8, N'BSTQ02', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'CPK01', 0x53C00AF73D384674D85E65093F26CD86473461BAFD100C056D0DAAF68596EDEF81496ECEC3655B50F7F30293DB7C92C45FACF915A3C765BA9BCE5DD87196D265, N'CPK01', 0)
INSERT [dbo].[Tai_khoan] ([Taikhoan], [Matkhau], [MaNV], [SoLan]) VALUES (N'LT01', 0x9C631AA40C2AE4B32A9F2A6AC1F7FC8FE7247A982960D6F467A5D83DE1D05D970164BD6B023D8B9ADB3BF42ACBBD8BF3739E14E3A6B16E1F477684C66AC2C811, N'LT01', 0)
GO
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0001', N'051024Ca102', NULL, 100000, NULL, N'Chưa thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0002', N'051024Ca103', CAST(N'2024-05-13T14:35:36.297' AS DateTime), 126000, N'Tiền mặt', N'Đã thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0003', N'051124Ca101', CAST(N'2024-05-11T12:40:53.267' AS DateTime), 0, N'Tiền mặt', N'Đã thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0004', N'051124Ca201', CAST(N'2024-05-11T12:44:56.750' AS DateTime), 18150000, N'Chuyển khoản', N'Đã thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0005', N'051124Ca302', NULL, 0, NULL, N'Chưa thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0006', N'051124Ca102', NULL, 0, NULL, N'Chưa thanh toán')
INSERT [dbo].[Thanh_toan] ([ID], [STT], [Gio], [Tongtien], [Hinhthuc], [Tinhtrang]) VALUES (N'HD0007', N'051324Ca101', NULL, 0, NULL, N'Chưa thanh toán')
GO
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'123', N'Hộp', 123, 123, N'123', N'123', N'Giảm đau')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Amoxicillin 1000', N'Hộp', 10, 275000, N'1000mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Amoxicillin 500', N'Hộp', 10, 120000, N'500mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Amoxicillin 625', N'Hộp', 21, 182000, N'625mg', N'', N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Amoxicillin 875', N'Hộp', 9, 126000, N'875mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Cephalexin', N'Hộp', 10, 127000, N'500mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Dexamethasone', N'Hộp', 9, 150000, N'4mg', NULL, N'Giảm đau')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Diclofenac 50', N'Hộp', 10, 32000, N'50mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Diclofenac 75', N'Hộp', 10, 55000, N'75mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Ibuprofen 200', N'Hộp', 10, 43000, N'200mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Ibuprofen 400', N'Hộp', 10, 88000, N'400mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Medrol 16', N'Hộp', 10, 120000, N'16mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Medrol 4', N'Hộp', 10, 40000, N'4mg', NULL, N'Kháng viêm')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Metronidazol 250', N'Hộp', 10, 30000, N'250mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Metronidazol 500', N'Hộp', 10, 100000, N'500mg', NULL, N'Kháng sinh')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Paracetamol 500', N'Hộp', 10, 33000, N'500mg', NULL, N'Giảm đau')
INSERT [dbo].[Thuoc] ([Ten_thuoc], [DVT], [So_luong], [Gia_ban], [Ham_luong], [Ghi_chu], [Ten_loai]) VALUES (N'Paracetamol 650', N'Hộp', 10, 56000, N'650mg', NULL, N'Giảm đau')
GO
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Bay trám', N'Trắng', NULL, N'Cái', 500000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Bộ dụng cụ khám răng cơ bản', N'Trắng', NULL, N'Bộ', 700000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Các loại trâm tay', N'Đen', NULL, N'Bộ', 300000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Cây đo túi nướu', N'Trắng', NULL, N'Cái', 40000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Chỉ khâu', N'Trắng', 0, N'Hộp', 40000, 19, N'', N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Chổi đánh bóng', N'Trắng', NULL, N'Hộp', 200000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Composite đặc', N'Đen', NULL, N'Ống', 170000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Composite lỏng', N'Đen', NULL, N'Ống', 100000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Cone chính', N'Trắng', NULL, N'Hộp', 500000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Cone giấy', N'Trắng', NULL, N'Hộp', 50000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Đèn quang trùng hợp', N'Xanh dương', NULL, N'Cái', 20000000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'EDTA', N'Trắng', NULL, N'Ống', 150000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Formacresol', N'Đỏ', NULL, N'Chai', 200000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'GIC', N'Trắng', NULL, N'Chai', 1000000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Kiềm', N'Trắng', NULL, N'Cái', 300000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'MTA', N'Trắng', NULL, N'Cái', 2500000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Mũi cạo vôi', N'Trắng', NULL, N'Cái', 400000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Mũi đánh bóng', N'Trắng', NULL, N'Cái', 100000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'NaCL', N'Trắng', NULL, N'Chai', 12000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Nạo ngà', N'Trắng', NULL, N'Cái', 300000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'NaOCl', N'Trắng', NULL, N'Chai', 450000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Nạy', N'Đen', NULL, N'Cái', 100000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Ống chích sắt', N'Trắng', NULL, N'Cái', 200000, 10, NULL, N'Vật liệu cố định')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Sealer trám bít', N'Trắng', NULL, N'Ống', 500000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Sò đánh bóng', N'Nâu', NULL, N'Hộp', 200000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Spongel', N'Trắng', NULL, N'Hộp', 12000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Thuốc tê', N'Trắng', NULL, N'Hộp', 900000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Trâm máy', N'Vàng', NULL, N'Cái', 200000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'Trám tạm', N'Trắng', NULL, N'Hộp', 100000, 10, NULL, N'Vật liệu tiêu hao')
INSERT [dbo].[Vat_lieu] ([Ten_dung_cu], [Mau_sac], [Kich_co], [DVT], [Gia], [So_luong], [Ghi_chu], [Loai]) VALUES (N'ZnO', N'Trắng', NULL, N'Chai', 70000, 10, NULL, N'Vật liệu tiêu hao')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Nguoi_du__A955A0AA6C4E35B7]    Script Date: 5/13/2024 11:01:21 PM ******/
ALTER TABLE [dbo].[Nguoi_dung] ADD UNIQUE NONCLUSTERED 
(
	[CCCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Benh_an] ADD  DEFAULT (N'Chưa ghi nhận bất thường') FOR [Benh_su]
GO
ALTER TABLE [dbo].[Benh_an] ADD  DEFAULT (N'Chưa ghi nhận bất thường') FOR [Tien_su_gia_dinh]
GO
ALTER TABLE [dbo].[Benh_an] ADD  DEFAULT (N'Chưa ghi nhận bất thường') FOR [Tien_su_noi_khoa]
GO
ALTER TABLE [dbo].[Benh_an] ADD  DEFAULT (N'Chưa ghi nhận bất thường') FOR [Tien_su_rang_ham_mat]
GO
ALTER TABLE [dbo].[Bac_si]  WITH CHECK ADD FOREIGN KEY([Chuyen_nganh])
REFERENCES [dbo].[Khoa] ([Ten])
GO
ALTER TABLE [dbo].[Bac_si]  WITH CHECK ADD FOREIGN KEY([Chuyen_nganh])
REFERENCES [dbo].[Khoa] ([Ten])
GO
ALTER TABLE [dbo].[Bac_si]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Bac_si]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Benh_an]  WITH CHECK ADD FOREIGN KEY([MaBN])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Benh_an]  WITH CHECK ADD FOREIGN KEY([MaBN])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Chi_tieu_dung_cu]  WITH CHECK ADD FOREIGN KEY([Ten_dung_cu])
REFERENCES [dbo].[Vat_lieu] ([Ten_dung_cu])
GO
ALTER TABLE [dbo].[Chi_tieu_dung_cu]  WITH CHECK ADD FOREIGN KEY([Ten_dung_cu])
REFERENCES [dbo].[Vat_lieu] ([Ten_dung_cu])
GO
ALTER TABLE [dbo].[Chi_tieu_dung_cu]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[Chi_tieu_dung_cu]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[Chu]  WITH CHECK ADD FOREIGN KEY([Ma_chu])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Chu]  WITH CHECK ADD FOREIGN KEY([Ma_chu])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD FOREIGN KEY([Ten_danh_muc])
REFERENCES [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc])
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD FOREIGN KEY([Ten_danh_muc])
REFERENCES [dbo].[Danh_muc_ki_thuat] ([Ten_danh_muc])
GO
ALTER TABLE [dbo].[HD_Dich_vu]  WITH CHECK ADD FOREIGN KEY([Ten_dich_vu])
REFERENCES [dbo].[Dich_vu] ([Ten_dich_vu])
GO
ALTER TABLE [dbo].[HD_Dich_vu]  WITH CHECK ADD FOREIGN KEY([Ten_dich_vu])
REFERENCES [dbo].[Dich_vu] ([Ten_dich_vu])
GO
ALTER TABLE [dbo].[HD_Dich_vu]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[HD_Dich_vu]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[HD_Thuoc]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[HD_Thuoc]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[HD_Thuoc]  WITH CHECK ADD FOREIGN KEY([Ten_thuoc])
REFERENCES [dbo].[Thuoc] ([Ten_thuoc])
GO
ALTER TABLE [dbo].[HD_Thuoc]  WITH CHECK ADD FOREIGN KEY([Ten_thuoc])
REFERENCES [dbo].[Thuoc] ([Ten_thuoc])
GO
ALTER TABLE [dbo].[image]  WITH CHECK ADD FOREIGN KEY([Taikhoan])
REFERENCES [dbo].[Tai_khoan] ([Taikhoan])
GO
ALTER TABLE [dbo].[image]  WITH CHECK ADD FOREIGN KEY([Taikhoan])
REFERENCES [dbo].[Tai_khoan] ([Taikhoan])
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD FOREIGN KEY([Ca])
REFERENCES [dbo].[Ca_lam] ([Ca])
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD FOREIGN KEY([Ca])
REFERENCES [dbo].[Ca_lam] ([Ca])
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Bac_si] ([Ma_bac_si])
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Bac_si] ([Ma_bac_si])
GO
ALTER TABLE [dbo].[Le_tan]  WITH CHECK ADD FOREIGN KEY([Ma_le_tan])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Le_tan]  WITH CHECK ADD FOREIGN KEY([Ma_le_tan])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Nguoi_dung]  WITH CHECK ADD FOREIGN KEY([Maluong])
REFERENCES [dbo].[Luong_co_dinh] ([Ma])
GO
ALTER TABLE [dbo].[Nguoi_dung]  WITH CHECK ADD FOREIGN KEY([Maluong])
REFERENCES [dbo].[Luong_co_dinh] ([Ma])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Bac_si] ([Ma_bac_si])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_bac_si])
REFERENCES [dbo].[Bac_si] ([Ma_bac_si])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_benh_nhan])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_benh_nhan])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_le_tan])
REFERENCES [dbo].[Le_tan] ([Ma_le_tan])
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD FOREIGN KEY([Ma_le_tan])
REFERENCES [dbo].[Le_tan] ([Ma_le_tan])
GO
ALTER TABLE [dbo].[Tai_khoan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Tai_khoan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[Nguoi_dung] ([Ma_nhan_vien])
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD FOREIGN KEY([Hinhthuc])
REFERENCES [dbo].[Phuong_thuc_thanh_toan] ([Ten])
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD FOREIGN KEY([Hinhthuc])
REFERENCES [dbo].[Phuong_thuc_thanh_toan] ([Ten])
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD FOREIGN KEY([STT])
REFERENCES [dbo].[Nguoi_kham] ([STT])
GO
ALTER TABLE [dbo].[Theo_doi_dieu_tri]  WITH CHECK ADD FOREIGN KEY([MaBN])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Theo_doi_dieu_tri]  WITH CHECK ADD FOREIGN KEY([MaBN])
REFERENCES [dbo].[Benh_nhan] ([MaBN])
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD FOREIGN KEY([Ten_loai])
REFERENCES [dbo].[Loai_thuoc] ([Ten_loai])
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD FOREIGN KEY([Ten_loai])
REFERENCES [dbo].[Loai_thuoc] ([Ten_loai])
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD FOREIGN KEY([Loai])
REFERENCES [dbo].[Loai_vat_lieu] ([Ten_loai])
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD FOREIGN KEY([Loai])
REFERENCES [dbo].[Loai_vat_lieu] ([Ten_loai])
GO
ALTER TABLE [dbo].[Benh_an]  WITH CHECK ADD CHECK  (([Can_lam_sang]=N'Khác' OR [Can_lam_sang]=N'Xét nghiệm máu' OR [Can_lam_sang]=N'Siêu âm' OR [Can_lam_sang]=N'X-quang'))
GO
ALTER TABLE [dbo].[Benh_an]  WITH CHECK ADD CHECK  (([Can_lam_sang]=N'Khác' OR [Can_lam_sang]=N'Xét nghiệm máu' OR [Can_lam_sang]=N'Siêu âm' OR [Can_lam_sang]=N'X-quang'))
GO
ALTER TABLE [dbo].[Benh_nhan]  WITH CHECK ADD CHECK  (([Gioi_tinh]=N'Nữ' OR [Gioi_tinh]=N'Nam'))
GO
ALTER TABLE [dbo].[Benh_nhan]  WITH CHECK ADD CHECK  (([Gioi_tinh]=N'Nữ' OR [Gioi_tinh]=N'Nam'))
GO
ALTER TABLE [dbo].[Ca_lam]  WITH CHECK ADD CHECK  (([Ca]>=(1) AND [Ca]<=(3)))
GO
ALTER TABLE [dbo].[Ca_lam]  WITH CHECK ADD CHECK  (([Ca]>=(1) AND [Ca]<=(3)))
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD CHECK  (([Don_gia]>(0)))
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD CHECK  (([Don_gia]>(0)))
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD CHECK  (([Don_vi_tinh]=N'Đơn vị' OR [Don_vi_tinh]=N'Phim' OR [Don_vi_tinh]=N'Máng' OR [Don_vi_tinh]=N'Bộ' OR [Don_vi_tinh]=N'Hàm' OR [Don_vi_tinh]=N'Ống tủy' OR [Don_vi_tinh]=N'Xoang' OR [Don_vi_tinh]=N'Răng' OR [Don_vi_tinh]=N'Lần' OR [Don_vi_tinh]=N'Vùng hàm' OR [Don_vi_tinh]=N'2 hàm' OR [Don_vi_tinh]=N'Lượt' OR [Don_vi_tinh]=N'Cái'))
GO
ALTER TABLE [dbo].[Dich_vu]  WITH CHECK ADD CHECK  (([Don_vi_tinh]=N'Đơn vị' OR [Don_vi_tinh]=N'Phim' OR [Don_vi_tinh]=N'Máng' OR [Don_vi_tinh]=N'Bộ' OR [Don_vi_tinh]=N'Hàm' OR [Don_vi_tinh]=N'Ống tủy' OR [Don_vi_tinh]=N'Xoang' OR [Don_vi_tinh]=N'Răng' OR [Don_vi_tinh]=N'Lần' OR [Don_vi_tinh]=N'Vùng hàm' OR [Don_vi_tinh]=N'2 hàm' OR [Don_vi_tinh]=N'Lượt' OR [Don_vi_tinh]=N'Cái'))
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD CHECK  (([Diemdanh]=N'Chưa điểm danh' OR [Diemdanh]=N'Vắng' OR [Diemdanh]=N'Có mặt'))
GO
ALTER TABLE [dbo].[Lam_viec]  WITH CHECK ADD CHECK  (([Diemdanh]=N'Chưa điểm danh' OR [Diemdanh]=N'Vắng' OR [Diemdanh]=N'Có mặt'))
GO
ALTER TABLE [dbo].[Nguoi_dung]  WITH CHECK ADD CHECK  (([Gioi_tinh]=N'Nữ' OR [Gioi_tinh]=N'Nam'))
GO
ALTER TABLE [dbo].[Nguoi_dung]  WITH CHECK ADD CHECK  (([Gioi_tinh]=N'Nữ' OR [Gioi_tinh]=N'Nam'))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Ghi_chu]=N'Xong' OR [Ghi_chu]=N'Tái khám'))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Ghi_chu]=N'Xong' OR [Ghi_chu]=N'Tái khám'))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Trang_thai]=N'Đã điều trị' OR [Trang_thai]=N'Đang điều trị' OR [Trang_thai]=N'Đã tiếp nhận' OR [Trang_thai]=N'Chưa tiếp nhận'))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Trang_thai]=N'Đã điều trị' OR [Trang_thai]=N'Đang điều trị' OR [Trang_thai]=N'Đã tiếp nhận' OR [Trang_thai]=N'Chưa tiếp nhận'))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Ca]>=(1) AND [Ca]<=(3)))
GO
ALTER TABLE [dbo].[Nguoi_kham]  WITH CHECK ADD CHECK  (([Ca]>=(1) AND [Ca]<=(3)))
GO
ALTER TABLE [dbo].[Phuong_thuc_thanh_toan]  WITH CHECK ADD CHECK  (([Ten]=N'Chuyển khoản' OR [Ten]=N'Tiền mặt'))
GO
ALTER TABLE [dbo].[Phuong_thuc_thanh_toan]  WITH CHECK ADD CHECK  (([Ten]=N'Chuyển khoản' OR [Ten]=N'Tiền mặt'))
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD CHECK  (([Tinhtrang]=N'Đã thanh toán' OR [Tinhtrang]=N'Chưa thanh toán'))
GO
ALTER TABLE [dbo].[Thanh_toan]  WITH CHECK ADD CHECK  (([Tinhtrang]=N'Đã thanh toán' OR [Tinhtrang]=N'Chưa thanh toán'))
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD CHECK  (([Gia_ban]>(0)))
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD CHECK  (([Gia_ban]>(0)))
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD CHECK  (([So_luong]>=(0)))
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD CHECK  (([So_luong]>=(0)))
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD CHECK  (([Gia]>(0)))
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD CHECK  (([Gia]>(0)))
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD CHECK  (([So_luong]>=(0)))
GO
ALTER TABLE [dbo].[Vat_lieu]  WITH CHECK ADD CHECK  (([So_luong]>=(0)))
GO
/****** Object:  StoredProcedure [dbo].[CapNhatThanhToan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CapNhatThanhToan]
(
    @id varchar(30),
    @hinhthuc NVARCHAR(100)
)
AS
BEGIN
    -- Cập nhật trạng thái thanh toán
    UPDATE Thanh_toan
    SET tinhtrang = N'Đã thanh toán'
    WHERE id = @id;

    -- Cập nhật hình thức thanh toán
    UPDATE Thanh_toan
    SET Hinhthuc = @hinhthuc
    WHERE id = @id;

    -- Cập nhật thời gian thanh toán
    UPDATE Thanh_toan
    SET gio = GETDATE()
    WHERE id = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[CapNhatThuocVoiChenhLech]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CapNhatThuocVoiChenhLech]
    @TenThuoc NVARCHAR(30),
    @STT VARCHAR(15),
    @SoLuong INT,
    @GhiChu NVARCHAR(150)
AS
BEGIN
    DECLARE @SoLuongHienTai INT;

    -- Lấy số lượng hiện tại của thuốc
    SELECT @SoLuongHienTai = ISNULL(So_luong, 0) 
    FROM HD_Thuoc 
    WHERE Ten_thuoc = @TenThuoc AND STT = @STT;

    -- Cập nhật số lượng thuốc trong bảng HD_Thuoc
    UPDATE HD_Thuoc 
    SET So_luong = @SoLuong, 
        Ghi_chu = @GhiChu 
    WHERE Ten_thuoc = @TenThuoc AND STT = @STT;

    -- Tính toán chênh lệch số lượng
    DECLARE @ChenhLechSoLuong INT;
    SET @ChenhLechSoLuong = @SoLuong - @SoLuongHienTai;

    -- Cập nhật số lượng thuốc trong kho trong bảng Thuoc
    UPDATE Thuoc 
    SET So_luong = So_luong - @ChenhLechSoLuong 
    WHERE Ten_thuoc = @TenThuoc;
END
GO
/****** Object:  StoredProcedure [dbo].[DiemDanh]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DiemDanh] 
  @Ngay date,
  @Ma_bac_si VARCHAR(10),
  @Ca INT
AS
BEGIN
  UPDATE Lam_viec
  SET Diemdanh = N'Có mặt'
  WHERE Ngay = @Ngay AND Ma_bac_si = @Ma_bac_si AND Ca = @Ca;

END;
GO
/****** Object:  StoredProcedure [dbo].[Lay_ngay_ra]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lay_ngay_ra]
  @mabacsi VARCHAR(10),
  @thang INT,
  @nam INT
AS
BEGIN
  SELECT DAY(Ngay) AS Ngay_trong_thang
  FROM Lam_viec
  WHERE Ma_bac_si = @mabacsi
    AND MONTH(Ngay) = @thang
    AND YEAR(Ngay) = @nam;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_capnhatsolan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_capnhatsolan] @taikhoan VARCHAR(30)
as
	begin
		update Tai_khoan set SoLan = 0 where @taikhoan = Taikhoan
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_check]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_check]
    @manhanvien VARCHAR(10),
	@matkhau VARCHAR(30)
AS
BEGIN
    select * from Nguoi_dung inner join Tai_khoan on Nguoi_dung.Ma_nhan_vien = Tai_khoan.MaNV
	where MaNV = @manhanvien
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_check_login]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_check_login] 
    @taikhoan VARCHAR(30),
    @matkhau NVARCHAR(4000),
    @message NVARCHAR(1000) OUTPUT
AS
BEGIN
    DECLARE @SoLan INT;

    -- Khởi tạo giá trị mặc định cho output parameter
    SET @message = '';

    -- Check if the account exists
    IF NOT EXISTS (SELECT 1 FROM Tai_khoan WHERE Taikhoan = @taikhoan)
    BEGIN
        SET @message = N'Không tìm thấy tài khoản';
        RETURN;
    END

    -- Check if the account is active
    IF NOT EXISTS (
        SELECT 1 
        FROM Tai_khoan tk 
        JOIN Nguoi_dung nd ON tk.MaNV = nd.Ma_nhan_vien
        WHERE tk.Taikhoan = @taikhoan AND nd.Hoatdong = 1
    )
    BEGIN
        SET @message = N'Tài khoản không hoạt động';
        RETURN;
    END

    -- Get the number of login attempts
    SELECT @SoLan = SoLan FROM Tai_khoan WHERE Taikhoan = @taikhoan;

    -- Check if the login attempts exceed 5
    IF @SoLan > 5
    BEGIN
        SET @message = N'Tài khoản bị vô hiệu hóa do quá nhiều lần thử đăng nhập';
        RETURN;
    END

    -- Check if the password is correct
    IF NOT EXISTS (
        SELECT 1 
        FROM Tai_khoan 
        WHERE Taikhoan = @taikhoan AND Matkhau = dbo.HashPassword(@matkhau)
    )
    BEGIN
        SET @message = N'Sai mật khẩu';
        
        -- Increase the number of login attempts
        UPDATE Tai_khoan SET SoLan = SoLan + 1 WHERE Taikhoan = @taikhoan;
        RETURN;
    END

    -- Reset the number of login attempts to 0
    UPDATE Tai_khoan SET SoLan = 0 WHERE Taikhoan = @taikhoan;
    
    SET @message = N'Đăng nhập thành công';
END
GO
/****** Object:  StoredProcedure [dbo].[proc_checkmatkhau]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_checkmatkhau] @taikhoan VARCHAR(30), @matkhau NVARCHAR(4000)
as
	begin
		SELECT * FROM Tai_khoan WHERE Taikhoan = @taikhoan AND Matkhau = dbo.HashPassword(@matkhau)
		update Tai_khoan set SoLan = SoLan + 1 where @taikhoan = Taikhoan
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_checktaikhoan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_checktaikhoan] @taikhoan VARCHAR(30)
as
	begin
		select * from Tai_khoan where Taikhoan = @taikhoan
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_chitieudichvu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_chitieudichvu]
as
begin
	select Ten_dich_vu as Ten,So_luong,Ngay from HD_Dich_vu inner join Nguoi_kham on HD_Dich_vu.STT = Nguoi_kham.STT
	order by Ngay ,Ten_dich_vu
end
GO
/****** Object:  StoredProcedure [dbo].[proc_chitieuthuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_chitieuthuoc]
as
begin
	select Ten_thuoc as Ten,So_luong,Ngay from HD_Thuoc inner join Nguoi_kham on HD_Thuoc.STT = Nguoi_kham.STT
	order by Ngay, Ten_thuoc
end
GO
/****** Object:  StoredProcedure [dbo].[proc_income]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_income]
as
begin
	select ho+' '+ten as HoTen,Tongtien
	from Thanh_toan
	inner join Nguoi_kham on Thanh_toan.STT = Nguoi_kham.STT
	inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
end
GO
/****** Object:  StoredProcedure [dbo].[proc_khoiphucmatkhau]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_khoiphucmatkhau] @taikhoan VARCHAR(30)
as
	begin
		declare @cccd NVARCHAR(12)
		select @cccd = cccd from  Tai_khoan t inner join Nguoi_dung n on t.MaNV = n.Ma_nhan_vien where Taikhoan = @taikhoan
		update Tai_khoan
		set Matkhau = dbo.HashPassword(@CCCD)
		where Taikhoan = @taikhoan
		update Tai_khoan set SoLan = 0 where @taikhoan = Taikhoan
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_kiemtraemail]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_kiemtraemail] 
    @taikhoan VARCHAR(30),
    @email VARCHAR(50),
    @message NVARCHAR(1000) OUTPUT
AS
BEGIN
    DECLARE @Hoatdong INT;

    -- Check if the account exists
    IF NOT EXISTS (SELECT 1 FROM Tai_khoan WHERE Taikhoan = @taikhoan)
    BEGIN
        SET @message = N'Không tìm thấy tài khoản';
        RETURN;
    END

    -- Check if the account is active
    SELECT @Hoatdong = Hoatdong
    FROM Nguoi_dung nd
    INNER JOIN Tai_khoan tk ON nd.Ma_nhan_vien = tk.MaNV
    WHERE tk.Taikhoan = @taikhoan;

    IF @Hoatdong = 0
    BEGIN
        SET @message = N'Tài khoản không còn hoạt động';
        RETURN;
    END

    -- Check if the email matches
    IF NOT EXISTS (
        SELECT 1 
        FROM Nguoi_dung nd
        INNER JOIN Tai_khoan tk ON nd.Ma_nhan_vien = tk.MaNV
        WHERE tk.Taikhoan = @taikhoan AND nd.email = @email
    )
    BEGIN
        SET @message = N'Email không khớp với tài khoản';
        RETURN;
    END

    -- If everything is correct, return success
    SET @message = N'Thành công';
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_lankham]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_lankham]
    @Mabn VARCHAR(12)
AS
BEGIN
    SELECT TOP 1 
        nk.Ngay,
        nd.Ho + ' ' +
        nd.Ten AS HoTen
    FROM 
        Nguoi_kham nk
    INNER JOIN 
        Nguoi_dung nd ON nk.Ma_bac_si = nd.Ma_nhan_vien
    WHERE 
        nk.Ma_benh_nhan = @Mabn
        AND nk.Trang_thai = N'Đã điều trị'
    ORDER BY 
        nk.Ngay;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_layanh]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_layanh]
as
begin
	select * from image
end
GO
/****** Object:  StoredProcedure [dbo].[proc_LayBenhAn]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_LayBenhAn]
		@MaBN VARCHAR(12)
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT 
			BA.Ly_do_den_kham, 
			BA.Benh_su, 
			BA.Tien_su_gia_dinh, 
			BA.Tien_su_noi_khoa, 
			BA.Tien_su_rang_ham_mat, 
			BA.Kham_ngoai_mat, 
			BA.Tinh_trang_ve_sinh_rang_mieng, 
			BA.Mo_mem, 
			BA.Mo_nha_chu, 
			BA.Rang, 
			BA.Khop_can, 
			BA.Can_lam_sang, 
			BA.Ket_qua_can_lam_sang, 
			BA.Chuan_doan, 
			BA.Ke_hoach_dieu_tri
		FROM 
			Benh_an BA
		INNER JOIN 
			Benh_nhan BN ON BN.MaBN = BA.MaBN
		WHERE 
			BN.MaBN = @MaBN
		ORDER BY BA.So_Benh_an desc
	END;
GO
/****** Object:  StoredProcedure [dbo].[proc_lichlam]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_lichlam] @ngay date, @maBS varchar(12)
as
	begin
		 select ca,Diemdanh from Lam_viec where @ngay = Ngay and @maBS = Ma_bac_si
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_lichlamthang]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_lichlamthang] @nam int, @thang int , @maBS varchar(12)
as
	begin
		 select ca,Diemdanh,ngay from Lam_viec where month(ngay) = @thang and year(ngay) = @nam and @maBS = Ma_bac_si
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_luong]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_luong] @nam int, @thang int
as
	begin
		select ma_nhan_vien, ho+' '+ten as HoTen, tong_luong
		from Tong_luong
		where thang = @thang and nam = @nam
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_luongcb]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_luongcb]
as
	begin
		select ma_nhan_vien, ho+' '+ten as HoTen, So_tien
		from Nguoi_dung inner join Luong_co_dinh on Nguoi_dung.Maluong = Luong_co_dinh.Ma
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_thaydoimatkhau]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_thaydoimatkhau]
    @manhanvien VARCHAR(10),
	@matkhaumoi NVARCHAR(4000)
AS
BEGIN
    update Tai_khoan set Matkhau = dbo.HashPassword(@matkhaumoi)
	where MaNV = @manhanvien
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_themanh]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_themanh]
    @bin VARBINARY(MAX),
	@Taikhoan VARCHAR(30)
AS
BEGIN
    INSERT INTO image (bin,Taikhoan)
    VALUES (@bin,@Taikhoan);
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_thongtin]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_thongtin] @taikhoan VARCHAR(30)
as
	begin
		 select Ma_nhan_vien,ho,ten,Gioi_tinh from Nguoi_dung inner join Tai_khoan on Tai_khoan.MaNV = Nguoi_dung.Ma_nhan_vien
		 where @taikhoan = Taikhoan
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_tiepnhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_tiepnhan] @maBN varchar(12)
as
	begin
		 update Nguoi_kham set Trang_thai = N'Đã tiếp nhận'
		 where STT = @maBN
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_timbacsi]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_timbacsi]
AS
BEGIN
    SELECT 
        nd.Ma_nhan_vien,
        nd.ho + ' ' + nd.ten AS HoTen,
        nd.Gioi_tinh,
        bs.Chuyen_nganh,
        CASE 
            WHEN nd.Hoatdong = 1 THEN N'Còn hoạt động'
            ELSE N'Không còn hoạt động'
        END AS Tinh_trang_hoat_dong
    FROM 
        Nguoi_dung nd
    INNER JOIN 
        Bac_si bs ON nd.Ma_nhan_vien = bs.Ma_bac_si;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_timbenhnhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_timbenhnhan] @ngay date, @maBS varchar(12)
as
	begin
		 select STT,ho+' '+ten as HoTen, Gioi_tinh,Ghi_chu from Nguoi_kham inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
		 where Ngay = @ngay and Ma_bac_si = @maBS and Trang_thai = N'Chưa tiếp nhận'
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_timbenhnhanchuakham]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_timbenhnhanchuakham] @ngay date, @maBS varchar(12)
as
	begin
		 select STT,ho+' '+ten as HoTen, Gioi_tinh,Ghi_chu from Nguoi_kham inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
		 where Ngay > @ngay and Ma_bac_si = @maBS and Trang_thai = N'Chưa tiếp nhận'
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_timbenhnhancu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--chuaw run
create proc [dbo].[proc_timbenhnhancu] @maBS varchar(12)
as
	begin
		 select STT,ho+' '+ten as HoTen, Gioi_tinh,Ghi_chu from Nguoi_kham inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
		 where Ngay >= GETDATE() and Ma_bac_si = @maBS
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_timbenhnhandatiepnhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_timbenhnhandatiepnhan] @ngay date, @maBS varchar(12)
as
	begin
		 select STT,Nguoi_kham.Ma_benh_nhan,ho+' '+ten as HoTen, Gioi_tinh,Ghi_chu from Nguoi_kham inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
		 where Ngay = @ngay and Ma_bac_si = @maBS and Trang_thai = N'Đã tiếp nhận'
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_timletan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_timletan]
AS
BEGIN
    SELECT 
        nd.Ma_nhan_vien,
        nd.ho + ' ' + nd.ten AS HoTen,
        nd.Gioi_tinh,
        CASE 
            WHEN nd.Hoatdong = 1 THEN N'Còn hoạt động'
            ELSE N'Không còn hoạt động'
        END AS Tinh_trang_hoat_dong
    FROM 
        Nguoi_dung nd
    INNER JOIN 
        Le_tan lt ON nd.Ma_nhan_vien = lt.Ma_le_tan;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_timSTT]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[proc_timSTT] @Ngay date, @Ca int, @Ma_benh_nhan varchar(12),@Ma_le_tan varchar(10),@Ma_bac_si varchar(10)
AS
BEGIN
	select STT from Nguoi_kham where ca = @ca and ngay = @ngay and Ma_le_tan = @Ma_le_tan and Ma_bac_si = @Ma_bac_si and Ma_benh_nhan = @Ma_benh_nhan
END

GO
/****** Object:  StoredProcedure [dbo].[proc_timtatcabenhnhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_timtatcabenhnhan] @ngay date
as
	begin
		 select STT,ho+' '+ten as HoTen,Ma_bac_si, Gioi_tinh,Ghi_chu from Nguoi_kham inner join Benh_nhan on Nguoi_kham.Ma_benh_nhan = Benh_nhan.MaBN
		 where Ngay >= @ngay and Trang_thai = N'Chưa tiếp nhận'
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_xoaanh]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_xoaanh]
		@Taikhoan VARCHAR(30)
as
begin
	delete from image where Taikhoan = @Taikhoan
end
GO
/****** Object:  StoredProcedure [dbo].[them_chiTieuDungCu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[them_chiTieuDungCu] @STT varchar(15),@Ten_dung_cu nvarchar(50), @So_luong int
AS
BEGIN
	Declare @ID varchar(15),@temp varchar(15)
	if (select count(*) from Chi_tieu_dung_cu)=0
		begin
			set @ID = 'CT0001'
		end
	else 
		begin
			if(select count(*) from Chi_tieu_dung_cu where @STT = STT)>0
				begin
					select @ID = id from Chi_tieu_dung_cu where @STT = STT
				end
			else
				begin 
					select TOP 1 @temp = ID from Chi_tieu_dung_cu order by ID desc
					set @temp = cast(right(@temp,4) as int)
					set @temp = @temp +1
					if @temp < 10
						begin
							set @ID = 'CT'+ '000'+Cast(@temp as varchar(1))
						end
					else if @temp < 100
						begin
							set @ID = 'CT'+ '00'+Cast(@temp as varchar(2))
						end
					else if @temp < 1000
						begin
							set @ID = 'CT'+ '0'+Cast(@temp as varchar(3))
						end
					else
						begin
							set @ID = 'CT'+Cast(@temp as varchar(4))
						end
				end
		end	

    --Check loại dụng cụ gì 
    Declare @check nvarchar(50)
    select @check = loai from Vat_lieu where @Ten_dung_cu = Ten_dung_cu
    if @check = N'Vật liệu tiêu hao'
        begin
            insert into Chi_tieu_dung_cu(ID,STT,Ten_dung_cu,So_luong) values(@ID,@STT,@Ten_dung_cu,@So_luong)
            --Cập nhật số lượng tồn kho
            UPDATE t
            SET So_luong = t.So_luong - @So_luong
            FROM Vat_lieu t
            WHERE t.Ten_dung_cu = @Ten_dung_cu

            -- Cập nhật Thanh_tien trong bảng Chi_tieu_dung_cu
            UPDATE hd
            SET Tong_tien = hd.So_luong * t.Gia
            FROM Chi_tieu_dung_cu hd
            INNER JOIN Vat_lieu t ON hd.Ten_dung_cu = t.Ten_dung_cu
            WHERE hd.ID = @ID
        end
    else
        begin
            insert into Chi_tieu_dung_cu(ID,STT,Ten_dung_cu,So_luong) values(@ID,@STT,@Ten_dung_cu,0)
        end
END
---
GO
/****** Object:  StoredProcedure [dbo].[Them_dich_vu_LT]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Them_dich_vu_LT] @STT varchar(15),@Ten_dich_vu nvarchar(50)
AS
BEGIN
	Declare @ID varchar(15),@temp varchar(15)
	if (select count(*) from HD_Dich_vu)=0
		begin
			set @ID = 'HDDV0001'
			insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
		end
	else 
		begin
			if(select count(*) from HD_Dich_vu where @STT = STT)>0
				begin
					select @ID = id from HD_Dich_vu where @STT = STT
					insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
				end
			else
				begin 
					select TOP 1 @temp = ID from HD_Dich_vu order by ID desc
					set @temp = cast(right(@temp,4) as int)
					set @temp = @temp +1
					if @temp < 10
						begin
							set @ID = 'HDDV'+ '000'+Cast(@temp as varchar(1))
							insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
						end
					else if @temp < 100
						begin
							set @ID = 'HDDV'+ '00'+Cast(@temp as varchar(2))
							insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
						end
					else if @temp < 1000
						begin
							set @ID = 'HDDV'+ '0'+Cast(@temp as varchar(3))
							insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
						end
					else
						begin
							set @ID = 'HDDV'+Cast(@temp as varchar(4))
							insert into HD_Dich_vu values(@ID,@STT,@Ten_dich_vu,0,0,NULL)
						end
				end
		end	
END
GO
/****** Object:  StoredProcedure [dbo].[Them_hoadon_thuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Them_hoadon_thuoc] @STT varchar(15),@Ten_thuoc nvarchar(50), @So_luong int, @Ghi_chu nvarchar(100)
AS
BEGIN
	Declare @ID varchar(15),@temp varchar(15)
	if (select count(*) from HD_Thuoc)=0
		begin
			set @ID = 'HDT0001'
			insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
		end
	else 
		begin
			if(select count(*) from HD_Thuoc where @STT = STT)>0
				begin
					select @ID = id from HD_Thuoc where @STT = STT
					insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
				end
			else
				begin 
					select TOP 1 @temp = ID from HD_Thuoc order by ID desc
					set @temp = cast(right(@temp,4) as int)
					set @temp = @temp +1
					if @temp < 10
						begin
							set @ID = 'HDT'+ '000'+Cast(@temp as varchar(1))
							insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
						end
					else if @temp < 100
						begin
							set @ID = 'HDT'+ '00'+Cast(@temp as varchar(2))
							insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
						end
					else if @temp < 1000
						begin
							set @ID = 'HDT'+ '0'+Cast(@temp as varchar(3))
							insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
						end
					else
						begin
							set @ID = 'HDT'+Cast(@temp as varchar(4))
							insert into HD_Thuoc(ID,STT,Ten_thuoc,So_luong,Ghi_chu) values(@ID,@STT,@Ten_thuoc,@So_luong,@Ghi_chu)
						end
				end
		end	
    -- Cập nhật Thanh_tien trong bảng HD_Thuoc
    UPDATE hd
    SET Thanh_tien = hd.So_luong * t.Gia_ban
    FROM HD_Thuoc hd
    INNER JOIN Thuoc t ON hd.Ten_thuoc = t.Ten_thuoc
    WHERE hd.ID = @ID

    -- Trừ đi So_luong trong bảng Thuoc
    UPDATE t
    SET So_luong = t.So_luong - @So_luong
    FROM Thuoc t
    WHERE t.Ten_thuoc = @Ten_thuoc
END
GO
/****** Object:  StoredProcedure [dbo].[Them_nguoi_kham]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Them_nguoi_kham] @Ngay date, @Ca int, @Ma_benh_nhan varchar(12),@Ma_le_tan varchar(10),@Ma_bac_si varchar(10)
AS
BEGIN
	Declare @STT varchar(15),@temp varchar(15)
	if( select count(*) from Nguoi_kham where @Ngay =Ngay and @Ca = Ca )=0
		begin
			set @STT = dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+ '01'
			insert into Nguoi_kham values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_le_tan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
		end
	else 
		begin

			select TOP 1 @temp = STT from Nguoi_kham where  @Ngay =Ngay and @Ca = Ca order by STT desc
				set @temp = cast(right(@temp,2) as int)
				set @temp = @temp +1
				if @temp < 10
					begin
						set @STT =  dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+ '0'+Cast(@temp as varchar(1))
						insert into Nguoi_kham values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_le_tan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
					end
				else
					begin
						set @STT =  dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+Cast(@temp as varchar(2))
						insert into Nguoi_kham values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_le_tan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
					end
		end
END
GO
/****** Object:  StoredProcedure [dbo].[Them_nguoi_kham_bac_si]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Them_nguoi_kham_bac_si] @Ngay date, @Ca int, @Ma_benh_nhan varchar(12),@Ma_bac_si varchar(10)
AS
BEGIN
	Declare @STT varchar(15),@temp varchar(15)
	if( select count(*) from Nguoi_kham where @Ngay =Ngay and @Ca = Ca )=0
		begin
			set @STT = dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+ '01'
			insert into Nguoi_kham(STT,Ngay,Ca,Ma_benh_nhan,Ma_bac_si,Trang_thai,Ghi_chu) values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
		end
	else 
		begin

			select TOP 1 @temp = STT from Nguoi_kham where  @Ngay =Ngay and @Ca = Ca order by STT desc
				set @temp = cast(right(@temp,2) as int)
				set @temp = @temp +1
				if @temp < 10
					begin
						set @STT =  dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+ '0'+Cast(@temp as varchar(1))
			insert into Nguoi_kham(STT,Ngay,Ca,Ma_benh_nhan,Ma_bac_si,Trang_thai,Ghi_chu) values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
					end
				else
					begin
						set @STT =  dbo.Tao_ngay(@Ngay) + 'Ca'+Cast(@Ca as varchar(1))+Cast(@temp as varchar(2))
			insert into Nguoi_kham(STT,Ngay,Ca,Ma_benh_nhan,Ma_bac_si,Trang_thai,Ghi_chu) values(@STT,@Ngay,@Ca,@Ma_benh_nhan,@Ma_bac_si,N'Chưa tiếp nhận',NULL)
					end
		end
END
GO
/****** Object:  StoredProcedure [dbo].[Them_Nhan_Vien]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--THÊM NHÂN VIÊN
CREATE PROC [dbo].[Them_Nhan_Vien] @Ho NVARCHAR(50),@Ten NVARCHAR(50), @Gioi_tinh NVARCHAR(3),@email varchar(50),@Ngay_sinh DATE,@Que_quan NVARCHAR(30),@CCCD NVARCHAR(12),@Maluong varchar(10)
AS
begin
	Declare @Ma_nhan_vien varchar(10),@stt int,@temp varchar(10)
	if( (select count(*) from Nguoi_dung where Maluong = @Maluong)=0)
		begin
			set @Ma_nhan_vien = @Maluong +'01' 
			insert into Nguoi_dung values(@Ma_nhan_vien,@Ho,@Ten,@Gioi_tinh,@Ngay_sinh,@email,@Que_quan,@CCCD,@Maluong,1)
			declare @Username varchar(30), @Password VARBINARY(64), @mixName varchar(30)
			set @Username = @Ma_nhan_vien
			set @Password = dbo.HashPassword(@CCCD)
			insert into Tai_khoan values(@Username,@Password,@Ma_nhan_vien,0)
			---
			if @Maluong = 'BSNC'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Nha chu')
				end
			if  @Maluong = 'BSNRVTP'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Nhổ răng và tiểu phẫu')
				end
				
			if  @Maluong = 'BSPH'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Phục hình')
				end
			if @Maluong = 'BSCRVNN'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Chữa răng và nội nha')
				end
			if @Maluong = 'BSRTE'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Răng trẻ em')
				end
			if @Maluong = 'BSTQ'
				begin
					insert into Bac_si values(@Ma_nhan_vien,N'Tổng quát')
				end
			if @Maluong = 'CPK'
				begin
					insert into Chu values(@Ma_nhan_vien)
				end
			if @Maluong = 'LT'
				begin
					insert into Le_tan values(@Ma_nhan_vien)
				end
			--
		end
	else
		begin
			select TOP 1 @temp = Ma_nhan_vien from Nguoi_dung where Maluong = @Maluong order by Ma_nhan_vien desc
			set @stt = cast(right(@temp,2) as int)
			set @stt = @stt +1
			if @stt < 10
					begin
						set @Ma_nhan_vien = @Maluong+ '0' + cast(@stt as varchar(3))
						insert into Nguoi_dung values(@Ma_nhan_vien,@Ho,@Ten,@Gioi_tinh,@Ngay_sinh,@email,@Que_quan,@CCCD,@Maluong,1)
						declare @Username1 varchar(30), @Password1 VARBINARY(64), @mixName1 varchar(30)
						set @Username1 = @Ma_nhan_vien
					set @Password1 = dbo.HashPassword(@CCCD)
					insert into Tai_khoan values(@Username1,@Password1,@Ma_nhan_vien,0)
						---
					if @Maluong = 'BSNC'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Nha chu')
						end
					if  @Maluong = 'BSNRVTP'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Nhổ răng và tiểu phẫu')
						end
				
					if  @Maluong = 'BSPH'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Phục hình')
						end
					if @Maluong = 'BSCRVNN'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Chữa răng và nội nha')
						end
					if @Maluong = 'BSRTE'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Răng trẻ em')
						end
					if @Maluong = 'BSTQ'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Tổng quát')
						end
					if @Maluong = 'CPK'
						begin
							insert into Chu values(@Ma_nhan_vien)
						end
					if @Maluong = 'LT'
						begin
							insert into Le_tan values(@Ma_nhan_vien)
						end
			--
				end
			else
				begin
					set @Ma_nhan_vien = @Maluong + cast(@stt as varchar(3))
					insert into Nguoi_dung values(@Ma_nhan_vien,@Ho,@Ten,@Gioi_tinh,@Ngay_sinh,@email,@Que_quan,@CCCD,@Maluong,1)
					declare @Username2 varchar(30), @Password2 VARBINARY(64), @mixName2 varchar(30)
					set @Username2 = @Ma_nhan_vien
					set @Password2 = dbo.HashPassword(@CCCD)
					insert into Tai_khoan values(@Username2,@Password2,@Ma_nhan_vien,0)
					---
					if @Maluong = 'BSNC'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Nha chu')
						end
					if  @Maluong = 'BSNRVTP'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Nhổ răng và tiểu phẫu')
						end
				
					if  @Maluong = 'BSPH'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Phục hình')
						end
					if @Maluong = 'BSCRVNN'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Chữa răng và nội nha')
						end
					if @Maluong = 'BSRTE'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Răng trẻ em')
						end
					if @Maluong = 'BSTQ'
						begin
							insert into Bac_si values(@Ma_nhan_vien,N'Tổng quát')
						end
					if @Maluong = 'CPK'
						begin
							insert into Chu values(@Ma_nhan_vien)
						end
					if @Maluong = 'LT'
						begin
							insert into Le_tan values(@Ma_nhan_vien)
						end
			--
				end
		end
end
GO
/****** Object:  StoredProcedure [dbo].[ThemBenhNhan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThemBenhNhan]
    @CCCD NVARCHAR(12),
    @Ho NVARCHAR(50),
    @Ten NVARCHAR(50),
    @GioiTinh NVARCHAR(3),
    @NgaySinh DATETIME,
    @DiaChi NVARCHAR(100),
    @NgheNghiep NVARCHAR(50),
    @SoDienThoai NVARCHAR(15)
AS
BEGIN
    DECLARE @MaBN VARCHAR(12)
    DECLARE @SoBn INT
    
    SET @SoBn = ISNULL((SELECT MAX(CAST(RIGHT(MaBN, 4) AS INT)) FROM Benh_nhan), 0) + 1
    
    SET @MaBN = CONVERT(VARCHAR(8), GETDATE(), 112) + RIGHT('000' + CAST(@SoBn AS VARCHAR(4)), 4)

    INSERT INTO Benh_nhan (MaBN, CCCD, Ho, Ten, Gioi_tinh, NgaySinh, Dia_chi, Nghe_nghiep, So_dien_thoai)
    VALUES (@MaBN, @CCCD, @Ho, @Ten, @GioiTinh, @NgaySinh, @DiaChi, @NgheNghiep, @SoDienThoai)
END
GO
/****** Object:  StoredProcedure [dbo].[ThemCongViec]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThemCongViec] 
  @Ngay date,
  @Ma_bac_si VARCHAR(10),
  @Ca INT
AS
BEGIN
  -- Thêm công việc mới
  INSERT INTO Lam_viec (Ngay, Ma_bac_si, Ca, Diemdanh)
  VALUES (@Ngay, @Ma_bac_si, @Ca, N'Chưa điểm danh');
END;
GO
/****** Object:  StoredProcedure [dbo].[ThemDichVu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThemDichVu]
    @Ten_dich_vu NVARCHAR(50),
    @Don_vi_tinh NVARCHAR(15),
    @Don_gia FLOAT,
    @Ghi_chu NVARCHAR(150),
    @Ten_danh_muc NVARCHAR(50)
AS
BEGIN
    -- Insert new row into Dich_vu table
    INSERT INTO Dich_vu (Ten_dich_vu, Don_vi_tinh, Don_gia, Ghi_chu, Ten_danh_muc)
    VALUES (@Ten_dich_vu, @Don_vi_tinh, @Don_gia, @Ghi_chu, @Ten_danh_muc);
END;
GO
/****** Object:  StoredProcedure [dbo].[ThemDungCu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThemDungCu]
    @Ten_dung_cu NVARCHAR(30),
    @Mau_sac NVARCHAR(15),
    @Kich_co FLOAT,
    @DVT NVARCHAR(15),
    @Gia FLOAT,
    @So_luong INT,
    @Ghi_chu NVARCHAR(150),
    @Loai NVARCHAR(30)
AS
BEGIN

    INSERT INTO Vat_lieu (Ten_dung_cu, Mau_sac, Kich_co, DVT, Gia, So_luong, Ghi_chu, Loai)
    VALUES (@Ten_dung_cu, @Mau_sac, @Kich_co, @DVT, @Gia, @So_luong, @Ghi_chu, @Loai);
END;
GO
/****** Object:  StoredProcedure [dbo].[ThemThuoc]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThemThuoc]
    @Ten_thuoc NVARCHAR(30),
    @DVT NVARCHAR(15),
    @So_luong INT,
    @Gia_ban FLOAT,
    @Ham_luong NVARCHAR(10),
    @Ghi_chu NVARCHAR(150),
    @Ten_loai NVARCHAR(30)
AS
BEGIN
    INSERT INTO Thuoc (Ten_thuoc, DVT, So_luong, Gia_ban, Ham_luong, Ghi_chu, Ten_loai)
    VALUES (@Ten_thuoc, @DVT, @So_luong, @Gia_ban, @Ham_luong, @Ghi_chu, @Ten_loai);
END;
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTheoNam]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Thủ tục lưu trữ thống kê theo năm
CREATE PROCEDURE [dbo].[ThongKeTheoNam] @nam int
AS
BEGIN
    SELECT 
        YEAR(Gio) AS Khoang,
        SUM(Tongtien) AS TongThu
    FROM 
        Thanh_toan
    WHERE 
        Tinhtrang = N'Đã thanh toán' and YEAR(Gio) = @nam
    GROUP BY 
        YEAR(Gio)
    ORDER BY 
        Khoang;
END;
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTheoQuy]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThongKeTheoQuy]  @nam int
AS
BEGIN
    SELECT 
        DATEPART(QUARTER, Gio) AS Khoang,
        SUM(Tongtien) AS TongThu
    FROM 
        Thanh_toan
    WHERE 
        Tinhtrang = N'Đã thanh toán'  and YEAR(Gio) = @nam
    GROUP BY 
        DATEPART(QUARTER, Gio)
    ORDER BY 
        Khoang;
END;
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTheoThang]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Thủ tục lưu trữ thống kê theo tháng
CREATE PROCEDURE [dbo].[ThongKeTheoThang]  @nam int
AS
BEGIN
    SELECT 
        MONTH(Gio) AS Khoang,
        SUM(Tongtien) AS TongThu
    FROM 
        Thanh_toan
    WHERE 
        Tinhtrang = N'Đã thanh toán'  and YEAR(Gio) = @nam
    GROUP BY 
        MONTH(Gio)
    ORDER BY 
        Khoang;
END;
GO
/****** Object:  StoredProcedure [dbo].[TongTienHD]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[TongTienHD] @STT varchar(15)
as
begin
	declare @Tong float
	SELECT @Tong=COALESCE(th.Tong, 0) + COALESCE(dv.Tong, 0) 
	FROM Nguoi_kham nk 
	LEFT JOIN TongHDT th ON nk.STT = th.STT
	LEFT JOIN TongHDDV dv ON nk.STT = dv.STT
	where nk.STT = @STT
	update Nguoi_kham set Trang_thai = N'Đã điều trị' where STT = @STT
	if(select count(*) from Thanh_toan)=0
		begin
			declare @ID varchar(30)
			set @ID = 'HD0001'
			insert into Thanh_toan(ID,STT,Gio,Tongtien,Tinhtrang) values (@ID,@STT,NULL,@Tong,N'Chưa thanh toán')
		end
	else
		begin
			declare @ID1 varchar(30)
			declare @temp varchar(30),@thuTu int
			select Top 1 @temp =ID from Thanh_toan order by ID desc
			set @thuTu = cast(right(@temp,4) as int)
			set @thuTu = @thuTu +1
			if @thuTu<10
				begin
					set @ID1 = 'HD'+'000'+cast(@thuTu as varchar(1))
					insert into Thanh_toan(ID,STT,Gio,Tongtien,Tinhtrang) values(@ID1,@STT,NULL,@Tong,N'Chưa thanh toán')
				end
			else if @thuTu<100
				begin
					set @ID1 = 'HD'+'00'+cast(@thuTu as varchar(2))
					insert into Thanh_toan(ID,STT,Gio,Tongtien,Tinhtrang) values(@ID1,@STT,NULL,@Tong,N'Chưa thanh toán')
				end
			else if @thuTu<1000
				begin
					set @ID1 = 'HD'+'0'+cast(@thuTu as varchar(3)	)
					insert into Thanh_toan(ID,STT,Gio,Tongtien,Tinhtrang) values(@ID1,@STT,NULL,@Tong,N'Chưa thanh toán')
				end
			else
				begin
					set @ID1 = 'HD'+cast(@thuTu as varchar(4))
					insert into Thanh_toan(ID,STT,Gio,Tongtien,Tinhtrang) values(@ID,@STT,NULL,@Tong,N'Chưa thanh toán')
				end
		end
end
GO
/****** Object:  StoredProcedure [dbo].[xacNhanthanhToan]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[xacNhanthanhToan] @ID varchar(30),@Hinhthuc nvarchar(30), @Tinhtrang nvarchar(30), @Gio datetime 
AS 
BEGIN
	UPDATE Thanh_toan
	set Tinhtrang = @Tinhtrang, Gio = @Gio, Hinhthuc = @Hinhthuc
	where ID = @ID
	if @Tinhtrang = N'Đã thanh toán'
		begin
			---Tiền bonus
			declare @Tongtien float, @STT varchar(15), @bonus float, @ma int
			--
			select @STT = tt.STT from Thanh_toan tt ,Nguoi_kham nk where tt.STT = nk.STT and tt.ID =@ID
			--
			select @Tongtien = Tong from TongHDDV where STT = @STT

			set @bonus = @Tongtien  * 0.3
			IF(Select count(*) from Luong_nhan_them) =0	
				begin
					set @ma = 1
					insert into Luong_nhan_them values(@ma,@bonus,@Gio,@ID)
				end
			else
				begin
					select Top 1 @ma = Ma from Luong_nhan_them order by Ma desc
					set @ma = @ma +1
					insert into Luong_nhan_them values(@ma,@bonus,@Gio,@ID)
				end
		end
END
GO
/****** Object:  StoredProcedure [dbo].[xoa_chiTieuDungCu]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[xoa_chiTieuDungCu] @STT varchar(15),@Ten_dung_cu nvarchar(50)
AS
BEGIN
    --Check loại dụng cụ gì 
    Declare @check nvarchar(50),@So_luong int
    select @check = loai from Vat_lieu where @Ten_dung_cu = Ten_dung_cu
    select @So_luong = So_luong from Chi_tieu_dung_cu where @STT = STT and @Ten_dung_cu =Ten_dung_cu
    if @check = N'Vật liệu tiêu hao'
        begin
            update Vat_lieu 
            set So_luong  = So_luong + @So_luong
            where @Ten_dung_cu = Ten_dung_cu

            delete from Chi_tieu_dung_cu
            where @STT = STT and @Ten_dung_cu =Ten_dung_cu
        end
END
GO
/****** Object:  StoredProcedure [dbo].[Xoa_Nhan_Vien]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--XÓA NHÂN VIÊN
CREATE PROC [dbo].[Xoa_Nhan_Vien] 
    @Ma_nhan_vien VARCHAR(10)
AS
BEGIN
    -- Update Hoatdong column to 0 for the specified Ma_nhan_vien
    UPDATE Nguoi_dung
    SET Hoatdong = 0
    WHERE Ma_nhan_vien = @Ma_nhan_vien;
END
GO
/****** Object:  Trigger [dbo].[Update_Thanh_tien]    Script Date: 5/13/2024 11:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Update_Thanh_tien]
ON [dbo].[HD_Dich_vu]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(So_luong)
    BEGIN
        UPDATE hd
        SET Thanh_tien = d.Don_gia * i.So_luong
        FROM HD_Dich_vu hd
        INNER JOIN inserted i ON hd.ID = i.ID AND hd.STT = i.STT AND hd.Ten_dich_vu = i.Ten_dich_vu
        INNER JOIN Dich_vu d ON hd.Ten_dich_vu = d.Ten_dich_vu
    END
END;
GO
ALTER TABLE [dbo].[HD_Dich_vu] ENABLE TRIGGER [Update_Thanh_tien]
GO
/****** Object:  Trigger [dbo].[update_thanhTienDichVu]    Script Date: 5/13/2024 11:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[update_thanhTienDichVu]
ON [dbo].[HD_Dich_vu]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE hd
        SET Thanh_tien = i.So_luong * t.Don_gia
        FROM HD_Dich_vu hd
        INNER JOIN inserted i ON hd.ID = i.ID AND hd.Ten_dich_vu = i.Ten_dich_vu
        INNER JOIN Dich_vu t ON hd.Ten_dich_vu = t.Ten_dich_vu;
    END
END;
GO
ALTER TABLE [dbo].[HD_Dich_vu] ENABLE TRIGGER [update_thanhTienDichVu]
GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaKhoa] SET  READ_WRITE 
GO
