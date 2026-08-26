3) b) La entidad débil se marca con rectángulo doble, igual que en Chen. La relación identificante se marca con rombo, igual que en Chen. La clave parcial se marca con subrayado punteado, igual que en Chen.

4) b) El símbolo más cercano a la entidad indica la cardinalidad:
* barra simple = 1.
* pata de cuervo = N. 
El símbolo más alejado indica la participación:
* barra = línea doble en Chen (total).
* círculo = línea simple en Chen (parcial).

Relación	  Extremo	      ERDPlus	           Chen
tiene	      MATERIA	      barra + barra	     1 en MATERIA + línea doble en MESA/COMISION
tiene	      COMISION      barra + pata	     N en COMISION + línea doble en MATERIA
dicta	      DOCENTE	      barra + barra	     1 en DOCENTE + línea doble en COMISION
dicta	      COMISION	    círculo + pata	   N en COMISION + línea simple en DOCENTE
inscribe	  ESTUDIANTE	  círculo + pata     N en ESTUDIANTE + línea simple en COMISION
inscribe	  COMISION	    círculo + pata     M en COMISION + línea simple en ESTUDIANTE
Se parece a la notación crow's foot. Estructuralmente puede parecerse a la forma (mín, máx), ya que toda la información de un extremo está fusionada en una sola anotación.

5) a) No ofrece el triángulo como tal, sino un círculo con una d (disjunta) o una o (solapada). La especialización total o parcial se marca con línea doble o simple desde el supertipo.
b) No existe forma de representar una agregación en el programa.
c) Expresa directamente:
* entidad fuerte (rectángulo)
* atributo simple (óvalo)
* clave primaria (subrayado)
* atributo compuesto (paréntesis + componentes colgando)
* multivaluado (óvalo doble)
* derivado (óvalo punteado)
* relación (rombo)
* atributo de relación
* cardinalidad y participación (crow's foot)
* entidad débil (rectángulo doble)
* clave parcial (subrayado punteado)
* relación identificante (rombo)
* jerarquía IS-A (círculo)
* restricción disjunta/solapada (d/o)
* especialización total/parcial (línea doble/simple).

No expresa directamente:
* Clave alternativa.
Aproximación: dejar cuil como atributo común y anotar al margen que es candidata. Se pierde la declaración de unicidad — nada impide dos estudiantes con el mismo CUIL.
* Agregación.
Aproximación: convertir la relación que se quiere agregar en una entidad intermedia y relacionarla con la tercera; en el ejemplo de la unidad, dictado pasa de rombo a rectángulo. Se pierde que ese elemento es una relación entre dos entidades: queda como entidad suelta y la dependencia de su identidad hay que sostenerla por fuera del diagrama.