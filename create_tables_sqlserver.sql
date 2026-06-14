-- ============================================================
-- StreamUCV — SQL Server 2022
-- Script: create_tables_sqlserver.sql
-- Descripción:Crea las tablas, restricciones e índices del sistema de contenido audiovisual de StreamUCV.
-- ============================================================

USE StreamUCV;
GO

-- ============================================================
-- ELIMINAR TABLAS SI EXISTEN
-- Orden importante por claves foráneas
-- ============================================================

DROP TABLE IF EXISTS streaming.involucrada;
DROP TABLE IF EXISTS streaming.transmite;
DROP TABLE IF EXISTS streaming.participa;
DROP TABLE IF EXISTS streaming.interpreta;
DROP TABLE IF EXISTS streaming.venta;
DROP TABLE IF EXISTS streaming.lanzar;

DROP TABLE IF EXISTS streaming.horario;
DROP TABLE IF EXISTS streaming.semana;
DROP TABLE IF EXISTS streaming.pelicula;
DROP TABLE IF EXISTS streaming.artista;
DROP TABLE IF EXISTS streaming.personaje;
DROP TABLE IF EXISTS streaming.cadena;
DROP TABLE IF EXISTS streaming.serie;
GO



-- ============================================================
-- TABLA: serie
-- ============================================================

CREATE TABLE streaming.serie (
    cod_serie          VARCHAR(50)    NOT NULL,
    nombre_serie       VARCHAR(510)   NOT NULL,
    tipo_serie         VARCHAR(50)    NOT NULL,
    cant_actores       INT            NOT NULL,
    desc_serie         VARCHAR(510),
    rating             DECIMAL(3,1)   NOT NULL,

    CONSTRAINT pk_serie PRIMARY KEY (cod_serie),

    CONSTRAINT chk_serie_tipo
        CHECK (tipo_serie IN ('dramatica','suspenso','comica')),

    CONSTRAINT chk_serie_cant_actores
        CHECK (cant_actores > 0),

    CONSTRAINT chk_serie_rating
        CHECK (rating >= 0 AND rating <= 10)
);
GO

CREATE INDEX ix_serie_nombre
ON streaming.serie(nombre_serie);
GO


-- ============================================================
-- TABLA: cadena
-- ============================================================

CREATE TABLE streaming.cadena (
    cod_cadena          VARCHAR(50)    NOT NULL,
    nombre_cadena       VARCHAR(510)   NOT NULL,
    direccion_cadena    VARCHAR(510),
    presidente          VARCHAR(510)   NOT NULL,

    CONSTRAINT pk_cadena PRIMARY KEY (cod_cadena)
);
GO

CREATE INDEX ix_cadena_nombre
ON streaming.cadena(nombre_cadena);
GO


-- ============================================================
-- TABLA: personaje
-- ============================================================

CREATE TABLE streaming.personaje (
    cod_personaje       VARCHAR(50)    NOT NULL,
    nombre_personaje    VARCHAR(510)   NOT NULL,
    tipo_personaje      VARCHAR(50),

    CONSTRAINT pk_personaje PRIMARY KEY (cod_personaje)
);
GO

CREATE INDEX ix_personaje_nombre
ON streaming.personaje(nombre_personaje);
GO


-- ============================================================
-- TABLA: artista
-- ============================================================

CREATE TABLE streaming.artista (
    cod_artista         VARCHAR(50)    NOT NULL,
    nombre_real         VARCHAR(510)   NOT NULL,
    estado_civil        VARCHAR(50)    NOT NULL,
    nombre_artistico    VARCHAR(510),

    CONSTRAINT pk_artista PRIMARY KEY (cod_artista),

    CONSTRAINT chk_artista_estado_civil
        CHECK (estado_civil IN ('soltero','casado','divorciado','viudo'))
);
GO

CREATE INDEX ix_artista_nombre_real
ON streaming.artista(nombre_real);
GO

CREATE INDEX ix_artista_nombre_artistico
ON streaming.artista(nombre_artistico);
GO


-- ============================================================
-- TABLA: pelicula
-- ============================================================

