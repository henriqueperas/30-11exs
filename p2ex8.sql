CREATE DATABASE P2ex8
GO
USE P2ex8

CREATE TABLE cliente(
codigo			INT	NOT NULL,
nome			VARCHAR(80),
endereco		VARCHAR(80),
telefone		BIGINT,
tele_comercial	BIGINT,
PRIMARY KEY(codigo)
)

CREATE TABLE compra(
nota_fiscal		INT	NOT NULL,
cod_cliente		INT,
valor			INT,
PRIMARY KEY(nota_fiscal),
FOREIGN KEY (cod_cliente) REFERENCES cliente(codigo)
)

CREATE TABLE tipo_mercadoria(
codigo			INT	NOT NULL,
nome			VARCHAR(80),
PRIMARY KEY(codigo)
)

CREATE TABLE corredores(
codigo			INT	NOT NULL,
tipo			INT,
nome			VARCHAR(80),
PRIMARY KEY(codigo),
FOREIGN KEY (tipo) REFERENCES tipo_mercadoria(codigo)
)

CREATE TABLE mercadoria(
codigo			INT	NOT NULL,
nome			VARCHAR(80),
corredor		INT,
tipo			INT,
valor			DECIMAL(10,2),
PRIMARY KEY(codigo),
FOREIGN KEY (corredor) REFERENCES corredores(codigo),
FOREIGN KEY (tipo) REFERENCES tipo_mercadoria(codigo)
)

INSERT INTO cliente
VALUES (1,	'Luis Paulo',	'R. Xv de Novembro 100',	45657878, NULL),
(2,	'Maria Fernanda',	'R. Anhaia 1098',	27289098,	40040090),
(3,	'Ana Claudia',	'Av. Voluntários da Pátria 876',	21346548, NULL),	
(4,	'Marcos Henrique',	'R. Pantojo 76',	51425890,	30394540),
(5,	'Emerson Souza',	'R. Pedro Álvares Cabral 97',	44236545,	39389900),
(6,	'Ricardo Santos',	'Trav. Hum 10',	98789878, NULL)
GO

INSERT INTO compra
VALUES (1234,	2,	200),
(2345,	4,	156),
(3456,	6,	354),
(4567,	3,	19)
GO

INSERT INTO tipo_mercadoria
VALUES (10001,	'Pães'),
(10002,	'Frios'),
(10003,	'Bolacha'),
(10004,	'Clorados'),
(10005,	'Frutas'),
(10006,	'Esponjas'),
(10007,	'Massas'),
(10008,	'Molhos')
GO

INSERT INTO corredores
VALUES (101,	10001,	'Padaria'),
(102,	10002,	'Calçados'),
(103,	10003,	'Biscoitos'),
(104,	10004,	'Limpeza'),
(105, NULL, NULL),
(106, NULL, NULL),
(107,	10007,	'Congelados')
GO

INSERT INTO mercadoria
VALUES (1001,	'Pão de Forma',	101,	10001,	3.5),
(1002,	'Presunto',	101,	10002,	2.0),
(1003,	'Cream Cracker',	103,	10003,	4.5),
(1004,	'Água Sanitária',	104,	10004,	6.5),
(1005,	'Maçã',	105,	10005,	0.9),
(1006,	'Palha de Aço',	106,	10006,	1.3),
(1007,	'Lasanha',	107,	10007,	9.7)
GO

--SELECT * FROM cliente;
--SELECT * FROM compra;
--SELECT * FROM tipo_mercadoria;
--SELECT * FROM corredores;
--SELECT * FROM mercadoria;

--Valor da Compra de Luis Paulo	
SELECT DISTINCT SUM(compra.valor) FROM cliente, compra WHERE cliente.nome = 'Luis Paulo'
--Valor da Compra de Marcos Henrique	
SELECT DISTINCT SUM(compra.valor) FROM cliente, compra WHERE cliente.nome = 'Marcos Henrique'
--Endereço e telefone do comprador de Nota Fiscal = 4567	
SELECT DISTINCT cliente.endereco, cliente.telefone FROM cliente, compra WHERE compra.nota_fiscal = 4567
--Valor da mercadoria cadastrada do tipo " Pães"	
SELECT DISTINCT mercadoria.valor FROM cliente, compra, mercadoria WHERE mercadoria.nome = 'Pão de Forma'
--Nome do corredor onde está a Lasanha	
SELECT DISTINCT corredores.nome FROM cliente, compra, mercadoria, corredores WHERE mercadoria.nome = 'Lasanha' AND corredores.codigo = mercadoria.corredor
--Nome do corredor onde estão os clorados	
SELECT DISTINCT corredores.nome FROM cliente, compra, tipo_mercadoria, mercadoria, corredores WHERE tipo_mercadoria.nome = 'Clorados' AND tipo_mercadoria.codigo = mercadoria.tipo AND corredores.codigo = mercadoria.corredor
