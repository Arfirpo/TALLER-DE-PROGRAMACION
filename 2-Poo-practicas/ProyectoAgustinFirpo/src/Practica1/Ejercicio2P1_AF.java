/*
  2- Escriba un programa que lea las alturas de los 15 jugadores de un equipo de
básquet y las almacene en un vector. Luego informe:
- la altura promedio
- la cantidad de jugadores con altura por encima del promedio
NOTA: Dispone de un esqueleto para este programa en Ej02Jugadores.java

*/


package Practica1;
import PaqueteLectura.Lector;

public class Ejercicio2P1_AF {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        int dimF = 15;
        //Paso 3: Crear el vector para 15 double 
        double [] vector = new double[dimF];
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i;
        double prom = 0;
        int cantMasProm = 0;
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        for (i=0;i<dimF;i++){
            System.out.print("Ingrese altura de jugador " + i + ": ");
            vector[i] = Lector.leerDouble();
            prom = prom + vector[i];
        }
        //Paso 7: Calcular el promedio de alturas, informarlo
        prom = prom / dimF;
        System.out.printf("El promedio de altura de los jugadores leidos es: %.2f%n",prom);
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        for(i=0;i<dimF;i++)
            if(vector[i] > prom) cantMasProm++;
        //Paso 9: Informar la cantidad.
        System.out.println("La cantidad de jugadores cuya altura supera el promedio es: " + cantMasProm);
    }
    
}

