/*
4- Sobre un nuevo programa, modifique el ejercicio anterior para considerar que:
   a) Durante el proceso de inscripción se pida a cada persona sus datos (nombre, DNI, edad) y el día en que se quiere presentar al casting. 
   La persona debe ser inscripta en ese día, en el siguiente turno disponible. En caso de no existir un turno en ese día, informe la situación.
   La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los 40 cupos de casting.
   Una vez finalizada la inscripción:
   b) Informar para cada día: la cantidad de inscriptos al casting ese día y el nombre de la
   persona a entrevistar en cada turno asignado.
 */
package Practica2;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio4P2_AF {

   public static void main(String[] args) {
      GeneradorAleatorio.iniciar();
      int dias = 5; 
      int turnos = 8;
      int dimL = 0; 
      int dimF = 40;
      Persona [][] Casting = new Persona [dias][turnos]; //matriz de personas. Dimensiones: 5 dias x 8 personas.
      int [] dimLEntrevistas = new int[dias]; //vector de dimensiones logicas por cada dia de casting.
      String Nom, corte = "zzz"; 
      int i; 
      int j; 
      int num;
      int diaEstimado;
      boolean asignado;
      
      //inicializo el vector en 0.
      
      for(i=0;i<dias;i++)
         dimLEntrevistas[i] = 0;
      
      //simulacion inscripciones
      
      num = 1 + GeneradorAleatorio.generarInt(10);
      if (num != 5)
         Nom = GeneradorAleatorio.generarString(3);
      else
         Nom = "zzz";
         
      while (!Nom.equalsIgnoreCase(corte) && dimL < dimF){
         
         //creo una persona con nombre,edad,dni y dia de casting deseado.
         Persona p = new Persona();
         p.setNombre(Nom);
         p.setDNI(GeneradorAleatorio.generarInt(30000000));
         p.setEdad(18 + GeneradorAleatorio.generarInt(100 - 18 + 1));
         
         //solicitar dia de casting deseado.
         do {
            System.out.print("Ingrese el dia en el que desea ser entrevistado -Dias 0 a 4-: ");
            diaEstimado = Lector.leerInt();
         } while ((diaEstimado < 0) || (diaEstimado >= dias));
         
         //seteo el valor de la variable booleana en false.
         asignado = false;
         
         //reviso si en el dia deseado hay turnos disponibles (mientras no se le asigne uno, se pide al usuario que ingrese otro dia).
         
         if (dimLEntrevistas[diaEstimado] < turnos) {
            //si el dia tiene turnos disponibles, asigno el siguiente disponible.
            Casting[diaEstimado][dimLEntrevistas[diaEstimado]] = p;
            System.out.println();
            System.out.println("Turno Asignado! - Dia: " + (diaEstimado + 1) + " Turno: " + (dimLEntrevistas[diaEstimado] + 1));
            System.out.println();
            dimLEntrevistas[diaEstimado]++;
            dimL++;
         } else {
            System.out.println("");
            System.out.println("No hay turnos disponibles en el dia seleccionado.");
            System.out.println("");
         }
         
         //una vez asignado el turno a la persona, genero otro nombre si hay cupos disponibles.
         if(dimL < dimF){
            num = 1 + GeneradorAleatorio.generarInt(10);
            if (num != 5)
               Nom = GeneradorAleatorio.generarString(3);
            else
               Nom = "zzz";            
         }
      }
      System.out.println("--------------- CASTING ---------------");
      System.out.println("");
      System.out.println("Total de personas inscriptas al casting: " + dimL);
      System.out.println("");
      for (i = 0; i < dias; i++) {
         System.out.println("--------------- | Dia " + (i + 1) + " | ---------------");
         System.out.println();
         if (dimLEntrevistas[i] != 0) {
            System.out.println("Cantidad de Personas inscriptas: " + dimLEntrevistas[i]);
            System.out.println();
            for (j = 0; j < dimLEntrevistas[i]; j++) {
               System.out.println(" Turno " + (j + 1) + " - Persona a entrevistar : " + Casting[i][j].getNombre());
            }
            System.out.println();
         } else {
            System.out.println("No se asignaron turnos.");
            System.out.println();
         }
      }
   }
}
