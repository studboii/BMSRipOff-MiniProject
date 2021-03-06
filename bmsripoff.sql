-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2019 at 10:59 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bmsripoff`
--
CREATE DATABASE IF NOT EXISTS `bmsripoff` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bmsripoff`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `UpdateForSalesStat`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateForSalesStat` (IN `MvName` VARCHAR(50))  MODIFIES SQL DATA
    COMMENT 'The Procedure Updates the Number of Tkts Sold for a given Movie'
UPDATE salesstat set TktsSold = TktsSold+1 WHERE Name LIKE MvName$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_log`
--

DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log` (
  `Admin` varchar(200) NOT NULL,
  `Pass` varchar(500) NOT NULL,
  `Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin_log`
--

INSERT INTO `admin_log` (`Admin`, `Pass`, `Name`) VALUES
('a', '$2y$10$U/Mc2Y.eAQQ3MxEBYna2YuJ.UxD30YvNdXAAug3J88LVwQJ4dRoeS', 'a'),
('abbasIsBadPerson', '$2y$10$VJtYu/Rn2ugMgMtqkg4Bj.Ku7hh7/T1wTIvxcsSY5fJFoYsVJ/d3G', 'abbaa'),
('ad', '$2y$10$gs.i3Oao1Clisz1H1gevGeN3DctVJPVmMoue4tyunb1V372F7oaWm', 'ad'),
('AllenNo1', '$2y$10$pls5VPZ5PddFFdpYklFv/OZU6wZ.Gaw8/VL8nDglMD1kFTxxEgd.2', 'Allen'),
('studboii', '$2y$10$791yRIrdeQOBidjSpln5ieSNrWbTKUcsJbHjUZ0vqKCG6ZOvw.Rh6', 'Jawad');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `uid` varchar(50) NOT NULL,
  `Bid` varchar(50) NOT NULL,
  `MvName` varchar(50) NOT NULL,
  `Screen` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Saves the bookings for each user';

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`uid`, `Bid`, `MvName`, `Screen`) VALUES
('hrst', 'hrstSeatS2MURICA BEST6178', 'MURICA BEST', 's3'),
('hrst', 'hrstSeatS3Funeral Time9133', 'Funeral Time', 's1'),
('sk', 'skSeatS3MURICA BEST9855', 'MURICA BEST', 's3');

--
-- Triggers `bookings`
--
DROP TRIGGER IF EXISTS `ReduceTicketsSoldInSalesStat`;
DELIMITER $$
CREATE TRIGGER `ReduceTicketsSoldInSalesStat` AFTER DELETE ON `bookings` FOR EACH ROW UPDATE salesstat SET TktsSold = TktsSold-1 WHERE Name LIKE OLD.MvName
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deets`
--

