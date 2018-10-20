create table USUARIO (
	idUsuario 		integer 	not null,
	nomeUsuario 		varchar(45)	not null,
	cidadeUsuario		varchar(45),
	idadeUsuario    	integer 	not null,
	qtdAmigosUsuarios	integer,
	constraint PK_USUARIO
		primary key (idUsuario)
);

create table COMUNIDADE (  
	idComunidade		integer		not null,
	proprietarioComunidade	integer		not null,
	nomeComunidade		varchar(45)	not null,
	qtdUsuariosComunidade	integer		not null,
	constraint PK_Comunidade
		primary key (idComunidade),
	constraint FK_COMUNIDADE_USUARIO
		foreign key (proprietarioComunidade)
		references USUARIO(idUsuario)
);
create table AMIGO (
	idUsuario2		integer 	not null,
	idAmigo			integer		not null,
	constraint PK_AMIGO
		PRIMARY KEY (idUsuario2,idAmigo),

	constraint FK1_AMIGO_USUARIO
		foreign key (idUsuario2)
		references USUARIO(idUsuario),
	constraint FK2_AMIGO_USUARIO
		foreign key (idAmigo)
		references USUARIO(idUsuario)
 
);
create table ORKUT (
	idUsuarioOrkut		integer		not null,
	idComunidadeOrkut	Integer		not null,
	constraint PK_ORKUT
		PRIMARY KEY (idUsuarioOrkut,idComunidadeOrkut),

	constraint FK1_ORKUT_USUARIO
		foreign key (idUsuarioOrkut)
		references USUARIO(idUsuario),
	constraint FK2_ORKUT_COMUNIDADE
		foreign key (idComunidadeOrkut)
		references COMUNIDADE(idComunidade)
);

insert into USUARIO(idUsuario,nomeUsuario,cidadeUsuario,idadeUsuario,qtdAmigosUsuarios)
VALUES 
(1,'wirys da cunha francisco','iconha',19,288),
(2,'Lidiane Louzada gomes', 'Conduru',20,355),
(3,'Maria Joaquina Cruz','Rio de Janeiro',35,500);

insert into COMUNIDADE (idComunidade,proprietarioComunidade,nomeComunidade,qtdUsuariosComunidade)
values 
(1,1,'Programadores',36),
(2,2,'JavaDevelop',200),
(3,3,'ABC SQl',1000),
(4,2,'Html para todos',100)

insert into ORKUT (idUsuarioOrkut,idComunidadeOrkut)
values 
(1,1),
(1,2),
(2,1),
(2,2),
(2,4)

--*Para Group By
-- Coluna coluna funcao de agregação
--Group by 
	
1) --Crie uma consulta que apresente uma relação de comunidades e seus proprietários.
select C.idcomunidade, C.nomecomunidade , u.idusuario, u.nomeusuario
from USUARIO AS U, COMUNIDADE AS C
where U.idUsuario = C.proprietarioComunidade;

2)  -- Escreva uma consulta para apresentar uma relação de comunidades e seus participantes.

select C.idcomunidade , C.nomecomunidade,U.nomeusuario, O.idUsuarioOrkut, O.idComunidadeOrkut
from COMUNIDADE AS C , ORKUT AS O, USUARIO AS U
WHERE O.idComunidadeOrkut = C.idcomunidade 
AND  O.idUsuarioOrkut = u.idusuario

3) --Estabeleça um comando o qual possa ser usado para recuperar todas as comunidades sob a propriedade de “Maria Joaquina Cruz”.
select C.idcomunidade , C.nomecomunidade,U.idUsuario,U.nomeusuario
from COMUNIDADE AS C , USUARIO AS U
where U.idUsuario = C.proprietarioComunidade 
and U.nomeusuario = 'Lidiane Louzada gomes'; 


4) --Especifique uma consulta que apresente o somatório das quantidades de participantes das comunidades da “Maria Joaquina Cruz”.
Select SUM(  C.qtdUsuariosComunidade)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
and U.nomeusuario = 'Lidiane Louzada gomes'; 

5) --Especifique uma consulta que apresente o somatório das quantidades de participantes das comunidades de cada usuário proprietário de uma ou mais comunidades.
select  U.idUsuario,U.nomeusuario,SUM(  C.qtdUsuariosComunidade)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
group by U.idUsuario,U.nomeusuario;


6) -- Crie um comando para apresentar a quantidade de comunidades sob a propriedade de cada usuário que é proprietário de uma ou mais comunidades.
 select  U.idUsuario,U.nomeusuario,COUNT(*)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
group by U.idUsuario,U.nomeusuario;


7) -- Determine uma consulta com a qual seja possível obter a quantidade de amigos de cada usuário sem utilizar a coluna 'qtdAmigosUsuario'.
 select u.idUsuario, u.nomeUsuario, COUNT(*)
FROM usuario as u, amigo as a
where u.idUsuario = a.idUsuario2
group by u.idUsuario, u.nomeUsuario


8) -- Para cada proprietário de comunidade, apresente a quantidade de participantes da comunidade sob sua propriedade com a maior quantidade de participantes. 

select u.idUsuario , u.NomeUsuario , MAX(c.qtdusuarioscomunidade)
from usuario as u , comunidade as c
where u.idUsuario = c.proprietariocomunidade
group by u.idusuario, u.nomeusuario
 
9) --Apresente uma consulta que possa ser usada para listar os usuários sem amigos. Sua solução não pode usar a coluna 'qtdAmigosUsuario'.
select u.idUsuario, U.nomeusuario 
 from usuario as u left outer join amigo as a
 on u.idUsuario = a.idUsuario2
 where a.idAmigo is null
