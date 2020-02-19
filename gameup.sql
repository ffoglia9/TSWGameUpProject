--
-- Struttura della tabella `fatturazione`
--

DROP TABLE IF EXISTS `fatturazione`;
CREATE TABLE IF NOT EXISTS `fatturazione` (
  `ID_Fatturazione` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Utente` int(11) NOT NULL,
  `Nome` varchar(40) NOT NULL,
  `Cognome` varchar(40) NOT NULL,
  `Email` varchar(80) NOT NULL,
  `Via` varchar(120) NOT NULL,
  `CAP` mediumint(9) NOT NULL,
  `Città` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_Fatturazione`),
  KEY `ID_Utente` (`ID_Utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Struttura della tabella `gioco`
--

DROP TABLE IF EXISTS `gioco`;
CREATE TABLE IF NOT EXISTS `gioco` (
  `ID_Gioco` int(11) NOT NULL AUTO_INCREMENT,
  `Titolo` varchar(60) NOT NULL,
  `Descrizione` varchar(255) NOT NULL,
  `Immagine` varchar(255) NOT NULL,
  `Icon` varchar(255) NOT NULL,
  `Prezzo` double NOT NULL,
  `Sconto` int NOT NULL DEFAULT 0,
  `Genere` ENUM('Action','RTS','Adventure','Puzzle','Arcade') NOT NULL,
  `ID_Sponsor` int(11) NOT NULL DEFAULT -1,
  `Approvato` tinyint(1) NOT NULL,
  `ID_Utente` int(11) NOT NULL,
  `Valutazione` int(3) DEFAULT 100,
  KEY `ID_Sponsor` (`ID_Sponsor`),
  KEY `ID_Utente`(`ID_Utente`),
  PRIMARY KEY (`ID_Gioco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `recensione`
--

DROP TABLE IF EXISTS `recensione`;
CREATE TABLE IF NOT EXISTS `recensione` (
  `ID_Recensione` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Gioco` int(11) NOT NULL,
  `ID_Utente` int(11) NOT NULL,
  `Consigliato` tinyint(1) NOT NULL,
  `Opinione` varchar(420) NOT NULL,
  PRIMARY KEY (`ID_Recensione`),
  KEY `ID_Giochi` (`ID_Gioco`,`ID_Utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `sponsorizzazione`
--

DROP TABLE IF EXISTS `sponsorizzazione`;
CREATE TABLE IF NOT EXISTS `sponsorizzazione` (
  `ID_Sponsor` int(11) NOT NULL AUTO_INCREMENT,
  `DataInizio` date NOT NULL,
  `DataFine` date NOT NULL,
  PRIMARY KEY (`ID_Sponsor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `transazione`
--

DROP TABLE IF EXISTS `transazione`;
CREATE TABLE IF NOT EXISTS `transazione` (
  `ID_Transazione` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Gioco` int(11) NOT NULL,
  `ID_Utente` int(11) NOT NULL,
  `ID_Fatturazione` int(11) NOT NULL,
  `Data` datetime NOT NULL,
  PRIMARY KEY (`ID_Transazione`),
  KEY `ID_Gioco` (`ID_Gioco`,`ID_Utente`,`ID_Fatturazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

DROP TABLE IF EXISTS `utente`;
CREATE TABLE IF NOT EXISTS `utente` (
  `ID_Utente` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) NOT NULL,
  `Password` varchar(21) NOT NULL,
  `Tipo_Utente` enum('0','1','2') NOT NULL,
  `Email` varchar(80) NOT NULL,


  PRIMARY KEY (`ID_Utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
