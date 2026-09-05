================================================================================
# Ejercicio 2
================================================================================
### Inciso b
================================================================================
Se generaron un total de 5 tablas.

* ESTUDIANTE
  Columnas: dni_estudiante
  Clave primaria: dni_estudiante

* MATERIA
  Columnas: codigo_materia
  Clave primaria: codigo_materia

* DOCENTE
  Columnas: dni_docente
  Clave primaria: dni_docente

* MESA
  Columnas: codigo_mesa, codigo_materia, turno, anio, dni_docente
  Clave primaria: (codigo_mesa, codigo_materia)
  Claves foráneas:
    ** codigo_materia -> MATERIA(codigo_materia)
    ** dni_docente -> DOCENTE(dni_docente)

* SE_INSCRIBE
  Columnas: dni_estudiante, codigo_mesa, codigo_materia, fecha, calificacion
  Clave primaria: (dni_estudiante, codigo_mesa, codigo_materia)
  Claves foráneas:
    ** dni_estudiante -> ESTUDIANTE(dni_estudiante)
    ** (codigo_mesa, codigo_materia) -> MESA(codigo_mesa, codigo_materia)

================================================================================
# Ejercicio 3
================================================================================
### Inciso a
================================================================================
No hay diferencias estructurales entre las tablas generadas por el programa y las hechas en papel

================================================================================
### Inciso b
================================================================================
* La clave primaria de MESA es la clave primaria de la entidad fuerte (o sea MATERIA) y la clave parcial.
* La PK de SE_INSCRIBE es la PK de ESTUDIANTE y la PK de MESA.
* La clave foránea que referencia a MESA es (codigo_mesa, codigo_materia), además de haberse escrito de forma compuesta (visto por el corchete)
* fecha y calificacion quedaron en SE_INSCRIBE.

================================================================================
### Inciso c
================================================================================
La herramienta no generó ninguna clave inventada. De haberlo hecho, no sería un error sino una decisión de diseño distinta, con ventajas y costos.

Se gana:
* Simplicidad en las referencias. SE_INSCRIBE tendría una clave foránea simple en lugar de una compuesta —una columna en vez de dos— y su clave primaria se reduciría a dos atributos.

Se pierde:
* La identificación natural. El identificador autonumérico es un valor sin significado: no dice de qué materia es la mesa. Para saberlo hay que ir a MESA y consultar la clave foránea, mientras que con la clave compuesta la referencia ya lo indica por sí sola.
* El control automático de unicidad. Con la clave primaria (codigo_materia, codigo_mesa), el modelo garantiza que no existan dos mesas con el mismo código dentro de una misma materia. Con un identificador artificial esa garantía desaparece, y para conservarla habría que declarar (codigo_materia, codigo_mesa) como UNIQUE.

Se relaciona con el ítem d del ejercicio 5 de la Práctica 2: allí, un código de mesa único en toda la facultad convertía a MESA en entidad fuerte, porque dejaba de necesitar la clave de MATERIA para identificarse. La diferencia es que aquí el modelo conceptual no cambia sino que el esquema relacional deja de reflejar esa debilidad al agregarle un identificador propio.

================================================================================
# Ejercicio 5
================================================================================
### Inciso b
================================================================================
Tomando la tabla MESA:
La orden que la crea es CREATE TABLE MESA, cuya sentencia completa abarca todo el bloque entre paréntesis hasta el punto y coma: la lista de columnas con sus tipos y las declaraciones de clave primaria y foráneas forman parte de la misma orden.
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

La declaración de la clave primaria:
PRIMARY KEY (codigo_mesa, codigo_materia)

La declaración de cada clave foránea:
FOREIGN KEY (codigo_materia) REFERENCES MATERIA(codigo_materia)
FOREIGN KEY (dni_docente) REFERENCES DOCENTE(dni_docente)

================================================================================
### Inciso c
================================================================================
PRIMARY KEY (codigo_mesa, codigo_materia) implementa la integridad de entidad: declara la clave primaria y, junto con el NOT NULL de esas columnas, garantiza que ningún atributo de la clave pueda ser nulo.

FOREIGN KEY (...) REFERENCES ... implementa la integridad referencial: exige que el valor de la clave foránea exista como clave primaria en la tabla referenciada.

El CREATE TABLE es la orden que contiene a las tres: dentro de ella se declaran los tipos de dato de cada columna, que implementan la integridad de dominio.

El dominio de calificacion quedaría declarado en la tabla SE_INSCRIBE, en la definición de esa columna. El SQL generado sólo produce calificacion INT NOT NULL, lo que no expresa el dominio real: no impide un valor menor que 0 ni mayor que 10, y no admite el valor 'Ausente'. Para declararlo harían falta una restricción CHECK que acote el rango y un tipo de dato capaz de contener 'Ausente'. La herramienta genera la estructura y las claves, pero no los dominios: eso queda para escribir a mano.