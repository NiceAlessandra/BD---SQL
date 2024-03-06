use ecommerce;
create table categorias (
	cod_categoria smallint(5) unsigned not null,
	nome varchar(50) not null,
	primary key (cod_categoria)
);
show tables;
create table marcas (
	cod_marca smallint (5) unsigned not null primary key,
	nome varchar(50)  not null
);
create table subcategorias(
	cod_subcategoria smallint(50) unsigned not null, 
    nome varchar(50) not null,
    cod_categoria smallint(5) unsigned not null, 
    primary key(cod_subcategoria),
    foreign key(cod_categoria) 
    references categorias(cod_categoria)
);
create table formaspagamentos(
	cod_formapagamento smallint(5) unsigned not null,
    entrada tinyint(1) unsigned not null default 0,
    parcelas tinyint(3) unsigned not null,
    tipo varchar(20)  not null,
    primary key(cod_formapagamento)
);
create table clientes (
	cpf int(16) unsigned not null primary key,
    nome varchar(200) not null, 
    rg int(16) unsigned not null, 
    estado_rg char(2) not null, 
    telefone char(12) not null,
    celular char(12),
    data_nascimento date not null, 
    email varchar(100) not null, 
    endereço varchar(200) not null
);
create table produtos(
	cod_produto smallint(5) unsigned not null,
    nome varchar(100) not null, 
    preco decimal(8,2) not null, 
    cod_marca smallint(5) unsigned not null,
    cod_subcategoria smallint(5) unsigned not null, 
    primary key (cod_produto),
    foreign key (cod_marca) references marcas (cod_marca), 
    foreign key (cod_subcategoria) references subcategorias (cod_subcategoria)
);
create table formasprodutos (
	cod_produto smallint(5) unsigned not null, 
    cod_formapagamento smallint(5) unsigned not null, 
    primary key (cod_produto, cod_formapagamento),
    foreign key (cod_produto) references produtos(cod_produto),
    foreign key (cod_formapagamento) references formaspagamentos(cod_formapagamento)
);
create table imagens(
	cod_imagem mediumint(8) unsigned not null, 
    arquivo varchar(50) not null, 
    cod_produto smallint(5) unsigned not null, 
    primary key (cod_imagem),
    foreign key (cod_produto) references produtos(cod_produto)
);
create table carrinhos (
	cod_carrinho int(16) unsigned not null primary key, 
    cpf int(16) unsigned not null, 
    total decimal(9,2) not null default 0,
    data_hora datetime not null,
    foreign key (cpf) references clientes(cpf)
);
show tables;
create table listascasamentos(
	cod_listacasamento mediumint(8) unsigned not null,
    cpf int(16) unsigned not null, 
    data_hora datetime not null, 
    data_hora_casamento datetime not null, 
    foreign key (cpf) references clientes(cpf)
);
create table carrinhosprodutos (
	cod_produto smallint(5) unsigned not null, 
    cod_carrinho int(16) unsigned not null, 
    quantidade tinyint(3) unsigned not null default 1,
    preco decimal(8,2) not null, 
    primary key (cod_produto, cod_carrinho),
    foreign key (cod_produto) references produtos(cod_produto),
    foreign key(cod_carrinho) references carrinhos(cod_carrinho)
);

create table listasprodutos(
	cod_listacasamento mediumint(8) unsigned not null, 
    cod_produto smallint(5) unsigned not null, 
     quantidade tinyint(3) unsigned not null default 1,
    preco decimal(8,2) not null, 
    comprado tinyint(1) unsigned not null default 0,
    primary key(cod_listacasamento, cod_produto),
     foreign key(cod_listacasamento) references listascasamentos(cod_listacasamento),
    foreign key(cod_produto) references produtos(cod_produto)
 );

create table listaspadrinhos (
	cod_listacasamento mediumint(8) unsigned not null, 
    cpf int(16) unsigned not null, 
    primary key(cod_listacasamento, cpf),
    foreign key(cod_listacasamento) references listascasamentos(cod_listacasamento), 
    foreign key(cpf) references clientes(cpf)
);
show tables;
desc produtos;
alter table produtos add descricao varchar(200);
alter table imagens add extensao varchar(4) not null; 
desc imagens;
alter table produtos modify descricao text;
desc produtos;
desc categorias;
alter table categorias modify nome varchar (80) not null;
-- para apagar um campo 
alter table categorias add vaiserdeletado int;
-- add adicionar um campo 
desc categorias;
-- drop deleta um campo 
alter table categorias drop vaiserdeletado;
desc categorias;
desc imagens;
alter table imagens change nome_arquivo arquivo varchar(50) not null;
alter table formaspagamentos change tipo moeda varchar(20) not null;
desc formaspagamentos;
alter table carrinhos_produtos rename to carrinhosprodutos;
-- rename to para renomear uma tabela
show tables;
alter table listaspadrinhos drop primary key;
alter table imagens drop primary key;
alter table imagens add primary key(cod_imagem);
-- mostra os indices de uma tabela
show indexes from imagens;
-- para apagar uma chave estrangeira
-- alter table imagens drop foreign key cod_produto;
create table cidades(
	cod_cidade smallint(5) unsigned not null, 
    nome varchar(80) not null,
    estado char(2) not null,
    primary key (cod_cidade)
);
show tables;
alter table clientes drop cidade;
desc clientes;
alter table clientes add bairro varchar(80) not null;
desc clientes;
alter table clientes add cod_cidade smallint(5) unsigned not null;
-- adicionando uma chave estrangeira para a tabela cidades
alter table clientes
add constraint fk_cidade
foreign key (cod_cidade) references cidades(cod_cidade);
-- para apagar a constraint 
-- alter table clientes drop foreign key fk_cidade;

