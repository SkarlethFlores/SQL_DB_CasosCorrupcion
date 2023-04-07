/* 
                 UCM
          Bases de Datos SQL
       Catedratica: Isabel Riomos

 Tarea: Base de datos Casos de Corrupcion
Creada por: Skarleth melissa Motino Flores

           8 de Marzo, 2023

*/

DROP DATABASE IF EXISTS  casos_corrupcion;
CREATE DATABASE casos_corrupcion;
USE  casos_corrupcion;

-- --------------------- DEFINICION DE TABLAS -----------------------------------------------
    
DROP TABLE IF EXISTS persona_implicada;
DROP TABLE IF EXISTS persona_partido;
DROP TABLE IF EXISTS investigacion;
DROP TABLE IF EXISTS juez;
DROP TABLE IF EXISTS familia;
DROP TABLE IF EXISTS persona;
DROP TABLE IF EXISTS periodico;
DROP TABLE IF EXISTS partido;
DROP TABLE IF EXISTS ambito;
DROP TABLE IF EXISTS caso_ambitos;
DROP TABLE IF EXISTS casos;

create table juez(
   id_j  int AUTO_INCREMENT primary key,
   nombre_j varchar(50) not null,
   ape_j varchar(50) not null,
   direcion_j varchar(50),
   ciudad_j varchar(25),
   fecha_nac date,
   f_ejerce date
   );
   
create table ambito(
   id_ambito int AUTO_INCREMENT primary key,
   nombre_ambito varchar(50) 
   );

create table persona(
   id_persona  int AUTO_INCREMENT primary key,
   dni varchar(9) unique key,
   nombre_persona varchar(25) not null,
   apellido_persona varchar(25) not null,
   direcion_persona varchar(50), 
   ciudad_persona varchar(50), 
   patrimonio  numeric(12,2) DEFAULT 0
   );
   
create table familia(
   id_relacion  int AUTO_INCREMENT primary key,
   persona  int,
   familiar int,
   parentesco varchar(50)  not null,
   FOREIGN KEY(persona) REFERENCES persona(id_persona),
   FOREIGN KEY(familiar) REFERENCES persona(id_persona)
);

create table partido(
   id_partido  int AUTO_INCREMENT primary key,
   nombre_partido varchar(50) not null,
   direcion_sede varchar(50), 
   ciudad_sede  varchar(50)
   );
   
create table telefonos(
	id_partido int,
    telefono varchar(9) primary key,
    FOREIGN KEY(id_partido) REFERENCES partido(id_partido)   
    );

create table persona_partido(
   id_pp  int AUTO_INCREMENT primary key,
   id_persona  int,
   id_partido int,
   puesto  varchar(50), 
   FOREIGN KEY(id_persona) REFERENCES persona(id_persona),
   FOREIGN KEY(id_partido) REFERENCES partido(id_partido)   
);

create table periodico(
   id_periodico  int AUTO_INCREMENT primary key,
   nombre_periodico varchar(50), 
   formato varchar(20), 
   sitio_web BIT,   
   afinidad int, 
   FOREIGN KEY(afinidad) REFERENCES partido(id_partido)    
);
-- FORMATO: digital, papel
-- SITIO WEB: 1: Yes, 0: No

CREATE TABLE casos (
	id_casos  int AUTO_INCREMENT primary key,
	nombre_caso varchar(25) not null,
	descripcion_caso  varchar(50), 
    cantidad_desviada  numeric(12,2) DEFAULT 0,
    id_desc_p int,
    fecha_desc date,
    FOREIGN KEY(id_desc_p) REFERENCES periodico(id_periodico)    
    );

create table caso_ambitos(  
   id_caso  int,  
   id_ambito int,
   PRIMARY KEY(id_ambito, id_caso),
   FOREIGN KEY(id_ambito) REFERENCES ambito(id_ambito)   ON DELETE cascade,   
   FOREIGN KEY(id_caso) REFERENCES casos(id_casos)   ON DELETE cascade  
   );
create table investigacion(
   id_investigacion int AUTO_INCREMENT primary key,
   id_j  int, 
   id_caso  int, 
   dictamen varchar(50), 
   FOREIGN KEY(id_j) REFERENCES juez(id_j), 
   FOREIGN KEY(id_caso) REFERENCES casos(id_casos)
   );

