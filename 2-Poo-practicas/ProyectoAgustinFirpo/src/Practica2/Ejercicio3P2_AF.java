/*
3- Se realizará un casting para un programa de TV. El casting durará a lo sumo 5 días y en cada día se entrevistarán a 8 personas en distinto turno.
a) Simular el proceso de inscripción de personas al casting. A cada persona se le pide nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las personas primero completan el primer día en turnos sucesivos, luego el segundo día y así siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los 40 cupos de casting. Una vez finalizada la inscripción:
b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
NOTA: utilizar la clase Persona. Pensar en la estructura de datos a utilizar. Para comparar Strings use el método equals.
 */
package Practica2;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;
        
public class Ejercicio3P2_AF {

   public static void main(String[] args) {
      GeneradorAleatorio.iniciar();
      int dias = 5; int entrevistas = 8;
      Persona [][] Casting = new Persona [dias][entrevistas]; //matriz de personas. Dimensiones: 5 dias x 8 personas.
      int [] dimLEntrevistas = new int[dias];
      
      //simulacion inscripciones
      String Nom, corte = "zzz"; 
      int i=0; int j=0; int num;
      
      num = 1 + GeneradorAleatorio.generarInt(10);
      if (num != 5)
         Nom = GeneradorAleatorio.generarString(3);
      else
         Nom = "zzz";
         
      while (((!Nom.equals(corte))) && (i < dias)){
         while ((!Nom.equals(corte)) && (j < entrevistas)){
             Casting[i][j] = new Persona(Nom,GeneradorAleatorio.generarInt(30000000),(10 + GeneradorAleatorio.generarInt(100)));
             j++;
             if (j < entrevistas){
               num = 1 + GeneradorAleatorio.generarInt(10);
               if (num != 5) Nom = GeneradorAleatorio.generarString(3);
               else Nom = "zzz";                
             } 
         }
         dimLEntrevistas[i] = j;
         j = 0;
         i++;
      }
      
      for(i=0;i<dias;i++){
         if (dimLEntrevistas[i] != 0) {
            System.out.println();
            System.out.println("--------------- | Dia " + (i+1) + " | ---------------" );
            for(j=0;j<dimLEntrevistas[i];j++){
              System.out.println();
              System.out.println(" Casting " + (j+1) + " - Persona a entrevistar : " + Casting[i][j].getNombre());   
            }
            System.out.println();
         }
      }
   }
}