CREATE TABLE streaming.pelicula (
    cod_pelicula        VARCHAR(50)    NOT NULL,
    nombre_promocion    VARCHAR(510)   NOT NULL,
    resena              VARCHAR(510),
    cant_actores        INT            NOT NULL,
    monto               DECIMAL(18,2) NOT NULL,

    CONSTRAINT pk_pelicula PRIMARY KEY (cod_pelicula),

    CONSTRAINT chk_pelicula_cant_actores
        CHECK (cant_actores > 0),

    CONSTRAINT chk_pelicula_monto
        CHECK (monto >= 0)
);
GO

CREATE INDEX ix_pelicula_nombre_promocion
ON streaming.pelicula(nombre_promocion);
GO


-- ============================================================
-- TABLA: semana
-- ============================================================

CREATE TABLE streaming.semana (
    numero_semana       INT             NOT NULL,
    mes                 INT             NOT NULL,
    anio                INT             NOT NULL,
    exito               VARCHAR(50),
    tematica            VARCHAR(500),

    CONSTRAINT pk_semana
        PRIMARY KEY (numero_semana, mes, anio),

    CONSTRAINT chk_semana_numero
        CHECK (numero_semana > 0),

    CONSTRAINT chk_semana_mes
        CHECK (mes BETWEEN 1 AND 12),

    CONSTRAINT chk_semana_anio
        CHECK (anio >= 1990),

    CONSTRAINT chk_semana_exito
        CHECK (exito IN ('Mucho exito','Poco exito','Nadie la vio')),

    CONSTRAINT chk_semana_tematica
        CHECK (tematica IN ('Romanticas','Comedia','Suspenso','Terror','Independiente'))
);
GO


-- ============================================================
-- TABLA: horario
-- ============================================================

CREATE TABLE streaming.horario (
    cod_horario         VARCHAR(50)    NOT NULL,
    hora_comienzo       TIME(0)        NOT NULL,
    hora_fin            TIME(0)        NOT NULL,
    tipo_horario        VARCHAR(50)    NOT NULL,

    CONSTRAINT pk_horario PRIMARY KEY (cod_horario),

    CONSTRAINT chk_horario_tipo
        CHECK (tipo_horario IN ('Todo publico','Adultos'))
);
GO


-- ============================================================
-- TABLA: lanzar
-- ============================================================

CREATE TABLE streaming.lanzar (
    cod_cadena           VARCHAR(50)    NOT NULL,
    cod_serie            VARCHAR(50)    NOT NULL,
    fecha_lanzamiento    DATE           NOT NULL,
    critica              VARCHAR(510)   NOT NULL,
    fecha_cancelacion    DATE,

    CONSTRAINT pk_lanzar
        PRIMARY KEY (cod_cadena, cod_serie, fecha_lanzamiento),

    CONSTRAINT fk_lanzar_cadena
        FOREIGN KEY (cod_cadena)
        REFERENCES streaming.cadena(cod_cadena),

    CONSTRAINT fk_lanzar_serie
        FOREIGN KEY (cod_serie)
        REFERENCES streaming.serie(cod_serie)
);
GO


-- ============================================================
-- TABLA: venta
-- ============================================================

CREATE TABLE streaming.venta (
    cod_serie                 VARCHAR(50)   NOT NULL,
    cod_cadena_vendedora      VARCHAR(50)   NOT NULL,
    cod_cadena_compradora     VARCHAR(50)   NOT NULL,
    fecha_venta               DATE          NOT NULL,
    cambios                   VARCHAR(2)    NOT NULL,

    CONSTRAINT pk_venta
        PRIMARY KEY (
            cod_serie,
            cod_cadena_vendedora,
            cod_cadena_compradora,
            fecha_venta
        ),

    CONSTRAINT chk_venta_cambios
        CHECK (cambios IN ('si','no')),

    CONSTRAINT fk_venta_serie
        FOREIGN KEY (cod_serie)
        REFERENCES streaming.serie(cod_serie),

    CONSTRAINT fk_venta_cadena_vendedora
        FOREIGN KEY (cod_cadena_vendedora)
        REFERENCES streaming.cadena(cod_cadena),

    CONSTRAINT fk_venta_cadena_compradora
        FOREIGN KEY (cod_cadena_compradora)
        REFERENCES streaming.cadena(cod_cadena)
);
GO


