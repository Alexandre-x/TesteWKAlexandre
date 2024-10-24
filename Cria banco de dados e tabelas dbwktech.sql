CREATE DATABASE `dbwktech` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(40) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `nome_cliente_idx` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `preco_venda` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `descricao_produto` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`numero_pedido`),
  UNIQUE KEY `numero_pedido_UNIQUE` (`numero_pedido`),
  KEY `fk_codigo_cliente_clientes_idx` (`codigo_cliente`),
  CONSTRAINT `fk_codigo_cliente_clientes` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos_produtos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` decimal(11,4) NOT NULL,
  `valor_unitario` decimal(11,2) NOT NULL,
  `valor_total` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_numero_pedido_pedidos_idx` (`numero_pedido`),
  KEY `fk_codigo_produto_produtos_idx` (`codigo_produto`),
  CONSTRAINT `fk_codigo_produto_produtos` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `fk_numero_pedido_pedidos` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`numero_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
