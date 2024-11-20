-- BANCO DE DADOS SYNAPSYS
drop database if exists SynapSys;
-- CRIAÇÃO DO DATABASE
CREATE DATABASE SynapSys;
use Synapsys;


-- TIPOS DE USUÁRIO
create table Synapsys.tipoUsuario(
idTipo int auto_increment,
descricao varchar(45),
primary key(idTipo)
);


-- CADASTRO DO USUÁRIO 
create table Synapsys.usuario(
idUsuario int primary key auto_increment,
nome varchar(45) not null,
email varchar(45) not null,
senha varchar(45) not null,
telefoneContato char(11) not null,
createAt timestamp DEFAULT CURRENT_TIMESTAMP,
updateAt timestamp,
fkTipo int not null,
status varchar(15) default 'habilitado',
constraint fkTipo foreign key (fkTipo) references tipoUsuario(idTipo)
);


-- ENDEREÇO
create table Synapsys.endereco(
idEndereco int primary key auto_increment,
cep char(8) not null,
uf char(2) not null,
logradouro varchar(100) not null,
numero int not null,
cidade varchar(45) not null,
bairro varchar(45) not null,
complemento varchar(45),
fkDonoPropriedade int null,
createAt timestamp DEFAULT CURRENT_TIMESTAMP,
updateAt timestamp
);


-- CADASTRO DE EMPRESA
create table Synapsys.empresa(
idEmpresa int primary key auto_increment,
razaoSocial varchar(45) not null,
nomeFantasia varchar(45) not null,
inscricaoEstadual varchar(45) not null,
cnpj char(14),
createAt timestamp DEFAULT CURRENT_TIMESTAMP,
updateAt timestamp,
status varchar(15) default 'habilitado',
fk_endereco int not null,
constraint fk_endereco foreign key (fk_endereco) references endereco (idEndereco),
fk_usuario int not null,
constraint fk_usuario foreign key (fk_usuario) references usuario (idUsuario)
);

-- CADASTRO DE ASSOCIAÇÃO
create table Synapsys.associar(
idAssociar int primary key,
fkUsuario int not null,
fkEmpresa int not null,
constraint fkUsuario foreign key (fkUsuario) references usuario (idUsuario),
constraint fkEmpresa foreign key (fkEmpresa) references empresa (idEmpresa)
);

-- CADASTRO DE PROPRIEDADE
create table Synapsys.propriedade(
idPropriedade int primary key auto_increment,
tamanho int not null,
createAt timestamp DEFAULT CURRENT_TIMESTAMP,
updateAt timestamp,
status varchar(15) default 'habilitado',
fk_endereco int not null,
constraint fk_endereco2 foreign key (fk_endereco) references endereco (idEndereco),
fk_empresa int not null,
constraint fk_empresa foreign key (fk_empresa) references empresa (idEmpresa)
);

alter table endereco add constraint fkDonoPropriedade foreign key (fkDonoPropriedade) references propriedade(idPropriedade);

-- DADOS CAPTURADOS DAS BASES
create table Synapsys.leitura(
idLeitura int auto_increment primary key,
dataHora datetime,
latitude double,
longitude double,
direcaoVento int,
rajadaMax double,
velocidadeHoraria double,
municipio varchar(45) not null,
estado varchar(45) not null,
createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INSERT (TIPO USUARIO):
insert into Synapsys.tipoUsuario (idTipo, descricao)
VALUES (1, "Empresario"),
       (2, "Investidor"),
       (3, "Empresario e Investidor");

-- OBS* direção do vento é em graus e velocidade em m/s.
