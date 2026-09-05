CREATE TABLE MATERIA
(
  codigo_materia INT NOT NULL,
  PRIMARY KEY (codigo_materia)
);

CREATE TABLE DOCENTE
(
  dni_docente INT NOT NULL,
  PRIMARY KEY (dni_docente)
);

CREATE TABLE MESA
(
  codigo_mesa INT NOT NULL,
  turno INT NOT NULL,
  año INT NOT NULL,
  codigo_materia INT NOT NULL,
  dni_docente INT NOT NULL,
  PRIMARY KEY (codigo_mesa, codigo_materia),
  FOREIGN KEY (codigo_materia) REFERENCES MATERIA(codigo_materia),
  FOREIGN KEY (dni_docente) REFERENCES DOCENTE(dni_docente)
);

CREATE TABLE ESTUDIANTE
(
  dni_estudiante INT NOT NULL,
  PRIMARY KEY (dni_estudiante)
);

CREATE TABLE SE_INSCRIBE
(
  fecha INT NOT NULL,
  calificacion INT NOT NULL,
  dni_estudiante INT NOT NULL,
  codigo_mesa INT NOT NULL,
  codigo_materia INT NOT NULL,
  PRIMARY KEY (dni_estudiante, codigo_mesa, codigo_materia),
  FOREIGN KEY (dni_estudiante) REFERENCES ESTUDIANTE(dni_estudiante),
  FOREIGN KEY (codigo_mesa, codigo_materia) REFERENCES MESA(codigo_mesa, )
  -- Notar que en el REFERENCES de la FK compuesta de MESA falta codigo_materia.
  -- Los tipos de datos se dejaron con los predeterminados.
);