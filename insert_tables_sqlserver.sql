-- ============================================================
-- StreamUCV — SQL Server 2022
-- Script: insert_tables_sqlserver.sql
-- Descripción: Carga datos de prueba densos y coherentes para el sistemade contenido audiovisual de StreamUCV.
--
-- Requisitos previos:
--     1. Ejecutar create_repositorio_sqlserver.sql.
--     2. Ejecutar create_tables_sqlserver.sql.
--     3. Estar conectado a la base de datos StreamUCV.
--
-- Nota:
--     Se usa formato ISO 8601 para fechas: YYYY-MM-DD.
-- ============================================================

SET DATEFORMAT YMD;
GO

-- ============================================================
-- LIMPIEZA DE DATOS PARA PERMITIR REEJECUCION DEL SCRIPT
-- ============================================================

DELETE FROM streaming.involucrada;
DELETE FROM streaming.transmite;
DELETE FROM streaming.participa;
DELETE FROM streaming.interpreta;
DELETE FROM streaming.venta;
DELETE FROM streaming.lanzar;
DELETE FROM streaming.horario;
DELETE FROM streaming.semana;
DELETE FROM streaming.pelicula;
DELETE FROM streaming.artista;
DELETE FROM streaming.personaje;
DELETE FROM streaming.cadena;
DELETE FROM streaming.serie;
GO


-- ============================================================
-- cadena
-- ============================================================

INSERT INTO streaming.cadena (cod_cadena, nombre_cadena, direccion_cadena, presidente)
VALUES
    (N'C001', N'Netflix', N'Los Gatos, California, Estados Unidos', N'Ted Sarandos'),
    (N'C002', N'HBO Max', N'Nueva York, Estados Unidos', N'Casey Bloys'),
    (N'C003', N'AMC', N'Nueva York, Estados Unidos', N'Dan McDermott'),
    (N'C004', N'Prime Video', N'Seattle, Estados Unidos', N'Mike Hopkins'),
    (N'C005', N'Disney Plus', N'Burbank, California, Estados Unidos', N'Alan Bergman'),
    (N'C006', N'Hulu', N'Santa Monica, California, Estados Unidos', N'Lauren Tempest'),
    (N'C007', N'Apple TV Plus', N'Cupertino, California, Estados Unidos', N'Jamie Erlicht'),
    (N'C008', N'Paramount Plus', N'Nueva York, Estados Unidos', N'George Cheeks'),
    (N'C009', N'Peacock', N'Nueva York, Estados Unidos', N'Matt Strauss'),
    (N'C010', N'FX', N'Los Ángeles, Estados Unidos', N'John Landgraf'),
    (N'C011', N'BBC Studios', N'Londres, Reino Unido', N'Tom Fussell'),
    (N'C012', N'Movistar Plus', N'Madrid, España', N'Cristina Burzako');
GO


-- ============================================================
-- serie
-- ============================================================

INSERT INTO streaming.serie (cod_serie, nombre_serie, tipo_serie, cant_actores, desc_serie, rating)
VALUES
    (N'S001', N'Breaking Bad', N'dramatica', 12, N'Profesor de química entra al mundo criminal mientras una cadena premium negocia derechos globales.', 9.8),
    (N'S002', N'Stranger Things', N'suspenso', 14, N'Grupo de jóvenes investiga fenómenos sobrenaturales en un pueblo estadounidense.', 9.1),
    (N'S003', N'Dark', N'suspenso', 18, N'Drama alemán sobre viajes temporales, familias conectadas y desapariciones misteriosas.', 8.9),
    (N'S004', N'Black Mirror', N'suspenso', 10, N'Antología de ciencia ficción sobre tecnología, sociedad y consecuencias inesperadas.', 8.6),
    (N'S005', N'The Crown', N'dramatica', 22, N'Drama histórico sobre una familia real y los cambios políticos de varias décadas.', 8.7),
    (N'S006', N'The Boys', N'suspenso', 16, N'Sátira oscura sobre superhéroes corporativos, poder mediático y control social.', 8.8),
    (N'S007', N'The Bear', N'dramatica', 9, N'Un chef joven intenta rescatar el restaurante familiar bajo presión operacional.', 9.0),
    (N'S008', N'Severance', N'suspenso', 11, N'Empleados de una corporación separan quirúrgicamente su memoria laboral y personal.', 8.9),
    (N'S009', N'The Last of Us', N'dramatica', 13, N'Dos sobrevivientes cruzan un país devastado por una pandemia fúngica.', 8.8),
    (N'S010', N'Fallout', N'suspenso', 15, N'Sobrevivientes de refugios nucleares enfrentan un mundo retrofuturista postapocalíptico.', 8.5),
    (N'S011', N'Shogun', N'dramatica', 28, N'Drama político y militar ambientado en el Japón feudal.', 9.2),
    (N'S012', N'Squid Game', N'suspenso', 20, N'Participantes endeudados compiten en juegos mortales por un premio millonario.', 8.6),
    (N'S013', N'Wednesday', N'comica', 12, N'Una estudiante enigmática investiga misterios familiares en una academia sobrenatural.', 8.1),
    (N'S014', N'Euphoria', N'dramatica', 17, N'Adolescentes enfrentan adicciones, identidad, relaciones y presión social.', 8.3),
    (N'S015', N'The Mandalorian', N'suspenso', 21, N'Cazarrecompensas viaja por la galaxia protegiendo a un niño sensible a la Fuerza.', 8.7),
    (N'S016', N'House of the Dragon', N'dramatica', 30, N'Familias nobles disputan la sucesión al trono en un reino de dragones.', 8.5),
    (N'S017', N'Better Call Saul', N'dramatica', 18, N'Abogado carismático desciende hacia prácticas legales cada vez más ambiguas.', 9.3),
    (N'S018', N'True Detective', N'suspenso', 12, N'Detectives investigan crímenes complejos con fuerte carga psicológica.', 8.9),
    (N'S019', N'The White Lotus', N'dramatica', 15, N'Huéspedes privilegiados exhiben conflictos sociales en resorts de lujo.', 8.2),
    (N'S020', N'BoJack Horseman', N'comica', 8, N'Actor animado en decadencia enfrenta fama, depresión y autodestrucción.', 8.8),
    (N'S021', N'Ted Lasso', N'comica', 10, N'Entrenador optimista dirige un club de fútbol británico sin experiencia previa.', 8.8),
    (N'S022', N'Only Murders in the Building', N'comica', 11, N'Vecinos aficionados al true crime investigan asesinatos en su edificio.', 8.1),
    (N'S023', N'Arcane', N'dramatica', 16, N'Hermanas separadas quedan atrapadas en una guerra entre ciudades tecnológicas.', 9.1),
    (N'S024', N'Adolescence', N'dramatica', 10, N'Miniserie social sobre familia, escuela y violencia juvenil en la era digital.', 8.4),
    (N'S025', N'Paradise', N'suspenso', 14, N'Thriller político sobre seguridad nacional, secretos de Estado y crisis institucional.', 8.0),
    (N'S026', N'Daredevil Born Again', N'suspenso', 13, N'Abogado vigilante enfrenta crimen organizado y tensiones políticas urbanas.', 8.2),
    (N'S027', N'Bluey', N'comica', 7, N'Familia animada enseña creatividad, juego y convivencia cotidiana.', 9.4),
    (N'S028', N'Mad Men', N'dramatica', 20, N'Ejecutivos publicitarios transforman marcas y cultura en la Nueva York de los sesenta.', 8.7),
    (N'S029', N'The Penguin', N'suspenso', 12, N'Ascenso criminal de un capo urbano en una ciudad marcada por corrupción.', 8.3),
    (N'S030', N'The Studio', N'comica', 9, N'Ejecutivos de Hollywood intentan mantener relevante un estudio tradicional.', 8.0);
GO


-- ============================================================
-- personaje
-- ============================================================

