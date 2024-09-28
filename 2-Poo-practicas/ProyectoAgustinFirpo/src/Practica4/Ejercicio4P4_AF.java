/*
4- El Servicio Meteorológico Nacional necesita un sistema que permita registrar, para una determinada estación meteorológica, la temperatura promedio mensual de N años consecutivos a partir de un año A dado. 
Además, necesita dos versiones del sistema: una que tenga funcionalidad para reportar el promedio histórico por años y otra que tenga funcionalidad para reportar el promedio histórico por meses. Esto se detalla más adelante.

De la estación, interesa conocer: nombre, y latitud y longitud donde se encuentra.

Implemente las clases, constructores y métodos que considere necesarios para:

   a) Crear el sistema de registro/reporte, que funcionará en una determinada estación, para N años consecutivos a partir de un año A. Inicie cada temperatura en un valor
   muy alto.

   b) Registrar la temperatura de un mes y año recibidos por parámetro. Nota: El mes está en rango 1..12 y el año está en rango A..A+N-1.

   c) Obtener la temperatura de un mes y año recibidos por parámetro. Nota: El mes está en rango 1..12 y el año está en rango A..A+N-1. En caso de no haberse registrado
   temperatura para ese mes/año se retorna el valor muy alto.

   d) Devolver un String que concatena el mes y año en que se registró la mayor temperatura. 

   Nota: Suponga que ya están registradas las temperaturas de todos los meses y años.

   e) Devolver un String con el nombre de la estación, su latitud y longitud, y los promedios mensuales o anuales según corresponda:
   - La versión del sistema que reporta por años deberá calcular el promedio para cada año (el promedio del año X se calcula con los datos mensuales de ese año).
   Ej: “La Plata (34,921 S - 57,955 O):
   - Año 2020: 23,8 ºC;
   - Año 2021: 26,1 ºC;
   - Año 2022: 25,3 ºC. ”

- La versión del sistema que reporta por meses deberá calcular el promedio para cada mes (el promedio del mes M se calcula con los datos de todos los años en ese
mes).
   Ej: “La Plata (34,921 S - 57,955 O):
   - Enero: 28,2 ºC;
   - Febrero: 26,8 ºC;
   - Marzo: 24.3 ºC
   - …..”
   Nota: Suponga que ya están registradas las temperaturas de todos los meses y años. Utilice el carácter \n para concatenar un salto de línea.
   
   f) Realice un programa principal que cree un Sistema con reporte anual para 3 años
   consecutivos a partir del 2021, para la estación La Plata (latitud -34.921
   y longitud -57.955). Cargue todas las temperaturas (para todos los meses y años).
   Informe los promedios anuales, y el mes y año en que se registró la mayor
   temperatura.

   Luego cree un Sistema con informe mensual para 4 años a partir de 2020, para la
   estación Mar del Plata (latitud -38.002 y longitud -57.556). Cargue todas las
   temperaturas (para todos los meses y años). Informe los promedios mensuales, y el
   mes y año en que se registró la mayor temperatura.
   NOTA: Preste atención de no violar el encapsulamiento al resolver el ejercicio.
 */
package Practica4;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ejercicio4P4_AF {

   public static void main(String[] args) {

      EstacionMeteorologica e1 = new EstacionMeteorologica("La Plata", -34.921, -57.955);
      SistemaRelevamientoTemperaturas sistemaAnual = new SistemaRelevamientoTemperaturas(e1, 2021, 3);
      EstacionMeteorologica e2 = new EstacionMeteorologica("Mar del Plata", -38.002, -57.556);
      SistemaRelevamientoTemperaturas sistemaMensual = new SistemaRelevamientoTemperaturas(e2, 2020, 4);

      for (int i = 0; i < sistemaAnual.getNumAnios(); i++) {
         for (int j = 0; j < 12; j++) {
            double temp = 1 + GeneradorAleatorio.generarDouble(50);
            sistemaAnual.registrarTemperatura(sistemaAnual.getAnioInicio() + i, j, temp);
         }
      }

      System.out.println(sistemaAnual.ReporteAnual());
      System.out.println("");
      System.out.println(sistemaAnual.maxTemperatura());
      
      System.out.println("");

      for (int i = 0; i < sistemaMensual.getNumAnios(); i++) {
         for (int j = 0; j < 12; j++) {
            double temp = 1 + GeneradorAleatorio.generarDouble(50);
            sistemaMensual.registrarTemperatura(sistemaMensual.getAnioInicio() + i, j, temp);
         }
      }

      System.out.println(sistemaMensual.ReporteMensual());
      System.out.println("");
      System.out.println(sistemaMensual.maxTemperatura());

   }

}
