CREATE TABLE IF NOT EXISTS snarky_messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nutrient_type VARCHAR(20) NOT NULL COMMENT 'CALORIE, PROTEIN, FAT, CARB',
    status_type VARCHAR(10) NOT NULL COMMENT 'DEFICIT, SURPLUS',
    message_text VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nutrient_status (nutrient_type, status_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;