-- definir uma constraint quando crio a tabela
-- constraint fk_clientes foreign key (cpf) references clientes(cod_cliente)

-- como apago uma tabela - drop table 

show create table imagens;
drop table imagens;
show tables;

CREATE TABLE `imagens` (
  cod_imagem mediumint(8) unsigned NOT NULL,
  arquivo varchar(50) NOT NULL,
  cod_produto smallint(5) unsigned NOT NULL,
  extensao varchar(4) NOT NULL,
  PRIMARY KEY (`cod_imagem`),
  KEY `cod_produto` (`cod_produto`),
  CONSTRAINT `imagens_ibfk_1` FOREIGN KEY (`cod_produto`) REFERENCES `produtos` (`cod_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- só depois de apagar a chave estrangeira de uma tabela é que consigo apagá-la

insert into categorias(cod_categoria,nome) 
values (1,'Cama, Mesa e Banho');
insert into categorias(cod_categoria,nome) 
values (2,'Informática');
insert into categorias(cod_categoria,nome) 
values (3,'Eletrônicos');
insert into categorias(cod_categoria,nome) 
values (4,'Eletrodomésticos');
insert into categorias(cod_categoria,nome) 
values (5,'Celulares');
-- para checar todos os campos de uma tabela
select * from categorias;
alter table categorias modify cod_categoria smallint(5) unsigned not null auto_increment;
-- deu errado a partir da alteracao do auto increment...alter
alter table subcategorias drop cod_categoria;

desc categorias;
insert into categorias(nome) values ('Eletrônicos');
delete from categorias where cod_categoria=1;
delete from categorias where nome='Cama, Mesa e Banho';

alter table categorias auto_increment=1;

-- binary diferencia maiúsculas de minúsculas
alter table clientes add senha varchar(20) binary not null;
desc clientes;
alter table subcategorias modify 
cod_subcategoria smallint(5) unsigned not null auto_increment;

-- auto increment não funcionou
select * from subcategorias;
select * from categorias;
/* caso o auto increment estivesse funcionando 
insert into subcategorias(nome, cod_categoria) 
values ('Teclado',2);*/ 

insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (1,'Teclado',2);
insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (2,'Mouse',2);
/*para inserir varios campos de uma vez 
insert into subcategorias values(null);*/
insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (3,'Toalha',1);
insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (4,'Roupão',1);
insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (5,'Notebooks',2);
insert into subcategorias(cod_subcategoria,nome, cod_categoria) 
values (6,'Fontes',2);
desc marcas;
/*alter table marcas modify 
cod_marca smallint(5) unsigned not null auto_increment;
não funcionou */

insert into marcas(cod_marca,nome) 
values (1,'Samsung');
insert into marcas(cod_marca,nome) 
values (2,'Sony'), (3,'Dell');

select * from marcas;
select * from subcategorias;

desc produtos;
/* alter table produtos modify cod_produto smallint(5) unsigned not null auto_increment; 
o auto incremento também não funcionou*/
insert into produtos(cod_produto,nome,preco,cod_marca,cod_subcategoria) 
values (1,'Preto com varias teclas',30.50,1,1);
select * from produtos;
insert into produtos(cod_produto,nome,preco,cod_marca,cod_subcategoria)
values (2,'Inspiron',10.00,3,5);

select * from cidades;

/* alter table cidades modify cod_cidade
smallint(5) unsigned not null auto_increment;
também não funcionou.
linha de comando caso funcionasse:
insert into cidades (nome,estado)
values ('Guaratinguetá','SP');*/

insert into cidades (cod_cidade,nome,estado)
values (1,'Guaratinguetá','SP');
insert into cidades (cod_cidade,nome,estado)
values (2,'São Paulo','SP');
insert into cidades (cod_cidade,nome,estado)
values (3,'Rio de Janeiro','RJ');
insert into cidades (cod_cidade,nome,estado)
values (4,'Boa Vista','RR');
insert into cidades (cod_cidade,nome,estado)
values (5,'Rio Branco','AC');
insert into cidades (cod_cidade,nome,estado)
values (6,'Campo Grande','MS');
desc clientes;
insert into clientes (cpf, nome,rg,estado_rg,telefone, 
data_nascimento, email,endereço,bairro,cod_cidade,senha)
values
(123123,'João Silva', 456456,'SP','(12)31223256',
'2000-05-13','joao@gmail.com','Rua do João','Centro',4,'123joao');
select * from clientes;
insert into clientes (cpf, nome,rg,estado_rg,telefone,celular, 
data_nascimento, email,endereço,bairro,cod_cidade,senha)
values
(456321,'Paulo',456123,'RJ','(21)23658974','(21)92365897',
'1984-04-09','paulo@gmail.com','Rua do Paulo', 
'Centro',3,'235897');
select * from clientes;
/*alter table formaspagamentos modify cod_formapagamento
smallint(5) unsigned not null auto_increment;
NÃO FUNCIONOU a correcao do auto_increment
*/
desc formaspagamentos;
insert into formaspagamentos (cod_formapagamento,parcelas, moeda)
value(1,10,'Dinheiro');
select * from formaspagamentos;
insert into formaspagamentos(cod_formapagamento,entrada, parcelas, moeda)
values(2,1,9,'Dinheiro');
insert into formaspagamentos(cod_formapagamento,entrada, parcelas, moeda)
values(3,1,11,'Cartão de Crédito');
insert into formaspagamentos(cod_formapagamento,entrada, parcelas, moeda)
values(4,0,12,'Cartão de Crédito');

insert into formasprodutos(cod_produto,cod_formapagamento)
values
(1,1);
select * from formasprodutos;
insert into formasprodutos(cod_produto,cod_formapagamento)
values
(1,3);
insert into formasprodutos(cod_produto,cod_formapagamento)
values
(2,1),(2,2),(2,3),(2,4);
desc imagens;

alter table imagens modify cod_imagem 
mediumint(8) unsigned not null auto_increment;
-- conseui fazer a alteracao do auto increment

insert into imagens(arquivo,extensao,cod_produto)
values ('frente','jpg',1);
select * from imagens;
insert into imagens(arquivo,extensao,cod_produto)
values ('lateral','jpg',1);
select * from produtos;
insert into imagens(arquivo,extensao,cod_produto)
values ('fotonote','jpg',2);

-- AGORA VAMOS FAZER AS COMPRAS DOS NOSSO CLIENTES
desc carrinhos;
/*alter table carrinhos modify cod_carrinho
int(16) unsigned not null auto_increment;
não funcionou o auto increment */

select * from clientes;
# cpf 123123 João Silva
# cpf 456321 Paulo

insert into carrinhos(cod_carrinho,cpf,data_hora)
values(1,456321,'2023-02-14');
select * from carrinhos;
insert into carrinhos(cod_carrinho,cpf,data_hora)
values (2,123123,'2023-02-14 08:09:10');

insert into carrinhos (cod_carrinho,cpf,data_hora)
values (3,123123, now()); #now indica a data e hora atuaisno momento da compra
insert into carrinhosprodutos(cod_produto, cod_carrinho,quantidade,preco)
values
(1,1,2,30.50);
select * from carrinhosprodutos;
insert into carrinhosprodutos
(cod_produto, cod_carrinho, quantidade, preco)
values (2,1,4,10.00);
# cpf 123123 João Silva
insert into carrinhosprodutos(cod_produto,cod_carrinho,quantidade,preco)
values (1,2,1,30.00);
insert into carrinhosprodutos(cod_produto,cod_carrinho,quantidade,preco)
values(2,3,1,10.00);

desc listascasamentos;

/* alter table listascasamentos modify cod_listacasamento 
mediumint(8) unsigned not null auto_increment;
nao funcionou o auto increment */
insert into listascasamentos (cod_listacasamento, cpf, data_hora, data_hora_casamento)
values (1,123123,now(),'2024-01-10 20:00:00');
select * from listascasamentos;
# cpf 456321 Paulo

insert into listaspadrinhos (cod_listacasamento,cpf)
values (1,456321);
select * from listaspadrinhos;

insert into listascasamentos (cod_listacasamento, cpf, data_hora,data_hora_casamento)
values (2,123123,now(),'2024-02-10 20:00:00');

delete from listascasamentos where cod_listacasamento = 2;

insert into listascasamentos (cod_listacasamento, cpf, data_hora,data_hora_casamento)
values (2,456321,now(),'2024-02-10 20:00:00');
insert into listaspadrinhos (cod_listacasamento,cpf)
values (2,123123);
desc listasprodutos;
insert into listasprodutos (cod_listacasamento, cod_produto,quantidade,preco)
values(1,2,1,10.00);
select * from listasprodutos;
-- para atualizar ou alterar 
-- set - definir algo
select * from clientes;
-- update clientes set nome='João Silva';  altera todos os nomes da tabela
-- para alterar somente um registro
update clientes set nome='João Silvas'
where cpf=123123;
update clientes set telefone='(12)32132121',
email='joaosilvas@gmail.com'
where cpf=123123;
-- para alterar todos os preços de todos os produtos da loja aumentado os 10%

-- update - para alterar um determinado valor
update produtos set preco=(10/100)*preco+preco;
select * from produtos;
update produtos set preco=preco-2
where preco >20
# > maior



