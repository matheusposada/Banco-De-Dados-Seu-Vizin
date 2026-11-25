-- =====================================================================
-- 01_ddl.sql - Seu Vizin
-- Criacao das tabelas, restricoes e ALTER TABLE documentado.
-- Executar em um banco vazio, antes do 02_dml.sql.
-- =====================================================================

PRAGMA foreign_keys = ON;


-- cidade
-- ---------------------------------------------------------------------
CREATE TABLE cidade (
    id_cidade   INTEGER PRIMARY KEY,
    nome        TEXT NOT NULL,
    estado      TEXT NOT NULL
);


-- bairro (cada bairro pertence a uma unica cidade)
-- ---------------------------------------------------------------------
CREATE TABLE bairro (
    id_bairro   INTEGER PRIMARY KEY,
    nome        TEXT NOT NULL,
    id_cidade   INTEGER NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);


-- imobiliaria (autorrelacionamento: filial aponta para a matriz)
-- ---------------------------------------------------------------------
CREATE TABLE imobiliaria (
    id_imobiliaria  INTEGER PRIMARY KEY,
    id_matriz       INTEGER,    -- NULL quando o registro e uma matriz
    nome            TEXT NOT NULL,
    cnpj            TEXT NOT NULL UNIQUE
                    CHECK (length(cnpj) = 14),   -- somente numeros
    FOREIGN KEY (id_matriz) REFERENCES imobiliaria (id_imobiliaria)
);


-- usuario
-- ---------------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario      INTEGER PRIMARY KEY,
    nome            TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    tipo            TEXT NOT NULL
                    CHECK (tipo IN ('morador', 'interessado', 'proprietario', 'corretor'))
);


-- estabelecimento
-- ---------------------------------------------------------------------
CREATE TABLE estabelecimento (
    id_estabelecimento  INTEGER PRIMARY KEY,
    id_bairro           INTEGER NOT NULL,
    nome                TEXT NOT NULL,
    categoria           TEXT NOT NULL
                        CHECK (categoria IN ('mercado', 'farmacia', 'escola', 'transporte')),
    FOREIGN KEY (id_bairro) REFERENCES bairro (id_bairro)
);


CREATE TABLE imovel (
    id_imovel       INTEGER PRIMARY KEY,
    id_bairro       INTEGER NOT NULL,
    id_imobiliaria  INTEGER,    -- opcional: anuncio pode nao ter imobiliaria
    tipo            TEXT NOT NULL
                    CHECK (tipo IN ('apartamento', 'casa', 'kitnet', 'terreno')),
    finalidade      TEXT NOT NULL
                    CHECK (finalidade IN ('aluguel', 'venda')),
    area_m2         REAL NOT NULL CHECK (area_m2 > 0),
    preco           REAL NOT NULL CHECK (preco > 0),
    status          TEXT NOT NULL DEFAULT 'pendente'
                    CHECK (status IN ('pendente', 'ativo', 'alugado', 'vendido')),
    FOREIGN KEY (id_bairro)      REFERENCES bairro (id_bairro),
    FOREIGN KEY (id_imobiliaria) REFERENCES imobiliaria (id_imobiliaria)
);

-- avaliacao (resolve o N:N entre usuario e bairro)
-- ---------------------------------------------------------------------
CREATE TABLE avaliacao (
    id_avaliacao     INTEGER PRIMARY KEY,
    id_usuario       INTEGER NOT NULL,
    id_bairro        INTEGER NOT NULL,
    data             DATE NOT NULL,
    nota             REAL NOT NULL CHECK (nota BETWEEN 0.5 AND 5.0),
    topico           TEXT NOT NULL
                     CHECK (topico IN ('seguranca', 'infraestrutura', 'custo_de_vida',
                                       'qualidade_de_vida', 'comercio')),
    situacao_moradia TEXT NOT NULL
                     CHECK (situacao_moradia IN ('atual', 'antigo')),
    motivo           TEXT,
    -- regra 7: nota abaixo de 2,5 exige motivo preenchido
    CHECK (nota >= 2.5 OR (motivo IS NOT NULL AND motivo <> '')),
    -- regra 6: um usuario avalia o mesmo topico do mesmo bairro uma unica vez
    UNIQUE (id_usuario, id_bairro, topico),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_bairro)  REFERENCES bairro (id_bairro)
);

-- ---------------------------------------------------------------------
-- ALTER TABLE documentado:
-- Adiciona o telefone de contato da imobiliaria, que nao foi previsto na
-- modelagem inicial. A coluna e opcional (aceita NULL), entao as
-- imobiliarias ja cadastradas continuam validas sem precisar de valor.
-- ---------------------------------------------------------------------
ALTER TABLE imobiliaria ADD COLUMN telefone TEXT;
