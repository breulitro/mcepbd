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

CREATE TABLE Funcionarios (
nro_matricula INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
data_admissao Date NOT NULL,
email VARCHAR(80),
ramal INTEGER(4),
salario NUMERIC(15,2) NOT NULL,
cpf VARCHAR(12) NOT NULL UNIQUE
);

insert into Funcionarios (nome, data_admissao, email, ramal, salario, cpf)
values	("Percival", "1956-04-01", "perci@val.com", 5467, 634.33, "132414234-33"),
		("Roberval", "1979-02-23", "rober@val.com", 3422, 379.27, "987234756-13"),
		("Pafuncio", "1978-04-28", "pafun@cio.com", 3123, 279.27, "987234756-12"),
		("Bartholomeo", "1928-11-23", "bar@tho.lomeo", 2312, 1980.00, "123443223-12"),
		("Geraldison", "1976-02-29", "ger@ldis.on", 1231, 459.29, "623434534-34"),
		("Geraldaughter", "1976-02-29", "gerald@ugh.ter", 1232, 459.28, "623434534-35");

CREATE TABLE Setor (
cod_setor INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
email VARCHAR(80),
ramal INTEGER(4),
nome VARCHAR(80) NOT NULL,
capacidade INTEGER(4)
);

insert into Setor (email, ramal, nome, capacidade)
values	("in@fan.~", 1234, "Infantil", 3421),
		("moveis@loja.com", 3453, "Moveis", 353),
		("cama@mesa.banho", 5432, "Cama Mesa e Banho", 6543);

CREATE TABLE Produto (
cod_produto INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
descricao VARCHAR(100) NOT NULL,
preco NUMERIC(15,2) NOT NULL
);

insert into Produto (descricao, preco)
values	("Calcinha", 11.32),
		("Cama", 123.54),
		("Roupeiro", 543.23),
		("Travesseiro", 12.99);

CREATE TABLE GerentesSetor (
cod_gerente INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nro_matricula INTEGER(4) NOT NULL,
cod_setor INTEGER(4) NOT NULL,
celular INTEGER(14),
FOREIGN KEY(nro_matricula) REFERENCES Funcionarios (nro_matricula),
FOREIGN KEY(cod_setor) REFERENCES Setor (cod_setor)
);
insert into GerentesSetor (nro_matricula, cod_setor, celular)
values	(3, 3, 67474356),
		(2, 2, 98712322),
		(1, 1, 94572289);

CREATE TABLE Lojas (
cod_filial INTEGER(4) PRIMARY KEY AUTO_INCREMENT NOT NULL,
endereco VARCHAR(100) NOT NULL,
telefone INTEGER(14),
email VARCHAR(80)
);

insert into Lojas (endereco, telefone, email)
values	("Avenida Passo Manco 171", 32552345, "filial@manca.br"),
		("Travessa Paralela 1313", 32423243, "filial@travessa.br"),
		("Rua Paranguape 1234", 32255896, "filial@paranguape.br");

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
values  (3, 1, 20, 200, 140),
		(2, 3, 4, 10, 6),
		(2, 2, 2, 6, 4),
		(1, 4, 10, 30, 22),
		(1, 2, 2, 10, 6),
		(1, 1, 10, 100, 22);

CREATE TABLE SetorProduto (
cod_setor INTEGER(4) NOT NULL,
cod_produto INTEGER(4) NOT NULL,
quantidade INTEGER(4) NOT NULL,
PRIMARY KEY(cod_setor,cod_produto),
FOREIGN KEY(cod_setor) REFERENCES Setor (cod_setor),
FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto)
);

insert into SetorProduto (cod_setor, cod_produto, quantidade)
values	(3, 2, 32),
		(3, 4, 64),
		(2, 3, 30),
		(1, 1, 500);

CREATE TABLE GerentesLoja (
cod_gerente INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nro_matricula INTEGER(4) NOT NULL,
cod_filial INTEGER(4) NOT NULL,
meta_mensal NUMERIC(15,2) NOT NULL,
FOREIGN KEY(nro_matricula) REFERENCES Funcionarios (nro_matricula),
FOREIGN KEY(cod_filial) REFERENCES Lojas (cod_filial)
);

insert into GerentesLoja (nro_matricula, cod_filial, meta_mensal)
values	(4, 1, 1000.00),
		(5, 2, 2000.00),
		(6, 3, 3000.00);


CREATE TABLE PedidoLoja (
cod_pedido INTEGER(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
cod_gerente INTEGER(4) NOT NULL,
urgente char(1) DEFAULT 'n',
data Date NOT NULL,
FOREIGN KEY(cod_gerente) REFERENCES GerentesLoja (cod_gerente)
);

insert into PedidoLoja (cod_gerente, urgente, data)
values (1, 'y', "2012-03-31");
insert into PedidoLoja (cod_gerente, data)
values (2, "2012-03-31");


CREATE TABLE ItemPedido (
cod_pedido INTEGER(4) NOT NULL,
cod_produto INTEGER(4) NOT NULL,
quantidade INTEGER(4) NOT NULL,
PRIMARY KEY(cod_pedido, cod_produto),
FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto),
FOREIGN KEY(cod_pedido) REFERENCES PedidoLoja (cod_pedido)
);

insert into ItemPedido (cod_pedido, cod_produto, quantidade)
values	(1, 1, 20),
		(1, 2, 3),
		(1, 3, 6),
		(2, 1, 12),
		(2, 2, 4),
		(2, 4, 9);

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
