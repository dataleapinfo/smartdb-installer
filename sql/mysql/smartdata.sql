GRANT SELECT ON `performance_schema`.* TO 'smartdb'@'%';

FLUSH PRIVILEGES;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `smartdata` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `smartdata`;

SET NAMES utf8mb4;
