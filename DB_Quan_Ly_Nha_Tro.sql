-- Tạo cơ sở dữ liệu
CREATE DATABASE HomeManager;

-- Sử dụng cơ sở dữ liệu mới tạo
USE HomeManager;

-- Tạo bảng khách hàng (customer) với cột created_at và updated_at
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    masv VARCHAR(50),
    fullname VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    img VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng người dùng (user) với cột created_at và updated_at
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    img VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng quyền hạn (role)
CREATE TABLE role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50)
);

-- Tạo bảng phân quyền người dùng (user_role)
CREATE TABLE user_role (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id)
);

-- Tạo bảng danh mục loại nhà trọ (loai_nha_tro)
CREATE TABLE loai_nha_tro (
    loai_nha_tro_id INT PRIMARY KEY AUTO_INCREMENT,
    ten_loai VARCHAR(50)
);

-- Tạo bảng nhà trọ (nhatro) với cột created_at và updated_at
CREATE TABLE nhatro (
    nhatro_id INT PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(100),
    dia_chi VARCHAR(200),
    so_luong_phong_trong INT,
    tien_nghi_co_san TEXT,
    loai_nha_tro_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (loai_nha_tro_id) REFERENCES loai_nha_tro(loai_nha_tro_id)
);

-- Tạo bảng phòng trọ (phongtro) với cột created_at và updated_at
CREATE TABLE phongtro (
    phongtro_id INT PRIMARY KEY AUTO_INCREMENT,
    dien_tich DECIMAL(10, 2),
    loai_phong VARCHAR(20),
    gia_thue DECIMAL(10, 2),
    trang_thai ENUM('Trống', 'Có người ở') DEFAULT 'Trống',
    nhatro_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (nhatro_id) REFERENCES nhatro(nhatro_id)
);

-- Tạo bảng hợp đồng thuê (hopdongthue) với cột created_at và updated_at
CREATE TABLE hopdongthue (
    hopdong_id INT PRIMARY KEY AUTO_INCREMENT,
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    chi_phi DECIMAL(10, 2),
    trang_thai_thanh_toan ENUM('Đã thanh toán', 'Chưa thanh toán') DEFAULT 'Chưa thanh toán',
    customer_id INT,
    phongtro_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (phongtro_id) REFERENCES phongtro(phongtro_id)
);

-- Tạo bảng tiền phòng (tienphong) với cột created_at và updated_at
CREATE TABLE tienphong (
    tienphong_id INT PRIMARY KEY AUTO_INCREMENT,
    thang_nam DATE,
    tong_tien DECIMAL(10, 2),
    phongtro_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (phongtro_id) REFERENCES phongtro(phongtro_id)
);

-- Tạo bảng phương thức thanh toán (phuong_thuc_thanh_toan)
CREATE TABLE payment (
    phuong_thuc_id INT PRIMARY KEY AUTO_INCREMENT,
    ten_phuong_thuc VARCHAR(50)
);

-- Tạo bảng ngân hàng (ngan_hang)
CREATE TABLE bank (
    ngan_hang_id INT PRIMARY KEY AUTO_INCREMENT,
    ten_ngan_hang VARCHAR(100),
    so_tai_khoan VARCHAR(50)
);

-- Tạo bảng liên kết giữa phương thức thanh toán và ngân hàng (phuong_thuc_thanh_toan_ngan_hang)
CREATE TABLE payment_bank (
    phuong_thuc_id INT,
    ngan_hang_id INT,
    PRIMARY KEY (phuong_thuc_id, ngan_hang_id),
    FOREIGN KEY (phuong_thuc_id) REFERENCES payment(phuong_thuc_id),
    FOREIGN KEY (ngan_hang_id) REFERENCES bank(ngan_hang_id)
);

-- Tạo bảng giao dịch thanh toán (thanh_toan) với cột created_at và updated_at
CREATE TABLE thanh_toan (
    thanh_toan_id INT PRIMARY KEY AUTO_INCREMENT,
    hopdong_id INT,
    phuong_thuc_id INT,
    ngan_hang_id INT,
    so_tien DECIMAL(10, 2),
    ngay_thanh_toan DATETIME,
    trang_thai ENUM('Đã thanh toán', 'Chưa thanh toán') DEFAULT 'Chưa thanh toán',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hopdong_id) REFERENCES hopdongthue(hopdong_id),
    FOREIGN KEY (phuong_thuc_id) REFERENCES payment(phuong_thuc_id),
    FOREIGN KEY (ngan_hang_id) REFERENCES bank(ngan_hang_id)
);
