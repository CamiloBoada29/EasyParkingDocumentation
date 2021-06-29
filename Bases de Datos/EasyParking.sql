CREATE TABLE athority (
    name varchar(50) NOT NULL,
     PRIMARY KEY (name)
     );

CREATE TABLE user_authority (
    name_rol varchar(50) NOT NULL,
     id_system_user int4 NOT NULL, 
     PRIMARY KEY (name_rol, id_system_user)
    );

CREATE TABLE "system_user" (
    id SERIAL NOT NULL, 
    login varchar(50) NOT NULL UNIQUE,
    password varchar(60) NOT NULL, 
    email varchar(254) NOT NULL UNIQUE, 
    activated int4,
    lang_key varchar(6) NOT NULL,
    image_url varchar(256), 
    activation_key varchar(20), 
    reset_ket varchar(20), 
    reset_date timestamp, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_system_user UNIQUE (login, email)
    );

CREATE TABLE empleado (
    id SERIAL NOT NULL, 
    id_system_user int4 NOT NULL UNIQUE, 
    id_tipo_documento int4 NOT NULL UNIQUE, 
    numero_documento varchar(50) NOT NULL UNIQUE, 
    primer_nombre varchar(50) NOT NULL, 
    segundo_nombre varchar(50), 
    primer_apellido varchar(50) NOT NULL, 
    segundo_apellido varchar(50), 
    telefono int4 NOT NULL, 
    tipo_sangre varchar(20) NOT NULL, 
    rh varchar(10) NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_empleado UNIQUE (id_system_user, id_tipo_documento, numero_documento)
    );

CREATE TABLE tipo_documento (
    id SERIAL NOT NULL, 
    sigla varchar(50) NOT NULL UNIQUE, 
    nombre_documento varchar(50) NOT NULL, 
    estado varchar(50) NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_tipo_documento UNIQUE (sigla)
    );

CREATE TABLE vehiculo (
    id SERIAL NOT NULL, 
    numero_placa varchar(50) NOT NULL UNIQUE, 
    color varchar(50) NOT NULL, 
    marca varchar(50) NOT NULL, 
    id_empleado int4 NOT NULL UNIQUE, 
    id_ticket int4 NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_vehiculo UNIQUE (id_empleado, numero_placa)
    );

CREATE TABLE tarifa (
    id SERIAL NOT NULL, 
    tipo_vehiculo varchar(50) NOT NULL UNIQUE, 
    tarifa_tipo_vehiculo int4 NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_tarifa UNIQUE (tipo_vehiculo)
    );

CREATE TABLE reporte (
    id SERIAL NOT NULL, 
    numero_reporte varchar(50) NOT NULL UNIQUE, 
    fecha timestamp NOT NULL, 
    id_empleado int4 NOT NULL UNIQUE, 
    id_vehiculo int4 NOT NULL UNIQUE, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_reporte UNIQUE (numero_reporte, id_empleado, id_vehiculo)
    );

CREATE TABLE ticket (
    id SERIAL NOT NULL, 
    numero_ticket int4 NOT NULL UNIQUE, 
    fecha timestamp NOT NULL, 
    hora_ingreso time(10) NOT NULL, 
    hora_salida time(10), 
    valor_final int4 NOT NULL, 
    id_tarifa int4 NOT NULL, 
    id_empleado int4 NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT uk_ticket UNIQUE (numero_ticket)
    );

ALTER TABLE user_authority ADD CONSTRAINT fk_auth_usau FOREIGN KEY (name_rol) REFERENCES athority (name);
ALTER TABLE user_authority ADD CONSTRAINT fk_syus_usau FOREIGN KEY (id_system_user) REFERENCES "system_user" (id);
ALTER TABLE empleado ADD CONSTRAINT fk_syus_empl FOREIGN KEY (id_system_user) REFERENCES "system_user" (id);
ALTER TABLE empleado ADD CONSTRAINT fk_tido_empl FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento (id);
ALTER TABLE vehiculo ADD CONSTRAINT fk_empl_vehi FOREIGN KEY (id_empleado) REFERENCES empleado (id);
ALTER TABLE reporte ADD CONSTRAINT fk_empl_repo FOREIGN KEY (id_empleado) REFERENCES empleado (id);
ALTER TABLE reporte ADD CONSTRAINT fk_vehi_repo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id);
ALTER TABLE ticket ADD CONSTRAINT fk_tari_tick FOREIGN KEY (id_tarifa) REFERENCES tarifa (id);
ALTER TABLE vehiculo ADD CONSTRAINT fk_tick_vehi FOREIGN KEY (id_ticket) REFERENCES ticket (id);
ALTER TABLE ticket ADD CONSTRAINT fk_empl_tick FOREIGN KEY (id_empleado) REFERENCES empleado (id);

SELECT id, numero_documento, primer_nombre, primer_apellido, telefono FROM empleado;
INSERT INTO empleado(id,numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo_sangre, rh) VALUES (2, 1485471488, 'Jhon', 'Jairo', 'Sanchez', 'Quitian', 258744, 'O', 'POSITIVO');
UPDATE empleado SET numero_documento=1582212, telefono=345751 WHERE id = 2;
DELETE FROM empleado WHERE id = 2;

SELECT id, numero_reporte, fecha FROM reporte;
INSERT INTO reporte(id,  numero_reporte, fecha) VALUES (1, 25, '2021-04-10');
UPDATE reporte SET numero_reporte=2576, fecha= '2021-05-09' WHERE id = 1 ;
DELETE FROM reporte WHERE id=1;

SELECT id, tipo_vehiculo, tarifa_tipo_vehiculo FROM tarifa;
INSERT INTO tarifa(id,  tipo_vehiculo, tarifa_tipo_vehiculo) VALUES (1,'carro', 60);
UPDATE tarifa SET  tipo_vehiculo='moto', tarifa_tipo_vehiculo=80 WHERE id =1 ;
DELETE FROM tarifa WHERE id=1;

SELECT id numero_ticket, fecha, hora_ingreso, hora_salida, valor_final FROM ticket;
INSERT INTO ticket(id, numero_ticket, fecha, hora_ingreso, hora_salida, valor_final ) VALUES (1,12, '2021-10-06','2021-06-29 03:00:00','2021-06-29 06:00:00', 19200);
UPDATE ticket SET numero_ticket=12, fecha='2021-11-07', hora_ingreso='2021-06-29 06:00:00', hora_salida='2021-06-29 09:00:00', valor_final=15000  WHERE id=1;
DELETE FROM ticket WHERE id=1;

SELECT id, numero_placa, color, marca FROM vehiculo;
INSERT INTO vehiculo(id, numero_placa, color, marca) VALUES (1, 'JAG852', 'Gris','Mazda');
UPDATE vehiculo SET color='Azul' WHERE id=1;
DELETE FROM vehiculo WHERE id=1;

SELECT id, sigla, nombre_documento, estado FROM tipo_documento;
INSERT INTO tipo_documento(id, sigla, nombre_documento, estado) VALUES (1,'cc' , 'cedula cuidadania' , 'ACTIVO');
UPDATE tipo_documento SET  sigla='cc', nombre_documento='cedula cuidadania', estado='INACTIVO' WHERE id=1;
DELETE FROM tipo_documento WHERE id=1;