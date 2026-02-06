-- Achna Central Bank (ACB)
-- Digital Banking System Schema

CREATE DATABASE achna_bank;
USE achna_bank;

-- ======================
-- USERS TABLE
-- ======================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    age INT,
    parent_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- ACCOUNTS TABLE
-- ======================
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    account_number VARCHAR(30) UNIQUE NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    status ENUM('active','suspended','closed') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ======================
-- WALLETS (DIGITAL MONEY)
-- ======================
CREATE TABLE wallets (
    wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    currency_name VARCHAR(50) DEFAULT 'Achemark',
    wallet_balance DECIMAL(15,2) DEFAULT 0.00,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- ======================
-- TRANSACTIONS TABLE
-- ======================
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_wallet INT,
    to_wallet INT,
    amount DECIMAL(15,2) NOT NULL,
    transaction_type ENUM('deposit','withdraw','transfer','payment') NOT NULL,
    status ENUM('success','pending','failed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_wallet) REFERENCES wallets(wallet_id),
    FOREIGN KEY (to_wallet) REFERENCES wallets(wallet_id)
);

-- ======================
-- LOGIN HISTORY
-- ======================
CREATE TABLE login_history (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ======================
-- KYC (PARENT SUPPORT)
-- ======================
CREATE TABLE kyc_verification (
    kyc_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    document_type VARCHAR(50),
    document_number VARCHAR(100),
    verified_by_parent BOOLEAN DEFAULT FALSE,
    verified_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
