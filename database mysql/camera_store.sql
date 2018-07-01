-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 29, 2018 at 06:27 AM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `camera_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `ct_hoa_don`
--

DROP TABLE IF EXISTS `ct_hoa_don`;
CREATE TABLE IF NOT EXISTS `ct_hoa_don` (
  `STT` int(11) NOT NULL AUTO_INCREMENT,
  `Ma_hoa_don` int(11) NOT NULL,
  `Ma_so` int(11) NOT NULL,
  `So_luong` int(11) NOT NULL,
  PRIMARY KEY (`STT`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ct_hoa_don`
--

INSERT INTO `ct_hoa_don` (`STT`, `Ma_hoa_don`, `Ma_so`, `So_luong`) VALUES
(1, 8, 7, 1),
(2, 8, 15, 1),
(3, 9, 7, 1),
(4, 9, 15, 1),
(5, 9, 23, 2),
(6, 10, 15, 4),
(8, 12, 1, 1),
(9, 13, 1, 2),
(10, 14, 1, 1),
(11, 15, 35, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hang`
--

DROP TABLE IF EXISTS `hang`;
CREATE TABLE IF NOT EXISTS `hang` (
  `Ma_hang` int(11) NOT NULL AUTO_INCREMENT,
  `Ten_hang` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Ma_hang`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hang`
--

INSERT INTO `hang` (`Ma_hang`, `Ten_hang`) VALUES
(1, 'Canon'),
(2, 'Fujifilm'),
(3, 'Nikon'),
(4, 'Olympus'),
(10, 'Sony');

-- --------------------------------------------------------

--
-- Table structure for table `hoa_don`
--

DROP TABLE IF EXISTS `hoa_don`;
CREATE TABLE IF NOT EXISTS `hoa_don` (
  `Ma_hoa_don` int(11) NOT NULL AUTO_INCREMENT,
  `Ngay_dat_hang` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tong_tien` int(11) NOT NULL,
  `Ma_khach_hang` int(11) NOT NULL,
  `Trang_thai` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Ma_hoa_don`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hoa_don`
--

INSERT INTO `hoa_don` (`Ma_hoa_don`, `Ngay_dat_hang`, `Tong_tien`, `Ma_khach_hang`, `Trang_thai`) VALUES
(14, '2018-06-24 09:56:13', 9500000, 1, 0),
(13, '2018-06-24 09:54:52', 19000000, 1, 0),
(12, '2018-06-24 09:54:31', 9500000, 1, 0),
(8, '2018-05-31 16:28:16', 12980000, 1, 0),
(9, '2018-05-31 16:29:31', 37300000, 1, 0),
(10, '2018-05-31 16:36:48', 7960000, 1, 1),
(15, '2018-06-25 23:16:01', 35490000, 15, 2);

-- --------------------------------------------------------

--
-- Table structure for table `khach_hang`
--

DROP TABLE IF EXISTS `khach_hang`;
CREATE TABLE IF NOT EXISTS `khach_hang` (
  `Ma_khach_hang` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Ten_khach_hang` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Gioi_tinh` tinyint(1) NOT NULL,
  `Ngay_sinh` date NOT NULL,
  `Mat_khau` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `So_dien_thoai` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Dia_chi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Ma_khach_hang`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `khach_hang`
--

INSERT INTO `khach_hang` (`Ma_khach_hang`, `Email`, `Ten_khach_hang`, `Gioi_tinh`, `Ngay_sinh`, `Mat_khau`, `So_dien_thoai`, `Dia_chi`) VALUES
(15, 'phamlethientam@gmail.com', 'Lê Thị Bưởi', 1, '1997-09-02', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '01633208578', '321 gt'),
(1, 'thientam@gmail.com', 'Thiện Tâm', 0, '1995-01-12', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '01633208999', '123 Nguyễn Văn Lê Q7');

-- --------------------------------------------------------

--
-- Table structure for table `loai`
--

DROP TABLE IF EXISTS `loai`;
CREATE TABLE IF NOT EXISTS `loai` (
  `Ma_loai` int(11) NOT NULL AUTO_INCREMENT,
  `Ten_loai` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Ma_loai`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `loai`
--

INSERT INTO `loai` (`Ma_loai`, `Ten_loai`) VALUES
(1, 'Travel'),
(2, 'Mirrorless'),
(3, 'DSLR');

-- --------------------------------------------------------

--
-- Table structure for table `may_anh`
--

DROP TABLE IF EXISTS `may_anh`;
CREATE TABLE IF NOT EXISTS `may_anh` (
  `Ma_so` int(11) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Hinh_anh` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Don_gia_ban` int(11) NOT NULL,
  `Hang` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Loai` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Mo_ta` text COLLATE utf8_unicode_ci NOT NULL,
  `So_luot_xem` int(11) NOT NULL DEFAULT '0',
  `So_luong_ban` int(11) NOT NULL DEFAULT '0',
  `Ngay_tiep_nhan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Ma_so`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `may_anh`
--

INSERT INTO `may_anh` (`Ma_so`, `Ten`, `Hinh_anh`, `Don_gia_ban`, `Hang`, `Loai`, `Mo_ta`, `So_luot_xem`, `So_luong_ban`, `Ngay_tiep_nhan`) VALUES
(1, 'Canon PowerShot G1', 'CANON_1.jpg', 9500000, 'Canon', 'Travel', 'Khẩu độ tối đa: f / 2,8 (W), f / 5,6 (T). Tốc độ màn trập: 30-1 / 2000 giây. ISO: 100-3200 (ở chế độ Tự động). Quang học 3x. Tự hẹn giờ: Tắt, 2 giây, 10 giây, Tùy chỉnh. Độ phân giải: 24,2 Megapixel. APS-C CMOS (tỷ lệ co 3: 2). Zoom kỹ thuật số 4x và 12x. Bộ ổn định hình ảnh quang học. Điều khiển không dây: Wi-Fi/ NFC/ Bluetooth. Dãy đèn flash: 1.6 ft (50cm) - 29.5 ft (9.0m) (W), 1.6 ft (50cm) - 14.8 ft (4.5m) (T)', 22, 6, '2018-05-02 00:00:00'),
(2, 'Canon PowerShot SX430', 'CANON_2.jpg', 13500000, 'Canon', 'Travel', 'Zoom quang học 45x (24 - 1080 mm) với ZoomPlus 90x. Bộ xử lý DIGIC 4+. Cảm biến 20.0 megapixel. Hệ thống Ổn định hình ảnh thông minh. Quay video 1280 x 720. Wi-Fi & NFC', 5, 1, '2018-05-01 00:00:00'),
(3, 'Canon PCanon IXUS 185', 'CANON_3.jpg', 2350000, 'Canon', 'Travel', 'Ống kính 20 megapixel. Zoom quang học 8x (28 224) / ZoomPlus 16x. Bộ xử lý hình ảnh hình ảnh DIGIC 4+. Ổn định hình ảnh kỹ thuật số IS. ISO 100 – ISO800. Quay video 1280 x 720', 11, 10, '2018-04-11 00:00:00'),
(4, 'Canon PowerShot SX540', 'CANON_4.jpg', 9200000, 'Canon', 'Travel', 'Cảm biến CMOS 20.3 megapixel. Bộ xử lý hình ảnh Digic 6. Màn hình 3.0 inch 461k-Dot. Zoom Quang học 50x (24mm – 1200mm trên full-frame). Zoomplus lên tới 100x. Độ nhạy sáng ISO 100-1600, mở rộng 3200. Tốc độ màn chập 15 – 1/2000 giây. Tốc độ chụp 5.9 ảnh/giây. Quay phim Full HD 1920 x 1080. Tích hợp Wifi và NFC. Sử dụng Pin NB-6LH', 13, 6, '2018-04-01 00:00:00'),
(5, 'Canon EOS M50', 'CANON_5.jpg', 19900000, 'Canon', 'Mirrorless', 'Độ phân giải 24,1 Megapixel APS-C CMOS. Dual pixel CMOS AF. DIGIC 8 (bộ xử lý hình ảnh mới nhất). Video 4K. ISO: 100-25600 (mở rộng ISO: 51200). Chụp Liên tục: Lên đến 10 khung hình/giây (ở servo AF: lên đến 7,4 khung hình/giây). Màn hình: EVF: 2,36 điểm ảnh. Wi-Fi · Bluetooth · Đã cài đặt NFC. Hỗ trợ định dạng RAW CR3 thế hệ tiếp theo và định dạng nén C-RAW mới. Định dạng C-RAW có kích thước tệp nhỏ hơn 40% so với RAW thông thường. Ống kính STM EF-M 15-45mm f/3.5-6.3 IS', 15, 5, '2018-05-01 00:00:00'),
(6, 'Canon EOS M100', 'CANON_6.jpg', 12900000, 'Canon', 'Mirrorless', 'Cảm biến: CMOS APS-C (22.3 X 14.9 mm). Độ phân giải: 24.2 Mp. Kích thước ảnh: 6000 x 4000. Bộ xử lý: DIGIC 7. IOS: Auto, 100 – 25600. Số điểm lấy nét: 49. Ngàm : Canon EF-M. Màn hình LCD: 3” lật 180 độ. Cảm ứng: Có. Tốc độ màn trập: 30s – 1/4000s. Flash tích hợp: Có. Tốc độ đồng bộ flash: 1/200 sec. Tốc độ chụp liên tục: 6.1 fps. Quay phim: 1080 tại 60p', 20, 10, '2018-05-03 00:00:00'),
(7, 'Canon EOS M3', 'CANON_7.jpg', 10990000, 'Canon', 'Mirrorless', 'Cảm biến CMOS APS-C 24.2MP. Cảm biến hình ảnh DIGIC 6. Màn hình cảm ứng LCD 3.0\' 1.040k-Dot. Quay phim Full HD 1080p tại 24/24/30fps. Tích hợp kết nối NFC và Wifi. Công nghệ lấy nét Hybrid CMOS AF với 49 điểm. ISO 100-12800, mở rộng 25600. Ống kính EF-M 15-45mm F/3.5-6.3 IS STM', 35, 23, '2018-05-08 00:00:00'),
(8, 'Canon EOS 3000D', 'CANON_8.jpg', 8900000, 'Canon', 'DSLR', 'Cảm biến CMOS APS-C 18 megapixel. Bộ xử lý hình ảnh SIGIC 4+. Quay phim Full HD . Lấy nét tự động 9 điểm với 1 điểm lấy nét tự động chữ thập chính giữa. ISO tiêu chuẩn 100 - 6400 (có thể tăng tới 12800). Hỗ trợ kết nối wifi. Chụp liên tục 3 frame / s. LCD 2,7inch, 230k dots', 38, 22, '2018-05-07 00:00:00'),
(9, 'Fujifilm FinePix XP130 (Blue)', 'FUJIFILM_1.jpg', 3890000, 'Fujifilm', 'Travel', 'Cảm biến BSI-CMOS độ phân giải 16.4 MP. Kết nối Bluetooth. Màn hình LCD 3 inch 920K điểm. Hệ thống lấy nét EYEAF. Thước cân điện tử. Chống nước 20m, chống sốc 1.70m. Chịu lạnh -10 Độ CỐng kính zoom quang học 5x với gốc rộng 28-140mm F3.9/4.9. Có chống rung quang học. Có Wifi để chia sẻ qua các thiết bị khácQuay phim Full HD 60fps, Quay slow motion 480fps11 chế độ chụp có sẵn. Chụp ảnh HDR và Panorama 360°Pin tương thích NP45', 43, 4, '2018-05-05 00:00:00'),
(10, 'Fujifilm FinePix XP130 (Lime)', 'FUJIFILM_2.jpg', 3890000, 'Fujifilm', 'Travel', 'Cảm biến BSI-CMOS độ phân giải 16.4 MP. Kết nối Bluetooth. Màn hình LCD 3 inch 920K điểm. Hệ thống lấy nét EYEAF. Thước cân điện tử. Chống nước 20m, chống sốc 1.70m. Chịu lạnh -10 Độ CỐng kính zoom quang học 5x với gốc rộng 28-140mm F3.9/4.9. Có chống rung quang học. Có Wifi để chia sẻ qua các thiết bị khácQuay phim Full HD 60fps, Quay slow motion 480fps11 chế độ chụp có sẵn. Chụp ảnh HDR và Panorama 360°Pin tương thích NP45', 10, 8, '2018-05-04 00:00:00'),
(11, 'Fujifilm FinePix XP130 (Silver)', 'FUJIFILM_3.jpg', 3890000, 'Fujifilm', 'Travel', 'Cảm biến BSI-CMOS độ phân giải 16.4 MP. Kết nối Bluetooth. Màn hình LCD 3 inch 920K điểm. Hệ thống lấy nét EYEAF. Thước cân điện tử. Chống nước 20m, chống sốc 1.70m. Chịu lạnh -10 Độ CỐng kính zoom quang học 5x với gốc rộng 28-140mm F3.9/4.9. Có chống rung quang học. Có Wifi để chia sẻ qua các thiết bị khácQuay phim Full HD 60fps, Quay slow motion 480fps11 chế độ chụp có sẵn. Chụp ảnh HDR và Panorama 360°Pin tương thích NP45', 7, 3, '2018-04-26 00:00:00'),
(12, 'Fujifilm FinePix XP130 (Yellow)', 'FUJIFILM_4.jpg', 3890000, 'Fujifilm', 'Mirrorless', 'Cảm biến BSI-CMOS độ phân giải 16.4 MP. Kết nối Bluetooth. Màn hình LCD 3 inch 920K điểm. Hệ thống lấy nét EYEAF. Thước cân điện tử. Chống nước 20m, chống sốc 1.70m. Chịu lạnh -10 Độ CỐng kính zoom quang học 5x với gốc rộng 28-140mm F3.9/4.9. Có chống rung quang học. Có Wifi để chia sẻ qua các thiết bị khácQuay phim Full HD 60fps, Quay slow motion 480fps11 chế độ chụp có sẵn. Chụp ảnh HDR và Panorama 360°Pin tương thích NP45', 16, 4, '2018-03-16 00:00:00'),
(13, 'Fujifilm instax mini 9 (Pink)', 'FUJIFILM_5.jpg', 1990000, 'Fujifilm', 'Mirrorless', 'In ảnh tức thì. Kính ngắm quang học với Target Spot. Tích hợp gương tự sướng trên ống kính. Tích hợp đèn flash và chế độ Auto Expose Mode. Điều chỉnh độ sáng bằng tay. Chế độ Hi-Key. Ống kính Fujinon 60mm F/12.7.', 14, 7, '2018-03-22 00:00:00'),
(14, 'Fujifilm instax mini 9 (Blue)', 'FUJIFILM_6.jpg', 1990000, 'Fujifilm', 'Mirrorless', 'In ảnh tức thì. Kính ngắm quang học với Target Spot. Tích hợp gương tự sướng trên ống kính. Tích hợp đèn flash và chế độ Auto Expose Mode. Điều chỉnh độ sáng bằng tay. Chế độ Hi-Key. Ống kính Fujinon 60mm F/12.7.', 24, 2, '2018-05-04 00:00:00'),
(15, 'Fujifilm instax mini 9 (Green)', 'FUJIFILM_7.jpg', 1990000, 'Fujifilm', 'DSLR', 'In ảnh tức thì. Kính ngắm quang học với Target Spot. Tích hợp gương tự sướng trên ống kính. Tích hợp đèn flash và chế độ Auto Expose Mode. Điều chỉnh độ sáng bằng tay. Chế độ Hi-Key. Ống kính Fujinon 60mm F/12.7.', 25, 16, '2018-05-09 00:00:00'),
(16, 'Fujifilm X-H1', 'FUJIFILM_8.jpg', 54990000, 'Fujifilm', 'DSLR', 'Cảm biến X-Trans CMOS III 24.3MP và chip xử lý ảnh X-Processor Pro. Chống rung thân máy 5 trục, hiệu quả 5.5stop. Màn hình EVF lớn với công nghệ OLED, độ phân giải cao 3.69 MP. Thiết kế chống bụi, chống nước, chống đóng băng ở -10°C. ISO100/125/160/25600/51200. Màn hình LCD 3.0 inch, 1.04MP, cảm ứng, xoay lật. Chụp liên tiếp lên đến 14.0 hình/giây. Quay video 4K (yêu cầu dùng thẻ U3 hoặc cao hơn). FullHD 60p/30p/24p. Kết nối: Wiffi, Bluetooth® Ver. 4.0 LE. Kết nối có dây: Micro HDMI, MicroUSB 3.0', 23, 19, '2018-04-27 00:00:00'),
(17, 'Nikon COOLPIX P900', 'NIKON_1.jpg', 11990000, 'Nikon', 'Travel', 'Cảm biến CMOS 16-Megapixel. Tiêu cự tương đương 24-2000mm. Zoom quang học 83x. Màn hình LCD 3\' xoay lật đa hướng. Kính ngắm điện tử. Full HD 1080 / 60p video. Tích hợp Wi-Fi, NFC, và GPS. Kích thước 139,5 x 103,2 x 137,4 mm. Trọng lượng 899g', 57, 11, '2018-05-01 00:00:00'),
(18, 'Nikon Coolpix S3600', 'NIKON_2.jpg', 1800000, 'Nikon', 'Travel', 'Cảm biến hình ảnh CCD 20.1MP. Màn hình LCD chống phản chiếu 2.7\' 230K Dot. Tự động lấy nét, chụp chân dung thông minh. Quay video HD 720/30/25p. Ổn định hình ảnh quang học. ISO 80-3200, 18 Scene Mode. Ưu tiên lấy nét tự động khuôn mặt, làm mềm da. Tương thích với thẻ nhớ SD/ SDHC/ SDXC. Cung cấp phần mềm ViewNX 2. Tích hợp ống kính Nikon zoom tiêu cự tương đương 25-200mm (35mm)', 46, 5, '2018-04-25 00:00:00'),
(19, 'Nikon Coolpix L840', 'NIKON_3.jpg', 5000000, 'Nikon', 'Travel', 'Cảm biến hình ảnh CMOS 16MP. Tiêu cự tương đương 22.5-855mm ( định dạng 35mm). Màn hình LCD 3\' với 921K Dot. Quay video Full HD 1080p 30fps. Tích hợp kết nối Wifi và NFC. Chức năng zoom Dynamic Fine 76x. ISO 6400 và tốc độ chụp 7.4fps. Chế độ Scene Auto Selector', 33, 2, '2018-03-31 00:00:00'),
(20, 'Nikon Coolpix S3700', 'NIKON_4.jpg', 3000000, 'Nikon', 'Mirrorless', 'Cảm biến CCD 1/2.3\' 20.1MP. Ống kính khẩu độ f/3.7-6.6. Tiêu cự 25-200mm (trên định dạng 35mm). Zoom quang học 8x (16x Dynamic Fine Zoom). Màn hình LCD 2.7\' 230k-Dot. Quay phim HD 720p. Có đến16 bối cảnh chụp. Kết nối Wi-Fi và NFC. Chụp ảnh liên tục 1.1 fps. ISO 80–1600, ISO 3200 (khả dụng khi sử dụng Chế độ tự động)', 15, 10, '2018-04-11 00:00:00'),
(21, 'Nikon D760', 'NIKON_5.jpg', 3940000, 'Nikon', 'Mirrorless', 'Bộ xử lý ảnh EXPEED 5 với 24 triệu điểm ảnh. Multi-CAM 20K 153-Point AF. ISO: 100-51200 (Extended NA). Hỗ trợ quay video 4K UHD/30fps.', 10, 6, '2018-04-03 00:00:00'),
(22, 'Nikon D500', 'NIKON_6.jpg', 3760000, 'Nikon', 'DSLR', 'Cảm biến CMOS 20.9MP DX format. Cảm biến hình ảnh mới EXPEED 5. Hệ thống lấy nét chuyên dụng được thiết kế lại mới hoàn toàn với 153 điểm lấy nét. Dãi ISO rộng: ISO 100 đến 51.200 (mở rộng từ ISO 50 đến ISO 1.640.000). Quay video 4K Ultra High Definition (UHD) với chống rung điện tử và công nghệ smooth auto ISO. Tích hợp công nghệ \'SnapBridge wireless communication\'. Chụp liên tục 10fps với buffer lên đến 200 tấm ảnh ở định dạng RAW. Màn hình cảm ứng LCD 3.2 inch', 55, 10, '2018-05-01 00:00:00'),
(23, 'Nikon D5', 'NIKON_7.jpg', 12160000, 'Nikon', 'DSLR', 'Cảm biến CMOS FX-Format 20.8MP. Bộ xử lý Expeed 5. Màn hình cảm ứng LCD 3.2\' 2.36m-Dot. Quay video 4K UHD tại 30fps. ISO 102.400 mở rộng 3.280.000. Tốc độ chụp hình liên tiếp 12fps', 20, 12, '2018-05-08 00:00:00'),
(24, 'Nikon D610', 'NIKON_8.jpg', 26490000, 'Nikon', 'DSLR', 'Cảm biến định dạng CMOS 24.3MP FX. Bộ xử lý hình ảnh EXPEED 3. Màn hình LCD 3,2 \'921k-Dot. Quay phim full HD 1080p thời gian 30 fps. Có Mic bên ngoài và tai nghe đầu vào. Chụp liên tục lên đến 6 fps. Độ nhạy mở rộng tới ISO 25600. Multi-CAM 4800 AF Sensor với 39 điểm. Flash gắn trong với chế độ Commander. Hỗ trợ adapter WU-1b không dây di động', 48, 13, '2018-04-26 00:00:00'),
(25, 'Olympus E-M10 Mark III (Black)', 'OLYMPUS_1.jpg', 5790000, 'Olympus', 'Mirrorless', 'Bộ cảm biến MOS Live Four Thirds 16.1MP. Bộ xử lý Dual-Core TruePic VIII Dual Quad. Hệ thống Micro Four Thirds. Khả năng quay phim 4K. ISO khả dụng tăng từ 1600 lên 6400. Kính ngắm điện tử 2.36m-Dot 1.23x. Màn hình cảm ứng LCD 3.0 \'1.04m. Cơ chế chống rung ảnh 5 trục. Hệ thống AF lấy nét 121 điểm. Lên đến 8,6 khung hình. Tích hợp Wi-Fi', 49, 5, '2018-04-11 00:00:00'),
(26, 'Olympus Pen E-PL8', 'OLYMPUS_2.jpg', 14690000, 'Olympus', 'Mirrorless', 'Cảm biến Live MOS 16.1MP. Bộ xử lý hình ảnh TruePic VII. Màn hình cảm ứng LCD 3\' 1.04m-Dot. Quay video Full HD tại 30fps. Tích hợp kết nối Wifi. Hệ thống lấy nét FAST 81 điểm với Small Target AF. Tốc độ chụp liên tục 8.5fps và ISO 25600. Hệ thống chống rung 3 trục VCM. Ống kính M.Zuiko 14-42mm F/3.5-5.6 II R', 62, 8, '2018-04-02 00:00:00'),
(27, 'Olympus OM-D E-M5 Mark II(Silver)', 'OLYMPUS_3.jpg', 31580000, 'Olympus', 'Mirrorless', 'Cảm biến 16MP Live MOS. Bộ xử lý hình ảnh: TruePic VII. Kính ngắm điện tử 2360k-Dot. Màn hình LCD 3.0\' Vari-Angle OLED. Dải ISO rộng 100-25600. Định dạng ảnh: JPEG, RAW, MPO. Hệ thống lấy nét tương phản 81 điểm. Tốc độ màn trập tối đa: 1/16000s. Quay video Full HD 1080p/60 fps. 40MP High Res Shot. Kết nối Wi-Fi; Chụp ảnh liên tục10 fps. Ổn định hình ảnh 5-Axis VCM', 52, 0, '2018-04-19 00:00:00'),
(28, 'Olympus PEN-F(Black)', 'OLYMPUS_4.jpg', 34690000, 'Olympus', 'Mirrorless', 'Cảm biến 20.3MP Live MOS. Bộ xử lý ảnh: TruePic VII. Hệ thống Micro Four Thirds. Kính ngắm điện tử OLED: 2.36m-Dot. Màn hính cảm ứng LCD: 3.0\' 1.037m-Dot. Quay video Full HD 1080p 60 fps. Chụp ảnh liên tục 10 fps. Quay Timelapse Video độ phân giải lên đến 4K. Hệ thống ổn định hình ảnh 5 trục. ISO 200-25600, có thể mở rộng ISO 80-25600. Chụp ảnh ở độ phân giải cực cao 50mp (High Res mode). Tích hợp HDMI, USB 2.0, Wi-Fi', 59, 13, '2018-04-13 00:00:00'),
(29, 'Olympus OM-D E-M1 Mark II', 'OLYMPUS_5.jpg', 44990000, 'Olympus', 'Mirrorless', 'Cảm biến 20.4MP Live MOS. Bộ xử lý hình ảnh TruePic VIII Dual Quad Core. Hệ thống Micro Four Thirds. Kính ngắm điện tử 2.36m-Dot LCD. Màn hình cảm ứng 3.0\' 1.04m-Dot Vari-Angle. Quay video DCI 4K/24p & UHD 4K/30p. Cảm biến ổn định hình ảnh 5-Axis. Chụp ảnh liên tục 15 fps. Độ nhạy sáng mở rộng ISO 25600', 27, 2, '2018-04-18 00:00:00'),
(30, 'Olympus E-M10 Mark III (Silver)', 'OLYMPUS_6.jpg', 5780000, 'Olympus', 'DSLR', 'Bộ cảm biến MOS Live Four Thirds 16.1MP. Bộ xử lý Dual-Core TruePic VIII Dual Quad. Hệ thống Micro Four Thirds. Khả năng quay phim 4K. ISO khả dụng tăng từ 1600 lên 6400. Kính ngắm điện tử 2.36m-Dot 1.23x. Màn hình cảm ứng LCD 3.0 \'1.04m. Cơ chế chống rung ảnh 5 trục. Hệ thống AF lấy nét 121 điểm. Lên đến 8,6 khung hình. Tích hợp Wi-Fi', 19, 3, '2018-04-09 00:00:00'),
(31, 'Olympus OM-D E-M5 Mark II (Balck)', 'OLYMPUS_7.jpg', 31580000, 'Olympus', 'DSLR', 'Cảm biến 16MP Live MOS. Bộ xử lý hình ảnh: TruePic VII. Kính ngắm điện tử 2360k-Dot. Màn hình LCD 3.0\' Vari-Angle OLED. Dải ISO rộng 100-25600. Định dạng ảnh: JPEG, RAW, MPO. Hệ thống lấy nét tương phản 81 điểm. Tốc độ màn trập tối đa: 1/16000s. Quay video Full HD 1080p/60 fps. 40MP High Res Shot. Kết nối Wi-Fi; Chụp ảnh liên tục10 fps. Ổn định hình ảnh 5-Axis VCM', 71, 13, '2018-04-27 00:00:00'),
(32, 'Olympus PEN-F(Silver)', 'OLYMPUS_8.jpg', 34690000, 'Olympus', 'DSLR', 'Cảm biến 20.3MP Live MOS. Bộ xử lý ảnh: TruePic VII. Hệ thống Micro Four Thirds. Kính ngắm điện tử OLED: 2.36m-Dot. Màn hính cảm ứng LCD: 3.0\' 1.037m-Dot. Quay video Full HD 1080p 60 fps. Chụp ảnh liên tục 10 fps. Quay Timelapse Video độ phân giải lên đến 4K. Hệ thống ổn định hình ảnh 5 trục. ISO 200-25600, có thể mở rộng ISO 80-25600. Chụp ảnh ở độ phân giải cực cao 50mp (High Res mode). Tích hợp HDMI, USB 2.0, Wi-Fi', 68, 5, '2018-04-12 00:00:00'),
(33, 'Sony Cyber-shot DSC-RX10', 'SONY_1.jpg', 39990000, 'Sony', 'Travel', 'Cảm biến: stacked CMOS Exmor RS. Kích thước 1\', 20.1 triệu điểm ảnh. Bộ xử lý BIONZ X. Lấy nét: 315 điểm theo pha, tốc độ 0,03 giây. Màn hình: LCD 3\' cảm ứng. Kính ngắm điện tử: OLED độ phân giải XGA. Phóng đại 0.70x. Tốc độ màn trập: 1/2.000 giây, tối đa 1/32.000 giây. Chụp liên tục tối đa 24 ảnh/giây, tối đa 249 tấm. ISO: 100 - 12.800, mở rộng 64 hoặc 80. Quay phim 4K 3.840 x 2.160 pixel. Quay phim Full HD: XAVC S 50 Mbps. Chụp hình 17MP khi quay phim. High Frame: 240 fps, 480 fps, 960 fps.', 54, 18, '2018-05-04 00:00:00'),
(34, 'Sony DSC WX100', 'SONY_2.jpg', 14990000, 'Sony', 'Travel', 'Màn hình 2.7inch. Độ phân giải 18.2MP. Zoom quang 10x. Cảm biến 18.2MP. Tự động lấy nét nhanh với High-speed Auto Focus. Zoom hình ảnh rõ nét 20x. 9 chế độ hiệu ứng hình ảnh. Quay phim Full HD với ổn định hình ảnh quang học. Loại Cảm biến Exmor R CMOS. Kích cỡ 1/2.3 (7.76mm). Điểm ảnh tổng 18.9 Mega Pixels. Điểm ảnh thật 18.2 Mega Pixels', 15, 10, '2018-04-18 00:00:00'),
(35, 'Sony Cyber-shot DSC-H400', 'SONY_3.jpg', 35490000, 'Sony', 'Travel', '20.1MP 1 / 2.3 \'Super HAD CCD Sensor. BIONZ R xử lý hình ảnh. Zoom quang học 63x 24.5-1550mm. 3 \'Clear Photo LCD 460k-Dot & Kính ngắm. 720p HD Movie Mode. Optical SteadyShot ổn định hình ảnh. 360˚ Sweep Panorama. Dễ sử dụng với chi tiết đơn giản.', 123, 25, '2018-05-01 00:00:00'),
(36, 'Sony Cyber-shot DSC-HX350', 'SONY_4.jpg', 8990000, 'Sony', 'Mirrorless', 'Độ phân giải 20.4MP. ISO Auto, 80-3200 (mở rộng 12800). Zoom quang 50x. Màn hình LCD xoay lật, độ phân giải 921,600 điểm ảnh. Tích hợp ống ngắm điện tử. Tốc độ màn trập: 1/4000 giây - 30 giây. Chụp ảnh liên tiếp 10.0 fps. Quay phim: FullhD 60fps, định dạng MPEG-4, AVCHD. Thẻ nhớ tương thích: SD/SDHC/SDXC + Memory Stick Pro Duo. Kết nối: Wi-Fi/NFC/GPS. Phụ kiện đi kèm: pin NP-BX1, AC Adaptor, cáp micro USB, dây đeo, nắp ống kính, shoe cap', 110, 20, '2018-03-31 00:00:00'),
(37, 'Sony HX400V', 'SONY_5.jpg', 9690000, 'Sony', 'Mirrorless', 'Cảm biến ảnh CMOS 20.4MP. Ống kính zoom quang học Zeiss 50X. Màn hình 3 \'Xtra Fine 921k điểm ảnh. Quay Video Full HD 1080p AVCHD. Chụp liên tục lên đến 10fps. Tích hợp Wi-Fi và công nghệ NFC.', 85, 14, '2018-04-19 00:00:00'),
(38, 'Sony Alpha a7 III', 'SONY_6.jpg', 4599000, 'Sony', 'Mirrorless', 'Bộ cảm biến CMOS BSI CMOS 24MP full frame. Bộ xử lý hình ảnh BIONZ X và Front-End LSI. Hệ thống lấy nét tự động với 693 điểm lấy nét. Chụp 10 khung hình / giây. Video UHD 4K30p. Màn hình cảm ứng LCD 3.0 inch 922k điểm ảnh. Hệ thống ổn định hình ảnh 5 trục. ISO 204800 và chụp nhiều điểm ảnh. Kết nối Wi-Fi và NFC. Có khe SD đôi. Cổng USB Loại C. Thiết kế chống chịu mọi thời tiết', 78, 11, '2018-04-19 00:00:00'),
(39, 'Sony Alpha A6300', 'SONY_7.jpg', 33980000, 'Sony', 'DSLR', 'Cảm biến CMOS APS-C 24MP. Bộ xử lý hình ảnh BIONZ X. Hệ thống lấy nét AF 425 điểm theo pha. Chụp liên tiếp 11fps (8fps ở chế độ live-view). Có chế độ chụp yên lặng (Silent shooting như A7RII). Dải nhạy sáng ISO 100 - 51200. Quay video 4K lên tới 100Mbps, S-Log3 Gamma. LCD 3.0\' 921.6K', 44, 1, '2018-05-01 00:00:00'),
(40, 'Sony Alpha A7', 'SONY_8.jpg', 34480000, 'Sony', 'DSLR', 'Cảm biến CMOS Exmor 24.3MP Full Khung hình. Bộ xử lý hình ảnh BIONZ X. Kính ngắm điện tử OLED 2.4m-Dot. Chụp liên tiếp: 2,5 hình/giây đến 5 hình/giây. Tích hợp Wi-Fi và công nghệ NFC. Giao diện truy cập trực tiếp', 23, 16, '2018-04-10 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `quan_ly`
--

DROP TABLE IF EXISTS `quan_ly`;
CREATE TABLE IF NOT EXISTS `quan_ly` (
  `Ma_quan_ly` int(11) NOT NULL AUTO_INCREMENT,
  `Ten_quan_ly` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Mat_khau` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Ma_quan_ly`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `quan_ly`
--

INSERT INTO `quan_ly` (`Ma_quan_ly`, `Ten_quan_ly`, `Email`, `Mat_khau`) VALUES
(1, 'Phạm Lê Thiện Tâm', 'phamlethientam@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('0tIGmpJwuPDuWOVqkKrusMliv9Jhq1nq', 1530290714, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"manager\":null,\"user\":null,\"cart\":[]}'),
('caUtK1w7Soyh7KAkFOMJoRxWupTWQrFP', 1530338644, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"manager\":null,\"user\":null,\"cart\":[]}');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
