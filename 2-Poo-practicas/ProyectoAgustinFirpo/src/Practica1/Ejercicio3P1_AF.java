/*
3- Escriba un programa que defina una matriz de enteros de tamaño 5x5. Inicialice la matriz con números aleatorios entre 0 y 30.
Luego realice las siguientes operaciones:
- Mostrar el contenido de la matriz en consola.
- Calcular e informar la suma de los elementos de la fila 1
- Generar un vector de 5 posiciones donde cada posición j contiene la suma
de los elementos de la columna j de la matriz. Luego, imprima el vector.
- Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de
encontrarse indique su ubicación (fila y columna) en caso contrario
imprima “No se encontró el elemento”.
*/

package Practica1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;
        
public class Ejercicio3P1_AF {

    public static void main(String[] args) {
      GeneradorAleatorio.iniciar();
      
      //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios
      
      int dimF = 5;
      int [][] matriz = new int [dimF][dimF];
      
      int i; int j; int suma;
      
      for (i = 0; i < dimF; i++)
         for(j = 0; j < dimF; j++)
            matriz [i][j] = GeneradorAleatorio.generarInt(31);
    
      //Paso 4. mostrar el contenido de la matriz en consola
      
      System.out.println("---------------------- Matriz ----------------------");
      System.out.println();
      for(i = 0; i<dimF;i++){
         System.out.print(" | ");
         for(j=0;j<dimF;j++)
            System.out.print(matriz[i][j] + " | ");
         System.out.println();
      }
      
      //Paso 5. calcular e informar la suma de los elementos de la fila 1
      
      System.out.println();
      System.out.println("Recorrer Matriz por filas");
      System.out.println();
      for(i = 0; i < dimF;i++){
         int cantFila = 0;
         for(j=0;j<dimF;j++) cantFila = cantFila + matriz[i][j];
         System.out.println("La suma de los valores de la fila " + i + " es: " + cantFila);         
      }
    
      //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz.    
      
      System.out.println();
      int [] vector = new int [dimF];
      for(j = 0; j<dimF;j++){
         suma = 0;
         for(i=0;i<dimF;i++) {
            suma = suma + matriz[i][j];
            vector[j] = suma;
         }
      }
      
      //Luego, imprima el vector.
      
      System.out.println("---------------------- Vector ----------------------");
      System.out.println();
      System.out.println("Recorrer Matriz por columnas");
      System.out.println();
      for(j=0;j<dimF;j++) System.out.println("La suma de los valores de la columna " + j + " es: " + vector[j]);
      System.out.println();

      //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
      
      System.out.println();
      System.out.println("---------------------- Buscar en Matriz ----------------------");
      System.out.println();
      System.out.print("Ingrese un valor a buscar en la matriz: ");
      int num = Lector.leerInt();
       System.out.println();
      boolean esta = false;
      i=0; j=0; //inicializamos los indices en 0.
      int fila = 0; int columna = 0; //variables para guardar la posicion en la matriz.
      
      while(i<dimF && !esta){
         j=0;
         while (j<dimF && !esta){
            if(matriz[i][j] == num) {
               esta = true;
               fila = i;
               columna = j;
            }
            j++;
         }
         i++;                                
      }
      if(esta)
          System.out.println("El valor existe y se ecuentra en la fila: " + (fila + 1) + ", columna: " + (columna + 1) + ".");
      else
         //   y en caso contrario imprima "No se encontró el elemento".
         System.out.println("No se encontro el elemento.");
       System.out.println();
    }
}