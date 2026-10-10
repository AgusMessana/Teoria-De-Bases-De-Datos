-- ############################################################################
-- ARCHIVO GENERADO — no editar a mano.
-- Se deriva de canon-postgresql.sql con:  python3 tools/generar_etapas.py
-- ############################################################################
-- ============================================================================
-- canon-postgresql-nucleo.sql — ETAPA 1: el núcleo, del curso Bases de Datos (FCEIA-UNR)
-- Motor: PostgreSQL 18
--
-- FUENTE DE VERDAD del conjunto de ejemplo. Autocontenido: se puede ejecutar
-- desde cualquier directorio.
--
-- De este archivo se GENERAN las dos etapas, con:
--     python3 tools/generar_etapas.py
--   canon-postgresql-nucleo.sql     esquema + NÚCLEO. Cargado solo, reproduce
--                                   las tablas de resultado de la Unidad 4.
--   canon-postgresql-extension.sql  sólo las filas de práctica, sobre el núcleo.
--
-- Estructura del archivo:
--   NÚCLEO    = las tablas de resultado de las diapositivas; algunas
--               premisas de U8 usan filas de la extensión.
--               No se modifica sin actualizar las diapositivas.
--   EXTENSIÓN = filas adicionales para que las consultas de práctica den
--               resultados interesantes. Regla: extiende, nunca contradice.
--               Sólo agrega personas/materias/cursados NUEVOS; las tuplas
--               de las personas canónicas quedan exactamente como se dibujan.
--
-- Valores PROPUESTOS (no dibujados en ninguna diapositiva, a confirmar):
--   · Todos los cuil (las diapositivas sólo declaran la columna; los valores
--     tienen dígito verificador real).
--   · Todas las fecha_nacimiento (plausibles según el rango del dni).
--   · Nombres de pila de los docentes Suárez y Molina (sólo se dibuja el
--     apellido en U5).
--   · carrera/promedio/activo de Paz (nunca se dibujan; el promedio 7.0 es
--     coherente con su única nota dibujada: 7 en SO01).
-- ============================================================================

-- La base se crea desde afuera (createdb bd_curso) y el cliente se conecta
-- a ella; PostgreSQL no tiene USE. La codificación es de la base, no de la
-- conexión, así que aquí no hace falta declararla.

DROP TABLE IF EXISTS
  escala, correlativa, cursa, materia, docente, estudiante, telefono, persona
  CASCADE;

-- ----------------------------------------------------------------------------
-- Esquema (U2/U3): PERSONA con subtipos estudiante y docente.
-- Regla madre: nombre vive SOLO en persona.
-- El registro de persona ≈ 80 B de U6: dni(4) + cuil(8) + nombre(~60) + fecha(8).
-- ----------------------------------------------------------------------------

CREATE TABLE persona (
  dni              integer       NOT NULL,
  cuil             bigint        NOT NULL,
  nombre           VARCHAR(100)  NOT NULL,   -- formato dibujado: 'Apellido, Nombre'
  fecha_nacimiento DATE          NOT NULL,
  PRIMARY KEY (dni),
  CONSTRAINT uq_persona_cuil UNIQUE (cuil)   -- clave alternativa (U2/U3)
);

-- 1FN de U5: los teléfonos de una persona salen a su propia tabla.
CREATE TABLE telefono (
  dni      integer     NOT NULL,
  telefono varchar(20) NOT NULL,
  PRIMARY KEY (dni, telefono),
  CONSTRAINT fk_telefono_persona FOREIGN KEY (dni) REFERENCES persona (dni)
);

CREATE TABLE estudiante (
  dni      integer      NOT NULL,
  carrera  varchar(5)   NOT NULL,
  promedio numeric(3,1)  NOT NULL,
  activo   boolean      NOT NULL,
  PRIMARY KEY (dni),
  CONSTRAINT fk_estudiante_persona FOREIGN KEY (dni) REFERENCES persona (dni),
  CHECK (carrera IN ('LCC','LM','IE','LF')),         -- dominio canónico
  CHECK (promedio BETWEEN 0 AND 10)
);

CREATE TABLE docente (
  dni       integer     NOT NULL,
  categoria varchar(20) NOT NULL,
  -- dominio de referencia (U2): Ayudante de 2.ª, Ayudante de 1.ª, JTP,
  -- Adjunto, Asociado, Titular. Se almacena como se dibuja en U4: 'titular'.
  PRIMARY KEY (dni),
  CONSTRAINT fk_docente_persona FOREIGN KEY (dni) REFERENCES persona (dni)
);

CREATE TABLE materia (
  codigo      char(4)      NOT NULL,
  titulo      varchar(100) NOT NULL,
  dni_docente integer      NOT NULL,
  PRIMARY KEY (codigo),
  CONSTRAINT fk_materia_docente FOREIGN KEY (dni_docente) REFERENCES docente (dni)
);

