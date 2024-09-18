/******************************************************************************

5- El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.

*******************************************************************************/

package Practica1;

import PaqueteLectura.Lector;

public class Ejercicio5P1_AF{

	public static void main(String[] args) {
		
		int cli = 5; int cat = 4; int i; int j;
		double [][] matriz = new double [cli][cat];
		double [] vector = new double [cat];
		double prom = 0.0;
		
		//cargar matriz
		System.out.println("Estimado Cliente, Califique (entre 1 y 10) los siguientes aspectos de nuestro local: 0.-Atención al cliente, 1.-Calidad de la comida, 2.-Precio, 3.-Ambiente");
		for(i=0;i<cli;i++){
      System.out.println();
      System.out.println("---------- Cliente " + (i+1) + " ----------");
      System.out.println();
      for(j = 0; j < cat; j++) {
        switch (j) {
          case 0:
            System.out.print("Atencion al cliente: ");
            break;
          case 1:
            System.out.print("Calidad de la comida: ");
            break;
          case 2:
            System.out.print("Precio: ");
            break;
          case 3:
            System.out.print("Ambiente: ");
            break;
        }
        matriz[i][j] = Lector.leerDouble();
      }
    }
		
   //calcular promedios por categoria
   for(j=0;j<cat;j++){
      prom = 0;
      for(i=0;i<cli;i++)
         prom += matriz [i][j];
      vector[j] = prom / cli;
   }
		
		//informar promedios matriz
		System.out.println();
    System.out.println("---------- Calificaciones promedio ----------");
    System.out.println();
    for(i = 0; i < cat; i++) {
      System.out.println();
      switch (i) {
        case 0:
          System.out.printf("Atención al cliente: %.2f%n", vector[i]);
          break;
        case 1:
          System.out.printf("Calidad de la comida: %.2f%n", vector[i]);
          break;
        case 2:
          System.out.printf("Precio: %.2f%n", vector[i]);
          break;
        case 3:
          System.out.printf("Ambiente: %.2f%n", vector[i]);
          break;
      }
    }
	}
}