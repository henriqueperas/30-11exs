CREATE DATABASE P2ex7
GO
USE P2ex7

CREATE TABLE cliente(
RG			BIGINT	NOT NULL,
CPF			BIGINT	NOT NULL,
nome		VARCHAR(80),
logradouro	VARCHAR(80),
numero		INT,
PRIMARY KEY(RG)
)

CREATE TABLE pedido(
nota_fiscal			BIGINT	NOT NULL,
valor			DECIMAL(10,2),
data			DATE,
RG_cliente		BIGINT,
PRIMARY KEY(nota_fiscal),
FOREIGN KEY (RG_cliente) REFERENCES cliente(RG),
)

CREATE TABLE fornecedor(
codigo		BIGINT	NOT NULL,
nome		VARCHAR(80),
logradouro	VARCHAR(80),
numero		INT,
pais		VARCHAR(80),
area		VARCHAR(80),
telefone	BIGINT,
CNPJ		BIGINT,
cidade		VARCHAR(80),
transporte	VARCHAR(80),
moeda		VARCHAR(80),
PRIMARY KEY(codigo),
)

CREATE TABLE mercadoria(
codigo			BIGINT	NOT NULL,
destino		VARCHAR(80),
preco			DECIMAL(10,2),
quantidade			INT,
cod_pornecedor		BIGINT,
PRIMARY KEY(codigo),
FOREIGN KEY (cod_pornecedor) REFERENCES fornecedor(codigo),
)

INSERT INTO cliente
VALUES (29531844,	34519878040,	'Luiz André',	'R. Astorga',	500),
(135149968,	84984285630,	'Maria Luiza',	'R. Piauí',	174),
(121985541,	23354997310,	'Ana Barbara',	'Av. Jaceguai',	1141),
(239877464,	43587669920,	'Marcos Alberto',	'R. Quinze',	22)
GO

INSERT INTO pedido
VALUES (1001,	754,	'2018-04-01',	121985541),
(1002,	350,	'2018-04-02',	121985541),
(1003,	30,	'2018-04-02',	29531844),
(1004,	1500,	'2018-04-03',	135149968)
GO

INSERT INTO fornecedor
VALUES (1,	'Clone',	'Av. Nações Unidas', 12000,	'BR',	55,	1141487000,	NULL,	'São Paulo',	NULL,	'R$'),
(2,	'Logitech',	'28th Street', 100,	'USA',	1,	2127695100,	NULL,	NULL,	'Avião',	'US$'),
(3,	'LG',	'Rod. Castello Branco',	NULL,	'BR',	55,	800664400,	4159978100001,	'Sorocaba',	NULL,	'R$'),
(4,	'PcChips',	'Ponte da Amizade',	NULL,	'PY',	595,	NULL,	NULL,	NULL,	'Navio',	'US$')
GO

INSERT INTO mercadoria
VALUES (10,	'Mouse',	24,	30,	1),
(11,	'Teclado',	50,	20,	1),
(12,	'Cx. De Som',	30,	8,	2),
(13,	'Monitor 17',	350,	4,	3),
(14,	'Notebook',	1500,	7,	4)
GO

--SELECT * FROM cliente;
--SELECT * FROM pedido;
--SELECT * FROM fornecedor;
--SELECT * FROM mercadoria;

--Consultar 10% de desconto no pedido 1003		
SELECT DISTINCT valor * 0.1 FROM pedido WHERE nota_fiscal = 1003
--Consultar 5% de desconto em pedidos com valor maior de R$700,00	
SELECT DISTINCT valor * 0.05 FROM pedido WHERE valor > 700.00
--Consultar e atualizar aumento de 20% no valor de marcadorias com estoque menor de 10				
--Data e valor dos pedidos do Luiz		
SELECT DISTINCT pedido.valor FROM pedido, cliente WHERE cliente.nome = 'Luiz André' AND cliente.RG = pedido.RG_cliente
--CPF, Nome e endereço concatenado do cliente de nota 1004		
SELECT DISTINCT cliente.CPF, cliente.nome, cliente.logradouro FROM pedido, cliente WHERE pedido.nota_fiscal = 1003 AND cliente.RG = pedido.RG_cliente AND pedido.RG_cliente = cliente.RG
--País e meio de transporte da Cx. De som				
SELECT DISTINCT fornecedor.pais, fornecedor.transporte FROM mercadoria, fornecedor WHERE fornecedor.codigo = mercadoria.cod_pornecedor AND mercadoria.destino = 'Cx. De Som'
--Nome e Quantidade em estoque dos produtos fornecidos pela Clone			
SELECT DISTINCT mercadoria.destino, mercadoria.quantidade FROM mercadoria, fornecedor WHERE fornecedor.codigo = mercadoria.cod_pornecedor AND fornecedor.nome = 'Clone'
--Endereço concatenado e telefone dos fornecedores do monitor. (Telefone brasileiro (XX)XXXX-XXXX ou XXXX-XXXXXX (Se for 0800), Telefone Americano (XXX)XXX-XXXX)				
--Tipo de moeda que se compra o notebook	
SELECT DISTINCT fornecedor.moeda FROM mercadoria, fornecedor WHERE fornecedor.codigo = mercadoria.cod_pornecedor AND mercadoria.destino = 'Notebook'
--Considerando que hoje é 03/02/2019, há quantos dias foram feitos os pedidos e, criar uma coluna que escreva Pedido antigo para pedidos feitos há mais de 6 meses e pedido recente para os outros				
--Nome e Quantos pedidos foram feitos por cada cliente				
--RG,CPF,Nome e Endereço dos cliente cadastrados que Não Fizeram pedidos
SELECT DISTINCT cliente.RG, cliente.nome, cliente.logradouro FROM cliente, pedido WHERE cliente.RG <> pedido.RG_cliente
