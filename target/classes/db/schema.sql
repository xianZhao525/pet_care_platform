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