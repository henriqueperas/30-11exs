CREATE DATABASE ex9
GO
USE ex9
GO
CREATE TABLE editora (
codigo			INT				NOT NULL,
nome			VARCHAR(30)		NOT NULL,
site			VARCHAR(40)		NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE autor (
codigo			INT				NOT NULL,
nome			VARCHAR(30)		NOT NULL,
biografia		VARCHAR(100)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE estoque (
codigo			INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL	UNIQUE,
quantidade		INT				NOT NULL,
valor			DECIMAL(7,2)	NOT NULL	CHECK(valor > 0.00),
codEditora		INT				NOT NULL,
codAutor		INT				NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codEditora) REFERENCES editora (codigo),
FOREIGN KEY (codAutor) REFERENCES autor (codigo)
)
GO
CREATE TABLE compra (
codigo			INT				NOT NULL,
codEstoque		INT				NOT NULL,
qtdComprada		INT				NOT NULL,
valor			DECIMAL(7,2)	NOT NULL,
dataCompra		DATE			NOT NULL
PRIMARY KEY (codigo, codEstoque, dataCompra)
FOREIGN KEY (codEstoque) REFERENCES estoque (codigo)
)
GO
INSERT INTO editora VALUES
(1,'Pearson','www.pearson.com.br'),
(2,'Civilização Brasileira',NULL),
(3,'Makron Books','www.mbooks.com.br'),
(4,'LTC','www.ltceditora.com.br'),
(5,'Atual','www.atualeditora.com.br'),
(6,'Moderna','www.moderna.com.br')
GO
INSERT INTO autor VALUES
(101,'Andrew Tannenbaun','Desenvolvedor do Minix'),
(102,'Fernando Henrique Cardoso','Ex-Presidente do Brasil'),
(103,'Diva Marília Flemming','Professora adjunta da UFSC'),
(104,'David Halliday','Ph.D. da University of Pittsburgh'),
(105,'Alfredo Steinbruch','Professor de Matemática da UFRS e da PUCRS'),
(106,'Willian Roberto Cereja','Doutorado em Lingüística Aplicada e Estudos da Linguagem'),
(107,'William Stallings','Doutorado em Ciências da Computacão pelo MIT'),
(108,'Carlos Morimoto','Criador do Kurumin Linux')
GO
INSERT INTO estoque VALUES
(10001,'Sistemas Operacionais Modernos ',4,108.00,1,101),
(10002,'A Arte da Política',2,55.00,2,102),
(10003,'Calculo A',12,79.00,3,103),
(10004,'Fundamentos de Física I',26,68.00,4,104),
(10005,'Geometria Analítica',1,95.00,3,105),
(10006,'Gramática Reflexiva',10,49.00,5,106),
(10007,'Fundamentos de Física III',1,78.00,4,104),
(10008,'Calculo B',3,95.00,3,103)
GO
INSERT INTO compra VALUES
(15051,10003,2,158.00,'2021-07-04'),
(15051,10008,1,95.00,'2021-07-04'),
(15051,10004,1,68.00,'2021-07-04'),
(15051,10007,1,78.00,'2021-07-04'),
(15052,10006,1,49.00,'2021-07-05'),
(15052,10002,3,165.00,'2021-07-05'),
(15053,10001,1,108.00,'2021-07-05'),
(15054,10003,1,79.00,'2021-08-06'),
(15054,10008,1,95.00,'2021-08-06')
GO

--1
SELECT DISTINCT estoque.nome, estoque.valor, editora.nome, autor.nome FROM estoque, autor, editora, compra WHERE compra.codEstoque = estoque.codigo AND compra.valor = estoque.valor AND estoque.codAutor = autor.codigo AND estoque.codEditora = 
editora.codigo;
--2
SELECT DISTINCT estoque.nome, compra.qtdComprada, compra.valor FROM estoque, compra WHERE compra.codigo = 15051 AND estoque.codigo = compra.codEstoque;
--3
SELECT DISTINCT estoque.nome, editora.site FROM editora, compra, estoque WHERE editora.nome = 'Makron Books' AND editora.codigo = estoque.codEditora;
--4
SELECT DISTINCT estoque.nome, autor.biografia FROM estoque, autor WHERE autor.nome = 'David Halliday' AND autor.codigo = estoque.codAutor;
--5
SELECT DISTINCT compra.codigo, compra.qtdComprada FROM compra, estoque, autor WHERE estoque.nome = 'Sistemas Operacionais Modernos ' AND estoque.codigo = compra.codEstoque;
--6
SELECT DISTINCT estoque.nome, estoque.codigo FROM compra, estoque WHERE estoque.codigo NOT IN (SELECT compra.codEstoque FROM compra);
--7
SELECT DISTINCT estoque.nome, estoque.codigo FROM compra, estoque WHERE estoque.codigo IN (SELECT compra.codEstoque FROM compra);
--8
SELECT DISTINCT editora.nome, editora.site FROM estoque, editora WHERE editora.codigo NOT IN (SELECT estoque.codEditora FROM estoque);
--9
SELECT DISTINCT autor.nome, autor.biografia FROM compra, estoque, autor WHERE autor.codigo NOT IN (SELECT estoque.codAutor FROM estoque);
--10
SELECT DISTINCT autor.nome, estoque.valor FROM compra, estoque, autor WHERE autor.codigo = estoque.codAutor ORDER BY estoque.valor desc;
--11

--12

--13

--14

--15

--16


--SELECT * FROM autor;
--SELECT * FROM compra;
--SELECT * FROM editora;
--SELECT * FROM estoque;
