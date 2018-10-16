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

insert into USUARIO(idUsuario,nomeUsuario,cidadeUsuario,idadeUsuario,qatdAmigosUsuarios)
VALUES 
(1,'wirys da cunha francisco','iconha',19,288),
(2,'Lidiane Louzada gomes', 'Conduru',20,355),
(3,'Maria Joaquina Cruz','Rio de Janeiro',35,500)

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
	
1)
select C.idcomunidade, C.nomecomunidade , u.idusuario, u.nomeusuario
from USUARIO AS U, COMUNIDADE AS C
where U.idUsuario = C.proprietarioComunidade;

2)

select C.idcomunidade , C.nomecomunidade,U.nomeusuario, O.idUsuarioOrkut, O.idComunidadeOrkut
from COMUNIDADE AS C , ORKUT AS O, USUARIO AS U
WHERE O.idComunidadeOrkut = C.idcomunidade 
AND  O.idUsuarioOrkut = u.idusuario

3)
select C.idcomunidade , C.nomecomunidade,U.idUsuario,U.nomeusuario
from COMUNIDADE AS C , USUARIO AS U
where U.idUsuario = C.proprietarioComunidade 
and U.nomeusuario = 'Lidiane Louzada gomes'; 


4)
Select SUM(  C.qtdUsuariosComunidade)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
and U.nomeusuario = 'Lidiane Louzada gomes'; 

5) 
select  U.idUsuario,U.nomeusuario,SUM(  C.qtdUsuariosComunidade)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
group by U.idUsuario,U.nomeusuario;

6) select  U.idUsuario,U.nomeusuario,COUNT(*)
from Comunidade as C, usuario as U
where U.idUsuario = C.proprietarioComunidade 
group by U.idUsuario,U.nomeusuario;