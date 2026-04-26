-- ============================================
-- Community Event Management System
-- MySQL Database Setup Script
-- Run this in phpMyAdmin (XAMPP)
-- ============================================

CREATE DATABASE IF NOT EXISTS `community_events` 
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `community_events`;

-- -----------------------------------------------
-- Table: Users (Admin + Members)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `UserID`      INT AUTO_INCREMENT PRIMARY KEY,
  `FullName`    VARCHAR(100) NOT NULL,
  `Email`       VARCHAR(150) NOT NULL UNIQUE,
  `Password`    VARCHAR(255) NOT NULL,
  `Phone`       VARCHAR(20),
  `Role`        ENUM('Admin','Member') DEFAULT 'Member',
  `IsActive`    TINYINT(1) DEFAULT 1,
  `CreatedAt`   DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- Table: Categories
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS `categories` (
  `CategoryID`   INT AUTO_INCREMENT PRIMARY KEY,
  `CategoryName` VARCHAR(80) NOT NULL,
  `IconClass`    VARCHAR(60) DEFAULT 'fa-calendar',
  `ColorCode`    VARCHAR(10) DEFAULT '#4e73df'
) ENGINE=InnoDB;

-- -----------------------------------------------
-- Table: Events
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS `events` (
  `EventID`      INT AUTO_INCREMENT PRIMARY KEY,
  `Title`        VARCHAR(200) NOT NULL,
  `Description`  TEXT,
  `CategoryID`   INT,
  `Venue`        VARCHAR(200),
  `City`         VARCHAR(100),
  `EventDate`    DATE NOT NULL,
  `StartTime`    TIME,
  `EndTime`      TIME,
  `MaxCapacity`  INT DEFAULT 100,
  `TicketPrice`  DECIMAL(10,2) DEFAULT 0.00,
  `Status`       ENUM('Upcoming','Ongoing','Completed','Cancelled') DEFAULT 'Upcoming',
  `CreatedBy`    INT,
  `CreatedAt`    DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`CategoryID`) REFERENCES `categories`(`CategoryID`),
  FOREIGN KEY (`CreatedBy`)  REFERENCES `users`(`UserID`)
) ENGINE=InnoDB;

-- -----------------------------------------------
-- Table: Registrations
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS `registrations` (
  `RegID`        INT AUTO_INCREMENT PRIMARY KEY,
  `EventID`      INT NOT NULL,
  `UserID`       INT NOT NULL,
  `RegDate`      DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Status`       ENUM('Registered','Cancelled','Attended') DEFAULT 'Registered',
  `Notes`        VARCHAR(300),
  FOREIGN KEY (`EventID`) REFERENCES `events`(`EventID`),
  FOREIGN KEY (`UserID`)  REFERENCES `users`(`UserID`),
  UNIQUE KEY `unique_reg` (`EventID`,`UserID`)
) ENGINE=InnoDB;

-- -----------------------------------------------
-- Table: Announcements
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS `announcements` (
  `AnnID`        INT AUTO_INCREMENT PRIMARY KEY,
  `Title`        VARCHAR(200) NOT NULL,
  `Content`      TEXT,
  `PostedBy`     INT,
  `PostedAt`     DATETIME DEFAULT CURRENT_TIMESTAMP,
  `IsActive`     TINYINT(1) DEFAULT 1,
  FOREIGN KEY (`PostedBy`) REFERENCES `users`(`UserID`)
) ENGINE=InnoDB;

-- -----------------------------------------------
-- Seed Data
-- -----------------------------------------------

-- Default Admin
INSERT INTO `users` (`FullName`,`Email`,`Password`,`Role`) VALUES
('Admin User','admin@community.com','admin123','Admin'),
('John Smith','john@email.com','john123','Member'),
('Sarah Lee','sarah@email.com','sarah123','Member');

-- Categories
INSERT INTO `categories` (`CategoryName`,`IconClass`,`ColorCode`) VALUES
('Music & Arts','fa-music','#e83e8c'),
('Sports','fa-futbol','#28a745'),
('Technology','fa-laptop','#17a2b8'),
('Food & Drink','fa-utensils','#fd7e14'),
('Education','fa-graduation-cap','#6610f2'),
('Community','fa-users','#4e73df');

-- Sample Events
INSERT INTO `events` (`Title`,`Description`,`CategoryID`,`Venue`,`City`,`EventDate`,`StartTime`,`EndTime`,`MaxCapacity`,`TicketPrice`,`Status`,`CreatedBy`) VALUES
('Summer Music Festival','Annual outdoor music festival featuring local bands and artists.',1,'Central Park Amphitheater','New York','2026-06-15','14:00:00','22:00:00',500,25.00,'Upcoming',1),
('Community 5K Run','Charity run to support local food banks.',2,'Riverside Trail','Chicago','2026-05-10','07:00:00','11:00:00',200,0.00,'Upcoming',1),
('Tech Talks 2026','Monthly meetup for developers and tech enthusiasts.',3,'Innovation Hub','San Francisco','2026-05-20','18:00:00','21:00:00',100,0.00,'Upcoming',1),
('Food & Wine Expo','Taste wines and gourmet dishes from top local restaurants.',4,'Convention Center','Los Angeles','2026-06-05','12:00:00','20:00:00',300,50.00,'Upcoming',1),
('Free Coding Workshop','Beginner-friendly Python workshop for teens and adults.',5,'Public Library Hall','Austin','2026-05-25','10:00:00','16:00:00',40,0.00,'Upcoming',1),
('Neighborhood Clean-Up Day','Community volunteer day to clean and beautify local parks.',6,'City Park Entrance','Seattle','2026-05-18','09:00:00','13:00:00',80,0.00,'Upcoming',1);

-- Sample Registrations
INSERT INTO `registrations` (`EventID`,`UserID`,`Status`) VALUES
(1,2,'Registered'),(3,2,'Registered'),(2,3,'Registered'),(4,3,'Registered');

-- Sample Announcement
INSERT INTO `announcements` (`Title`,`Content`,`PostedBy`) VALUES
('Welcome to Community Events!','Stay connected with all local events. Register for free to join events and get updates.', 1);
