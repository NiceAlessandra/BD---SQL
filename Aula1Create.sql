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

