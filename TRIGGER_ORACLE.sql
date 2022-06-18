--=============CREACION DE TABLAS=====----
create table ESTUDIANTE
(
    ID_ESTUDIANTE INTEGER,
    NOMBRE_EST    VARCHAR2(40),
    FECHA_INGRESO_EST DATE,
    NUMERO_REPET_EST NUMERIC,
    constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE)
);

CREATE TABLE MATRICULA
(
    ID_MATRICULA INTEGER,
    ID_ESTUDIANTE INTEGER,
    FECHA_MATRI DATE,
    NIVEL_MATRI NUMERIC,
    constrainT PK_MATRICULA primary key (ID_MATRICULA)
);
alter table matricula
    add constraint fk_estudiante foreign key (id_estudiante)
        references estudiante (id_estudiante);

--Nota como explique en las indicaciones, funciona el trigger, pero
--antes de ejecutar un insert es decir (uno cada uno de los insert) 
--debe de presionar el boton de confirmar o si no la tecla (F11) 
--y asi mismo, despues de haberse ejecutado el insert se debe de presionar el boton confirmar(F11).
--REALMENTE no se por que  sucede eso, pero si se realiza correctamente, este funciona. 


--TRIGGER.
create or replace trigger ControlMatri
BEFORE INSERT OR DELETE on Matricula
FOR EACH ROW
declare valor number(4):=0;
PRAGMA AUTONOMOUS_TRANSACTION;
begin
    IF INSERTING THEN
        select COUNT(*) into valor from matricula where Id_Estudiante = :new.Id_Estudiante and Nivel_matri = :new.nivel_matri;
        If valor>=1 then
        update estudiante set Numero_repet_est = valor  where Id_estudiante = :new.Id_Estudiante;
        end if;
    ELSIF  DELETING THEN
     select COUNT(*) into valor from matricula where Id_Estudiante = :old.Id_Estudiante and Nivel_matri = :old.nivel_matri;
        If valor>1 then
            update estudiante set Numero_repet_est = Numero_repet_est-1 where Id_estudiante = :old.Id_Estudiante;
            end if;
        end if;
    commit;
end;


insert into estudiante values (1,'Ariel','01/02/2001',0);
insert into estudiante values (2,'Jean','01/02/2002',0);
insert into estudiante values (3,'Pierre','01/02/2003',0);

--Nota como explique en las indicaciones, funciona el trigger, pero
--antes de ejecutar un insert es decir (uno cada uno de los insert) 
--debe de presionar el boton de confirmar o si no la tecla (F11) 
--y asi mismo, despues de haberse finalizado la ejecucion del insert se debe de presionar el boton confirmar(F11).
--REALMENTE no se por que  sucede eso, pero si se realiza correctamente, este funciona. 

insert into matricula values (1,1,'01/02/2001',1);--confirmar(F11)
insert into matricula values (2,1,'01/02/2002',1);--confirmar(F11)
insert into matricula values (3,1,'01/02/2003',1);--confirmar(F11)
insert into matricula values (4,2,'01/02/2002',1);--confirmar(F11)
insert into matricula values (5,2,'01/02/2003',1);--confirmar(F11)
insert into matricula values (6,3,'01/02/2003',1);--confirmar(F11) 

--para comprobar..Eliminar las matricular 
--delete from matricula where id_matricula = 6
--select * from Estudiante 