create table persona_implicada(
   id_pi int AUTO_INCREMENT primary key,
   id_persona int,
   id_caso int,
   cargo_principal  varchar(50), 
   FOREIGN KEY(id_persona) REFERENCES persona(id_persona),
   FOREIGN KEY(id_caso) REFERENCES casos(id_casos)   
);

-- ---------------------------------------------------------------------------
/*
      INSERCION DE DATOS
   
*/

INSERT INTO ambito VALUES( '01', 'Banco Santander');
INSERT INTO ambito VALUES( '02', 'Estado Acoruña');
INSERT INTO ambito VALUES( '03', 'Estado Valencia');
INSERT INTO ambito VALUES( '04', 'Estado Malaga ');
INSERT INTO ambito VALUES( '05', 'Banco Nacional');
INSERT INTO ambito VALUES( '06', 'Comunidad de Madrid');
INSERT INTO ambito VALUES( '07', 'Banco de España');
INSERT INTO ambito VALUES( '08', 'Comunidad La Mancha');
INSERT INTO ambito VALUES( '09', 'Comunidad Extremadura');
INSERT INTO ambito VALUES( '10', 'Comunidad Andalucia');

INSERT INTO persona VALUES( '01', '187612876','Armando','Euceda','Barrio San Juan','Madrid','50000000.00');   
INSERT INTO persona VALUES( '02', '287612875','Maria','Castañeda','Barrio San Juan','Madrid','1000000.00');  
INSERT INTO persona VALUES( '03', '387612874','Ernesto','Castillo','Barrio San Juan','Barcelona','1000000.00');   
INSERT INTO persona VALUES( '04', '487612873','Dilma','Borjas','Barrio San Juan','Barcelona','10000000.00');   
INSERT INTO persona VALUES( '05', '587612872','Sebastian','Vicente','Barrio San Juan','Barcelona','1000000.00');   
INSERT INTO persona VALUES( '06', '687612871','Ernestina','Castañeda','Barrio San Juan','Madrid','1000000.00');   
INSERT INTO persona VALUES( '07', '787612870','Andres','Castañeda','Barrio San Juan','Madrid','500000.00');  
INSERT INTO persona VALUES( '08', '887612871','Manuel','Borjas','Barrio San Juan','Bilbao','1000000.00');   
   
INSERT INTO familia VALUES( '01', '02', '07','EsposOS'); 
INSERT INTO familia VALUES( '02', '06', '07','Madre-Hijo'); 
INSERT INTO familia VALUES( '03', '04', '07','Hermanos'); 
INSERT INTO familia VALUES( '04', '03', '04','Esposos'); 
INSERT INTO familia VALUES( '05', '01', '03','Esposos'); 

INSERT INTO partido VALUES( '01', 'VOX', 'Calle Bambú, 12 28036','Madrid'); 
INSERT INTO partido VALUES( '02', 'Popular', '	Calle de Génova, 13 28004','Madrid'); 
INSERT INTO partido VALUES( '03', 'Nacionalista Vasco', 'Calle Ibáñez de Bilbao, 16 48001','Bilbao'); 
INSERT INTO partido VALUES( '04', 'Junts per Catalunya', 'Rambla de Cataluña','Cataluña'); 
INSERT INTO partido VALUES( '05', 'PSOE', 'Calle Ferraz, 70 28008','Madrid'); 

INSERT INTO telefonos VALUES( '01', '321654987'); 
INSERT INTO telefonos VALUES( '02', '951648732'); 
INSERT INTO telefonos VALUES( '03', '652040018'); 
INSERT INTO telefonos VALUES( '04', '198746325'); 

INSERT INTO persona_partido VALUES( '01', '02','01', 'Presidente'); 
INSERT INTO persona_partido VALUES( '02', '06','01', 'Vice-Presidente'); 
INSERT INTO persona_partido VALUES( '03', '07','01', 'Secretatio'); 
INSERT INTO persona_partido VALUES( '04', '05','02', 'Presidente'); 
INSERT INTO persona_partido VALUES( '05', '08','03', 'Comisionado'); 
INSERT INTO persona_partido VALUES( '06', '03','04', 'Presidente'); 
INSERT INTO persona_partido VALUES( '07', '04','05', 'Secretario'); 
INSERT INTO persona_partido VALUES( '08', '05','02', 'Tesorero'); 

