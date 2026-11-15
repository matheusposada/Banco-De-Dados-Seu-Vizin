PRAGMA foreign_keys = ON;

CREATE TABLE cidade (
	id_cidade	INTEGER PRIMARY KEY,
	nome		TEXT NOT NULL,
	estado 		TEXT NOT NULL
);

CREATE TABLE bairro (
	id_bairro	INTEGER PRIMARY KEY,
	nome		TEXT NOT NULL,
	id_cidade 	INTEGER NOT NULL,
	FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);

CREATE TABLE imobiliaria (
	id_imobiliaria	INTEGER PRIMARY KEY,
	id_matriz		INTEGER,
	nome 			TEXT NOT NULL,
	cnpj			TEXT NOT NULL UNIQUE,
	FOREIGN KEY (id_matriz) REFERENCES imobiliaria (id_imobiliaria)
);

CREATE TABLE usuario (
	id_usuario	INTEGER PRIMARY KEY,
	nome 		TEXT NOT NULL,
	email		TEXT NOT NULL UNIQUE,
	data_nascimento		DATE NOT NULL,
	tipo 		TEXT NOT NULL CHECK (tipo IN ('morador', 'interessado', 'proprietario', 'corretor'))
	
);


CREATE TABLE estabelecimento (
	id_estabelecimento	INTEGER PRIMARY KEY,
	id_bairro			INTEGER NOT NULL,
	
	
	nome				TEXT NOT NULL,	
	categoria			TEXT NOT NULL CHECK (
							categoria IN (
							'farmacia', 'escola', 'mercado', 'transporte'
							)),
	FOREIGN KEY (id_bairro) REFERENCES bairro (id_bairro)
);

CREATE TABLE imovel (
	id_imovel 	INTEGER PRIMARY KEY,
	id_bairro	INTEGER NOT NULL,
	id_imobiliaria	INTEGER, 
	tipo		TEXT NOT NULL CHECK (tipo IN ('apartamento', 'casa', 'terreno', 'kitnet')),
	finalidade  TEXT NOT NULL CHECK (finalidade IN ('aluguel', 'venda')),
	area_m2		REAL NOT NULL CHECK (area_m2 > 0),
	preco		REAL NOT NULL CHECK (preco > 0),
	status		TEXT NOT NULL DEFAULT 'pendente',
	FOREIGN KEY (id_bairro) REFERENCES bairro (id_bairro),
	FOREIGN KEY (id_imobiliaria) REFERENCES imobiliaria (id_imobiliaria)
);

CREATE TABLE avaliacao (
	id_avaliacao	INTEGER PRIMARY KEY,
	id_usuario		INTEGER NOT NULL, 
	id_bairro		INTEGER NOT NULL, 
	data			DATE NOT NULL,
	nota			REAL NOT NULL CHECK (nota BETWEEN 0.5 AND 5.0),
	topico 			TEXT NOT NULL CHECK (topico IN ('seguranca', 'infraestrutura', 'custo_de_vida', 'qualidade_de_vida',
'comercio')),
	situacao_moradia TEXT NOT NULL,
	motivo			TEXT,
	CHECK (nota >= 2.5 OR (motivo IS NOT NULL AND motivo <> '')),
	FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
	FOREIGN KEY (id_bairro) REFERENCES bairro (id_bairro),
	UNIQUE (id_usuario, id_bairro, topico)
);


-- ALTER TABLE documentado:
-- Adiciona o telefone de contato da imobiliaria, que nao foi previsto na
-- modelagem inicial. A coluna e opcional (aceita NULL), entao as imobiliarias
-- ja cadastradas continuam validas sem precisar de valor.
ALTER TABLE imobiliaria ADD COLUMN telefone TEXT;
