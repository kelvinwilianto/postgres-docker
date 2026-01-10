-- Example initialization script
-- This file will be automatically executed when the container starts for the first time

-- Create a sample table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO users (username, email) VALUES
    ('kelvin', 'kelvin@example.com')
ON CONFLICT DO NOTHING;