INSERT INTO periodico VALUES( '01', 'ElPais',              'papel', 1, '02' );
INSERT INTO periodico VALUES( '02', 'El Mundo',            'papel', 1, '05' );
INSERT INTO periodico VALUES( '03', 'Actuall',           'digital', 1, '01' );
INSERT INTO periodico VALUES( '04', 'Caso Aislado',      'digital', 1, '01' );
INSERT INTO periodico VALUES( '05', 'Noticias de Álava',   'papel', 1, '03' );
INSERT INTO periodico VALUES( '06', 'Noticias de Gipuzkoa','papel', 0, '03' );
INSERT INTO periodico VALUES( '07', 'El Heraldo',        'digital', 1, null );
INSERT INTO periodico VALUES( '08', 'La Vanguardia',       'papel', 1, null );

INSERT INTO casos VALUES('01', 'Arbitros',    'Desvio  de fondos de plan de arbitros.', '1000.00', '03', '2021-09-01');
INSERT INTO casos VALUES('02', 'Gavetazo',               'Desvio  de fondos de salud.', '2000.00', '02', '2018-09-01');
INSERT INTO casos VALUES('03', 'Vacunas Covid',              'Contrato sobrevalorado.', '5000.00', '01', '2021-09-01');
INSERT INTO casos VALUES('04', 'Pandemia', 'Desvio  de fondos de plan respuesta covid', '800000.00', '04', '2021-09-01');
INSERT INTO casos VALUES('05', 'Bibliotecas',           'Desvio  de fondos de compra.', '900000.00', '05', '2021-09-01');
INSERT INTO casos VALUES('06', 'Hospitales Moviles', 'Contrato sobrevalorado resp Covid.', '400000.00', '06', '2023-01-10');
INSERT INTO casos VALUES('07', 'Autopistas',                 'Contrato sobrevalorado.', '5000.00', '07', '2021-09-01');
INSERT INTO casos VALUES('08', 'Carreteras 2010',  'Desvio  de fondos de p. arbitros.', '1000.00', '08', '2020-09-01');
INSERT INTO casos VALUES('09', 'Aguas de Valencia',     'Desvio  de fondos de compra.', '3000.00', '07', '2016-03-01');
INSERT INTO casos VALUES('10', 'Manejo de Covid',            'Contrato sobrevalorado.', '4000.00', '08', '2015-01-01');
INSERT INTO casos VALUES('11', 'Carretera a Alcala',   'Contrato con irregularidades.', '500.00', '08', '2021-09-01');
INSERT INTO casos VALUES('12', 'Alcantarillados',              'Contrato no ejecutado', '4000.00', '07', '2021-09-01');
   
INSERT INTO juez VALUES('01','Pedro',   'Flores', 'Calle Jerez',     'Madrid', '1970-10-06', '1995-11-16');
INSERT INTO juez VALUES('02','Angela',   'Lopez', 'Calle Antares',  'Cordoba', '1975-11-06', '1995-11-16');
INSERT INTO juez VALUES('03','Carmen',   'Penas', 'Calle Amaya',    'Sevilla', '1980-06-03', '1998-11-16');
INSERT INTO juez VALUES('04','Leandro',  'Lopez', 'Calle Pascual',   'Madrid', '1977-04-02', '1998-11-16');
INSERT INTO juez VALUES('05','Carlos',    'Bose', 'Calle Castro',    'Madrid', '1979-10-07', '2005-10-10');
INSERT INTO juez VALUES('06','Miguel',    'Zans', 'Calle Alameda',  'Segovia', '1981-05-06', '2005-10-10');

INSERT INTO caso_ambitos VALUES( '01', '01');
INSERT INTO caso_ambitos VALUES( '02', '10');
INSERT INTO caso_ambitos VALUES( '03', '09');
INSERT INTO caso_ambitos VALUES( '04', '08');
INSERT INTO caso_ambitos VALUES( '05', '07');
INSERT INTO caso_ambitos VALUES( '06', '10');
INSERT INTO caso_ambitos VALUES( '01', '04');
INSERT INTO caso_ambitos VALUES( '02', '03');
INSERT INTO caso_ambitos VALUES( '03', '02');
INSERT INTO caso_ambitos VALUES( '04', '01');
INSERT INTO caso_ambitos VALUES( '02', '05');

