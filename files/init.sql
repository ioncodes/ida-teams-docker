CREATE USER IF NOT EXISTS 'lumina'@'%' IDENTIFIED BY 'lumina';
GRANT ALL PRIVILEGES ON *.* TO 'lumina'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;