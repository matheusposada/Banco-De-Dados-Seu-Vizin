CREATE TABLE `cidade` (
  `id_cidade` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `estado` varchar(50) NOT NULL
);

CREATE TABLE `bairro` (
  `id_bairro` integer PRIMARY KEY AUTO_INCREMENT,
  `id_cidade` integer NOT NULL,
  `nome` varchar(100) NOT NULL
);

CREATE TABLE `imobiliaria` (
  `id_imobiliaria` integer PRIMARY KEY AUTO_INCREMENT,
  `id_matriz` integer COMMENT 'Preenchido apenas nas filiais; a matriz fica NULL',
  `nome` varchar(150) NOT NULL,
  `cnpj` varchar(14) UNIQUE NOT NULL
);

CREATE TABLE `imovel` (
  `id_imovel` integer PRIMARY KEY AUTO_INCREMENT,
  `id_bairro` integer NOT NULL,
  `id_imobiliaria` integer COMMENT 'Anúncio pode não ter imobiliária',
  `tipo` varchar(50) NOT NULL,
  `finalidade` varchar(50) NOT NULL,
  `area_m2` decimal(10,2) NOT NULL,
  `preco` decimal(14,2) NOT NULL,
  `status` varchar(50) NOT NULL
);

CREATE TABLE `estabelecimento` (
  `id_estabelecimento` integer PRIMARY KEY AUTO_INCREMENT,
  `id_bairro` integer NOT NULL,
  `nome` varchar(150) NOT NULL,
  `categoria` varchar(100) NOT NULL
);

CREATE TABLE `usuario` (
  `id_usuario` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `email` varchar(150) UNIQUE NOT NULL,
  `data_nascimento` date NOT NULL,
  `tipo` varchar(50) NOT NULL
);

CREATE TABLE `avaliacao` (
  `id_avaliacao` integer PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` integer NOT NULL,
  `id_bairro` integer NOT NULL,
  `data` date NOT NULL,
  `nota` smallint NOT NULL,
  `topico` varchar(100) NOT NULL,
  `situacao_moradia` varchar(100) NOT NULL,
  `motivo` text COMMENT 'Opcional (O)'
);

ALTER TABLE `bairro` ADD FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`);

ALTER TABLE `imovel` ADD FOREIGN KEY (`id_bairro`) REFERENCES `bairro` (`id_bairro`);

ALTER TABLE `estabelecimento` ADD FOREIGN KEY (`id_bairro`) REFERENCES `bairro` (`id_bairro`);

ALTER TABLE `imovel` ADD FOREIGN KEY (`id_imobiliaria`) REFERENCES `imobiliaria` (`id_imobiliaria`);

ALTER TABLE `imobiliaria` ADD FOREIGN KEY (`id_matriz`) REFERENCES `imobiliaria` (`id_imobiliaria`);

ALTER TABLE `avaliacao` ADD FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `avaliacao` ADD FOREIGN KEY (`id_bairro`) REFERENCES `bairro` (`id_bairro`);
