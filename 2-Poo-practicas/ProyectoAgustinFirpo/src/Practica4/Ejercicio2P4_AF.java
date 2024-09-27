/*
2- Queremos representar a los empleados de un club: jugadores y entrenadores.
     Cualquier empleado se caracteriza por su nombre, sueldo básico y antigüedad.
     Los jugadores son empleados que se caracterizan por el número de partidos jugados y el número de goles anotados.
     Los entrenadores son empleados que se caracterizan por la cantidad de campeonatos ganados.

A- Implemente la jerarquía de clases declarando atributos, métodos para obtener/modificar su valor y constructores que reciban los datos necesarios.

B- Cualquier empleado debe responder al mensaje calcularEfectividad. La efectividad del entrenador es el promedio de campeonatos ganados por año de antigüedad, mientras que la del jugador es el promedio de goles por partido.

C- Cualquier empleado debe responder al mensaje calcularSueldoACobrar. El sueldo a cobrar es el sueldo básico más un 10% del básico por cada año de antigüedad y además:
     Para los jugadores: si el promedio de goles por partido es superior a 0,5 se adiciona un plus de otro sueldo básico.
     Para los entrenadores: se adiciona un plus por campeonatos ganados (5000$ si ha ganado entre 1 y 4 campeonatos; $30.000 si ha ganado entre 5 y 10 campeonatos; 50.000$ si ha ganado más de 10 campeonatos).

D- Cualquier empleado debe responder al mensaje toString, que devuelve un String que lo representa, compuesto por nombre, sueldo a cobrar y efectividad.

F- Realizar un programa que instancie un jugador y un entrenador. Informe la representación String de cada uno.

NOTA: para cada método a implementar piense en que clase/s debe definir el método.
 */
package Practica4;

import PaqueteLectura.Lector;

public class Ejercicio2P4_AF {

  public static void main(String[] args) {
    Jugador j = new Jugador();
    Entrenador e = new Entrenador();
    
    System.out.println("---------- | Carga de datos Jugador | ----------\n");
    System.out.print("Ingrese Nombre del jugador: ");
    j.setNombre(Lector.leerString());
    System.out.print("Ingrese sueldo basico del jugador: ");
    j.setSueldoBasico(Lector.leerDouble());
    System.out.print("Ingrese antiguedad del jugador: ");
    j.setAntiguedad(Lector.leerInt());
    System.out.print("Ingrese partidos jugados: ");
    j.setPartidosJugados(Lector.leerInt());
    System.out.print("Ingrese goles anotados: ");
    j.setGolesAnotados(Lector.leerInt());
    System.out.println("----------------------------\n");
    
    System.out.println("---------- | Carga de datos Entrenador | ----------\n");
    System.out.print("Ingrese Nombre del entrenador: ");
    e.setNombre(Lector.leerString());
    System.out.print("Ingrese sueldo basico del entrenador: ");
    e.setSueldoBasico(Lector.leerDouble());
    System.out.print("Ingrese antiguedad del entrenador: ");
    e.setAntiguedad(Lector.leerInt());
    System.out.print("Ingrese campeonatos ganados: ");
    e.setCampeonatosGanados(Lector.leerInt());
    System.out.println("----------------------------\n");
    System.out.println("---------- | Datos Jugador | ----------\n");
    System.out.println(j.toString());
    System.out.println("---------- | Datos Entrenador | ----------\n");
    System.out.println(e.toString());
  }

}