DROP TABLE IF EXISTS `deets`;
CREATE TABLE `deets` (
  `Name` varchar(50) NOT NULL,
  `Synop` mediumtext,
  `PGRating` enum('U','UA','A','S') NOT NULL DEFAULT 'U',
  `Language` varchar(15) DEFAULT '"English"'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Just contains movie deets. ';

--
-- Dumping data for table `deets`
--

INSERT INTO `deets` (`Name`, `Synop`, `PGRating`, `Language`) VALUES
('Funeral Time', 'So I (74M) was recently hit by a car (2014 Honda) and died. My wife (5F) organized me a funeral (cost $2747) without asking me (74M) at all. I (74M) was unable to make it because I (74M) was dead (17 days). At the funeral I heard my dad (15M) and other family members talking about how they wish I could be there and now I feel bad for not showing up. AITA?', 'UA', 'Hindi'),
('Hit Or Miss', 'To hit, or not to hit. Dost thou ever miss? I suppose it not. You have a male love interest, yet I would wager he does not kiss thee (Ye olde mwah). Furthermore; he will find another lass like he won\'t miss thee. And at the end of it all. He is going to skrrt, and he will hit that dab, as if he were the man known by the name of Wiz Khalifa', 'UA', 'MissMe'),
('Incel The Movie', 'To be fair, you have to have a very high IQ to understand Rick and Morty. The humor is extremely subtle, and without a solid grasp of theoretical physics most of the jokes will go over a typical viewer\'s head. There\'s also Rick\'s nihilistic outlook, which is deftly woven into his characterisation - his personal philosophy draws heavily from Narodnaya Volya literature, for instance. The fans understand this stuff; they have the intellectual capacity to truly appreciate the depths of these jokes, to realize that they\'re not just funny- they say something deep about LIFE. As a consequence people who dislike Rick and Morty truly ARE idiots- of course they wouldn\'t appreciate, for instance, the humour in Rick\'s existencial catchphrase &quot;Wubba Lubba Dub Dub,&quot; which itself is a cryptic reference to Turgenev\'s Russian epic Fathers and Sons I\'m smirking right now just imagining one of those addlepated simpletons scratching their heads in confusion as Dan Harmon\'s genius unfolds itself on their television screens. What fools... how I pity them. ðŸ˜‚ And yes by the way, I DO have a Rick and Morty tattoo. And no, you cannot see it. It\'s for the ladies\' eyes only- And even they have to demonstrate that they\'re within 5 IQ points of my own (preferably lower) beforehand.', 'S', 'Spanish'),
('MURICA BEST', 'What the [redacted] did you just [redacted] say about me, you little [redacted]? I\'ll have you know I graduated top of my class in the Navy Seals, and I\'ve been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I\'m the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the [redacted]out with precision the likes of which has never been seen before on this Earth, mark my [redacted]words. You think you can get away with saying that [poo] to me over the Internet? Think again, [redacted]. As we speak I am contacting my secret network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You\'re [redacted] [not alive anymore], kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that\'s just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable [backside part] off the face of the continent, you little [redacted]. If only you could have known what unholy retribution your little &quot;clever&quot; comment was about to bring down upon you, maybe you would have held your [redacted] [mouth muscle]. But you couldn\'t, you didn\'t, and now you\'re paying the price, you [redacted][not smart person]. I will [excrete ]fury all over you and you will drown in it. You\'re [redacted][not alive anymore], kiddo.', 'A', 'henlo'),
('Thor 2 The Dark World', 'Hey it\'s Thor again, you know, the god of thunder. Listen buddy, if you don\'t log off this game immediately I am gonna fly over to your house, come down to that basement you\'re hiding in, rip off your arms and shove them up your butt! Oh, that\'s right, yes! Go cry to your father, you little weasel.', 'U', 'Eng'),
('Your Mom is Existential', 'Snake... why are we still here? Just to suffer? Every night, I can feel my leg and my arm... even my fingers... the body I\'ve lost... the comrades I\'ve lost... won\'t stop hurting. It\'s like they\'re all still there. You feel it too, don\'t you? I\'m the one who got caught up with Cipher. A group above nations... even the US. And I was the parasite below, feeding off Zero\'s power. They came after you in Cyprus... then Afghanistan... Cipher... just keeps growing. Swallowing everything in it\'s path. Getting bigger and bigger... Who knows how big now? Boss. I\'m gonna make \'em give back our past... take back everything that we\'ve lost. And I won\'t rest... until we do.', 'A', 'English'),
('your nt niec', 'Give it up folks, einstein over here has something to say. What\'s that buddy? Wha- A grammatical error?!? WHAT?!? B... Bu... That can\'t be possible! Surely not! A GRAMMAR MISTAKE? IN MY SIGHT?!? What a great, absolute miracle that you and your 257 IQ Brain was here to correct it! Thank you! Have my grattitude, Actually, What\'s your cashapp? I\'d like to give you 20$... Know what? While we\'re at it have the keys to my car. Actually, no, scratch that. Have the keys to my house, go watch my kids grow up and fuck my wife. Also, my Paypal username and password is: Ilikesmartazzes4 and 968386329. Go have fun. Thank you for your work.ï»¿', 'UA', 'English');

--
-- Triggers `deets`
--
DROP TRIGGER IF EXISTS `DeetsTriggerForSalesStat`;
DELIMITER $$
CREATE TRIGGER `DeetsTriggerForSalesStat` AFTER INSERT ON `deets` FOR EACH ROW INSERT INTO `salesstat` (`Name`, `TktsSold`) VALUES (NEW.Name, 0)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `uid` varchar(50) NOT NULL,
  `pass` varchar(500) NOT NULL,
  `Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This is the Table with Login details for the user';

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`uid`, `pass`, `Name`) VALUES
('a', '$2y$10$TNHx2r6mKSgVCtT/99khHOk89MTWh939xq9evMLqNxC.72GoK2.ue', 'a'),
('b', '$2y$10$fjNHG1p1lMtLP1Xum1HLZ.xJ5uRcm1eScqzFn16wj4ZWjo5.JLY62', 'b'),
('c', '$2y$10$pEXWoTPEIkbraN9y1Hz1J.MPnUwNQIi3576kALUQZMWOfKroBs.g6', 'c'),
('hrst', '$2y$10$oU7pyVdsQV4CdzgoSYO2xuevyghma5w1lEMZrseFZ69Xa4pwGCE6m', 'Diwakar'),
('sk', '$2y$10$xuaJOCC3a9bFEpUEid75KusxYrSmc8jX8j63HWHdwfw4gS.hANxJG', 'savitri');

-- --------------------------------------------------------

--
-- Table structure for table `moviet`
--

DROP TABLE IF EXISTS `moviet`;
CREATE TABLE `moviet` (
  `Name` varchar(50) NOT NULL,
  `Screen` varchar(3) NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Holds Screens and time a movie is running at';

--
-- Dumping data for table `moviet`
--

INSERT INTO `moviet` (`Name`, `Screen`, `Time`) VALUES
('Funeral Time', 's1', '09:00:00'),
('Funeral Time', 's1', '16:00:00'),
('Funeral Time', 's2', '20:15:00'),
('Incel The Movie', 's2', '09:00:00'),
('MURICA BEST', 's3', '09:00:00'),
('your nt niec', 's1', '15:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `s1`
--

DROP TABLE IF EXISTS `s1`;
CREATE TABLE `s1` (
  `Sno` int(11) NOT NULL,
  `bid` varchar(50) NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Booked seats for a given show';

--
-- Dumping data for table `s1`
--

INSERT INTO `s1` (`Sno`, `bid`, `Time`) VALUES
(49, 'hrstSeatS3Funeral Time9133', '14:00:00'),
(50, 'hrstSeatS3Funeral Time9133', '14:00:00'),
(51, 'hrstSeatS3Funeral Time9133', '14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `s2`
--

DROP TABLE IF EXISTS `s2`;
CREATE TABLE `s2` (
  `Sno` int(11) NOT NULL,
  `bid` varchar(50) NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Booked seats for a given show';

-- --------------------------------------------------------

--
-- Table structure for table `s3`
--

DROP TABLE IF EXISTS `s3`;
CREATE TABLE `s3` (
  `Sno` int(11) NOT NULL,
  `bid` varchar(50) NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Booked seats for a given show';

--
-- Dumping data for table `s3`
--

INSERT INTO `s3` (`Sno`, `bid`, `Time`) VALUES
(1, 'hrstSeatS2MURICA BEST6178', '09:00:00'),
(2, 'skSeatS3MURICA BEST9855', '09:00:00'),
(3, 'skSeatS3MURICA BEST9855', '09:00:00'),
(4, 'skSeatS3MURICA BEST9855', '09:00:00'),
(46, 'hrstSeatS2MURICA BEST6178', '09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `s4`
--

DROP TABLE IF EXISTS `s4`;
CREATE TABLE `s4` (
  `Sno` int(11) NOT NULL,
  `bid` varchar(50) NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Booked seats for a given show';

-- --------------------------------------------------------

--
-- Table structure for table `salesstat`
--

DROP TABLE IF EXISTS `salesstat`;
CREATE TABLE `salesstat` (
  `Name` varchar(50) NOT NULL,
  `TktsSold` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salesstat`
--

INSERT INTO `salesstat` (`Name`, `TktsSold`) VALUES
('Funeral Time', 6),
('Hit Or Miss', 0),
('Incel The Movie', 0),
('MURICA BEST', 5),
('Thor 2 The Dark World', 0),
('Your Mom is Existential', 0),
('your nt niec', 0);

-- --------------------------------------------------------

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
CREATE TABLE `screens` (
  `SName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `screens`
--

INSERT INTO `screens` (`SName`) VALUES
('s1'),
('s2'),
('s3'),
('s4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_log`
--
ALTER TABLE `admin_log`
  ADD PRIMARY KEY (`Admin`(50));

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`Bid`),
  ADD KEY `UidLinkToLogin` (`uid`),
  ADD KEY `MovieNameLinkToDetails` (`MvName`),
  ADD KEY `ScreenToScreens` (`Screen`);

--
-- Indexes for table `deets`
--
ALTER TABLE `deets`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `moviet`
--
ALTER TABLE `moviet`
  ADD PRIMARY KEY (`Screen`,`Time`),
  ADD KEY `MovieNamesLinked` (`Name`);

--
-- Indexes for table `s1`
--
ALTER TABLE `s1`
  ADD PRIMARY KEY (`Sno`,`bid`),
  ADD KEY `BidLinkToBookings` (`bid`);

--
-- Indexes for table `s2`
--
ALTER TABLE `s2`
  ADD PRIMARY KEY (`Sno`,`bid`),
  ADD KEY `BidLinkForScreen2` (`bid`);

--
-- Indexes for table `s3`
--
ALTER TABLE `s3`
  ADD PRIMARY KEY (`Sno`,`bid`),
  ADD KEY `BidLinkForScreen3` (`bid`);

--
-- Indexes for table `s4`
--
ALTER TABLE `s4`
  ADD PRIMARY KEY (`Sno`,`bid`),
  ADD KEY `BidLinkForScreen4` (`bid`);

--
-- Indexes for table `salesstat`
--
ALTER TABLE `salesstat`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `screens`
--
ALTER TABLE `screens`
  ADD PRIMARY KEY (`SName`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `MovieNameLinkToDetails` FOREIGN KEY (`MvName`) REFERENCES `deets` (`Name`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `ScreenToScreens` FOREIGN KEY (`Screen`) REFERENCES `screens` (`SName`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `UidLinkToLogin` FOREIGN KEY (`uid`) REFERENCES `login` (`uid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `moviet`
--
ALTER TABLE `moviet`
  ADD CONSTRAINT `MovieNamesLinked` FOREIGN KEY (`Name`) REFERENCES `deets` (`Name`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `s1`
--
ALTER TABLE `s1`
  ADD CONSTRAINT `BidLinkToBookings` FOREIGN KEY (`bid`) REFERENCES `bookings` (`Bid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `s2`
--
ALTER TABLE `s2`
  ADD CONSTRAINT `BidLinkForScreen2` FOREIGN KEY (`bid`) REFERENCES `bookings` (`Bid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `s3`
--
ALTER TABLE `s3`
  ADD CONSTRAINT `BidLinkForScreen3` FOREIGN KEY (`bid`) REFERENCES `bookings` (`Bid`) ON DELETE CASCADE;

--
-- Constraints for table `s4`
--
ALTER TABLE `s4`
  ADD CONSTRAINT `BidLinkForScreen4` FOREIGN KEY (`bid`) REFERENCES `bookings` (`Bid`) ON DELETE CASCADE;

--
-- Constraints for table `salesstat`
--
ALTER TABLE `salesstat`
  ADD CONSTRAINT `StatsNameLinkToDeetsName` FOREIGN KEY (`Name`) REFERENCES `deets` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
