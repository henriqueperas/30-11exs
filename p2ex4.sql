CREATE DATABASE P2ex5
GO
USE P2ex5

CREATE TABLE fornecedor(
codigo		INT	NOT NULL,
nome		VARCHAR(80),
atividade	VARCHAR(80),
telefone	BIGINT	NOT NULL,
PRIMARY KEY(codigo)
)

CREATE TABLE cliente(
codigo		INT	NOT NULL,
nome		VARCHAR(80),
logradouro	VARCHAR(80),
numero		INT,
telefone	INT	,
data_nasci	DATE,
PRIMARY KEY(codigo)
)

CREATE TABLE produto(
codigo			INT	NOT NULL,
nome			VARCHAR(80),
valor			DECIMAL(10,2),
qnt_estoque		INT,
descricao		VARCHAR(80),
cod_fornecedor	INT	NOT NULL,
PRIMARY KEY(codigo),
FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(codigo)
)

CREATE TABLE pedido(
codigo			INT	NOT NULL,
cod_cliente		INT	NOT NULL,
cod_produto		INT	NOT NULL,
quantidade		INT,
data_entrega	DATE,
PRIMARY KEY(codigo,cod_cliente,cod_produto),
FOREIGN KEY (cod_cliente) REFERENCES cliente(codigo),
FOREIGN KEY (cod_produto) REFERENCES produto(codigo)
)

INSERT INTO fornecedor (codigo, nome, atividade, telefone) 
VALUES (1001,	'Estrela',	'Brinquedo',	41525898),
(1002,	'Lacta',	'Chocolate',	42698596),
(1003,	'Asus',	'Informática',	52014596),
(1004,	'Tramontina',	'Utensílios Domésticos',	50563985),
(1005,	'Grow',	'Brinquedos',	47896325),
(1006,	'Mattel',	'Bonecos',	59865898)
GO 

INSERT INTO cliente (codigo, nome, logradouro, numero, telefone, data_nasci) 
VALUES (33601,	'Maria Clara',	'R. 1° de Abril',	870,	96325874,	'2000-08-15'),
(33602,	'Alberto Souza',	'R. XV de Novembro',	987,	95873625,	'1985-02-02'),
(33603,	'Sonia Silva',	'R. Voluntários da Pátria',	1151,	75418596,	'1957-08-23'),
(33604,	'José Sobrinho',	'Av. Paulista',	250,	85236547,	'1986-12-09'),
(33605,	'Carlos Camargo',	'Av. Tiquatira',	9652,	75896325,	'1971-03-25')
GO

INSERT INTO produto (codigo, nome, valor, qnt_estoque, descricao, cod_fornecedor) 
VALUES (1,	'Banco Imobiliário',	65.00,	15,	'Versão Super Luxo',	1001),
(2,	'Puzzle 5000 peças',	50.00,	5,	'Mapas Mundo',	1005),
(3,	'Faqueiro',	350.00,	0,	'120 peças',	1004),
(4,	'Jogo para churrasco',	75.00,	3,	'7 peças', 1004),
(5,	'Tablet',	750.00,	29,	'Tablet',	1003),
(6,	'Detetive',	49.00,	0,	'Nova Versão do Jogo',	1001),
(7,	'Chocolate com Paçoquinha',	6.00,	0,	'Barra',	1002),
(8,	'Galak',	5.00,	65,	'Barra',	1002)
GO

UPDATE produto SET valor = (SELECT SUM(valor * 0.9) FROM produto WHERE codigo = 7) WHERE nome = 'Chocolate com Paçoquinha' AND valor >= 6;
UPDATE produto SET qnt_estoque = 10 WHERE nome = 'Faqueiro';

INSERT INTO pedido (codigo, cod_cliente, cod_produto, quantidade, data_entrega) 
VALUES (99001,	33601,	1,	1,	'2012-06-07'),
(99001,	33601,	2,	1,	'2012-06-07'),
(99001,	33601,	8,	3,	'2012-06-07'),
(99002,	33602,	2,	1,	'2012-06-09'),
(99002,	33602,	4,	3,	'2012-06-09'),
(99003,	33605,	5,	1,	'2012-06-15')
GO

--SELECT * FROM fornecedor
--SELECT * FROM cliente
--SELECT * FROM produto
--SELECT * FROM pedido

--Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.		
SELECT DISTINCT SUM(pedido.quantidade), SUM(produto.valor * pedido.quantidade), SUM((produto.valor * pedido.quantidade) * 0.75) FROM cliente, pedido, produto WHERE cliente.codigo = pedido.cod_cliente AND cliente.nome = 'Maria Clara' AND pedido.cod_produto = produto.codigo
--Verificar quais brinquedos não tem itens em estoque.					
SELECT DISTINCT codigo, nome FROM produto WHERE qnt_estoque = 0
--Alterar para reduzir em 10% o valor das barras de chocolate.					
SELECT valor FROM produto WHERE nome = 'Chocolate com Paçoquinha'
--Alterar a quantidade em estoque do faqueiro para 10 peças.					
SELECT qnt_estoque FROM produto WHERE nome = 'Faqueiro'
--Consultar quantos clientes tem mais de 40 anos.					
SELECT DISTINCT codigo, nome FROM cliente WHERE YEAR(GETDATE()) - YEAR(data_nasci) >= 40
--Consultar Nome e telefone dos fornecedores de Brinquedos e Chocolate.					
SELECT fornecedor.nome, fornecedor.telefone FROM produto, fornecedor WHERE produto.nome <> 'Tablet' AND produto.nome <> 'Jogo para churrasco' AND produto.nome <> 'Faqueiro' AND fornecedor.codigo = produto.cod_fornecedor
--Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00					
SELECT nome, (valor * 0.75) FROM produto WHERE valor < 50.00
--Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00					
SELECT nome, (valor * 0.90) FROM produto WHERE valor > 100.00
--Consultar desconto de 15% no valor total de cada produto da venda 99001.					
SELECT DISTINCT SUM((produto.valor * pedido.quantidade) * 0.25) FROM cliente, pedido, produto WHERE pedido.codigo = 99001 AND pedido.cod_produto = produto.codigo
--Consultar Código do pedido, nome do cliente e idade atual do cliente					
--SELECT DISTINCT pedido.codigo, cliente.nome, GETDATE() - data_nasci FROM cliente, pedido, produto
