-- drops de menta
drop table if exists Aprovacoes;
drop table if exists PedidoLoja;
drop table if exists GerentesLoja;
drop table if exists ItemPedido;
drop table if exists SetorProduto;
drop table if exists ProdutosLoja;
drop table if exists Lojas;
drop table if exists GerentesSetor;
drop table if exists Produto;
drop table if exists Setor;
drop table if exists Funcionarios;

---------------------------------------------------------------------------------
--Oracle
--http://lmgtfy.com/?q=CREATE SEQUENCE
--Access
--nro_matricula INTEGER AUTOINCREMENT PRIMARY KEY,
--SQL Server
--nro_matricula INTEGER(4) IDENTITY(1,1) PRIMARY KEY,
--SQLite
--nro_matricula INTEGER(4) PRIMARY KEY NOT NULL AUTOINCREMENT,
--MySQL
-- eh o que ta sendo usado, mas eh tao tosco que nao aceita comentario no meio
--do create table...
CREATE TABLE Funcionarios (
nro_matricula INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
data_admissao Date NOT NULL,
email VARCHAR(80),
ramal INTEGER(4),
salario NUMERIC(15,2) NOT NULL,
cpf VARCHAR(12) NOT NULL
);

insert into Funcionarios (nome, data_admissao, email, ramal, salario, cpf)
values	("Roberval", "1979-02-23", "rober@val.com", 3422, 379.27, "987234756-13"),
		("Pafuncio", "1978-04-28", "pafun@cio.com", 3123, 279.27, "987234756-12");

---------------------------------------------------------------------------------
CREATE TABLE Setor (
cod_setor INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
email VARCHAR(80),
ramal INTEGER(4),
nome VARCHAR(80) NOT NULL,
capacidade INTEGER(4)
);

insert into Setor (email, ramal, nome, capacidade)
values ("bla@ga.csd", 5432, "Cama Mesa e Banho", 6543);

---------------------------------------------------------------------------------
CREATE TABLE Produto (
cod_produto INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
descricao VARCHAR(100) NOT NULL,
preco NUMERIC(15,2) NOT NULL
);

insert into Produto (descricao, preco)
values ("Travesseiro", 12.99);

---------------------------------------------------------------------------------
CREATE TABLE GerentesSetor (
cod_gerente INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nro_matricula INTEGER(4) NOT NULL,
cod_setor INTEGER(4) NOT NULL,
celular INTEGER(14),
FOREIGN KEY(nro_matricula) REFERENCES Funcionarios (nro_matricula),
FOREIGN KEY(cod_setor) REFERENCES Setor (cod_setor)
);

insert into GerentesSetor (nro_matricula, cod_setor, celular)
values (1, 1, 94572289);

---------------------------------------------------------------------------------
CREATE TABLE Lojas (
cod_filial INTEGER(4) PRIMARY KEY AUTO_INCREMENT NOT NULL,
endereco VARCHAR(100) NOT NULL,
telefone INTEGER(14),
email VARCHAR(80)
);

insert into Lojas (endereco, telefone, email)
values ("Rua Paranguape 1234", 32255896, "filial@paranguape.br");

---------------------------------------------------------------------------------
CREATE TABLE ProdutosLoja (
cod_filial INTEGER(4) NOT NULL,
cod_produto INTEGER(4) NOT NULL,
minimo INTEGER(4) NOT NULL,
maximo INTEGER(4) NOT NULL,
quantidade INTEGER(4) NOT NULL,
PRIMARY KEY(cod_filial, cod_produto),
FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto),
FOREIGN KEY(cod_filial) REFERENCES Lojas (cod_filial)
);

insert into ProdutosLoja (cod_filial, cod_produto, minimo, maximo, quantidade)
values (1, 1, 10, 100, 22);

---------------------------------------------------------------------------------
CREATE TABLE SetorProduto (
cod_setor INTEGER(4) NOT NULL,
cod_produto INTEGER(4) NOT NULL,
quantidade INTEGER(4) NOT NULL,
PRIMARY KEY(cod_setor,cod_produto),
FOREIGN KEY(cod_setor) REFERENCES Setor (cod_setor),
FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto)
);

insert into SetorProduto (cod_setor, cod_produto, quantidade)
values (1, 1, 12);

---------------------------------------------------------------------------------
CREATE TABLE ItemPedido (
cod_item_pedido INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
cod_produto INTEGER(4) NOT NULL,
quantidade INTEGER(4) NOT NULL,
FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto)
);

insert into ItemPedido (cod_produto, quantidade)
values (1, 20);

---------------------------------------------------------------------------------
CREATE TABLE GerentesLoja (
cod_gerente INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nro_matricula INTEGER(4) NOT NULL,
cod_filial INTEGER(4) NOT NULL,
meta_mensal NUMERIC(15,2) NOT NULL,
FOREIGN KEY(nro_matricula) REFERENCES Funcionarios (nro_matricula),
FOREIGN KEY(cod_filial) REFERENCES Lojas (cod_filial)
);

insert into GerentesLoja (nro_matricula, cod_filial, meta_mensal)
values (1, 1, 1000.00);

---------------------------------------------------------------------------------
CREATE TABLE PedidoLoja (
cod_pedido INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
cod_gerente INTEGER(4) NOT NULL,
cod_item_pedido INTEGER(4) NOT NULL,
urgente char(1) DEFAULT 'n',
data Date NOT NULL,
FOREIGN KEY(cod_gerente) REFERENCES GerentesLoja (cod_gerente),
FOREIGN KEY(cod_item_pedido) REFERENCES ItemPedido (cod_item_pedido)
);

insert into PedidoLoja (cod_gerente, cod_item_pedido, urgente, data)
values (1, 1, 'y', "2012-03-31");
-- Se omitir o campo 'urgente' ele assume o default ;)
insert into PedidoLoja (cod_gerente, cod_item_pedido, data)
values (1, 1, "2012-03-31");

---------------------------------------------------------------------------------
CREATE TABLE Aprovacoes (
cod_gerente INTEGER(4) NOT NULL,
cod_pedido INTEGER(4) NOT NULL,
data Date NOT NULL,
PRIMARY KEY(cod_gerente,cod_pedido),
FOREIGN KEY(cod_gerente) REFERENCES GerentesSetor (cod_gerente),
FOREIGN KEY(cod_pedido) REFERENCES PedidoLoja (cod_pedido)
);

insert into Aprovacoes (cod_gerente, cod_pedido, data)
values (1, 1, "2012-04-01");
