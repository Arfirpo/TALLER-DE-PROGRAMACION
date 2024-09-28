/*
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
 */
package Practica4;

import java.text.DecimalFormat;

public class SistemaRelevamientoTemperaturas {

   //Constantes.
   private final int MESES = 12; //rango de meses x año.
   private final double TEMP_MAX = -999.9; //temperatura maxima.

   //Variables de Instancia.
   private EstacionMeteorologica estacion; //objeto estacion meteorologica.
   private double[][] temperaturas; //matriz de temperaturas por año y meses.
   private int anioInicio; //base de años a considerar.
   private int numAnios; //cantidad de años a considerar.

   //Constructores.
   public SistemaRelevamientoTemperaturas() {
   }

   public SistemaRelevamientoTemperaturas(EstacionMeteorologica unaEstacion, int A, int N) {
      this.estacion = unaEstacion;
      this.anioInicio = A;
      this.numAnios = N;
      this.temperaturas = new double[N][MESES];

      //Inicializo todas las temperaturas en un valor maximo (contante).
      for (int i = 0; i < numAnios; i++) {
         for (int j = 0; j < MESES; j++) {
            temperaturas[i][j] = TEMP_MAX;
         }
      }
   }

   //Comportamientos
   public EstacionMeteorologica getEstacion() {
      return estacion;
   }

   public void setEstacion(EstacionMeteorologica estacion) {
      this.estacion = estacion;
   }

   public int getAnioInicio() {
      return anioInicio;
   }

   public void setAnioInicio(int anioInicio) {
      this.anioInicio = anioInicio;
   }

   public int getNumAnios() {
      return numAnios;
   }

   public void setNumAnios(int numAnios) {
      this.numAnios = numAnios;
   }

   public void registrarTemperatura(int unAnio, int unMes, double unaTemperatura) {
      if (unAnio >= anioInicio && unAnio <= anioInicio + numAnios && unMes >= 0  && unMes < MESES) {
         temperaturas[unAnio - anioInicio][unMes] = unaTemperatura;
      } else {
         System.out.println("Fecha fuera de rango.");
      }
   }

   public double mostrarTemperatura(int unAnio, int unMes) {
      if (unAnio >= anioInicio && unAnio <= anioInicio + numAnios && unMes >= 1 && unMes <= MESES) {
         return temperaturas[unAnio - anioInicio][unMes - 1];
      }
      return TEMP_MAX;
   }

   public String maxTemperatura() {
      int maxAnio = anioInicio;
      int maxMes = 1;
      double maxTemp = TEMP_MAX;

      for (int i = 0; i < numAnios; i++) {
         for (int j = 0; j < MESES; j++) {
            if (temperaturas[i][j] > maxTemp) {
               maxTemp = temperaturas[i][j];
               maxAnio = anioInicio + i;
               maxMes = j + 1;
            }
         }
      }
      return "La Mayor temperatura se registro en el mes: " + maxMes + " del anio: " + maxAnio + ".";

   }

   public String ReporteAnual() {
      DecimalFormat df = new DecimalFormat("0.00");
      StringBuilder reporte = new StringBuilder(estacion.toString() + "\n");
      for (int i = 0; i < numAnios; i++) {
         int suma = 0;
         for (int j = 0; j < MESES; j++) {
            suma += temperaturas[i][j];
         }
         double prom = (double) suma / MESES;
         reporte.append("- Anio ").append(anioInicio + i).append(": ").append(df.format(prom)).append("°C.\n");
      }
      return reporte.toString();
   }

   public String ReporteMensual() {
      DecimalFormat df = new DecimalFormat("0.00");
      StringBuilder reporte = new StringBuilder(estacion.toString() + "\n");
      String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
      for (int j = 0; j < MESES; j++) {
         int suma = 0;
         for (int i = 0; i < numAnios; i++) {
            suma += temperaturas[i][j];
         }
         double prom = (double) suma / numAnios;
         reporte.append("- ").append(meses[j]).append(": ").append(df.format(prom)).append("°C.\n");
      }
      return reporte.toString();
   }
}
