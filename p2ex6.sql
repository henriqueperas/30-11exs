CREATE DATABASE P2ex6
GO
USE P2ex6

CREATE TABLE motorista(
codigo			INT	NOT NULL,
nome			VARCHAR(80),
data_nasci		DATE,
naturalidade	VARCHAR(80),
PRIMARY KEY(codigo)
)

CREATE TABLE onibus(
placa		VARCHAR(80)	NOT NULL,
marca		VARCHAR(80),
ano			INT,
descricao	VARCHAR(80),
PRIMARY KEY(placa)
)

CREATE TABLE viagem(
codigo		INT	NOT NULL,
onibus		VARCHAR(80)	NOT NULL,
motorista	INT	NOT NULL,
hr_saida	INT,
hr_chegada	INT,
destino		VARCHAR(80),
PRIMARY KEY(codigo),
FOREIGN KEY (onibus) REFERENCES onibus(placa),
FOREIGN KEY (motorista) REFERENCES motorista(codigo)
)

INSERT INTO motorista (codigo, nome, data_nasci, naturalidade) 
VALUES (12341,	'Julio Cesar',	'1978-04-18',	'São Paulo'),
(12342,	'Mario Carmo',	'2002-07-29',	'Americana'),
(12343,	'Lucio Castro',	'1969-12-01',	'Campinas'),
(12344,	'André Figueiredo',	'1999-05-14',	'São Paulo'),
(12345,	'Luiz Carlos',	'2001-01-09',	'São Paulo')
GO

INSERT INTO onibus (placa, marca, ano, descricao) 
VALUES ('adf0965',   	'Mercedes',    1999,	'Leito'),               
('bhg7654',   	'Mercedes',   2002,	'Sem Banheiro'),        
('dtr2093',   	'Mercedes',   2001,	'Ar Condicionado'),     
('gui7625',   	'Volvo',      2001,	'Ar Condicionado')
GO

INSERT INTO viagem (codigo, onibus, motorista, hr_saida, hr_chegada, destino) 
VALUES (101,	'adf0965',   	12343,	10,	12,	'Campinas'),
(102,	'gui7625',   	12341,	7,	12,	'Araraquara'),
(103,	'bhg7654',   	12345,	14,	22,	'Rio de Janeiro'),
(104,	'dtr2093',   	12344,	18,	21,	'Sorocaba')
GO

--SELECT * FROM motorista;
--SELECT * FROM onibus;
--SELECT * FROM viagem;

-- Consultar, da tabela viagem, todas as horas de chegada e saída, convertidas em formato HH:mm (108) e seus destinos		
SELECT DISTINCT (hr_chegada - hr_saida) * 60, destino FROM viagem
-- Consultar, com subquery, o nome do motorista que viaja para Sorocaba					
-- Consultar, com subquery, a descrição do ônibus que vai para o Rio de Janeiro					
-- Consultar, com Subquery, a descrição, a marca e o ano do ônibus dirigido por Luiz Carlos					
-- Consultar o nome, a idade e a naturalidade dos motoristas com mais de 30 anos
SELECT DISTINCT nome, GETDATE() - data_nasci, naturalidade FROM motorista WHERE YEAR(GETDATE()) - YEAR(data_nasci) > 30
