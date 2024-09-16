/*

4- Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. 
Para esto, simule la llegada de personas al edificio de la siguiente manera: 
   a cada persona se le pide el nro. de piso y nro. de oficina a la cual quiere concurrir. 
   La llegada de personas finaliza al indicar un nro. de piso 9. 
   Al finalizar la llegada de personas, informe lo pedido.

*/
package Practica1;

import PaqueteLectura.Lector;

public class Ejercicio4P1_AF {

   public static void main(String[] args) {
      
      //declaracion de variables y matriz.
      int piso; int ofi;
      int i; int j;
      int[][] oficinas = new int [8][4];
      
      //inicializar matriz en 0.
      for(i=0;i<8;i++)
            for(j=0;j<4;j++)
               oficinas[i][j] = 0;
      
      //cargar matriz.
      System.out.print("Ingrese numero de piso: ");
      piso = Lector.leerInt();
      while(piso != 9){
         System.out.print("Ingrese numero de oficina: ");
         ofi = Lector.leerInt();
         oficinas[piso][ofi] = oficinas[piso][ofi] + 1;
         System.out.print("Ingrese numero de piso: ");
         piso = Lector.leerInt();
         
      }
      
      for(i=0;i<8;i++)
         for(j=0;j<4;j++)
            System.out.println("Por el piso " + i + " oficina " + j + " pasaron " + oficinas[i][j] + " personas.");
   }
   
}