INSERT INTO streaming.personaje (cod_personaje, nombre_personaje, tipo_personaje)
VALUES
    (N'P001', N'Walter White', N'Principal'),
    (N'P002', N'Jesse Pinkman', N'Principal'),
    (N'P003', N'Eleven', N'Secundario'),
    (N'P004', N'Mike Wheeler', N'Secundario'),
    (N'P005', N'Jonas Kahnwald', N'Extra'),
    (N'P006', N'Martha Nielsen', N'Principal'),
    (N'P007', N'Programador Anonimo', N'Principal'),
    (N'P008', N'Primer Ministro Digital', N'Secundario'),
    (N'P009', N'Reina Elizabeth', N'Secundario'),
    (N'P010', N'Principe Philip', N'Extra'),
    (N'P011', N'Homelander', N'Principal'),
    (N'P012', N'Billy Butcher', N'Principal'),
    (N'P013', N'Carmen Berzatto', N'Secundario'),
    (N'P014', N'Sydney Adamu', N'Secundario'),
    (N'P015', N'Mark Scout', N'Extra'),
    (N'P016', N'Helly Riggs', N'Principal'),
    (N'P017', N'Joel Miller', N'Principal'),
    (N'P018', N'Ellie Williams', N'Secundario'),
    (N'P019', N'Lucy MacLean', N'Secundario'),
    (N'P020', N'Cooper Howard', N'Extra'),
    (N'P021', N'Lord Toranaga', N'Principal'),
    (N'P022', N'John Blackthorne', N'Principal'),
    (N'P023', N'Seong Gi-hun', N'Secundario'),
    (N'P024', N'Kang Sae-byeok', N'Secundario'),
    (N'P025', N'Wednesday Addams', N'Extra'),
    (N'P026', N'Enid Sinclair', N'Principal'),
    (N'P027', N'Rue Bennett', N'Principal'),
    (N'P028', N'Jules Vaughn', N'Secundario'),
    (N'P029', N'Din Djarin', N'Secundario'),
    (N'P030', N'Grogu', N'Extra'),
    (N'P031', N'Rhaenyra Targaryen', N'Principal'),
    (N'P032', N'Daemon Targaryen', N'Principal'),
    (N'P033', N'Jimmy McGill', N'Secundario'),
    (N'P034', N'Kim Wexler', N'Secundario'),
    (N'P035', N'Rust Cohle', N'Extra'),
    (N'P036', N'Marty Hart', N'Principal'),
    (N'P037', N'Tanya McQuoid', N'Principal'),
    (N'P038', N'Armond', N'Secundario'),
    (N'P039', N'BoJack Horseman', N'Secundario'),
    (N'P040', N'Diane Nguyen', N'Extra'),
    (N'P041', N'Ted Lasso', N'Principal'),
    (N'P042', N'Rebecca Welton', N'Principal'),
    (N'P043', N'Charles Haden', N'Secundario'),
    (N'P044', N'Mabel Mora', N'Secundario'),
    (N'P045', N'Jinx', N'Extra'),
    (N'P046', N'Vi', N'Principal'),
    (N'P047', N'Jamie Miller', N'Principal'),
    (N'P048', N'Eddie Miller', N'Secundario'),
    (N'P049', N'Xavier Collins', N'Secundario'),
    (N'P050', N'Agent Robinson', N'Extra'),
    (N'P051', N'Matt Murdock', N'Principal'),
    (N'P052', N'Wilson Fisk', N'Principal'),
    (N'P053', N'Bluey Heeler', N'Secundario'),
    (N'P054', N'Bandit Heeler', N'Secundario'),
    (N'P055', N'Don Draper', N'Extra'),
    (N'P056', N'Peggy Olson', N'Principal'),
    (N'P057', N'Oz Cobb', N'Principal'),
    (N'P058', N'Sofia Falcone', N'Secundario'),
    (N'P059', N'Matt Remick', N'Secundario'),
    (N'P060', N'Sal Saperstein', N'Extra');
GO


-- ============================================================
-- artista
-- ============================================================

INSERT INTO streaming.artista (cod_artista, nombre_real, estado_civil, nombre_artistico)
VALUES
    (N'A001', N'Bryan Cranston', N'casado', N'B. Cranston'),
    (N'A002', N'Aaron Paul', N'casado', N'A. Paul'),
    (N'A003', N'Millie Bobby Brown', N'casado', N'M. Brown'),
    (N'A004', N'Finn Wolfhard', N'soltero', N'F. Wolfhard'),
    (N'A005', N'Louis Hofmann', N'soltero', N'L. Hofmann'),
    (N'A006', N'Lisa Vicari', N'soltero', N'L. Vicari'),
    (N'A007', N'Jesse Plemons', N'casado', N'J. Plemons'),
    (N'A008', N'Cristin Milioti', N'casado', N'C. Milioti'),
    (N'A009', N'Claire Foy', N'casado', N'C. Foy'),
    (N'A010', N'Matt Smith', N'soltero', N'M. Smith'),
    (N'A011', N'Antony Starr', N'soltero', N'A. Starr'),
    (N'A012', N'Karl Urban', N'casado', N'K. Urban'),
    (N'A013', N'Jeremy Allen White', N'casado', N'J. White'),
    (N'A014', N'Ayo Edebiri', N'soltero', N'A. Edebiri'),
    (N'A015', N'Adam Scott', N'casado', N'A. Scott'),
    (N'A016', N'Britt Lower', N'soltero', N'B. Lower'),
    (N'A017', N'Pedro Pascal', N'soltero', N'P. Pascal'),
    (N'A018', N'Bella Ramsey', N'soltero', N'B. Ramsey'),
    (N'A019', N'Ella Purnell', N'soltero', N'E. Purnell'),
    (N'A020', N'Walton Goggins', N'casado', N'W. Goggins'),
    (N'A021', N'Hiroyuki Sanada', N'casado', N'H. Sanada'),
    (N'A022', N'Cosmo Jarvis', N'soltero', N'C. Jarvis'),
    (N'A023', N'Lee Jung-jae', N'casado', N'L. Jung-jae'),
    (N'A024', N'Jung Ho-yeon', N'soltero', N'J. Ho-yeon'),
    (N'A025', N'Jenna Ortega', N'soltero', N'J. Ortega'),
    (N'A026', N'Emma Myers', N'soltero', N'E. Myers'),
    (N'A027', N'Zendaya', N'soltero', N'Zendaya'),
    (N'A028', N'Hunter Schafer', N'soltero', N'H. Schafer'),
    (N'A029', N'Katee Sackhoff', N'casado', N'K. Sackhoff'),
    (N'A030', N'Emma DArcy', N'soltero', N'E. DArcy'),
    (N'A031', N'Bob Odenkirk', N'casado', N'B. Odenkirk'),
    (N'A032', N'Rhea Seehorn', N'casado', N'R. Seehorn'),
    (N'A033', N'Matthew McConaughey', N'casado', N'M. McConaughey'),
    (N'A034', N'Woody Harrelson', N'casado', N'W. Harrelson'),
    (N'A035', N'Jennifer Coolidge', N'soltero', N'J. Coolidge'),
    (N'A036', N'Murray Bartlett', N'casado', N'M. Bartlett'),
    (N'A037', N'Will Arnett', N'divorciado', N'W. Arnett'),
    (N'A038', N'Alison Brie', N'casado', N'A. Brie'),
    (N'A039', N'Jason Sudeikis', N'divorciado', N'J. Sudeikis'),
    (N'A040', N'Hannah Waddingham', N'soltero', N'H. Waddingham'),
    (N'A041', N'Steve Martin', N'casado', N'S. Martin'),
    (N'A042', N'Selena Gomez', N'casado', N'S. Gomez'),
    (N'A043', N'Hailee Steinfeld', N'casado', N'H. Steinfeld'),
    (N'A044', N'Owen Cooper', N'soltero', N'O. Cooper'),
    (N'A045', N'Stephen Graham', N'soltero', N'S. Graham'),
    (N'A046', N'Sterling K Brown', N'soltero', N'S. Brown'),
    (N'A047', N'James Marsden', N'casado', N'J. Marsden'),
    (N'A048', N'Charlie Cox', N'casado', N'C. Cox'),
    (N'A049', N'Vincent DOnofrio', N'casado', N'V. DOnofrio'),
    (N'A050', N'David McCormack', N'soltero', N'D. McCormack'),
    (N'A051', N'Melanie Zanetti', N'soltero', N'M. Zanetti'),
    (N'A052', N'Jon Hamm', N'casado', N'J. Hamm'),
    (N'A053', N'Elisabeth Moss', N'casado', N'E. Moss'),
    (N'A054', N'Colin Farrell', N'soltero', N'C. Farrell'),
    (N'A055', N'Seth Rogen', N'casado', N'S. Rogen'),
    (N'A056', N'Catherine OHara', N'soltero', N'C. OHara'),
    (N'A057', N'Florence Pugh', N'soltero', N'F. Pugh'),
    (N'A058', N'Oscar Isaac', N'soltero', N'O. Isaac'),
    (N'A059', N'Diego Luna', N'soltero', N'D. Luna'),
    (N'A060', N'Gael Garcia Bernal', N'casado', N'G. Bernal');
