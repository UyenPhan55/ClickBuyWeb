CREATE DATABASE IF NOT EXISTS clickbuy
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE clickbuy;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS bao_hanh;
DROP TABLE IF EXISTS lich_su_hoat_dong;
DROP TABLE IF EXISTS thong_bao;
DROP TABLE IF EXISTS danh_gia;
DROP TABLE IF EXISTS khieu_nai;
DROP TABLE IF EXISTS san_pham_trong_don;
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS san_pham_trong_gio;
DROP TABLE IF EXISTS gio_hang;
DROP TABLE IF EXISTS bien_the_san_pham;
DROP TABLE IF EXISTS ma_giam_gia;
DROP TABLE IF EXISTS san_pham;
DROP TABLE IF EXISTS nguoi_dung;
DROP TABLE IF EXISTS vai_tro;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- 1. BẢNG VAI TRÒ
-- =========================================================
CREATE TABLE vai_tro (
    id_vai_tro INT AUTO_INCREMENT PRIMARY KEY,
    ten_vai_tro VARCHAR(20) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 2. BẢNG NGƯỜI DÙNG
-- =========================================================
CREATE TABLE nguoi_dung (
    id_nguoi_dung INT AUTO_INCREMENT PRIMARY KEY,
    ten_day_du VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau VARCHAR(255) NOT NULL,
    sdt VARCHAR(20) UNIQUE,
    id_vai_tro INT NOT NULL,
    trang_thai TINYINT NOT NULL DEFAULT 1,
    ngay_tao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_nguoidung_vaitro
        FOREIGN KEY (id_vai_tro) REFERENCES vai_tro(id_vai_tro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 3. BẢNG SẢN PHẨM
-- Chỉ lưu thông tin chung của sản phẩm
-- =========================================================
CREATE TABLE san_pham (
    id_san_pham INT AUTO_INCREMENT PRIMARY KEY,
    ten_san_pham VARCHAR(150) NOT NULL,
    nha_san_xuat VARCHAR(100) NOT NULL,
    gia_co_ban DECIMAL(12,2) NOT NULL,
    mo_ta TEXT,
    url_anh VARCHAR(500),
    -- Nhóm các cột trạng thái và thời gian xuống cuối
    trang_thai TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CHECK (gia_co_ban >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 3A. BẢNG INDEX
-- Phục vụ vấn đề tìm kiếm
-- =========================================================
CREATE INDEX idx_ten_sanpham
ON san_pham(ten_san_pham);

CREATE INDEX idx_nhasx
ON san_pham(nha_san_xuat);

-- =========================================================
-- 4. BẢNG BIẾN THỂ SẢN PHẨM
-- Mỗi sản phẩm có thể có nhiều phiên bản
-- =========================================================
CREATE TABLE bien_the_san_pham (
    id_bien_the INT AUTO_INCREMENT PRIMARY KEY,
    id_san_pham INT NOT NULL,
    ten_bien_the VARCHAR(100) NOT NULL,
    gia_bien_the DECIMAL(12,2) NOT NULL,
    so_luong_ton INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_bienthe_sanpham
        FOREIGN KEY (id_san_pham) REFERENCES san_pham(id_san_pham)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    updated_at TIMESTAMP NOT NULL
    DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_bienthe UNIQUE (id_san_pham, ten_bien_the),
    CHECK (gia_bien_the >= 0),
    CHECK (so_luong_ton >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 5. BẢNG MÃ GIẢM GIÁ
-- Không lưu so_luong_da_dung để tránh suy diễn
-- =========================================================
CREATE TABLE ma_giam_gia (
    id_voucher INT AUTO_INCREMENT PRIMARY KEY,
    ma_code VARCHAR(20) NOT NULL UNIQUE,
    loai_giam ENUM('PHAN_TRAM', 'TIEN_MAT') NOT NULL,
    gia_tri_giam DECIMAL(12,2) NOT NULL,
    don_toi_thieu DECIMAL(12,2) NOT NULL DEFAULT 0,
    giam_toi_da DECIMAL(12,2) DEFAULT NULL,
    so_luong_gioi_han INT NOT NULL,
    ngay_bat_dau DATETIME NOT NULL,
    ngay_het_han DATETIME NOT NULL,
    trang_thai TINYINT NOT NULL DEFAULT 1,
    CHECK (gia_tri_giam >= 0),
    CHECK (don_toi_thieu >= 0),
    CHECK (so_luong_gioi_han >= 0),
    CHECK (ngay_het_han > ngay_bat_dau)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 6. BẢNG GIỎ HÀNG
-- Mỗi người dùng chỉ có 1 giỏ hàng đang hoạt động
-- =========================================================
CREATE TABLE gio_hang (
    id_gio_hang INT AUTO_INCREMENT PRIMARY KEY,
    id_nguoi_dung INT NOT NULL UNIQUE,
    ngay_tao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_giohang_nguoidung
        FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 7. BẢNG SẢN PHẨM TRONG GIỎ
-- Gắn theo biến thể
-- =========================================================
CREATE TABLE san_pham_trong_gio (
    id_gio_hang INT NOT NULL,
    id_bien_the INT NOT NULL,
    so_luong INT NOT NULL,
    PRIMARY KEY (id_gio_hang, id_bien_the),
    CONSTRAINT fk_sptronggio_giohang
        FOREIGN KEY (id_gio_hang) REFERENCES gio_hang(id_gio_hang)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_sptronggio_bienthe
        FOREIGN KEY (id_bien_the) REFERENCES bien_the_san_pham(id_bien_the)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CHECK (so_luong > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 8. BẢNG ĐƠN HÀNG
-- Không lưu tong_tien, so_tien_giam vì có thể tính ra
-- =========================================================
CREATE TABLE don_hang (
    id_don_hang INT AUTO_INCREMENT PRIMARY KEY,
    id_nguoi_dung INT NOT NULL,
    ngay_dat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL
    DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    trang_thai ENUM(
        'CHO_XAC_NHAN',
        'DA_XAC_NHAN',
        'DANG_CHUAN_BI',
        'DANG_GIAO',
        'DA_GIAO',
        'HOAN_THANH',
        'DA_HUY'
    ) NOT NULL DEFAULT 'CHO_XAC_NHAN',
    dia_chi VARCHAR(255) NOT NULL,
    sdt_nguoi_nhan VARCHAR(15) NOT NULL,
    id_voucher INT DEFAULT NULL,
    CONSTRAINT fk_donhang_nguoidung
        FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_donhang_voucher
        FOREIGN KEY (id_voucher) REFERENCES ma_giam_gia(id_voucher)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 9. BẢNG SẢN PHẨM TRONG ĐƠN
-- Lưu đơn giá tại thời điểm đặt hàng để bảo toàn lịch sử
-- =========================================================
CREATE TABLE san_pham_trong_don (
    id_don_hang INT NOT NULL,
    id_bien_the INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_don_hang, id_bien_the),
    CONSTRAINT fk_sptrongdon_donhang
        FOREIGN KEY (id_don_hang) REFERENCES don_hang(id_don_hang)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_sptrongdon_bienthe
        FOREIGN KEY (id_bien_the) REFERENCES bien_the_san_pham(id_bien_the)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CHECK (so_luong > 0),
    CHECK (don_gia >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 10. BẢNG KHIẾU NẠI
-- Chỉ lưu id_don_hang, không lưu id_nguoi_dung để tránh dư thừa
-- =========================================================
CREATE TABLE khieu_nai (
    id_khieu_nai INT AUTO_INCREMENT PRIMARY KEY,
    id_don_hang INT NOT NULL,
    noi_dung TEXT NOT NULL,
    phan_hoi TEXT,
    trang_thai ENUM(
        'CHO_XU_LY',
        'DANG_XU_LY',
        'DA_PHAN_HOI',
        'DA_DONG'
    ) NOT NULL DEFAULT 'CHO_XU_LY',
    ngay_gui TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    yeu_cau_tra_hang TINYINT NOT NULL DEFAULT 0,
    CONSTRAINT fk_khieunai_donhang
        FOREIGN KEY (id_don_hang) REFERENCES don_hang(id_don_hang)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 11. BẢNG ĐÁNH GIÁ
-- Gắn với dòng hàng trong đơn để đảm bảo đã mua mới được đánh giá
-- Mỗi dòng hàng trong đơn chỉ đánh giá 1 lần
-- =========================================================
CREATE TABLE danh_gia (
    id_danh_gia INT AUTO_INCREMENT PRIMARY KEY,
    id_don_hang INT NOT NULL,
    id_bien_the INT NOT NULL,
    so_sao INT NOT NULL,
    noi_dung TEXT NOT NULL,
    tra_loi TEXT,
    ngay_danh_gia TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    trang_thai TINYINT NOT NULL DEFAULT 1,
    CONSTRAINT fk_danhgia_chitietdon
        FOREIGN KEY (id_don_hang, id_bien_the)
        REFERENCES san_pham_trong_don(id_don_hang, id_bien_the)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_danhgia UNIQUE (id_don_hang, id_bien_the),
    CHECK (so_sao BETWEEN 1 AND 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 12. BẢNG THÔNG BÁO
-- =========================================================
CREATE TABLE thong_bao (
    id_thong_bao INT AUTO_INCREMENT PRIMARY KEY,
    id_nguoi_dung INT NOT NULL,
    tieu_de VARCHAR(255) NOT NULL,
    noi_dung TEXT NOT NULL,
    loai_thong_bao ENUM('KHUYEN_MAI', 'DON_HANG', 'HE_THONG') NOT NULL,
    da_doc TINYINT NOT NULL DEFAULT 0,
    ngay_tao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_thongbao_nguoidung
        FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 13. BẢNG LỊCH SỬ HOẠT ĐỘNG
-- =========================================================
CREATE TABLE lich_su_hoat_dong (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_nguoi_dung INT NOT NULL,
    hanh_dong VARCHAR(255) NOT NULL,
    bang_tac_dong VARCHAR(50) NOT NULL,
    id_doi_tuong INT NOT NULL,
    thoi_gian TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dia_chi_ip VARCHAR(45),
    CONSTRAINT fk_lichsu_nguoidung
        FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 14. BẢNG BẢO HÀNH
-- Không đặt UNIQUE(id_don_hang, id_bien_the)
-- để cho phép nhiều thiết bị cùng loại trong một đơn có nhiều mã bảo hành
-- Nếu sau này quản lý theo IMEI thì thêm cột imei UNIQUE
-- =========================================================
CREATE TABLE bao_hanh (
    id_bao_hanh INT AUTO_INCREMENT PRIMARY KEY,
    id_don_hang INT NOT NULL,
    id_bien_the INT NOT NULL,
    id_nhan_vien INT DEFAULT NULL,
    ma_bao_hanh_code VARCHAR(100) NOT NULL UNIQUE,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    trang_thai ENUM('CON_HAN', 'HET_HAN', 'DANG_XU_LY', 'DA_XU_LY') NOT NULL DEFAULT 'CON_HAN',
    ghi_chu TEXT,
    CONSTRAINT fk_baohanh_chitietdon
        FOREIGN KEY (id_don_hang, id_bien_the)
        REFERENCES san_pham_trong_don(id_don_hang, id_bien_the)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_baohanh_nhanvien
        FOREIGN KEY (id_nhan_vien) REFERENCES nguoi_dung(id_nguoi_dung)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CHECK (ngay_ket_thuc >= ngay_bat_dau)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO vai_tro (id_vai_tro, ten_vai_tro) VALUES
(1,'ADMIN'),
(2,'NHAN_VIEN'),
(3,'KHACH_HANG');

INSERT INTO nguoi_dung (id_nguoi_dung, ten_day_du, email, mat_khau, sdt, id_vai_tro, trang_thai, ngay_tao) VALUES
(1,'Nguyen Minh Quan','quan@gmail.com','123','0901412917',1,1,'2026-12-01'),
(2,'Tran Thi Lan','lan@gmail.com','524','0902728352',2,1,'2025-01-02'),
(3,'Le Hoang Nam','nam@gmail.com','765','0903236839',3,1,'2024-07-03'),
(4,'Pham Tuan Anh','anh@gmail.com','103','0325364784',3,1,'2025-01-04'),
(5,'Vo Ngoc Mai','mai@gmail.com','348','0906295785',3,0,'2023-09-05'),
(6,'Dang Quang Huy','huy@gmail.com','735','0902375606',2,1,'2026-10-19'),
(7,'Bui Thanh Dat','dat@gmail.com','423','0324579537',3,1,'2025-06-07'),
(8,'Do Thu Trang','trang@gmail.com','651','0348228798',3,1,'2025-11-08'),
(9,'Tran Dieu Linh','linh@gmail.com','452','0325483965',3,0,'2022-10-05');

INSERT INTO san_pham (id_san_pham, ten_san_pham, mo_ta, url_anh, nha_san_xuat, gia_co_ban, trang_thai) VALUES
(1,'iPhone 15 Pro','iPhone 15 Pro nổi bật với thiết kế khung titan nhẹ và bền. Máy sở hữu màn hình OLED 6.1 inch với công nghệ ProMotion 120Hz, cho trải nghiệm mượt mà. Chip A17 Pro cực kỳ mạnh mẽ, tối ưu cho chơi game và xử lý đồ họa nặng. Camera được nâng cấp với khả năng chụp ảnh chuyên nghiệp, zoom tốt và quay video chất lượng cao. IPhone 15 Pro còn có nút Action Button thay thế cần gạt rung truyền thống, cùng cổng USB-C tiện lợi hơn.','iphone15pro','Apple',30000000,1),
(2,'Samsung S23 Ultra','Samsung Galaxy S23 Ultra là flagship cao cấp của Samsung với thiết kế sang trọng và màn hình AMOLED 6.8 inch, tần số quét 120Hz siêu mượt. Nổi bật với camera chính 200MP cho ảnh cực kỳ chi tiết và zoom xa ấn tượng. Chip Snapdragon 8 Gen 2 mạnh mẽ, xử lý tốt mọi tác vụ từ game đến công việc. Pin 5000mAh cho thời gian sử dụng lâu, phù hợp người dùng cần hiệu năng cao.','s23ultra','Samsung',28000000,1),
(3,'Xiaomi 13','Xiaomi 13 là smartphone cao cấp của Xiaomi, có màn hình AMOLED 6.36 inch, 120Hz mượt và độ sáng cao. Camera 50MP hợp tác Leica, cho ảnh đẹp và màu sắc chân thực. Chip Snapdragon 8 Gen 2 mạnh mẽ, xử lý nhanh mọi tác vụ. Pin 4500mAh đi kèm sạc nhanh 67W và sạc không dây tiện lợi. Tổng thể, đây là lựa chọn flagship nhỏ gọn nhưng hiệu năng rất mạnh.','xiaomi13','Xiaomi',15000000,1),
(4,'Oppo Reno 10','OPPO Reno10 thiết kế mỏng nhẹ, màn hình AMOLED 6.7 inch, 120Hz mượt. Camera chính 64MP và camera tele 32MP chuyên chụp chân dung đẹp. Chip Dimensity 7050, đáp ứng tốt nhu cầu học tập, giải trí cơ bản. Pin 5000mAh đi kèm sạc nhanh 67W, sử dụng lâu và nạp pin nhanh.','opporeno10','Oppo',11000000,1),
(5,'Vivo V27','Vivo V27 màn hình AMOLED 6.78 inch cong 3D và tần số quét 120Hz mượt mà. Chip Dimensity 7200 (4nm) cho hiệu năng ổn định, xử lý tốt các tác vụ hằng ngày. Camera 64MP cùng hệ thống Aura Light giúp chụp chân dung đẹp, đặc biệt trong điều kiện thiếu sáng. Pin 4600mAh đi kèm sạc nhanh 66W, có thể sạc 50% chỉ khoảng 19 phút.','vivov27','Vivo',9000000,0),
(6,'Realme GT Neo 5','Realme GT Neo 5 là smartphone hiệu năng cao, nổi bật với công nghệ sạc nhanh 240W – có thể sạc đầy chỉ khoảng 10–15 phút. Màn hình AMOLED 6.74 inch, tần số quét 144Hz cho trải nghiệm cực kỳ mượt. Chip Snapdragon 8+ Gen 1 mạnh mẽ, chơi game và đa nhiệm tốt. Camera chính 50MP chụp ảnh ổn định, kèm thiết kế mặt lưng có đèn LED độc đáo.','realmegtneo5','Realme',12000000,1),
(7,'Nokia G22','Nokia G22 là smartphone giá rẻ ra mắt năm 2023, hướng đến độ bền và dễ sửa chữa. Máy có màn hình 6.5 inch, tần số quét 90Hz cho trải nghiệm khá mượt. Chip Unisoc T606, đủ đáp ứng các nhu cầu cơ bản như lướt web, học tập. Camera chính 50MP chụp ảnh ổn trong tầm giá, phù hợp sử dụng hằng ngày. Pin 5050mAh có thể dùng lâu, thậm chí lên tới vài ngày tùy mức độ sử dụng. Điểm đặc biệt là máy cho phép tự thay pin, màn hình dễ dàng – rất hiếm trong smartphone hiện nay.','nokiag22','Nokia',5000000,1),
(8,'iPhone 14','iPhone 14 là smartphone của Apple ra mắt năm 2022, nổi bật với thiết kế quen thuộc và hiệu năng ổn định. Màn hình OLED 6.1 inch, hiển thị sắc nét và độ sáng cao. Chip A15 Bionic mạnh mẽ, xử lý mượt các tác vụ hằng ngày và chơi game tốt. Camera kép 12MP cho chất lượng ảnh đẹp, hỗ trợ quay video 4K và chế độ chống rung tốt. Pin đủ dùng cả ngày, hỗ trợ sạc nhanh và sạc không dây MagSafe tiện lợi.','iphone14','Apple',20000000,1),
(9, 'iPhone 15', 'iPhone 15 là smartphone của Apple ra mắt năm 2023 với thiết kế nhôm và mặt lưng kính màu hiện đại. Màn hình OLED 6.1 inch, hiển thị sắc nét và độ sáng cao. Chip A16 Bionic mạnh mẽ, xử lý mượt các tác vụ hằng ngày và chơi game tốt. Camera chính 48MP cho ảnh chi tiết, hỗ trợ chụp chân dung và quay video 4K chất lượng cao. Ngoài ra, iPhone 15 chuyển sang cổng USB-C tiện lợi và có Dynamic Island hiển thị thông minh.', 'iphone15', 'Apple', 25000000, 1),
(10, 'Samsung Galaxy S24', 'Samsung Galaxy S24 là flagship ra mắt năm 2024 với thiết kế cao cấp, nhỏ gọn và hiện đại. Màn hình AMOLED 6.2 inch, 120Hz mượt và độ sáng cao. Chip Snapdragon 8 Gen 3 cho hiệu năng rất mạnh và tiết kiệm pin. Camera gồm 50MP + 10MP tele + 12MP góc rộng, chụp ảnh sắc nét, hỗ trợ zoom tốt. Điểm nổi bật là Galaxy AI với các tính năng như dịch cuộc gọi, chỉnh ảnh thông minh. Pin 4000mAh đủ dùng cả ngày, hỗ trợ sạc nhanh và sạc không dây', 's24', 'Samsung', 27000000, 1),
(11, 'Xiaomi Redmi Note 13', 'Xiaomi Redmi Note 13 ra mắt 2024 với thiết kế mỏng nhẹ, hiện đại. Màn hình AMOLED 6.67 inch, 120Hz cho trải nghiệm mượt mà. Chip Snapdragon 685 (bản 4G) hoặc Dimensity 6080 (bản 5G), đủ dùng cho học tập, lướt web và giải trí cơ bản. Camera chính từ 64MP–108MP (tùy phiên bản) cho ảnh khá ổn trong tầm giá. Pin khoảng 5000mAh, hỗ trợ sạc nhanh 33W, dùng cả ngày thoải mái.', 'redmi13', 'Xiaomi', 6000000, 1),
(12, 'Oppo Find X5', 'OPPO Find X5 là smartphone cao cấp ra mắt 2022, nổi bật với thiết kế cong liền mạch sang trọng. Màn hình AMOLED 6.55 inch hiển thị đẹp, màu sắc chuẩn. Camera hợp tác Hasselblad với cảm biến 50MP, cho ảnh màu sắc tự nhiên và chụp đêm tốt. Chip Snapdragon 888 mạnh mẽ, xử lý mượt các tác vụ và game nặng. Pin 4800mAh hỗ trợ sạc nhanh 80W, sạc đầy chỉ khoảng hơn 30 phút.', 'findx5', 'Oppo', 18000000, 1),
(13, 'Vivo Y36', 'Vivo Y36 là mẫu điện thoại tầm trung có thiết kế mỏng, nhẹ và khá hiện đại. Màn hình 6.64 inch FHD+ LCD, cho trải nghiệm hiển thị ổn trong nhu cầu hằng ngày. Chip Snapdragon 680, đủ mượt cho học tập, lướt web và các tác vụ cơ bản. Camera sau 50MP, camera trước 16MP, phù hợp chụp ảnh và selfie trong điều kiện thông thường. Pin 5000mAh và sạc nhanh 44W là điểm mạnh, giúp dùng lâu và nạp pin khá nhanh.', 'vivoy36', 'Vivo', 7000000, 1),
(14, 'Realme C55', 'Realme C55 là smartphone giá rẻ nổi bật với thiết kế đẹp và hiện đại trong tầm giá. Màn hình 6.72 inch Full HD+, tần số quét 90Hz cho trải nghiệm khá mượt. Chip Helio G88, đủ đáp ứng nhu cầu học tập, lướt web và giải trí cơ bản. Camera chính 64MP cho ảnh rõ nét trong điều kiện đủ sáng, phù hợp dùng hằng ngày. Pin 5000mAh đi kèm sạc nhanh 33W, cho thời gian sử dụng lâu và sạc khá nhanh.', 'realmeC55', 'Realme', 5000000, 1),
(15, 'Nokia X30', 'Nokia X30 là smartphone tầm trung ra mắt 2022, nổi bật với thiết kế thân thiện môi trường và độ bền cao. Màn hình AMOLED 6.43 inch, 90Hz cho hiển thị mượt và sắc nét. Chip Snapdragon 695, đủ đáp ứng tốt nhu cầu học tập, giải trí hằng ngày. Camera chính 50MP có chống rung OIS giúp chụp ảnh ổn định, kèm camera góc rộng 13MP. Pin 4200mAh hỗ trợ sạc nhanh 33W, đủ dùng trong ngày. Ngoài ra, máy đạt chuẩn chống nước IP67 và được hỗ trợ cập nhật phần mềm lâu dài, phù hợp dùng bền.', 'nokiaX30', 'Nokia', 9000000, 0);

INSERT INTO bien_the_san_pham (id_bien_the, id_san_pham, ten_bien_the, gia_bien_the, so_luong_ton) VALUES
(1,1,'128GB',30000000,10),
(2,1,'256GB',33000000,5),
(3,2,'256GB',28000000,7),
(4,3,'128GB',15000000,15),
(5,4,'256GB',11500000,12),
(6,5,'128GB',9000000,20),
(7,6,'256GB',12500000,8),
(8,7,'64GB',5000000,25);

INSERT INTO ma_giam_gia (id_voucher, ma_code, loai_giam, gia_tri_giam, don_toi_thieu, giam_toi_da, so_luong_gioi_han, ngay_bat_dau, ngay_het_han, trang_thai) VALUES
(1,'SALE10','PHAN_TRAM',10,1000000,500000,100,'2025-01-01','2025-12-31',1),
(2,'SALE20','PHAN_TRAM',20,2000000,800000,50,'2025-01-01','2025-06-01',1),
(3,'GIAM500K','TIEN_MAT',500000,5000000,NULL,30,'2025-01-01','2025-05-01',1),
(4,'GIAM1TR','TIEN_MAT',1000000,10000000,NULL,20,'2025-01-01','2025-04-01',0),
(5,'SALE5','PHAN_TRAM',5,500000,200000,200,'2025-01-01','2025-12-31',1),
(6,'SALE15','PHAN_TRAM',15,3000000,600000,80,'2025-01-01','2025-07-01',1),
(7,'GIAM200K','TIEN_MAT',200000,2000000,NULL,60,'2025-01-01','2025-08-01',1);

INSERT INTO gio_hang (id_gio_hang, id_nguoi_dung, ngay_tao) VALUES
(1,3,'2025-02-01'),
(2,4,'2025-02-02'),
(3,5,'2025-02-03'),
(4,6,'2025-02-04'),
(5,7,'2025-02-05'),
(6,8,'2025-02-06'),
(7,2,'2025-02-07'),
(8,1,'2025-02-08');

INSERT INTO san_pham_trong_gio (id_gio_hang, id_bien_the, so_luong) VALUES
(1,1,2),
(2,2,1),
(3,3,1),
(4,4,2),
(5,5,1),
(6,6,1),
(7,7,2),
(8,8,1);

INSERT INTO don_hang (id_don_hang, id_nguoi_dung, ngay_dat, trang_thai, dia_chi, sdt_nguoi_nhan, id_voucher) VALUES
(1,3,'2025-03-01','DA_GIAO','HCM','0903333333',1),
(2,4,'2025-03-02','DANG_GIAO','Ha Noi','0904444444',2),
(3,5,'2025-03-03','DA_HUY','Da Nang','0905555555',NULL),
(4,6,'2025-03-04','HOAN_THANH','Can Tho','0906666666',3),
(5,7,'2025-03-05','DA_GIAO','Hue','0907777777',NULL),
(6,8,'2025-03-06','CHO_XAC_NHAN','HCM','0908888888',4),
(7,2,'2025-03-07','DA_GIAO','HCM','0902222222',NULL),
(8,1,'2025-03-08','DA_GIAO','HCM','0901111111',5);

INSERT INTO san_pham_trong_don (id_don_hang, id_bien_the, so_luong, don_gia) VALUES
(1,1,1,30000000),
(2,2,1,33000000),
(3,3,2,28000000),
(4,4,1,15000000),
(5,5,1,11500000),
(6,6,1,9000000),
(7,7,2,12500000),
(8,8,1,5000000);

INSERT INTO khieu_nai (id_khieu_nai, id_don_hang, noi_dung, phan_hoi, trang_thai, ngay_gui, yeu_cau_tra_hang) VALUES
(1,1,'Man hinh loi','Da doi moi','DA_PHAN_HOI','2025-03-10',1),
(2,2,'Giao cham','Dang xu ly','DANG_XU_LY','2025-03-11',0),
(3,3,'Sai mau','Da hoan tien','DA_DONG','2025-03-12',1),
(4,4,'Thieu sac','Da gui bo sung','DA_PHAN_HOI','2025-03-13',0),
(5,5,'Pin yeu',NULL,'CHO_XU_LY','2025-03-14',1),
(6,6,'Vo hop','Dang xu ly','DANG_XU_LY','2025-03-15',0),
(7,7,'Camera loi','Da sua','DA_DONG','2025-03-16',1),
(8,8,'Treo may',NULL,'CHO_XU_LY','2025-03-17',1);

INSERT INTO danh_gia (id_danh_gia, id_don_hang, id_bien_the, so_sao, noi_dung, tra_loi, trang_thai) VALUES
(1,1,1,5,'Rat tot','Cam on ban',1),
(2,2,2,4,'Tot','Cam on',1),
(3,3,3,3,'Tam duoc',NULL,1),
(4,4,4,5,'Xuat sac','Thanks',1),
(5,5,5,2,'Khong hai long',NULL,0),
(6,6,6,4,'On','OK',1),
(7,7,7,5,'Rat dep','Cam on',1),
(8,8,8,3,'Binh thuong',NULL,1);

INSERT INTO thong_bao (id_thong_bao, id_nguoi_dung, tieu_de, noi_dung, loai_thong_bao, da_doc) VALUES
(1,3,'Sale','Giam 50%','KHUYEN_MAI',1),
(2,4,'Don hang','Dang giao','DON_HANG',0),
(3,5,'He thong','Bao tri','HE_THONG',1),
(4,6,'Sale','Giam 20%','KHUYEN_MAI',0),
(5,7,'Don hang','Da giao','DON_HANG',1),
(6,8,'He thong','Update','HE_THONG',0),
(7,2,'Sale','Giam 10%','KHUYEN_MAI',1),
(8,1,'Don hang','Xac nhan','DON_HANG',1);

INSERT INTO lich_su_hoat_dong (id_log, id_nguoi_dung, hanh_dong, bang_tac_dong, id_doi_tuong, dia_chi_ip) VALUES
(1,1,'Them SP','san_pham',1,'192.168.1.1'),
(2,2,'Sua don','don_hang',7,'192.168.1.2'),
(3,3,'Dat hang','don_hang',4,'192.168.1.3'),
(4,4,'Danh gia','danh_gia',2,'192.168.1.4'),
(5,5,'Them gio','gio_hang',6,'192.168.1.5'),
(6,6,'Update user','nguoi_dung',3,'192.168.1.6'),
(7,7,'Khieu nai','khieu_nai',5,'192.168.1.7'),
(8,8,'Login','nguoi_dung',8,'192.168.1.8');

INSERT INTO bao_hanh (id_bao_hanh, id_don_hang, id_bien_the, id_nhan_vien, ma_bao_hanh_code,
ngay_bat_dau, ngay_ket_thuc, trang_thai) VALUES
(1,1,1,2,'BH001','2025-03-01','2026-03-01','CON_HAN'),
(2,2,2,2,'BH002','2025-03-02','2026-03-02','CON_HAN'),
(3,3,3,6,'BH003','2025-03-03','2026-03-03','HET_HAN'),
(4,4,4,6,'BH004','2025-03-04','2026-03-04','CON_HAN'),
(5,5,5,2,'BH005','2025-03-05','2026-03-05','DANG_XU_LY'),
(6,6,6,6,'BH006','2025-03-06','2026-03-06','CON_HAN'),
(7,7,7,2,'BH007','2025-03-07','2026-03-07','DA_XU_LY'),
(8,8,8,6,'BH008','2025-03-08','2026-03-08','CON_HAN');

SELECT * FROM vai_tro;
SELECT * FROM nguoi_dung;
SELECT * FROM san_pham;
SELECT * FROM bien_the_san_pham;
SELECT * FROM ma_giam_gia;
SELECT * FROM gio_hang;
SELECT * FROM san_pham_trong_gio;
SELECT * FROM don_hang;
SELECT * FROM san_pham_trong_don;
SELECT * FROM khieu_nai;
SELECT * FROM danh_gia;
SELECT * FROM thong_bao;
SELECT * FROM lich_su_hoat_dong;
SELECT * FROM bao_hanh;



