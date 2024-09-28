/*
De la estación, interesa conocer: nombre, y latitud y longitud donde se encuentra.
 */
package Practica4;

public class EstacionMeteorologica {

   private String nombreEstacion;
   private double latitudEstacion;
   private double longitudEstacion;

   //Constructores.
   //Constructor vacio.
   public EstacionMeteorologica() {
   }

   //Constructor con parametros.
   public EstacionMeteorologica(String unNombre, double unaLatitud, double unaLongitud) {
      this.setNombreEstacion(unNombre);
      this.setLongitudEstacion(unaLatitud);
      this.setLongitudEstacion(unaLongitud);
   }

   //Comportamientos.
   //Getters.
   public String getNombreEstacion() {
      return nombreEstacion;
   }

   public double getLatitudEstacion() {
      return latitudEstacion;
   }

   public double getLongitudEstacion() {
      return longitudEstacion;
   }

   //Setters.
   public void setNombreEstacion(String unNombre) {
      this.nombreEstacion = unNombre;
   }

   public void setLatitudEstacion(double unaLatitud) {
      this.latitudEstacion = unaLatitud;
   }

   public void setLongitudEstacion(double unaLongitud) {
      this.longitudEstacion = unaLongitud;
   }

   //Objeto Representado en String.
   public String toString() {
      String aux = "Nombre de la estacion Meteorologica: " + this.nombreEstacion + "\n"
              + "Ubicacion: " + "Latitud: " + this.latitudEstacion + " Longitud: " + this.longitudEstacion + ".\n";
      return aux;
   }

}