GO


-- ============================================================
-- pelicula
-- ============================================================

INSERT INTO streaming.pelicula (cod_pelicula, nombre_promocion, resena, cant_actores, monto)
VALUES
    (N'M001', N'The Silent Hour', N'Thriller urbano sobre un detective que protege a una testigo clave.', 12, 18000000),
    (N'M002', N'Neon District', N'Drama criminal ambientado en una ciudad dominada por publicidad algorítmica.', 18, 35000000),
    (N'M003', N'Parallel Lives', N'Ciencia ficción sobre dos familias conectadas por líneas temporales alternas.', 10, 42000000),
    (N'M004', N'Last Signal', N'Suspenso espacial sobre una tripulación que recibe una señal imposible.', 9, 60000000),
    (N'M005', N'Casa de Humo', N'Drama familiar latinoamericano sobre herencias, secretos y migración.', 14, 9000000),
    (N'M006', N'Northern Lights', N'Romance dramático en una estación científica del Ártico.', 8, 15000000),
    (N'M007', N'Code Zero', N'Acción tecnológica sobre una filtración global de datos biométricos.', 20, 75000000),
    (N'M008', N'The Archivist', N'Misterio sobre una restauradora que descubre grabaciones prohibidas.', 7, 12000000),
    (N'M009', N'Golden Harbor', N'Drama financiero sobre medios, poder y adquisiciones corporativas.', 16, 28000000),
    (N'M010', N'Red Planet Motel', N'Comedia negra sobre turistas atrapados en una colonia marciana.', 11, 50000000),
    (N'M011', N'After Midnight', N'Terror psicológico en una plataforma de streaming maldita.', 6, 8000000),
    (N'M012', N'The Last Broadcast', N'Falso documental sobre la desaparición de una cadena regional.', 9, 11000000),
    (N'M013', N'Ciudad Sumergida', N'Aventura distópica en una capital costera inundada.', 17, 65000000),
    (N'M014', N'Royal Script', N'Comedia sobre guionistas que accidentalmente manipulan una campaña real.', 10, 16000000),
    (N'M015', N'The Glass Network', N'Thriller sobre monopolios digitales y espionaje corporativo.', 13, 32000000),
    (N'M016', N'Children of Orion', N'Ciencia ficción familiar sobre colonización y memoria artificial.', 12, 48000000),
    (N'M017', N'The Missing Reel', N'Misterio sobre una película perdida con consecuencias judiciales.', 7, 7000000),
    (N'M018', N'Blue Sunday', N'Drama deportivo sobre un club pequeño comprado por una corporación.', 15, 23000000),
    (N'M019', N'Echoes of Seoul', N'Drama musical internacional sobre identidad y fama digital.', 19, 27000000),
    (N'M020', N'Final Cut', N'Comedia satírica sobre productores que rehacen una película demasiadas veces.', 9, 19000000),
    (N'M021', N'Desert Protocol', N'Acción política sobre una negociación secreta en Medio Oriente.', 16, 55000000),
    (N'M022', N'The Quiet Chef', N'Drama culinario sobre duelo, restaurante familiar y alta cocina.', 8, 10000000),
    (N'M023', N'Empire of Dust', N'Épica histórica sobre rutas comerciales y traiciones imperiales.', 25, 85000000),
    (N'M024', N'Little Comet', N'Película familiar animada sobre una niña y una estrella perdida.', 7, 30000000),
    (N'M025', N'Subtitles', N'Comedia romántica multilingüe durante un festival de cine.', 6, 6000000);
GO


-- ============================================================
-- semana
-- ============================================================

INSERT INTO streaming.semana (numero_semana, mes, anio, exito, tematica)
VALUES
    (1, 1, 2021, N'Mucho exito', N'Suspenso'),
    (3, 3, 2021, N'Poco exito', N'Independiente'),
    (1, 5, 2021, N'Mucho exito', N'Comedia'),
    (3, 7, 2021, N'Poco exito', N'Terror'),
    (1, 9, 2021, N'Nadie la vio', N'Romanticas'),
    (3, 11, 2021, N'Mucho exito', N'Suspenso'),
    (2, 1, 2022, N'Mucho exito', N'Terror'),
    (4, 3, 2022, N'Poco exito', N'Romanticas'),
    (2, 5, 2022, N'Mucho exito', N'Suspenso'),
    (4, 7, 2022, N'Poco exito', N'Independiente'),
    (2, 9, 2022, N'Nadie la vio', N'Comedia'),
    (4, 11, 2022, N'Mucho exito', N'Terror'),
    (3, 1, 2023, N'Mucho exito', N'Independiente'),
    (1, 3, 2023, N'Poco exito', N'Comedia'),
    (3, 5, 2023, N'Mucho exito', N'Terror'),
    (1, 7, 2023, N'Poco exito', N'Romanticas'),
    (3, 9, 2023, N'Nadie la vio', N'Suspenso'),
    (1, 11, 2023, N'Mucho exito', N'Independiente'),
    (4, 1, 2024, N'Mucho exito', N'Romanticas'),
    (2, 3, 2024, N'Poco exito', N'Suspenso'),
    (4, 5, 2024, N'Mucho exito', N'Independiente'),
    (2, 7, 2024, N'Poco exito', N'Comedia'),
    (4, 9, 2024, N'Nadie la vio', N'Terror'),
    (2, 11, 2024, N'Mucho exito', N'Romanticas'),
    (1, 1, 2025, N'Mucho exito', N'Comedia'),
    (3, 3, 2025, N'Poco exito', N'Terror'),
    (1, 5, 2025, N'Mucho exito', N'Romanticas'),
    (3, 7, 2025, N'Poco exito', N'Suspenso'),
    (1, 9, 2025, N'Nadie la vio', N'Independiente'),
    (3, 11, 2025, N'Mucho exito', N'Comedia');
GO


-- ============================================================
-- horario
-- ============================================================

INSERT INTO streaming.horario (cod_horario, hora_comienzo, hora_fin, tipo_horario)
VALUES
    (N'H001', N'06:00:00', N'08:00:00', N'Todo publico'),
    (N'H002', N'08:00:00', N'10:00:00', N'Todo publico'),
    (N'H003', N'10:00:00', N'12:00:00', N'Todo publico'),
    (N'H004', N'12:00:00', N'14:00:00', N'Todo publico'),
    (N'H005', N'14:00:00', N'16:00:00', N'Todo publico'),
    (N'H006', N'16:00:00', N'18:00:00', N'Todo publico'),
    (N'H007', N'18:00:00', N'20:00:00', N'Todo publico'),
    (N'H008', N'20:00:00', N'22:00:00', N'Adultos'),
    (N'H009', N'22:00:00', N'00:00:00', N'Adultos'),
    (N'H010', N'00:00:00', N'02:00:00', N'Adultos'),
    (N'H011', N'02:00:00', N'04:00:00', N'Adultos'),
    (N'H012', N'04:00:00', N'06:00:00', N'Todo publico');
GO


-- ============================================================
-- lanzar
-- ============================================================

