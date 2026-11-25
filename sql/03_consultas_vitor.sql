-- =====================================================================
-- consultas Q8 a Q12 (junções) - Autor: Vitor
-- =====================================================================

-- Q8
-- Pergunta de negocio: quem avaliou o que? Lista cada avaliacao com o
-- nome do morador, o bairro, o topico, a nota e a data.
-- Tecnica: INNER JOIN entre 3 tabelas (usuario, avaliacao, bairro).
-- Autor: Vitor
SELECT u.nome AS usuario,
       b.nome AS bairro,
       a.topico,
       a.nota,
       a.data
FROM avaliacao a
INNER JOIN usuario u ON u.id_usuario = a.id_usuario
INNER JOIN bairro  b ON b.id_bairro  = a.id_bairro
ORDER BY b.nome, a.data;

-- Q9
-- Pergunta de negocio: quais bairros ainda nao receberam nenhuma
-- avaliacao (e, por isso, nao tem nota para exibir no app)?
-- Tecnica: LEFT JOIN; as linhas sem correspondencia em avaliacao
-- aparecem com NULL, e o WHERE IS NULL deixa so elas.
-- Autor: Vitor
SELECT b.nome AS bairro,
       c.nome AS cidade
FROM bairro b
INNER JOIN cidade c ON c.id_cidade = b.id_cidade
LEFT JOIN avaliacao a ON a.id_bairro = b.id_bairro
WHERE a.id_avaliacao IS NULL
ORDER BY c.nome, b.nome;

-- Q10
-- Pergunta de negocio: como fica a lista de imoveis anunciados, com
-- bairro, cidade e imobiliaria responsavel?
-- Tecnica: JOIN entre 4 tabelas (imovel, bairro, cidade, imobiliaria).
-- Observacao: imobiliaria e opcional (regra 11), entao usa LEFT JOIN;
-- com INNER JOIN os imoveis sem imobiliaria sumiriam do resultado.
-- Autor: Vitor
SELECT i.id_imovel,
       i.tipo,
       i.finalidade,
       i.preco,
       b.nome AS bairro,
       c.nome AS cidade,
       COALESCE(im.nome, 'Sem imobiliaria') AS imobiliaria
FROM imovel i
INNER JOIN bairro b ON b.id_bairro = i.id_bairro
INNER JOIN cidade c ON c.id_cidade = b.id_cidade
LEFT JOIN imobiliaria im ON im.id_imobiliaria = i.id_imobiliaria
ORDER BY c.nome, b.nome, i.id_imovel;

-- Q11
-- Pergunta de negocio: quantos imoveis cada imobiliaria anuncia,
-- incluindo as que ainda nao tem nenhum?
-- Tecnica: LEFT JOIN + COUNT + GROUP BY. O COUNT(i.id_imovel) conta so
-- as linhas com imovel; COUNT(*) contaria 1 para quem nao tem nenhum.
-- Autor: Vitor
SELECT im.id_imobiliaria,
       im.nome AS imobiliaria,
       COUNT(i.id_imovel) AS qtd_imoveis
FROM imobiliaria im
LEFT JOIN imovel i ON i.id_imobiliaria = im.id_imobiliaria
GROUP BY im.id_imobiliaria, im.nome
ORDER BY qtd_imoveis DESC, im.nome;

-- Q12
-- Pergunta de negocio: quantos estabelecimentos (mercados, farmacias,
-- escolas e transporte) cada bairro tem, com a cidade a que pertence?
-- Tecnica: INNER JOIN entre 3 tabelas (estabelecimento, bairro, cidade)
-- com GROUP BY. So aparecem bairros que tem ao menos um estabelecimento.
-- Autor: Vitor
SELECT c.nome AS cidade,
       b.nome AS bairro,
       COUNT(e.id_estabelecimento) AS qtd_estabelecimentos
FROM estabelecimento e
INNER JOIN bairro b ON b.id_bairro = e.id_bairro
INNER JOIN cidade c ON c.id_cidade = b.id_cidade
GROUP BY c.id_cidade, c.nome, b.id_bairro, b.nome
ORDER BY c.nome, qtd_estabelecimentos DESC, b.nome;
