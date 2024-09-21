/*
 2- Utilizando la clase Persona. Realice un programa que almacene en un vector a lo sumo 15 personas. La información (nombre, DNI, edad) se debe generar aleatoriamente hasta obtener edad 0. Luego de almacenar la información:
- Informe la cantidad de personas mayores de 65 años. - Muestre la representación de la persona con menor DNI.
 */
package Practica2;

import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio2P2 {

   public static void main(String[] args) {
      GeneradorAleatorio.iniciar();
      int i;
      int cantMay65 = 0;
      int dimL=0;
      int dimF = 15;
      int edad = 0;
      Persona [] vectorPersonas = new Persona [dimF];
      
      //Cargar Vector Personas
      
      edad = GeneradorAleatorio.generarInt(100);
      while((edad != 0) && (dimL < dimF)){
         Persona p = new Persona();
         p.setEdad(edad);
         p.setDNI(1 + GeneradorAleatorio.generarInt(50));
         p.setNombre(GeneradorAleatorio.generarString(5));
         vectorPersonas[dimL] = p;
         dimL++;
         edad = GeneradorAleatorio.generarInt(100);
      }
      
      Persona minPersona = vectorPersonas[0];
      
      // Recorrer Vector
      for(i=0;i<dimL;i++){
         System.out.println((i+1) + ". " + vectorPersonas[i].toString());
         System.out.println("");
         if(vectorPersonas[i].getDNI() < minPersona.getDNI()) minPersona = vectorPersonas[i];
         if(vectorPersonas[i].esMayor(65)) cantMay65++;
      }
      //informar cantidad personas mayores a 65 años
      System.out.println(cantMay65 + " personas leidas tienen mas de 65 años.");
      System.out.println("");
      System.out.println("---------- Persona con Menor DNI ----------");
      System.out.println("");
      System.out.println(minPersona.toString());
      System.out.println("");
   }
}
