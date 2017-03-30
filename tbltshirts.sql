-- phpMyAdmin SQL Dump
-- version 2.11.6
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generatie Tijd: 14 Mei 2010 om 15:00
-- Server versie: 5.0.45
-- PHP Versie: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `basketlummen`
--

-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `tbltshirts`
--

CREATE TABLE `tbltshirts` (
  `id` int(11) NOT NULL auto_increment,
  `naam` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `maat` varchar(5) default NULL,
  `kleur` varchar(5) default NULL,
  `aantal` varchar(5) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=176 ;

--
-- Gegevens worden uitgevoerd voor tabel `tbltshirts`
--

INSERT INTO `tbltshirts` (`id`, `naam`, `email`, `maat`, `kleur`, `aantal`) VALUES
(108, 'Doggen Linda', 'doggenlinda@hotmail.be', 'M', 'geel', '1'),
(114, 'Ludo Convents', 'ludo.convents@telenet.be', 'S', 'geel', '1'),
(115, 'Ludo Convents', 'ludo.convents@telenet.be', 'M', 'geel', '1'),
(116, 'Bert Coenen', 'bert.coenen@basketlummen.be', 'M', 'geel', '1'),
(117, 'Coolen Dieter', 'luc.coolen@skynet.be', 'L', 'geel', '1'),
(118, 'Pollaris Luc', 'luc.pollaris@skynet.be', 'XL', 'geel', '1'),
(119, 'aime zurings', 'aime.zurings@gmailcom', 'XL', 'geel', '1'),
(120, 'Daniël Cromphout', 'danielcromphout@telenet.be', 'S', 'geel', '1'),
(121, 'Daniël Cromphout', 'danielcromphout@telenet.be', 'M', 'geel', '1'),
(122, 'Daniël Cromphout', 'danielcromphout@telenet.be', 'XXL', 'geel', '1'),
(123, 'Patric Wauters', 'info@volderswauters.be', 'XL', 'geel', '1'),
(124, 'Benny Michiels', 'benmichiels@hotmail.com', 'S', 'geel', '2'),
(125, 'Benny Michiels', 'benmichiels@hotmail.com', 'M', 'geel', '1'),
(126, 'Benny Michiels', 'benmichiels@hotmail.com', 'L', 'geel', '1'),
(127, 'Johnny Peeters', 'johnny.peeters@basketlummen.be', 'L', 'geel', '1'),
(128, 'Bruno Pussig', 'bruno.pussig@telenet.be', 'XXL', 'geel', '2'),
(129, 'Eddy', 'eddy.coenen1@telenet.be', 'XXL', 'geel', '1'),
(130, 'Paraskevopoulos', 'aris.paras@belgacom.net', 'XXL', 'geel', '1'),
(131, 'ste', 'stefan.coenen@scarlet.be', 'XXL', 'geel', '1'),
(132, 'Carmans Liesa', 'gino.carmans@skynet.be', 'M', 'geel', '1'),
(133, 'Davina Swinnen', 'davinaswinnen652@hotmail.com', 'M', 'geel', '1'),
(134, 'Wouters Ria (lateesha)', 'ria.wouters@scarlet.be', 'M', 'geel', '1'),
(135, 'Wouters Ria (lateesha)', 'ria.wouters@scarlet.be', 'L', 'geel', '1'),
(136, 'Martijn Broekx', 'martijn.broekx@basketlummen.be', 'XL', 'geel', '1'),
(137, 'castro dominique', '', 'L', 'geel', '1'),
(139, 'Wendy Castro', 'weny_castro@hotmail.com', 'M', 'geel', '1'),
(140, 'Vanderheyden Dominique', 'dominique_vanderheyden@skynet.be', 'XL', 'geel', '1'),
(141, 'PATRICK DIELTIENS', 'DIELTIENS.PATRICK@TELENET.BE', 'M', 'geel', '1'),
(142, 'PATRICK DIELTIENS', 'DIELTIENS.PATRICK@TELENET.BE', 'XL', 'geel', '1'),
(143, 'Caro Swolfs', 'dereze.els@telenet.be', 'M', 'geel', '1'),
(144, 'amy filtjens', 'filtjens@pandora.be', 'S', 'geel', '1'),
(145, 'amy filtjens', 'filtjens@pandora.be', 'L', 'geel', '1'),
(146, 'Coemans Lotte', 'gbiesmans@telenet.be', 'M', 'geel', '1'),
(148, 'vlaeyen bart', 'bart.vlaeyen@euphonynet.be', 'L', 'geel', '2'),
(149, 'Maxime Daniels', 'lievevandewal@hotmail.com', 'M', 'geel', '1'),
(150, 'daphne renders', 'chris.renders2@telenet.be', 'S', 'geel', '1'),
(151, 'daphne renders', 'chris.renders2@telenet.be', 'M', 'geel', '1'),
(158, 'onbekend', '', 'M', 'geel', '1'),
(159, 'Marlies Vlaeyen', 'marliesvlaeyen@hotmail.com', 'M', 'geel', '1'),
(160, 'Eva Bloemers', 'kathleensohl@java.eu', 'M', 'geel', '01'),
(161, 'Jens Meijen', 'johanmeijen@pandora.be', 'XL', 'geel', '1'),
(162, 'lemmens fran', 'linda.saenen@uzleuven.be', 'S', 'geel', '1'),
(163, 'Bernhard & Dietger Glorieux', 'Beste,', 'L', 'geel', '1'),
(164, 'Bernhard & Dietger Glorieux', 'Beste,', 'XL', 'geel', '1'),
(165, 'Karlien Bongaerts', 'karlientjebongaerts@hotmail.com', 'M', 'geel', '1'),
(166, 'Jolien Wouters', 'jollewouters@hotmail.com', 'S', 'geel', '1'),
(167, 'Jolien Wouters', 'jollewouters@hotmail.com', 'M', 'geel', '1'),
(168, 'Pussig Britt', 'britt.pussig@telenet.be', 'M', 'geel', '1'),
(169, 'Moons Karen', 'karentjemoons1@hotmail.com', 'M', 'geel', '1'),
(170, 'Moons Karen', 'karentjemoons1@hotmail.com', 'XL', 'geel', '1'),
(171, 'lise op de beeck', 'liseodb@yahoo.com', 'S', 'geel', '1'),
(172, 'Liselore Quintens', 'liselore_q@hotmail.com', 'M', 'geel', '1'),
(173, 'Nathalie Vaes', 'vaesnathalie@hotmail.com', 'M', 'geel', '2'),
(174, 'van briel tony', 'tony.vanbriel@gmail.com', 'L', 'geel', '1'),
(175, 'gielen lana', 'lana.gielen@fulladsl.be', 'L', 'geel', '01');