CREATE TABLE cursa (
  dni    integer  NOT NULL,
  codigo char(4)  NOT NULL,
  nota   smallint,                -- admite NULL: acta no cerrada (U3 d.15; U4 'IS NULL').
                                 -- Canon no trae ninguna fila con NULL: el caso con nulos
                                 -- lo aporta bd_volumen, con el 4% de las actas abiertas.
  PRIMARY KEY (dni, codigo),
  CONSTRAINT fk_cursa_estudiante FOREIGN KEY (dni)    REFERENCES estudiante (dni),
  CONSTRAINT fk_cursa_materia    FOREIGN KEY (codigo) REFERENCES materia (codigo),
  CHECK (nota BETWEEN 0 AND 10)                      -- dominio de U2
);

-- ----------------------------------------------------------------------------
-- CORRELATIVA (U3 d.26 y d.27): N:M recursiva de materia consigo misma.
-- Las dos foráneas van a la MISMA tabla; se distinguen por el nombre del rol,
-- que es el punto de esas diapositivas. No usar (codigo, codigo_correlativa):
-- ese nombrado pierde cuál habilita a cuál.
-- ----------------------------------------------------------------------------
CREATE TABLE correlativa (
  codigo_requerida  char(4) NOT NULL,   -- la que hay que tener aprobada
  codigo_habilitada char(4) NOT NULL,   -- la que se puede cursar
  PRIMARY KEY (codigo_requerida, codigo_habilitada),
  CONSTRAINT fk_corr_requerida  FOREIGN KEY (codigo_requerida)  REFERENCES materia (codigo),
  CONSTRAINT fk_corr_habilitada FOREIGN KEY (codigo_habilitada) REFERENCES materia (codigo),
  CHECK (codigo_requerida <> codigo_habilitada)      -- nadie se habilita a sí misma
);

-- ----------------------------------------------------------------------------
-- ESCALA (U4 d.42): la escala oficial de calificaciones, como tabla.
-- Sirve al NON-EQUI JOIN: el ON es un rango, no una igualdad.
-- Las columnas NO se llaman min/max: son palabras reservadas en SQL.
-- ----------------------------------------------------------------------------
CREATE TABLE escala (
  nota_min  smallint    NOT NULL,
  nota_max  smallint    NOT NULL,
  categoria varchar(15) NOT NULL,
  PRIMARY KEY (nota_min, nota_max),
  CHECK (nota_min <= nota_max),
  CHECK (nota_min BETWEEN 0 AND 10 AND nota_max BETWEEN 0 AND 10)
);

-- ============================================================================
-- NÚCLEO — la instancia dibujada en las diapositivas
-- ============================================================================

INSERT INTO persona (dni, cuil, nombre, fecha_nacimiento) VALUES
  (44876052, 23448760529, 'López, Andrés',    '2003-04-12'),
  (40112233, 27401122333, 'Paz, Carla',       '1997-02-08'),
  (41220417, 20412204175, 'Díaz, Juan',       '1998-09-23'),
  (40111222, 27401112222, 'Martín, Ana Laura','1997-01-30'),
  (27888999, 20278889999, 'Suárez, Marta',    '1980-06-17'),  -- nombre de pila PROPUESTO
  (17222333, 20172223339, 'Molina, Jorge',    '1965-11-05');  -- nombre de pila PROPUESTO

INSERT INTO telefono (dni, telefono) VALUES
  (40112233, '341-555'),   -- U5, ejemplo de 1FN
  (40112233, '341-777');

INSERT INTO estudiante (dni, carrera, promedio, activo) VALUES
  (44876052, 'LCC', 8.5, TRUE),
  (41220417, 'LM',  7.2, TRUE),
  (40111222, 'LCC', 9.1, FALSE),
  (40112233, 'LF',  7.0, TRUE);   -- fila completa PROPUESTA (nunca dibujada)

INSERT INTO docente (dni, categoria) VALUES
  (27888999, 'titular'),   -- dibujado en el resultado del join de U4
  (17222333, 'titular');   -- ídem (fila López–Sistemas Operativos–titular–9)

INSERT INTO materia (codigo, titulo, dni_docente) VALUES
  ('BD01', 'Bases de Datos',      27888999),
  ('SO01', 'Sistemas Operativos', 17222333),
  ('PR01', 'Programación',        27888999);  -- dibujada en U3 d.27; Suárez dicta dos

INSERT INTO cursa (dni, codigo, nota) VALUES
  (44876052, 'BD01', 8),
  (44876052, 'SO01', 9),
  (41220417, 'BD01', 4),
  (40112233, 'SO01', 7);   -- agregada en U9 (grafo)

INSERT INTO correlativa (codigo_requerida, codigo_habilitada) VALUES
  ('PR01', 'BD01'),        -- las dos están dibujadas en U3 d.27
  ('PR01', 'SO01');

-- La escala oficial, tal como la enuncia U4 d.42.
INSERT INTO escala (nota_min, nota_max, categoria) VALUES
  ( 0,  1, 'reprobado'),
  ( 2,  5, 'insuficiente'),
  ( 6,  6, 'aprobado'),
  ( 7,  7, 'bueno'),
  ( 8,  8, 'muy bueno'),
  ( 9,  9, 'distinguido'),
  (10, 10, 'sobresaliente');
