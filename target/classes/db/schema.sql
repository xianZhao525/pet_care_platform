-- 创建数据库
CREATE DATABASE IF NOT EXISTS pet_care_platform DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;

USE pet_care_platform;

-- 用户表
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200),
    avatar VARCHAR(200) DEFAULT 'default-avatar.png',
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
);

-- 宠物表
CREATE TABLE pets (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type ENUM(
        'DOG',
        'CAT',
        'RABBIT',
        'BIRD',
        'OTHER'
    ) NOT NULL,
    status ENUM(
        'AVAILABLE',
        'ADOPTED',
        'FOSTERED',
        'PENDING'
    ) DEFAULT 'AVAILABLE',
    breed VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    color VARCHAR(50),
    description TEXT,
    health_status VARCHAR(200),
    vaccination VARCHAR(200),
    image_url VARCHAR(200) DEFAULT 'default-pet.jpg',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    owner_id BIGINT,
    FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_type (type)
);

-- 领养记录表
CREATE TABLE adoptions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    pet_id BIGINT NOT NULL,
    adopter_id BIGINT NOT NULL,
    adoption_date DATE,
    status ENUM(
        'PENDING',
        'APPROVED',
        'REJECTED',
        'COMPLETED'
    ) DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (pet_id) REFERENCES pets (id) ON DELETE CASCADE,
    FOREIGN KEY (adopter_id) REFERENCES users (id) ON DELETE CASCADE,
    INDEX idx_pet_id (pet_id),
    INDEX idx_adopter_id (adopter_id)
);

-- 寄养记录表
CREATE TABLE fosters (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    pet_id BIGINT NOT NULL,
    fosterer_id BIGINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM(
        'PENDING',
        'ACTIVE',
        'COMPLETED',
        'CANCELLED'
    ) DEFAULT 'PENDING',
    daily_rate DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pet_id) REFERENCES pets (id) ON DELETE CASCADE,
    FOREIGN KEY (fosterer_id) REFERENCES users (id) ON DELETE CASCADE
);

-- 捐赠项目表
CREATE TABLE IF NOT EXISTS donations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(2000),
    type VARCHAR(20),
    target_amount DECIMAL(10, 2),
    current_amount DECIMAL(10, 2) DEFAULT 0.00,
    unit_price DECIMAL(10, 2),
    item_name VARCHAR(200),
    item_count INT,
    item_received INT DEFAULT 0,
    cover_image VARCHAR(500),
    images TEXT,
    status VARCHAR(20) DEFAULT 'PLANNING',
    start_date DATE,
    end_date DATE,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    create_user_id BIGINT,
    beneficiary VARCHAR(500),
    contact_person VARCHAR(100),
    contact_phone VARCHAR(20),
    contact_address VARCHAR(500),
    progress TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    sort_order INT DEFAULT 0,
    INDEX idx_status (status),
    INDEX idx_featured (is_featured),
    INDEX idx_create_time (create_time DESC)
);

-- 捐赠记录表
CREATE TABLE IF NOT EXISTS donation_records (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    donation_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    type VARCHAR(20),
    amount DECIMAL(10, 2),
    item_name VARCHAR(200),
    item_count INT,
    item_value DECIMAL(10, 2),
    volunteer_hours INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20) DEFAULT 'PENDING',
    transaction_id VARCHAR(100),
    donor_name VARCHAR(100),
    donor_phone VARCHAR(20),
    donor_email VARCHAR(100),
    donor_address VARCHAR(500),
    message TEXT,
    is_anonymous BOOLEAN DEFAULT FALSE,
    donation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_status VARCHAR(50),
    delivery_time DATETIME,
    delivery_notes VARCHAR(500),
    certificate_number VARCHAR(50),
    certificate_sent BOOLEAN DEFAULT FALSE,
    certificate_sent_time DATETIME,
    invoice_required BOOLEAN DEFAULT FALSE,
    invoice_sent BOOLEAN DEFAULT FALSE,
    invoice_number VARCHAR(50),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (donation_id) REFERENCES donations (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    INDEX idx_donation_id (donation_id),
    INDEX idx_user_id (user_id),
    INDEX idx_donation_time (donation_time DESC)
);

-- 添加外键约束
ALTER TABLE donations
ADD CONSTRAINT fk_donation_user FOREIGN KEY (create_user_id) REFERENCES users (id) ON DELETE SET NULL;