-- ============================================================
-- TABLA: interpreta
-- ============================================================

CREATE TABLE streaming.interpreta (
    cod_serie                VARCHAR(50)   NOT NULL,
    cod_personaje            VARCHAR(50)   NOT NULL,
    cod_artista              VARCHAR(50)   NOT NULL,
    fecha_interpretacion     DATE          NOT NULL,
    critica                  VARCHAR(510),
    aparicion                VARCHAR(50),
    cant_episodios           INT           NOT NULL,

    CONSTRAINT pk_interpreta
        PRIMARY KEY (
            cod_serie,
            cod_personaje,
            cod_artista,
            fecha_interpretacion
        ),

    CONSTRAINT chk_interpreta_aparicion
        CHECK (aparicion IN ('Recurrente','Especial')),

    CONSTRAINT chk_interpreta_episodios
        CHECK (cant_episodios >= 1),

    CONSTRAINT fk_interpreta_serie
        FOREIGN KEY (cod_serie)
        REFERENCES streaming.serie(cod_serie),

    CONSTRAINT fk_interpreta_personaje
        FOREIGN KEY (cod_personaje)
        REFERENCES streaming.personaje(cod_personaje),

    CONSTRAINT fk_interpreta_artista
        FOREIGN KEY (cod_artista)
        REFERENCES streaming.artista(cod_artista)
);
GO


-- ============================================================
-- TABLA: participa
-- ============================================================

CREATE TABLE streaming.participa (
    cod_pelicula         VARCHAR(50)   NOT NULL,
    cod_artista          VARCHAR(50)   NOT NULL,
    principal            VARCHAR(2)    NOT NULL,
    critica              VARCHAR(510),
    merece_premio        VARCHAR(2)    NOT NULL,

    CONSTRAINT pk_participa
        PRIMARY KEY (cod_pelicula, cod_artista),

    CONSTRAINT chk_participa_principal
        CHECK (principal IN ('si','no')),

    CONSTRAINT chk_participa_premio
        CHECK (merece_premio IN ('si','no')),

    CONSTRAINT fk_participa_pelicula
        FOREIGN KEY (cod_pelicula)
        REFERENCES streaming.pelicula(cod_pelicula),

    CONSTRAINT fk_participa_artista
        FOREIGN KEY (cod_artista)
        REFERENCES streaming.artista(cod_artista)
);
GO


-- ============================================================
-- TABLA: transmite
-- ============================================================

CREATE TABLE streaming.transmite (
    cod_horario            VARCHAR(50)   NOT NULL,
    cod_serie              VARCHAR(50)   NOT NULL,
    cod_serie_sustituta    VARCHAR(50)   NOT NULL,

    CONSTRAINT pk_transmite
        PRIMARY KEY (
            cod_horario,
            cod_serie,
            cod_serie_sustituta
        ),

    CONSTRAINT fk_transmite_horario
        FOREIGN KEY (cod_horario)
        REFERENCES streaming.horario(cod_horario),

    CONSTRAINT fk_transmite_serie
        FOREIGN KEY (cod_serie)
        REFERENCES streaming.serie(cod_serie),

    CONSTRAINT fk_transmite_serie_sust
        FOREIGN KEY (cod_serie_sustituta)
        REFERENCES streaming.serie(cod_serie)
);
GO


-- ============================================================
-- TABLA: involucrada
-- ============================================================

CREATE TABLE streaming.involucrada (
    numero_semana      INT             NOT NULL,
    mes                INT             NOT NULL,
    anio               INT             NOT NULL,
    cod_pelicula       VARCHAR(50)     NOT NULL,

    CONSTRAINT pk_involucrada
        PRIMARY KEY (
            numero_semana,
            mes,
            anio,
            cod_pelicula
        ),

    CONSTRAINT fk_involucrada_semana
        FOREIGN KEY (numero_semana, mes, anio)
        REFERENCES streaming.semana(numero_semana, mes, anio),

    CONSTRAINT fk_involucrada_pelicula
        FOREIGN KEY (cod_pelicula)
        REFERENCES streaming.pelicula(cod_pelicula)
);
GO