INSERT INTO investigacion VALUES( '01', '03', '01', 'Culpable');
INSERT INTO investigacion VALUES( '02', '02', '02', 'Culpable');
INSERT INTO investigacion VALUES( '03', '01', '03', 'Absuelto');
INSERT INTO investigacion VALUES( '04', '04', '04', 'Culpable');
INSERT INTO investigacion VALUES( '05', '05', '05', 'Absuelto');
INSERT INTO investigacion VALUES( '06', '06', '06', 'Absuelto');
INSERT INTO investigacion VALUES( '07', '04', '07', 'Pendiente');
INSERT INTO investigacion VALUES( '08', '02', '08', 'Absuelto');
INSERT INTO investigacion VALUES( '09', '03', '09', 'Pendiente');
INSERT INTO investigacion VALUES( '10', '06', '10', 'Pendiente');
 

INSERT INTO persona_implicada VALUES( '01', '04', '01','Gerente General'); 
INSERT INTO persona_implicada VALUES( '02', '01', '02','Consultor Externo'); 
INSERT INTO persona_implicada VALUES( '03', '05', '03','Asesor Externo'); 
INSERT INTO persona_implicada VALUES( '04', '06', '04','Director de Centro Medico'); 
INSERT INTO persona_implicada VALUES( '05', '07', '05','Vicepresidente financiero'); 
INSERT INTO persona_implicada VALUES( '06', '08', '06','Gerente General'); 
INSERT INTO persona_implicada VALUES( '07', '05', '07','Asesor Financiero'); 
INSERT INTO persona_implicada VALUES( '08', '01', '08','Gerente General'); 
INSERT INTO persona_implicada VALUES( '09', '02', '09','Secretario de Manejo de Obras'); 
INSERT INTO persona_implicada VALUES( '10', '04', '10','Ministro de Salud'); 
INSERT INTO persona_implicada VALUES( '11', '02', '01','Analista financiero'); 
INSERT INTO persona_implicada VALUES( '12', '06', '02','Tesorero de Centro Medico'); 
INSERT INTO persona_implicada VALUES( '13', '02', '03','Ministro Finanzas'); 
INSERT INTO persona_implicada VALUES( '14', '08', '02','Tesorero General'); 
   
-- ---------------------------------------------------------------------------
/*
VISUALIZAR LAS TABLAS
*/
-- ---------------------------------------------------------------------------
USE  casos_corrupcion;
SELECT * FROM ambito;
SELECT * FROM partido;
SELECT * FROM telefonos;
SELECT * FROM periodico;
SELECT * FROM juez;
SELECT * FROM investigacion;
SELECT * FROM persona;
SELECT * FROM familia;
SELECT * FROM persona_implicada;
SELECT * FROM persona_partido;
SELECT * FROM casos;
SELECT * FROM caso_ambitos; 

-- ---------------------------------------------------------------------------
/*
      CONSULTAS
          &
       VISTAS
*/
-- ---------------------------------------------------------------------------
USE  casos_corrupcion; 
/* 
Nos interesará saber en qué ciudad hay el máximo número de corruptos, 
total del dinero defraudado por partido político (se contará si y sólo si la persona está afiliada al partido), 
periódico que más casos ha descubierto, año en el que se descubrieron más casos, número de personas implicadas en cada caso, 
número de implicados en cada caso, juez que más casos ha llevado, hay algún juez que aún no haya llevado un caso, …

*/ 
-- 1
-- Mostrar Los casos que estan siendo investigados y su dictamen correspondiente.
SELECT id_caso AS 'ID', casos.nombre_caso as 'Caso', dictamen  As 'Dictamen' FROM investigacion AS inv 
RIGHT JOIN casos ON inv.id_caso=casos.id_casos where id_casos in (select id_caso from investigacion);


-- 2
-- Mostrar Los casos que no han sido investigados aun.
SELECT id_casos AS 'ID', nombre_caso as 'Caso', 'No Iniciado'  As 'Investigacion'  FROM casos 
 where id_casos not in (select id_caso from investigacion);


