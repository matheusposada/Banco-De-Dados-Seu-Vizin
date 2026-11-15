PRAGMA foreign_keys = ON;

INSERT INTO cidade (id_cidade, nome, estado) VALUES
  (1, 'Florianópolis', 'SC'),
  (2, 'São José',      'SC'),
  (3, 'Palhoça',       'SC');

INSERT INTO bairro (id_bairro, id_cidade, nome) VALUES
  (1,  1, 'Trindade'),
  (2,  1, 'Centro'),
  (3,  1, 'Lagoa da Conceição'),
  (4,  1, 'Ingleses do Rio Vermelho'),
  (5,  1, 'Campeche'),
  (6,  1, 'Itacorubi'),
  (7,  2, 'Kobrasol'),
  (8,  2, 'Campinas'),
  (9,  2, 'Barreiros'),
  (10, 2, 'Forquilhinhas'),
  (11, 3, 'Pagani'),
  (12, 3, 'Pedra Branca'),
  (13, 3, 'Ponte do Imaruim'),
  (14, 3, 'Aririú'),
  (15, 3, 'Passa Vinte');


INSERT INTO usuario (id_usuario, nome, email, data_nascimento, tipo) VALUES
  (1,  'Ana Paula Souza',     'ana.souza@gmail.com',      '1995-03-12', 'morador'),
  (2,  'Bruno Martins',       'bruno.martins@gmail.com',  '1990-07-25', 'morador'),
  (3,  'Carla Mendes',        'carla.mendes@gmail.com',   '1988-11-02', 'morador'),
  (4,  'Diego Ferreira',      'diego.ferreira@gmail.com', '2000-01-18', 'morador'),
  (5,  'Eduarda Lima',        'eduarda.lima@gmail.com',   '1998-09-30', 'morador'),
  (6,  'Felipe Rocha',        'felipe.rocha@gmail.com',   '1985-05-14', 'morador'),
  (7,  'Gabriela Nunes',      'gabriela.nunes@gmail.com', '1992-12-08', 'morador'),
  (8,  'Heitor Alves',        'heitor.alves@gmail.com',   '1979-04-21', 'morador'),
  (9,  'Isabela Costa',       'isabela.costa@gmail.com',  '2002-06-09', 'morador'),
  (10, 'João Pedro Silva',    'joao.silva@gmail.com',     '1996-10-27', 'morador'),
  (11, 'Karina Duarte',       'karina.duarte@gmail.com',  '2001-02-15', 'interessado'),
  (12, 'Lucas Barbosa',       'lucas.barbosa@gmail.com',  '1999-08-03', 'interessado'),
  (13, 'Marta Oliveira',      'marta.oliveira@gmail.com', '1970-03-29', 'proprietario'),
  (14, 'Nelson Teixeira',     'nelson.teixeira@gmail.com','1965-09-17', 'proprietario'),
  (15, 'Olívia Ramos',        'olivia.ramos@gmail.com',   '1989-01-11', 'corretor');


INSERT INTO imobiliaria (id_imobiliaria, id_matriz, nome, cnpj) VALUES
  (1, NULL, 'Ilha Imóveis',                  '11222333000101'),
  (4, NULL, 'Casa Certa Imóveis',            '44555666000101'),
  (6, NULL, 'Morar Bem Imóveis',             '77888999000101');

INSERT INTO imobiliaria (id_imobiliaria, id_matriz, nome, cnpj) VALUES
  (2, 1, 'Ilha Imóveis - Filial Trindade',   '11222333000201'),
  (3, 1, 'Ilha Imóveis - Filial Kobrasol',   '11222333000301'),
  (5, 4, 'Casa Certa Imóveis - Palhoça',     '44555666000201');


INSERT INTO estabelecimento (id_estabelecimento, id_bairro, nome, categoria) VALUES
  (1,  1,  'Mercado Trindade',                 'mercado'),
  (2,  1,  'Farmácia Universitária',           'farmacia'),
  (3,  1,  'Terminal de Ônibus Trindade',      'transporte'),
  (4,  3,  'Escola Municipal da Lagoa',        'escola'),
  (5,  2,  'Supermercado Central',             'mercado'),
  (6,  2,  'Farmácia Popular Centro',          'farmacia'),
  (7,  2,  'Terminal de Ônibus Centro',        'transporte'),
  (8,  4,  'Mercado Ingleses',                 'mercado'),
  (9,  5,  'Colégio Campeche',                 'escola'),
  (10, 7,  'Farmácia Kobrasol',                'farmacia'),
  (11, 7,  'Mercado Kobrasol',                 'mercado'),
  (12, 7,  'Terminal de Ônibus Kobrasol',      'transporte'),
  (13, 12, 'Escola Estadual Pedra Branca',     'escola'),
  (14, 11, 'Farmácia Pagani',                  'farmacia'),
  (15, 14, 'Mercado Aririú',                   'mercado'),
  (16, 9,  'Mercado Bela Vista (fechado)',     'mercado');