INSERT INTO streaming.lanzar (cod_cadena, cod_serie, fecha_lanzamiento, critica, fecha_cancelacion)
VALUES
    (N'C001', N'S001', N'2008-01-15', N'Excelente recepción inicial', NULL),
    (N'C002', N'S002', N'2009-04-15', N'Alta demanda en estreno', NULL),
    (N'C003', N'S003', N'2010-07-15', N'Buena respuesta de audiencia', NULL),
    (N'C004', N'S004', N'2011-10-15', N'Lanzamiento moderado', NULL),
    (N'C005', N'S005', N'2012-01-15', N'Fenómeno global', NULL),
    (N'C006', N'S006', N'2013-04-15', N'Recepción de nicho', NULL),
    (N'C007', N'S007', N'2014-07-15', N'Excelente recepción inicial', NULL),
    (N'C008', N'S008', N'2015-10-15', N'Alta demanda en estreno', NULL),
    (N'C009', N'S009', N'2016-01-15', N'Buena respuesta de audiencia', NULL),
    (N'C010', N'S010', N'2017-04-15', N'Lanzamiento moderado', NULL),
    (N'C011', N'S011', N'2018-07-15', N'Fenómeno global', NULL),
    (N'C012', N'S012', N'2019-10-15', N'Recepción de nicho', NULL),
    (N'C001', N'S013', N'2020-01-15', N'Excelente recepción inicial', N'2022-01-28'),
    (N'C002', N'S014', N'2021-04-15', N'Alta demanda en estreno', NULL),
    (N'C003', N'S015', N'2022-07-15', N'Buena respuesta de audiencia', NULL),
    (N'C004', N'S016', N'2023-10-15', N'Lanzamiento moderado', NULL),
    (N'C005', N'S017', N'2024-01-15', N'Fenómeno global', NULL),
    (N'C006', N'S018', N'2025-04-15', N'Recepción de nicho', NULL),
    (N'C007', N'S019', N'2008-07-15', N'Excelente recepción inicial', NULL),
    (N'C008', N'S020', N'2009-10-15', N'Alta demanda en estreno', NULL),
    (N'C009', N'S021', N'2010-01-15', N'Buena respuesta de audiencia', NULL),
    (N'C010', N'S022', N'2011-04-15', N'Lanzamiento moderado', NULL),
    (N'C011', N'S023', N'2012-07-15', N'Fenómeno global', NULL),
    (N'C012', N'S024', N'2013-10-15', N'Recepción de nicho', NULL),
    (N'C001', N'S025', N'2014-01-15', N'Excelente recepción inicial', N'2016-01-28'),
    (N'C002', N'S026', N'2015-04-15', N'Alta demanda en estreno', NULL),
    (N'C003', N'S027', N'2016-07-15', N'Buena respuesta de audiencia', NULL),
    (N'C004', N'S028', N'2017-10-15', N'Lanzamiento moderado', NULL),
    (N'C005', N'S029', N'2018-01-15', N'Fenómeno global', NULL),
    (N'C006', N'S030', N'2019-04-15', N'Recepción de nicho', NULL),
    (N'C003', N'S004', N'2015-01-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C006', N'S006', N'2016-06-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C009', N'S008', N'2017-11-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C012', N'S010', N'2018-04-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C003', N'S012', N'2019-09-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C006', N'S014', N'2020-02-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C009', N'S016', N'2021-07-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C012', N'S018', N'2022-12-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C003', N'S020', N'2023-05-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C006', N'S022', N'2024-10-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C009', N'S024', N'2015-03-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C012', N'S026', N'2016-08-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C003', N'S028', N'2017-01-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C006', N'S030', N'2018-06-01', N'Relanzamiento por acuerdo de distribución', NULL),
    (N'C009', N'S002', N'2019-11-01', N'Relanzamiento por acuerdo de distribución', NULL);
GO


-- ============================================================
-- venta
-- ============================================================

INSERT INTO streaming.venta (cod_serie, cod_cadena_vendedora, cod_cadena_compradora, fecha_venta, cambios)
VALUES
    (N'S001', N'C001', N'C006', N'2010-01-01', N'si'),
    (N'S002', N'C003', N'C008', N'2011-08-04', N'no'),
    (N'S003', N'C005', N'C010', N'2012-03-07', N'no'),
    (N'S004', N'C007', N'C012', N'2013-10-10', N'si'),
    (N'S005', N'C009', N'C002', N'2014-05-13', N'no'),
    (N'S006', N'C011', N'C004', N'2015-12-16', N'no'),
    (N'S007', N'C001', N'C006', N'2016-07-19', N'si'),
    (N'S008', N'C003', N'C008', N'2017-02-22', N'no'),
    (N'S009', N'C005', N'C010', N'2018-09-25', N'no'),
    (N'S010', N'C007', N'C012', N'2019-04-01', N'si'),
    (N'S011', N'C009', N'C002', N'2020-11-04', N'no'),
    (N'S012', N'C011', N'C004', N'2021-06-07', N'no'),
    (N'S013', N'C001', N'C006', N'2022-01-10', N'si'),
    (N'S014', N'C003', N'C008', N'2023-08-13', N'no'),
    (N'S015', N'C005', N'C010', N'2024-03-16', N'no'),
    (N'S016', N'C007', N'C012', N'2025-10-19', N'si'),
    (N'S017', N'C009', N'C002', N'2010-05-22', N'no'),
    (N'S018', N'C011', N'C004', N'2011-12-25', N'no'),
    (N'S019', N'C001', N'C006', N'2012-07-01', N'si'),
    (N'S020', N'C003', N'C008', N'2013-02-04', N'no'),
    (N'S021', N'C005', N'C010', N'2014-09-07', N'no'),
    (N'S022', N'C007', N'C012', N'2015-04-10', N'si'),
    (N'S023', N'C009', N'C002', N'2016-11-13', N'no'),
    (N'S024', N'C011', N'C004', N'2017-06-16', N'no'),
    (N'S025', N'C001', N'C006', N'2018-01-19', N'si'),
    (N'S026', N'C003', N'C008', N'2019-08-22', N'no'),
    (N'S027', N'C005', N'C010', N'2020-03-25', N'no'),
    (N'S028', N'C007', N'C012', N'2021-10-01', N'si'),
    (N'S029', N'C009', N'C002', N'2022-05-04', N'no'),
    (N'S030', N'C011', N'C004', N'2023-12-07', N'no'),
    (N'S001', N'C001', N'C006', N'2024-07-10', N'si'),
    (N'S002', N'C003', N'C008', N'2025-02-13', N'no'),
    (N'S003', N'C005', N'C010', N'2010-09-16', N'no'),
    (N'S004', N'C007', N'C012', N'2011-04-19', N'si'),
    (N'S005', N'C009', N'C002', N'2012-11-22', N'no'),
    (N'S006', N'C011', N'C004', N'2013-06-25', N'no'),
    (N'S007', N'C001', N'C006', N'2014-01-01', N'si'),
    (N'S008', N'C003', N'C008', N'2015-08-04', N'no'),
    (N'S009', N'C005', N'C010', N'2016-03-07', N'no'),
    (N'S010', N'C007', N'C012', N'2017-10-10', N'si'),
    (N'S011', N'C009', N'C002', N'2018-05-13', N'no'),
    (N'S012', N'C011', N'C004', N'2019-12-16', N'no'),
    (N'S013', N'C001', N'C006', N'2020-07-19', N'si'),
    (N'S014', N'C003', N'C008', N'2021-02-22', N'no'),
    (N'S015', N'C005', N'C010', N'2022-09-25', N'no');
GO


-- ============================================================
-- interpreta
-- ============================================================

