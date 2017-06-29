-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.18-0ubuntu0.16.04.1 - (Ubuntu)
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para livrosapoio
CREATE DATABASE IF NOT EXISTS `livrosapoio` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_mysql500_ci */;
USE `livrosapoio`;

-- Copiando estrutura para tabela livrosapoio.copia
CREATE TABLE IF NOT EXISTS `copia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `copia` int(11) DEFAULT NULL,
  `data_copia` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_aluno` (`id_aluno`),
  CONSTRAINT `fk_id_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela livrosapoio.entrega
CREATE TABLE IF NOT EXISTS `entrega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) DEFAULT NULL,
  `id_livro` int(11) DEFAULT NULL,
  `data_ent` date DEFAULT NULL,
  `descricao_livro` varchar(144) DEFAULT NULL,
  `volume_livro` varchar(144) DEFAULT NULL,
  `nome_livro` varchar(144) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_livro` (`id_livro`),
  KEY `fk_aluno` (`id_aluno`),
  CONSTRAINT `fk_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `usuario` (`id`),
  CONSTRAINT `fk_livro` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela livrosapoio.estoque
CREATE TABLE IF NOT EXISTS `estoque` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_l_est` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_l` (`id_l_est`),
  CONSTRAINT `fk_id_l` FOREIGN KEY (`id_l_est`) REFERENCES `livro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela livrosapoio.livro
CREATE TABLE IF NOT EXISTS `livro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) DEFAULT NULL,
  `volume` varchar(10) DEFAULT NULL,
  `descricao` varchar(1024) DEFAULT NULL,
  `isLivro` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela livrosapoio.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matricula` varchar(25) NOT NULL,
  `nome` varchar(144) DEFAULT NULL,
  `isaluno` int(11) DEFAULT NULL,
  `senha` varchar(1024) DEFAULT NULL,
  `email` varchar(144) DEFAULT NULL,
  `copia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
