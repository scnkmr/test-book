-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2020 at 04:28 PM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tb`
--

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `Optionid` int(10) UNSIGNED NOT NULL,
  `Optiontext` varchar(255) NOT NULL,
  `Questionid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`Optionid`, `Optiontext`, `Questionid`) VALUES
(1, 'Narender Modi', 1),
(2, 'Abdul Kalam', 1),
(3, 'Atal bihari Bajpeyi', 1),
(4, 'Infection', 2),
(5, 'virus', 2),
(6, 'both', 2),
(7, 'none', 2);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `Questionid` int(10) UNSIGNED NOT NULL,
  `Question` varchar(600) NOT NULL,
  `Type` enum('short','mcq') NOT NULL,
  `Marks` int(50) DEFAULT NULL,
  `Testid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`Questionid`, `Question`, `Type`, `Marks`, `Testid`) VALUES
(1, 'Who is Prime Minister of India?', 'mcq', 2, 1),
(2, 'What is corona?', 'mcq', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `Responseid` int(10) UNSIGNED NOT NULL,
  `MarksObtained` int(50) DEFAULT NULL,
  `Questionid` int(10) UNSIGNED DEFAULT NULL,
  `Optionid` int(10) UNSIGNED DEFAULT NULL,
  `ShortAnswer` char(255) DEFAULT NULL,
  `Testid` int(10) UNSIGNED DEFAULT NULL,
  `ResponseSessionid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `response_session`
--

CREATE TABLE `response_session` (
  `ResponseSessionid` int(10) UNSIGNED NOT NULL,
  `Testid` int(10) UNSIGNED DEFAULT NULL,
  `Time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rightanswer`
--

CREATE TABLE `rightanswer` (
  `Rightanswerid` int(10) UNSIGNED NOT NULL,
  `Answer` varchar(255) DEFAULT NULL,
  `Questionid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rightoption`
--

CREATE TABLE `rightoption` (
  `Rightoptionid` int(10) UNSIGNED NOT NULL,
  `Optionid` int(10) UNSIGNED DEFAULT NULL,
  `Questionid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rightoption`
--

INSERT INTO `rightoption` (`Rightoptionid`, `Optionid`, `Questionid`) VALUES
(1, 1, 1),
(2, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `Testid` int(10) UNSIGNED NOT NULL,
  `Title` varchar(600) DEFAULT NULL,
  `StartAt` varchar(50) DEFAULT NULL,
  `Duration` varchar(50) DEFAULT NULL,
  `Userid` int(11) DEFAULT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`Testid`, `Title`, `StartAt`, `Duration`, `Userid`, `time_stamp`) VALUES
(1, 'Gk Online Tests', 'Mon, 31 Aug 2020 00:27:47', '3000000 minute', 1, '2020-08-31 14:24:23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Userid` int(11) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Verefied` enum('Yes','No') DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Userid`, `Email`, `Password`, `Verefied`, `LastName`, `FirstName`, `time_stamp`) VALUES
(1, 'scn.arn@gmail.com', 'scn.arn', 'Yes', 'Arayans', 'Sachin', '2020-08-30 17:19:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`Optionid`),
  ADD KEY `Questionid` (`Questionid`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`Questionid`),
  ADD KEY `Testid` (`Testid`);

--
-- Indexes for table `responses`
--
ALTER TABLE `responses`
  ADD PRIMARY KEY (`Responseid`),
  ADD KEY `Questionid` (`Questionid`),
  ADD KEY `Optionid` (`Optionid`),
  ADD KEY `Testid` (`Testid`),
  ADD KEY `ResponseSessionid` (`ResponseSessionid`);

--
-- Indexes for table `response_session`
--
ALTER TABLE `response_session`
  ADD PRIMARY KEY (`ResponseSessionid`),
  ADD KEY `Testid` (`Testid`);

--
-- Indexes for table `rightanswer`
--
ALTER TABLE `rightanswer`
  ADD PRIMARY KEY (`Rightanswerid`),
  ADD KEY `Questionid` (`Questionid`);

--
-- Indexes for table `rightoption`
--
ALTER TABLE `rightoption`
  ADD PRIMARY KEY (`Rightoptionid`),
  ADD KEY `Optionid` (`Optionid`),
  ADD KEY `Questionid` (`Questionid`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`Testid`),
  ADD KEY `Userid` (`Userid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `Optionid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `Questionid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `Responseid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `response_session`
--
ALTER TABLE `response_session`
  MODIFY `ResponseSessionid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rightanswer`
--
ALTER TABLE `rightanswer`
  MODIFY `Rightanswerid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rightoption`
--
ALTER TABLE `rightoption`
  MODIFY `Rightoptionid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `Testid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `Userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_ibfk_1` FOREIGN KEY (`Questionid`) REFERENCES `questions` (`Questionid`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`Testid`) REFERENCES `tests` (`Testid`);

--
-- Constraints for table `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`Questionid`) REFERENCES `questions` (`Questionid`),
  ADD CONSTRAINT `responses_ibfk_2` FOREIGN KEY (`Optionid`) REFERENCES `options` (`Optionid`),
  ADD CONSTRAINT `responses_ibfk_3` FOREIGN KEY (`Testid`) REFERENCES `tests` (`Testid`),
  ADD CONSTRAINT `responses_ibfk_4` FOREIGN KEY (`ResponseSessionid`) REFERENCES `response_session` (`ResponseSessionid`);

--
-- Constraints for table `response_session`
--
ALTER TABLE `response_session`
  ADD CONSTRAINT `response_session_ibfk_1` FOREIGN KEY (`Testid`) REFERENCES `tests` (`Testid`);

--
-- Constraints for table `rightanswer`
--
ALTER TABLE `rightanswer`
  ADD CONSTRAINT `rightanswer_ibfk_1` FOREIGN KEY (`Questionid`) REFERENCES `questions` (`Questionid`);

--
-- Constraints for table `rightoption`
--
ALTER TABLE `rightoption`
  ADD CONSTRAINT `rightoption_ibfk_1` FOREIGN KEY (`Optionid`) REFERENCES `options` (`Optionid`),
  ADD CONSTRAINT `rightoption_ibfk_2` FOREIGN KEY (`Questionid`) REFERENCES `questions` (`Questionid`);

--
-- Constraints for table `tests`
--
ALTER TABLE `tests`
  ADD CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`Userid`) REFERENCES `users` (`Userid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