INSERT INTO streaming.interpreta (cod_serie, cod_personaje, cod_artista, fecha_interpretacion, critica, aparicion, cant_episodios)
VALUES
    (N'S001', N'P001', N'A001', N'2010-01-01', N'Excelente química con el personaje', N'Especial', 1),
    (N'S002', N'P002', N'A008', N'2011-06-12', N'Interpretación sólida', N'Recurrente', 9),
    (N'S003', N'P003', N'A015', N'2012-11-23', N'Aparición destacada', N'Recurrente', 10),
    (N'S004', N'P004', N'A022', N'2013-04-07', N'Recepción mixta', N'Recurrente', 11),
    (N'S005', N'P005', N'A029', N'2014-09-18', N'Participación memorable', N'Especial', 5),
    (N'S006', N'P006', N'A036', N'2015-02-02', N'Trabajo correcto', N'Recurrente', 13),
    (N'S007', N'P007', N'A043', N'2016-07-13', N'Excelente química con el personaje', N'Recurrente', 14),
    (N'S008', N'P008', N'A050', N'2017-12-24', N'Interpretación sólida', N'Recurrente', 15),
    (N'S009', N'P009', N'A057', N'2018-05-08', N'Aparición destacada', N'Especial', 9),
    (N'S010', N'P010', N'A004', N'2019-10-19', N'Recepción mixta', N'Recurrente', 17),
    (N'S011', N'P011', N'A011', N'2020-03-03', N'Participación memorable', N'Recurrente', 18),
    (N'S012', N'P012', N'A018', N'2021-08-14', N'Trabajo correcto', N'Recurrente', 19),
    (N'S013', N'P013', N'A025', N'2022-01-25', N'Excelente química con el personaje', N'Especial', 13),
    (N'S014', N'P014', N'A032', N'2023-06-09', N'Interpretación sólida', N'Recurrente', 21),
    (N'S015', N'P015', N'A039', N'2024-11-20', N'Aparición destacada', N'Recurrente', 22),
    (N'S016', N'P016', N'A046', N'2010-04-04', N'Recepción mixta', N'Recurrente', 23),
    (N'S017', N'P017', N'A053', N'2011-09-15', N'Participación memorable', N'Especial', 17),
    (N'S018', N'P018', N'A060', N'2012-02-26', N'Trabajo correcto', N'Recurrente', 25),
    (N'S019', N'P019', N'A007', N'2013-07-10', N'Excelente química con el personaje', N'Recurrente', 26),
    (N'S020', N'P020', N'A014', N'2014-12-21', N'Interpretación sólida', N'Recurrente', 27),
    (N'S021', N'P021', N'A021', N'2015-05-05', N'Aparición destacada', N'Especial', 3),
    (N'S022', N'P022', N'A028', N'2016-10-16', N'Recepción mixta', N'Recurrente', 29),
    (N'S023', N'P023', N'A035', N'2017-03-27', N'Participación memorable', N'Recurrente', 30),
    (N'S024', N'P024', N'A042', N'2018-08-11', N'Trabajo correcto', N'Recurrente', 31),
    (N'S025', N'P025', N'A049', N'2019-01-22', N'Excelente química con el personaje', N'Especial', 7),
    (N'S026', N'P026', N'A056', N'2020-06-06', N'Interpretación sólida', N'Recurrente', 33),
    (N'S027', N'P027', N'A003', N'2021-11-17', N'Aparición destacada', N'Recurrente', 34),
    (N'S028', N'P028', N'A010', N'2022-04-01', N'Recepción mixta', N'Recurrente', 35),
    (N'S029', N'P029', N'A017', N'2023-09-12', N'Participación memorable', N'Especial', 11),
    (N'S030', N'P030', N'A024', N'2024-02-23', N'Trabajo correcto', N'Recurrente', 37),
    (N'S001', N'P031', N'A031', N'2010-07-07', N'Excelente química con el personaje', N'Recurrente', 38),
    (N'S002', N'P032', N'A038', N'2011-12-18', N'Interpretación sólida', N'Recurrente', 39),
    (N'S003', N'P033', N'A045', N'2012-05-02', N'Aparición destacada', N'Especial', 15),
    (N'S004', N'P034', N'A052', N'2013-10-13', N'Recepción mixta', N'Recurrente', 41),
    (N'S005', N'P035', N'A059', N'2014-03-24', N'Participación memorable', N'Recurrente', 42),
    (N'S006', N'P036', N'A006', N'2015-08-08', N'Trabajo correcto', N'Recurrente', 43),
    (N'S007', N'P037', N'A013', N'2016-01-19', N'Excelente química con el personaje', N'Especial', 1),
    (N'S008', N'P038', N'A020', N'2017-06-03', N'Interpretación sólida', N'Recurrente', 45),
    (N'S009', N'P039', N'A027', N'2018-11-14', N'Aparición destacada', N'Recurrente', 46),
    (N'S010', N'P040', N'A034', N'2019-04-25', N'Recepción mixta', N'Recurrente', 47),
    (N'S011', N'P041', N'A041', N'2020-09-09', N'Participación memorable', N'Especial', 5),
    (N'S012', N'P042', N'A048', N'2021-02-20', N'Trabajo correcto', N'Recurrente', 9),
    (N'S013', N'P043', N'A055', N'2022-07-04', N'Excelente química con el personaje', N'Recurrente', 10),
    (N'S014', N'P044', N'A002', N'2023-12-15', N'Interpretación sólida', N'Recurrente', 11),
    (N'S015', N'P045', N'A009', N'2024-05-26', N'Aparición destacada', N'Especial', 9),
    (N'S016', N'P046', N'A016', N'2010-10-10', N'Recepción mixta', N'Recurrente', 13),
    (N'S017', N'P047', N'A023', N'2011-03-21', N'Participación memorable', N'Recurrente', 14),
    (N'S018', N'P048', N'A030', N'2012-08-05', N'Trabajo correcto', N'Recurrente', 15),
    (N'S019', N'P049', N'A037', N'2013-01-16', N'Excelente química con el personaje', N'Especial', 13),
    (N'S020', N'P050', N'A044', N'2014-06-27', N'Interpretación sólida', N'Recurrente', 17),
    (N'S021', N'P051', N'A051', N'2015-11-11', N'Aparición destacada', N'Recurrente', 18),
    (N'S022', N'P052', N'A058', N'2016-04-22', N'Recepción mixta', N'Recurrente', 19),
    (N'S023', N'P053', N'A005', N'2017-09-06', N'Participación memorable', N'Especial', 17),
    (N'S024', N'P054', N'A012', N'2018-02-17', N'Trabajo correcto', N'Recurrente', 21),
    (N'S025', N'P055', N'A019', N'2019-07-01', N'Excelente química con el personaje', N'Recurrente', 22),
    (N'S026', N'P056', N'A026', N'2020-12-12', N'Interpretación sólida', N'Recurrente', 23),
    (N'S027', N'P057', N'A033', N'2021-05-23', N'Aparición destacada', N'Especial', 3),
    (N'S028', N'P058', N'A040', N'2022-10-07', N'Recepción mixta', N'Recurrente', 25),
    (N'S029', N'P059', N'A047', N'2023-03-18', N'Participación memorable', N'Recurrente', 26),
    (N'S030', N'P060', N'A054', N'2024-08-02', N'Trabajo correcto', N'Recurrente', 27),
    (N'S001', N'P001', N'A001', N'2010-01-13', N'Excelente química con el personaje', N'Especial', 7),
    (N'S002', N'P002', N'A008', N'2011-06-24', N'Interpretación sólida', N'Recurrente', 29),
    (N'S003', N'P003', N'A015', N'2012-11-08', N'Aparición destacada', N'Recurrente', 30),
    (N'S004', N'P004', N'A022', N'2013-04-19', N'Recepción mixta', N'Recurrente', 31),
    (N'S005', N'P005', N'A029', N'2014-09-03', N'Participación memorable', N'Especial', 11),
    (N'S006', N'P006', N'A036', N'2015-02-14', N'Trabajo correcto', N'Recurrente', 33),
    (N'S007', N'P007', N'A043', N'2016-07-25', N'Excelente química con el personaje', N'Recurrente', 34),
    (N'S008', N'P008', N'A050', N'2017-12-09', N'Interpretación sólida', N'Recurrente', 35),
    (N'S009', N'P009', N'A057', N'2018-05-20', N'Aparición destacada', N'Especial', 15),
    (N'S010', N'P010', N'A004', N'2019-10-04', N'Recepción mixta', N'Recurrente', 37),
    (N'S011', N'P011', N'A011', N'2020-03-15', N'Participación memorable', N'Recurrente', 38),
    (N'S012', N'P012', N'A018', N'2021-08-26', N'Trabajo correcto', N'Recurrente', 39),
    (N'S013', N'P013', N'A025', N'2022-01-10', N'Excelente química con el personaje', N'Especial', 1),
    (N'S014', N'P014', N'A032', N'2023-06-21', N'Interpretación sólida', N'Recurrente', 41),
    (N'S015', N'P015', N'A039', N'2024-11-05', N'Aparición destacada', N'Recurrente', 42),
    (N'S016', N'P016', N'A046', N'2010-04-16', N'Recepción mixta', N'Recurrente', 43),
    (N'S017', N'P017', N'A053', N'2011-09-27', N'Participación memorable', N'Especial', 5),
    (N'S018', N'P018', N'A060', N'2012-02-11', N'Trabajo correcto', N'Recurrente', 45),
    (N'S019', N'P019', N'A007', N'2013-07-22', N'Excelente química con el personaje', N'Recurrente', 46),
    (N'S020', N'P020', N'A014', N'2014-12-06', N'Interpretación sólida', N'Recurrente', 47),
    (N'S021', N'P021', N'A021', N'2015-05-17', N'Aparición destacada', N'Especial', 9),
    (N'S022', N'P022', N'A028', N'2016-10-01', N'Recepción mixta', N'Recurrente', 9),
    (N'S023', N'P023', N'A035', N'2017-03-12', N'Participación memorable', N'Recurrente', 10),
    (N'S024', N'P024', N'A042', N'2018-08-23', N'Trabajo correcto', N'Recurrente', 11),
    (N'S025', N'P025', N'A049', N'2019-01-07', N'Excelente química con el personaje', N'Especial', 13),
    (N'S026', N'P026', N'A056', N'2020-06-18', N'Interpretación sólida', N'Recurrente', 13),
    (N'S027', N'P027', N'A003', N'2021-11-02', N'Aparición destacada', N'Recurrente', 14),
    (N'S028', N'P028', N'A010', N'2022-04-13', N'Recepción mixta', N'Recurrente', 15),
    (N'S029', N'P029', N'A017', N'2023-09-24', N'Participación memorable', N'Especial', 17),
    (N'S030', N'P030', N'A024', N'2024-02-08', N'Trabajo correcto', N'Recurrente', 17),
    (N'S001', N'P031', N'A031', N'2010-07-19', N'Excelente química con el personaje', N'Recurrente', 18),
    (N'S002', N'P032', N'A038', N'2011-12-03', N'Interpretación sólida', N'Recurrente', 19),
    (N'S003', N'P033', N'A045', N'2012-05-14', N'Aparición destacada', N'Especial', 3),
    (N'S004', N'P034', N'A052', N'2013-10-25', N'Recepción mixta', N'Recurrente', 21),
    (N'S005', N'P035', N'A059', N'2014-03-09', N'Participación memorable', N'Recurrente', 22),
    (N'S006', N'P036', N'A006', N'2015-08-20', N'Trabajo correcto', N'Recurrente', 23),
    (N'S007', N'P037', N'A013', N'2016-01-04', N'Excelente química con el personaje', N'Especial', 7),
    (N'S008', N'P038', N'A020', N'2017-06-15', N'Interpretación sólida', N'Recurrente', 25),
    (N'S009', N'P039', N'A027', N'2018-11-26', N'Aparición destacada', N'Recurrente', 26),
    (N'S010', N'P040', N'A034', N'2019-04-10', N'Recepción mixta', N'Recurrente', 27),
    (N'S011', N'P041', N'A041', N'2020-09-21', N'Participación memorable', N'Especial', 11),
    (N'S012', N'P042', N'A048', N'2021-02-05', N'Trabajo correcto', N'Recurrente', 29),
    (N'S013', N'P043', N'A055', N'2022-07-16', N'Excelente química con el personaje', N'Recurrente', 30),
    (N'S014', N'P044', N'A002', N'2023-12-27', N'Interpretación sólida', N'Recurrente', 31),
    (N'S015', N'P045', N'A009', N'2024-05-11', N'Aparición destacada', N'Especial', 15),
    (N'S016', N'P046', N'A016', N'2010-10-22', N'Recepción mixta', N'Recurrente', 33),
    (N'S017', N'P047', N'A023', N'2011-03-06', N'Participación memorable', N'Recurrente', 34),
    (N'S018', N'P048', N'A030', N'2012-08-17', N'Trabajo correcto', N'Recurrente', 35),
    (N'S019', N'P049', N'A037', N'2013-01-01', N'Excelente química con el personaje', N'Especial', 1),
    (N'S020', N'P050', N'A044', N'2014-06-12', N'Interpretación sólida', N'Recurrente', 37),
    (N'S021', N'P051', N'A051', N'2015-11-23', N'Aparición destacada', N'Recurrente', 38),
    (N'S022', N'P052', N'A058', N'2016-04-07', N'Recepción mixta', N'Recurrente', 39),
    (N'S023', N'P053', N'A005', N'2017-09-18', N'Participación memorable', N'Especial', 5),
    (N'S024', N'P054', N'A012', N'2018-02-02', N'Trabajo correcto', N'Recurrente', 41),
    (N'S025', N'P055', N'A019', N'2019-07-13', N'Excelente química con el personaje', N'Recurrente', 42),
    (N'S026', N'P056', N'A026', N'2020-12-24', N'Interpretación sólida', N'Recurrente', 43),
    (N'S027', N'P057', N'A033', N'2021-05-08', N'Aparición destacada', N'Especial', 9),
    (N'S028', N'P058', N'A040', N'2022-10-19', N'Recepción mixta', N'Recurrente', 45),
    (N'S029', N'P059', N'A047', N'2023-03-03', N'Participación memorable', N'Recurrente', 46),
    (N'S030', N'P060', N'A054', N'2024-08-14', N'Trabajo correcto', N'Recurrente', 47),
    (N'S001', N'P001', N'A001', N'2010-01-25', N'Excelente química con el personaje', N'Especial', 13),
    (N'S002', N'P002', N'A008', N'2011-06-09', N'Interpretación sólida', N'Recurrente', 9),
    (N'S003', N'P003', N'A015', N'2012-11-20', N'Aparición destacada', N'Recurrente', 10),
    (N'S004', N'P004', N'A022', N'2013-04-04', N'Recepción mixta', N'Recurrente', 11),
    (N'S005', N'P005', N'A029', N'2014-09-15', N'Participación memorable', N'Especial', 17),
    (N'S006', N'P006', N'A036', N'2015-02-26', N'Trabajo correcto', N'Recurrente', 13),
    (N'S007', N'P007', N'A043', N'2016-07-10', N'Excelente química con el personaje', N'Recurrente', 14),
    (N'S008', N'P008', N'A050', N'2017-12-21', N'Interpretación sólida', N'Recurrente', 15),
    (N'S009', N'P009', N'A057', N'2018-05-05', N'Aparición destacada', N'Especial', 3),
    (N'S010', N'P010', N'A004', N'2019-10-16', N'Recepción mixta', N'Recurrente', 17),
    (N'S011', N'P011', N'A011', N'2020-03-27', N'Participación memorable', N'Recurrente', 18),
    (N'S012', N'P012', N'A018', N'2021-08-11', N'Trabajo correcto', N'Recurrente', 19),
    (N'S013', N'P013', N'A025', N'2022-01-22', N'Excelente química con el personaje', N'Especial', 7),
    (N'S014', N'P014', N'A032', N'2023-06-06', N'Interpretación sólida', N'Recurrente', 21),
    (N'S015', N'P015', N'A039', N'2024-11-17', N'Aparición destacada', N'Recurrente', 22),
    (N'S016', N'P016', N'A046', N'2010-04-01', N'Recepción mixta', N'Recurrente', 23),
    (N'S017', N'P017', N'A053', N'2011-09-12', N'Participación memorable', N'Especial', 11),
    (N'S018', N'P018', N'A060', N'2012-02-23', N'Trabajo correcto', N'Recurrente', 25),
    (N'S019', N'P019', N'A007', N'2013-07-07', N'Excelente química con el personaje', N'Recurrente', 26),
    (N'S020', N'P020', N'A014', N'2014-12-18', N'Interpretación sólida', N'Recurrente', 27),
    (N'S021', N'P021', N'A021', N'2015-05-02', N'Aparición destacada', N'Especial', 15),
    (N'S022', N'P022', N'A028', N'2016-10-13', N'Recepción mixta', N'Recurrente', 29),
    (N'S023', N'P023', N'A035', N'2017-03-24', N'Participación memorable', N'Recurrente', 30),
    (N'S024', N'P024', N'A042', N'2018-08-08', N'Trabajo correcto', N'Recurrente', 31),
    (N'S025', N'P025', N'A049', N'2019-01-19', N'Excelente química con el personaje', N'Especial', 1),
    (N'S026', N'P026', N'A056', N'2020-06-03', N'Interpretación sólida', N'Recurrente', 33),
    (N'S027', N'P027', N'A003', N'2021-11-14', N'Aparición destacada', N'Recurrente', 34),
    (N'S028', N'P028', N'A010', N'2022-04-25', N'Recepción mixta', N'Recurrente', 35),
    (N'S029', N'P029', N'A017', N'2023-09-09', N'Participación memorable', N'Especial', 5),
    (N'S030', N'P030', N'A024', N'2024-02-20', N'Trabajo correcto', N'Recurrente', 37);