INSERT INTO imovel (id_imovel, id_bairro, id_imobiliaria, tipo, finalidade, area_m2, preco, status) VALUES
  (1,  1,  2,    'apartamento', 'aluguel',  55.00,    1800.00, 'ativo'),
  (2,  1,  2,    'kitnet',      'aluguel',  28.00,    1200.00, 'ativo'),
  (3,  2,  1,    'apartamento', 'aluguel',  70.00,    2500.00, 'ativo'),
  (4,  3,  1,    'casa',        'aluguel', 120.00,    4200.00, 'alugado'),
  (5,  4,  4,    'apartamento', 'aluguel',  62.00,    2100.00, 'ativo'),
  (6,  5,  NULL, 'casa',        'aluguel',  95.00,    2900.00, 'ativo'),
  (7,  7,  3,    'apartamento', 'aluguel',  48.00,    1100.00, 'ativo'),
  (8,  11, 5,    'casa',        'aluguel', 140.00,    3800.00, 'pendente'),
  (9,  1,  1,    'apartamento', 'venda',    60.00,  450000.00, 'ativo'),
  (10, 2,  4,    'apartamento', 'venda',    85.00,  680000.00, 'ativo'),
  (11, 5,  4,    'casa',        'venda',   150.00, 1200000.00, 'vendido'),
  (12, 7,  3,    'apartamento', 'venda',    70.00,  420000.00, 'ativo'),
  (13, 12, 5,    'apartamento', 'venda',    55.00,  390000.00, 'ativo');

INSERT INTO imovel (id_imovel, id_bairro, id_imobiliaria, tipo, finalidade, area_m2, preco) VALUES
  (14, 13, NULL, 'terreno',     'venda',   360.00,  210000.00),
  (15, 11, 5,    'casa',        'venda',   110.00,  530000.00);


INSERT INTO avaliacao (id_avaliacao, id_usuario, id_bairro, data, nota, topico, situacao_moradia, motivo) VALUES
  (1,  1,  1, '2026-03-10', 4.5, 'qualidade_de_vida', 'atual',  'Bairro universitário, movimentado e com muitas opções.'),
  (2,  2,  1, '2026-03-15', 4.0, 'comercio',          'atual',  'Mercados e farmácias a poucos minutos a pé.'),
  (3,  3,  1, '2026-04-02', 5.0, 'infraestrutura',    'antigo', NULL),
  (4,  4,  1, '2026-04-20', 4.0, 'seguranca',         'atual',  NULL),

  (5,  1,  2, '2026-05-05', 3.0, 'custo_de_vida',     'antigo', NULL),
  (6,  5,  2, '2026-05-12', 3.5, 'comercio',          'atual',  NULL),
  (7,  6,  2, '2026-05-20', 2.0, 'seguranca',         'atual',  'Ruas vazias e mal iluminadas à noite.'),

  (8,  7,  3, '2026-06-01', 1.5, 'seguranca',         'atual',  'Sofri um assalto na saída da praia, falta policiamento.'),
  (9,  8,  3, '2026-06-08', 2.0, 'seguranca',         'antigo', 'Presenciei um assalto a pedestres perto da lagoa e me mudei por causa disso.'),
  (10, 7,  3, '2026-06-09', 4.5, 'qualidade_de_vida', 'atual',  'Natureza e lazer excelentes.'),

  (11, 9,  4, '2026-07-03', 4.0, 'comercio',          'atual',  'Muitos mercados e restaurantes perto de casa.'),
  (12, 10, 4, '2026-07-11', 3.5, 'infraestrutura',    'antigo', NULL),

  (13, 2,  5, '2026-07-19', 4.5, 'qualidade_de_vida', 'antigo', 'Praia e tranquilidade, mas o trânsito piorou.'),
  (14, 9,  5, '2026-07-25', 2.5, 'custo_de_vida',     'atual',  'Aluguéis subiram muito nos últimos anos.'),

  (15, 3,  6, '2026-08-04', 3.5, 'infraestrutura',    'atual',  NULL),
  (16, 4,  6, '2026-08-14', 1.0, 'infraestrutura',    'antigo', 'Alagamentos frequentes quando chove forte.'),

  (17, 5,  7, '2026-08-22', 4.0, 'comercio',          'atual',  'Tudo perto: mercado, farmácia e transporte.'),
  (18, 10, 7, '2026-09-02', 3.0, 'seguranca',         'antigo', NULL),

  (19, 6,  8, '2026-09-15', 3.5, 'custo_de_vida',     'atual',  NULL),

  (20, 1,  9, '2026-10-01', 4.0, 'qualidade_de_vida', 'antigo', 'Bairro calmo, boa vizinhança.');

UPDATE imovel
SET status = 'ativo'
WHERE id_imovel = 8;

DELETE FROM estabelecimento
WHERE id_estabelecimento = 16;