================================================================================
# Ejercicio 4
================================================================================
### Inciso b
================================================================================
Sí, generó una tabla aparte para el atributo multivaluado: ESTUDIANTE_TITULOS. Su clave primaria es compuesta, (titulos, dni), es decir el valor del atributo junto con la clave de la entidad. dni es además clave foránea a ESTUDIANTE(dni).
Coincide con la práctica.

================================================================================
### Inciso c
================================================================================
Con el atributo compuesto nombre, la conversión hizo lo que indica la regla de paso: lo descompuso en una columna por componente: nombres y apellido, ambas dentro de ESTUDIANTE. La columna padre nombre no aparece en el esquema. Coincide con la práctica.
Con el atributo derivado promedio, la conversión no generó ninguna columna. La herramienta reconoció el óvalo punteado del diagrama y aplicó la regla: un atributo derivado no se almacena, se calcula al consultar. También coincide con la práctica.