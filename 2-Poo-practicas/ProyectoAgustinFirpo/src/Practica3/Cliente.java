
package Practica3;

import Practica2.Persona;


public class Cliente extends Persona{
   
   private int nroHabitacion;
   
   //Constructor
   public Cliente(){
      
   }

   public Cliente(int nroHabitacion, String unNombre, int unDNI, int unaEdad) {
      super(unNombre, unDNI, unaEdad);
      this.nroHabitacion = nroHabitacion;
   }

   public int getNroHabitacion() {
      return nroHabitacion;
   }

   public void setNroHabitacion(int nroHabitacion) {
      this.nroHabitacion = nroHabitacion;
   }

   @Override
   public String toString() {
      return "Huesped: " + getNombre() + " | Edad: " + getEdad()+ " | Dni: " + getDNI() + ".";
   }
   
   
}