GO


-- ============================================================
-- participa
-- ============================================================

INSERT INTO streaming.participa (cod_pelicula, cod_artista, principal, critica, merece_premio)
VALUES
    (N'M001', N'A002', N'si', N'Muy buena participación', N'si'),
    (N'M002', N'A007', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M003', N'A012', N'no', N'Actuación funcional', N'no'),
    (N'M004', N'A017', N'no', N'Gran presencia en pantalla', N'si'),
    (N'M005', N'A022', N'no', N'Aporta valor narrativo', N'no'),
    (N'M006', N'A027', N'si', N'Muy buena participación', N'no'),
    (N'M007', N'A032', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M008', N'A037', N'no', N'Actuación funcional', N'no'),
    (N'M009', N'A042', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M010', N'A047', N'no', N'Aporta valor narrativo', N'si'),
    (N'M011', N'A052', N'si', N'Muy buena participación', N'no'),
    (N'M012', N'A057', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M013', N'A002', N'no', N'Actuación funcional', N'si'),
    (N'M014', N'A007', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M015', N'A012', N'no', N'Aporta valor narrativo', N'no'),
    (N'M016', N'A017', N'si', N'Muy buena participación', N'no'),
    (N'M017', N'A022', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M018', N'A027', N'no', N'Actuación funcional', N'no'),
    (N'M019', N'A032', N'no', N'Gran presencia en pantalla', N'si'),
    (N'M020', N'A037', N'no', N'Aporta valor narrativo', N'no'),
    (N'M021', N'A042', N'si', N'Muy buena participación', N'no'),
    (N'M022', N'A047', N'si', N'Buen trabajo de reparto', N'si'),
    (N'M023', N'A052', N'no', N'Actuación funcional', N'no'),
    (N'M024', N'A057', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M025', N'A002', N'no', N'Aporta valor narrativo', N'no'),
    (N'M001', N'A007', N'si', N'Muy buena participación', N'no'),
    (N'M002', N'A012', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M003', N'A017', N'no', N'Actuación funcional', N'si'),
    (N'M004', N'A022', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M005', N'A027', N'no', N'Aporta valor narrativo', N'no'),
    (N'M006', N'A032', N'si', N'Muy buena participación', N'si'),
    (N'M007', N'A037', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M008', N'A042', N'no', N'Actuación funcional', N'no'),
    (N'M009', N'A047', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M010', N'A052', N'no', N'Aporta valor narrativo', N'no'),
    (N'M011', N'A057', N'si', N'Muy buena participación', N'no'),
    (N'M012', N'A002', N'si', N'Buen trabajo de reparto', N'si'),
    (N'M013', N'A007', N'no', N'Actuación funcional', N'no'),
    (N'M014', N'A012', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M015', N'A017', N'no', N'Aporta valor narrativo', N'si'),
    (N'M016', N'A022', N'si', N'Muy buena participación', N'no'),
    (N'M017', N'A027', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M018', N'A032', N'no', N'Actuación funcional', N'no'),
    (N'M019', N'A037', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M020', N'A042', N'no', N'Aporta valor narrativo', N'no'),
    (N'M021', N'A047', N'si', N'Muy buena participación', N'si'),
    (N'M022', N'A052', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M023', N'A057', N'no', N'Actuación funcional', N'no'),
    (N'M024', N'A002', N'no', N'Gran presencia en pantalla', N'si'),
    (N'M025', N'A007', N'no', N'Aporta valor narrativo', N'no'),
    (N'M001', N'A012', N'si', N'Muy buena participación', N'no'),
    (N'M002', N'A017', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M003', N'A022', N'no', N'Actuación funcional', N'no'),
    (N'M004', N'A027', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M005', N'A032', N'no', N'Aporta valor narrativo', N'si'),
    (N'M006', N'A037', N'si', N'Muy buena participación', N'no'),
    (N'M007', N'A042', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M008', N'A047', N'no', N'Actuación funcional', N'si'),
    (N'M009', N'A052', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M010', N'A057', N'no', N'Aporta valor narrativo', N'no'),
    (N'M011', N'A002', N'si', N'Muy buena participación', N'no'),
    (N'M012', N'A007', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M013', N'A012', N'no', N'Actuación funcional', N'no'),
    (N'M014', N'A017', N'no', N'Gran presencia en pantalla', N'si'),
    (N'M015', N'A022', N'no', N'Aporta valor narrativo', N'no'),
    (N'M016', N'A027', N'si', N'Muy buena participación', N'no'),
    (N'M017', N'A032', N'si', N'Buen trabajo de reparto', N'si'),
    (N'M018', N'A037', N'no', N'Actuación funcional', N'no'),
    (N'M019', N'A042', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M020', N'A047', N'no', N'Aporta valor narrativo', N'no'),
    (N'M021', N'A052', N'si', N'Muy buena participación', N'no'),
    (N'M022', N'A057', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M023', N'A002', N'no', N'Actuación funcional', N'si'),
    (N'M024', N'A007', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M025', N'A012', N'no', N'Aporta valor narrativo', N'no'),
    (N'M001', N'A017', N'si', N'Muy buena participación', N'si'),
    (N'M002', N'A022', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M003', N'A027', N'no', N'Actuación funcional', N'no'),
    (N'M004', N'A032', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M005', N'A037', N'no', N'Aporta valor narrativo', N'no'),
    (N'M006', N'A042', N'si', N'Muy buena participación', N'no'),
    (N'M007', N'A047', N'si', N'Buen trabajo de reparto', N'si'),
    (N'M008', N'A052', N'no', N'Actuación funcional', N'no'),
    (N'M009', N'A057', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M010', N'A002', N'no', N'Aporta valor narrativo', N'si'),
    (N'M011', N'A007', N'si', N'Muy buena participación', N'no'),
    (N'M012', N'A012', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M013', N'A017', N'no', N'Actuación funcional', N'no'),
    (N'M014', N'A022', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M015', N'A027', N'no', N'Aporta valor narrativo', N'no'),
    (N'M016', N'A032', N'si', N'Muy buena participación', N'si'),
    (N'M017', N'A037', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M018', N'A042', N'no', N'Actuación funcional', N'no'),
    (N'M019', N'A047', N'no', N'Gran presencia en pantalla', N'si'),
    (N'M020', N'A052', N'no', N'Aporta valor narrativo', N'no'),
    (N'M021', N'A057', N'si', N'Muy buena participación', N'no'),
    (N'M022', N'A002', N'si', N'Buen trabajo de reparto', N'no'),
    (N'M023', N'A007', N'no', N'Actuación funcional', N'no'),
    (N'M024', N'A012', N'no', N'Gran presencia en pantalla', N'no'),
    (N'M025', N'A017', N'no', N'Aporta valor narrativo', N'si');
GO


-- ============================================================
-- transmite
-- ============================================================

INSERT INTO streaming.transmite (cod_horario, cod_serie, cod_serie_sustituta)
VALUES
    (N'H001', N'S001', N'S008'),
    (N'H002', N'S003', N'S010'),
    (N'H003', N'S005', N'S012'),
    (N'H004', N'S007', N'S014'),
    (N'H005', N'S009', N'S016'),
    (N'H006', N'S011', N'S018'),
    (N'H007', N'S013', N'S020'),
    (N'H008', N'S015', N'S022'),
    (N'H009', N'S017', N'S024'),
    (N'H010', N'S019', N'S026'),
    (N'H011', N'S021', N'S028'),
    (N'H012', N'S023', N'S030'),
    (N'H001', N'S025', N'S002'),
    (N'H002', N'S027', N'S004'),
    (N'H003', N'S029', N'S006'),
    (N'H004', N'S001', N'S008'),
    (N'H005', N'S003', N'S010'),
    (N'H006', N'S005', N'S012'),
    (N'H007', N'S007', N'S014'),
    (N'H008', N'S009', N'S016'),
    (N'H009', N'S011', N'S018'),
    (N'H010', N'S013', N'S020'),
    (N'H011', N'S015', N'S022'),
    (N'H012', N'S017', N'S024'),
    (N'H001', N'S019', N'S026'),
    (N'H002', N'S021', N'S028'),
    (N'H003', N'S023', N'S030'),
    (N'H004', N'S025', N'S002'),
    (N'H005', N'S027', N'S004'),
    (N'H006', N'S029', N'S006'),
    (N'H007', N'S001', N'S008'),
    (N'H008', N'S003', N'S010'),
    (N'H009', N'S005', N'S012'),
    (N'H010', N'S007', N'S014'),
    (N'H011', N'S009', N'S016'),
    (N'H012', N'S011', N'S018'),
    (N'H001', N'S013', N'S020'),
    (N'H002', N'S015', N'S022'),
    (N'H003', N'S017', N'S024'),
    (N'H004', N'S019', N'S026'),
    (N'H005', N'S021', N'S028'),
    (N'H006', N'S023', N'S030'),
    (N'H007', N'S025', N'S002'),
    (N'H008', N'S027', N'S004'),
    (N'H009', N'S029', N'S006'),
    (N'H010', N'S001', N'S008'),
    (N'H011', N'S003', N'S010'),
    (N'H012', N'S005', N'S012'),
    (N'H001', N'S007', N'S014'),
    (N'H002', N'S009', N'S016'),
    (N'H003', N'S011', N'S018'),
    (N'H004', N'S013', N'S020'),
    (N'H005', N'S015', N'S022'),
    (N'H006', N'S017', N'S024'),
    (N'H007', N'S019', N'S026'),
    (N'H008', N'S021', N'S028'),
    (N'H009', N'S023', N'S030'),
    (N'H010', N'S025', N'S002'),
    (N'H011', N'S027', N'S004'),
    (N'H012', N'S029', N'S006');
GO


-- ============================================================
-- involucrada
-- ============================================================

INSERT INTO streaming.involucrada (numero_semana, mes, anio, cod_pelicula)
VALUES
    (1, 1, 2021, N'M001'),
    (3, 3, 2021, N'M004'),
    (1, 5, 2021, N'M007'),
    (3, 7, 2021, N'M010'),
    (1, 9, 2021, N'M013'),
    (3, 11, 2021, N'M016'),
    (2, 1, 2022, N'M019'),
    (4, 3, 2022, N'M022'),
    (2, 5, 2022, N'M025'),
    (4, 7, 2022, N'M003'),
    (2, 9, 2022, N'M006'),
    (4, 11, 2022, N'M009'),
    (3, 1, 2023, N'M012'),
    (1, 3, 2023, N'M015'),
    (3, 5, 2023, N'M018'),
    (1, 7, 2023, N'M021'),
    (3, 9, 2023, N'M024'),
    (1, 11, 2023, N'M002'),
    (4, 1, 2024, N'M005'),
    (2, 3, 2024, N'M008'),
    (4, 5, 2024, N'M011'),
    (2, 7, 2024, N'M014'),
    (4, 9, 2024, N'M017'),
    (2, 11, 2024, N'M020'),
    (1, 1, 2025, N'M023'),
    (3, 3, 2025, N'M001'),
    (1, 5, 2025, N'M004'),
    (3, 7, 2025, N'M007'),
    (1, 9, 2025, N'M010'),
    (3, 11, 2025, N'M013'),
    (1, 1, 2021, N'M016'),
    (3, 3, 2021, N'M019'),
    (1, 5, 2021, N'M022'),
    (3, 7, 2021, N'M025'),
    (1, 9, 2021, N'M003'),
    (3, 11, 2021, N'M006'),
    (2, 1, 2022, N'M009'),
    (4, 3, 2022, N'M012'),
    (2, 5, 2022, N'M015'),
    (4, 7, 2022, N'M018'),
    (2, 9, 2022, N'M021'),
    (4, 11, 2022, N'M024'),
    (3, 1, 2023, N'M002'),
    (1, 3, 2023, N'M005'),
    (3, 5, 2023, N'M008'),
    (1, 7, 2023, N'M011'),
    (3, 9, 2023, N'M014'),
    (1, 11, 2023, N'M017'),
    (4, 1, 2024, N'M020'),
    (2, 3, 2024, N'M023'),
    (4, 5, 2024, N'M001'),
    (2, 7, 2024, N'M004'),
    (4, 9, 2024, N'M007'),
    (2, 11, 2024, N'M010'),
    (1, 1, 2025, N'M013'),
    (3, 3, 2025, N'M016'),
    (1, 5, 2025, N'M019'),
    (3, 7, 2025, N'M022'),
    (1, 9, 2025, N'M025'),
    (3, 11, 2025, N'M003'),
    (1, 1, 2021, N'M006'),
    (3, 3, 2021, N'M009'),
    (1, 5, 2021, N'M012'),
    (3, 7, 2021, N'M015'),
    (1, 9, 2021, N'M018'),
    (3, 11, 2021, N'M021'),
    (2, 1, 2022, N'M024'),
    (4, 3, 2022, N'M002'),
    (2, 5, 2022, N'M005'),
    (4, 7, 2022, N'M008'),
    (2, 9, 2022, N'M011'),
    (4, 11, 2022, N'M014'),
    (3, 1, 2023, N'M017'),
    (1, 3, 2023, N'M020'),
    (3, 5, 2023, N'M023'),
    (1, 7, 2023, N'M001'),
    (3, 9, 2023, N'M004'),
    (1, 11, 2023, N'M007'),
    (4, 1, 2024, N'M010'),
    (2, 3, 2024, N'M013');
GO


-- ============================================================
-- VALIDACION RAPIDA DE CARGA (opcional, pueden comentarlo)
-- ============================================================

SELECT 'serie' AS tabla, COUNT(*) AS registros FROM streaming.serie
UNION ALL SELECT 'cadena', COUNT(*) FROM streaming.cadena
UNION ALL SELECT 'personaje', COUNT(*) FROM streaming.personaje
UNION ALL SELECT 'artista', COUNT(*) FROM streaming.artista
UNION ALL SELECT 'pelicula', COUNT(*) FROM streaming.pelicula
UNION ALL SELECT 'semana', COUNT(*) FROM streaming.semana
UNION ALL SELECT 'horario', COUNT(*) FROM streaming.horario
UNION ALL SELECT 'lanzar', COUNT(*) FROM streaming.lanzar
UNION ALL SELECT 'venta', COUNT(*) FROM streaming.venta
UNION ALL SELECT 'interpreta', COUNT(*) FROM streaming.interpreta
UNION ALL SELECT 'participa', COUNT(*) FROM streaming.participa
UNION ALL SELECT 'transmite', COUNT(*) FROM streaming.transmite
UNION ALL SELECT 'involucrada', COUNT(*) FROM streaming.involucrada;
GO
