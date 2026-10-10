-- ############################################################################
-- ARCHIVO GENERADO — no editar a mano.
-- Se deriva de canon-postgresql.sql con:  python3 tools/generar_etapas.py
-- ############################################################################
-- ============================================================================
-- canon-postgresql-extension.sql — ETAPA 2: la extensión
--
-- Requiere canon-postgresql-nucleo.sql ya cargado. Agrega filas NUEVAS para que las
-- consultas de práctica den resultados interesantes. Regla: extiende, nunca
-- contradice — no toca ninguna tupla dibujada en una diapositiva.
--
-- OJO: con estas filas cargadas, las tablas de resultado de la Unidad 4 dan
-- más filas que lo que muestran las diapositivas. Eso es esperado: las
-- diapositivas ilustran el núcleo. Para reproducirlas al pie de la letra,
-- cargar sólo canon-postgresql-nucleo.sql.
-- ============================================================================

-- ============================================================================
-- EXTENSIÓN — sólo filas nuevas; no toca a las personas canónicas
-- ============================================================================

INSERT INTO persona (dni, cuil, nombre, fecha_nacimiento) VALUES
  (43555010, 27435550105, 'Fernández, Lucía',  '2001-07-19'),
  (42890774, 20428907745, 'Gómez, Pedro',      '2000-03-02'),
  (45120336, 27451203369, 'Romero, Sofía',     '2003-10-27'),
  (44310589, 20443105892, 'Herrera, Diego',    '2002-05-14'),
  (43978415, 27439784151, 'Ibáñez, Valentina', '2001-12-01'),
  (42045662, 20420456620, 'Navarro, Bruno',    '1999-08-09'),
  (45566778, 27455667785, 'Quiroga, Milena',   '2003-06-21'),
  (41777205, 20417772058, 'Vega, Tomás',       '1998-04-04'),
  (33444555, 27334445556, 'Ríos, Claudia',     '1988-01-25'),  -- ni estudiante ni docente
  (22111444, 27221114448, 'Acosta, Graciela',  '1971-09-12'),
  (25666090, 20256660904, 'Benítez, Hugo',     '1976-02-28');

INSERT INTO telefono (dni, telefono) VALUES
  (43555010, '341-4001'),
  (43555010, '341-4002'),
  (33444555, '341-9350');

INSERT INTO estudiante (dni, carrera, promedio, activo) VALUES
  (43555010, 'LCC', 8.0, TRUE),
  (42890774, 'LM',  5.0, TRUE),
  (45120336, 'IE',  9.0, TRUE),
  (44310589, 'LF',  3.5, TRUE),
  (43978415, 'LCC', 9.3, TRUE),
  (42045662, 'IE',  3.0, FALSE),
  (45566778, 'LM',  8.9, TRUE),   -- no cursó ninguna materia: caso para LEFT JOIN
  (41777205, 'LF',  6.5, TRUE);

INSERT INTO docente (dni, categoria) VALUES
  (22111444, 'adjunto'),
  (25666090, 'JTP');

INSERT INTO materia (codigo, titulo, dni_docente) VALUES
  ('AL01', 'Álgebra Lineal',       22111444),
  ('AM01', 'Análisis Matemático',  25666090);  -- nadie la cursó: caso para LEFT JOIN

-- AL01 y AM01 quedan sin correlativas a propósito: caso para NOT EXISTS y LEFT JOIN.

INSERT INTO cursa (dni, codigo, nota) VALUES
  (43555010, 'BD01', 9),
  (43555010, 'AL01', 7),
  (43555010, 'PR01', 8),
  (42890774, 'AL01', 4),
  (42890774, 'SO01', 6),
  (45120336, 'AL01', 8),
  (45120336, 'PR01', 10),
  (44310589, 'BD01', 2),
  (44310589, 'AL01', 5),
  (43978415, 'BD01', 10),
  (43978415, 'SO01', 9),
  (43978415, 'AL01', 9),
  (43978415, 'PR01', 9),
  (42045662, 'AL01', 3),
  (41777205, 'SO01', 7),
  (41777205, 'PR01', 6);