-- 3
-- Mostrar Los casos que estan siendo investigados y su dictamen correspondiente.
SELECT id_caso AS 'ID', casos.nombre_caso as 'Caso', dictamen  As 'Dictamen' FROM investigacion AS inv 
RIGHT JOIN casos ON inv.id_caso=casos.id_casos
WHERE Dictamen='Pendiente';

-- 4
-- Update: Actualizar el dictamen de el caso #09, establecer el dicatmen como 'Culpable'. 
UPDATE investigacion
SET dictamen = 'Culpable' 
WHERE id_caso=9;
SELECT * FROM investigacion;

-- 5
--  Mostrar los periodicos independientes y el tipo de formato (que no muestran simpatia por ningun partido).
SELECT nombre_periodico AS 'Periodico', formato as 'Formato' from periodico where afinidad is null;

-- 6
--  Mostrar la Ciudad con mayor numero de corruptos (Ciudad con mas personas implicadas en casos de corrupcion).
select ciudad_persona as Ciudad, count(*) as numero_corruptos from persona
RIGHT JOIN persona_implicada as pim
on persona.id_persona= pim.id_persona
group by Ciudad
order by numero_corruptos desc
limit 1;

-- 7 
-- Mostrar los jueces con su antiguedad en el trabajo, y cuantos casos ha investigado. 

SELECT juez.id_j AS ID, nombre_j AS Nombre, ape_j AS Apellido, f_ejerce as Comenzo_a_Ejercer, 
COUNT(investigacion.id_j)  as 'Cant Casos Investigados'
FROM juez, investigacion where juez.id_j = investigacion.id_j
group by juez.id_j
order by Comenzo_a_Ejercer; 


-- 8
-- Mostrar el total dinero defraudado por partido, usando las cantidades defraudadas 
-- por personas implicadas asociadas a cada partido.

SELECT 	persona_partido.id_partido, partido.nombre_partido AS 'Partido', 
		SUM( casos.cantidad_desviada) AS Suma_Defraudada 
FROM partido, casos, persona_partido, persona_implicada
WHERE  persona_implicada.id_persona = persona_partido.id_persona and 
	   persona_partido.id_partido =  partido.id_partido
group by persona_partido.id_partido 
order by Suma_Defraudada desc;

-- 9
-- Crear una VISTA
-- Mostrar Personas involucradas en casos de investigacion, y que tienen familiares 
-- involucrados en casos de corrupcion.

CREATE VIEW familiares(id_perfam, n_persona, a_persona, id_familiar, n_familiar, a_familiar, parentesco) AS

 SELECT  persona.id_persona, nombre_persona AS Nombre, apellido_persona AS Apellido, 
         id_familiar, n_familiar AS 'Familiar Nombre', a_familiar AS 'Familiar Apellido', parentesco
 FROM persona,(
	SELECT familia.persona, familia.familiar,
    persona.nombre_persona, persona.apellido_persona, familia.parentesco FROM persona, familia
	WHERE familia.familiar = persona.id_persona)
    AS familiar(id_perfam, id_familiar, n_familiar, a_familiar, parentesco)
    WHERE persona.id_persona = familiar.id_perfam
    ;
        
-- Visualizar la vista creada
SELECT * FROM familiares;


-- 10
-- Ver todas las relaciones familiares que invoucren el apellido 'Castañeda'.
-- Aqui, usare la vista creada en el inciso anterior.
 SELECT n_persona AS Nombre, a_persona AS Apellido, n_familiar AS 'Familiar Nombre', a_familiar AS 'Familiar Apellido', parentesco
 FROM  familiares 
 WHERE  a_persona= 'Castañeda' or a_familiar= 'Castañeda' 
;

-- 11 CREACION DE UNA VISTA
-- Crear una vista con la lista de todos los periodicos, y con que partido simpatizan. 
CREATE VIEW Periodicos(id_per, NomPeriodico, NomPartido) AS
SELECT periodico.id_periodico, periodico.nombre_periodico, partido.nombre_partido
		FROM periodico LEFT JOIN partido ON partido.id_partido = periodico.afinidad;

