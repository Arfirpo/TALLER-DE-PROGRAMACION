/*
  Un hotel posee N habitaciones. De cada habitación conoce costo por noche, si está ocupada y, en caso de estarlo, guarda el cliente que la reservó (nombre, DNI y edad).
    (i) Genere las clases necesarias. Para cada una provea métodos getters/setters adecuados.
    (ii) Implemente los constructores necesarios para iniciar: los clientes a partir de nombre, DNI, edad; 
    el hotel para N habitaciones, cada una desocupada y con costo aleatorio e/ 2000 y 8000.
    (iii) Implemente en las clases que corresponda todos los métodos necesarios para:
    - Ingresar un cliente C en la habitación número X. Asuma que X es válido (es decir, está en el rango 1..N) y que la habitación está libre.
    - Aumentar el precio de todas las habitaciones en un monto recibido.
    - Obtener la representación String del hotel, siguiendo el formato: 
      {Habitación 1: costo, libre u ocupada, información del cliente si está ocupada}
  …   {Habitación N: costo, libre u ocupada, información del cliente si está ocupada} 
  NOTAS: Reúse la clase Persona. Para cada método solicitado piense a qué clase debe delegar la responsabilidad de la operación.
 */
package Practica3;

import java.text.DecimalFormat;

public class Habitacion {

   //Variables de instanciacion.
   private double costoNoche;
   private boolean ocupacion;
   private Cliente huesped;

   //Constructor.
   public Habitacion() {

   }

   public Habitacion(double costoNoche) {
      this.costoNoche = costoNoche;
      this.ocupacion = false;
   }

   //Getters.
   public String estadoOcupacion() {
      return ocupacion ? "reservada" : "libre";
   }

   public Cliente getHuesped() {
      return this.huesped;
   }

   public boolean getOcupacion() {
      return this.ocupacion;
   }

   public double getCostoNoche() {
      return this.costoNoche;
   }

   //Setters.
   public void setOcupacion(boolean unEstado) {
      this.ocupacion = unEstado;
   }

   public void setCostoNoche(double unMonto) {
      this.costoNoche = unMonto;
   }

   public void setHuesped(Cliente unHuesped) {
      this.huesped = unHuesped;
   }

   public String toString() {
      DecimalFormat df = new DecimalFormat("0.00");
      String info = " | Costo: $" + df.format(costoNoche) + " | Estado: " + estadoOcupacion();
      return ocupacion ? info + " | " + huesped.toString() : info;
   }
}