-- Visualizar la vista creada.
SELECT * FROM periodicos;

 -- 12
 -- Mostrar cuantos casos ha descubierto cada periodico en orden descendente,
 -- la cantidad de dinero total desviada y el partido por el cual el caso muestra afinidad.
 -- En caso de no tener afinidad con ningun partido imprimir 'Independiente'. 
 -- Aqui, usare la vista Periodicos que cree en el inciso anterior.
  
 SELECT NomPeriodico, COUNT(id_desc_p) AS Total_Casos_Descubiertos, SUM(cantidad_desviada) AS Total_Desviado, 
ifNULL(NomPartido,'Independiente') As 'Partido'
 FROM casos,  Periodicos
 WHERE     Periodicos.id_per = casos.id_desc_p
 GROUP BY Periodicos.id_per
 ORDER BY Total_Casos_Descubiertos desc 
 ;
 
-- 13
-- Calcular el promedio, total, minimo y maximo de la cantidad desfraudadas de todos los casos. 
SELECT 'Cantidades defraudadas', AVG(cantidad_desviada) AS Promedio, SUM(cantidad_desviada) AS Total_Desviado, 
 MAX(cantidad_desviada) AS Maximo_Defraudado, MIN(cantidad_desviada) AS Menor_Defraudado
 FROM casos
 ;
 
-- 14
-- Mostrar en que ambitos abarca el caso con id_casos=02, y en que ciudad se desarrolla.

SELECT id_casos, nombre_caso As 'Nombre Caso', nombre_ambito AS Ambitos
	FROM casos, caso_ambitos, ambito
	WHERE
		ambito.id_ambito = caso_ambitos.id_ambito and
		caso_ambitos.id_caso = casos.id_casos and
		casos.id_casos ='02';
        
-- 15
-- Mostrar las personas implicadas en casos, y el total defraudado por persona.

SELECT  
persona_implicada.id_persona, dni, nombre_persona, apellido_persona, ciudad_persona,
 count(id_caso) AS 'Implicada en X casos', SUM(casos.cantidad_desviada) AS 'Suma Cant. Defraudada'
FROM persona_implicada, persona, casos
	WHERE  persona_implicada.id_persona = persona.id_persona
    AND persona_implicada.id_caso = casos.id_casos 
Group by persona_implicada.id_persona
ORDER BY persona_implicada.id_persona;

-- 16
-- Partidos políticos con sede en Madrid, y su numero telefonico. 
SELECT nombre_partido as partido, ciudad_sede AS Ciudad, telefono
FROM partido
RIGHT JOIN telefonos on partido.id_partido = telefonos.id_partido
WHERE ciudad_sede like '%Madrid%';

 
-- 17
-- Mostrar todos los implicados en casos de corrupcion que esten vinculados a palabras 'COVID' o 'Pandemia'. 
SELECT * FROM persona_implicada,
(SELECT * FROM casos
WHERE descripcion_caso like '%covid%' OR nombre_caso like '%covid%' OR 
      descripcion_caso like '%pandemia%' OR nombre_caso like '%pandemia%' ) AS CasosCovid
WHERE persona_implicada.id_caso = CasosCovid.id_casos;

-- ---------------------------------------------------------------------------
/*
      TRIGGER
*/
-- ---------------------------------------------------------------------------
 /*
create table juez(
   id_j  int AUTO_INCREMENT primary key,
   nombre_j varchar(50) not null,
   ape_j varchar(50) not null,
   direcion_j varchar(50),
   ciudad_j varchar(25),
   fecha_nac date,
   f_ejerce date
   );
 */
USE  casos_corrupcion;
-- DROP FUNCTION IF EXISTS CorroboraFecha;
--
DROP TRIGGER IF EXISTS CorroboraFecha;

delimiter //
create trigger CorroboraFecha before insert on juez for each row
	begin
		if new.f_ejerce < new.fecha_nac then 
			SIGNAL SQLSTATE '99991' SET MESSAGE_TEXT = 'WARNING! Fecha en que comenzo a ejercer no debe ser anterior a la fecha de nacimiento.';
		end if;
    end //           

INSERT INTO juez VALUES('013','Antonio',  'Camacho', 'Calle Alameda',  'Segovia', '1981-05-06', '1900-10-10');
SELECT * FROM juez;