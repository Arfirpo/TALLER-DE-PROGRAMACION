/**
 * 4-A- Un hotel posee N habitaciones. De cada habitación conoce costo por noche, si está ocupada y, en caso de estarlo, guarda el cliente que la reservó (nombre, DNI y edad).
 * (i) Genere las clases necesarias. Para cada una provea métodos getters/setters adecuados.
 * (ii) Implemente los constructores necesarios para iniciar: los clientes a partir de nombre, DNI, edad; el hotel para N habitaciones, cada una desocupada y con costo aleatorio e/ 2000 y 8000.
 * (iii) Implemente en las clases que corresponda todos los métodos necesarios para:
 * - Ingresar un cliente C en la habitación número X. Asuma que X es válido (es decir, está en el rango 1..N) y que la habitación está libre.
 * - Aumentar el precio de todas las habitaciones en un monto recibido.
 * - Obtener la representación String del hotel, siguiendo el formato:
 * {Habitación 1: costo, libre u ocupada, información del cliente si está ocupada}
 * …   {Habitación N: costo, libre u ocupada, información del cliente si está ocupada}
 *
 * B- Realice un programa que instancie un hotel, ingrese clientes en distintas habitaciones, muestre el hotel, aumente el precio de las habitaciones y vuelva a mostrar el hotel.
 * NOTAS: Reúse la clase Persona. Para cada método solicitado piense a qué clase debe delegar la responsabilidad de la operación.
 */
package Practica3;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio4P3_AF {

   public static void main(String args[]) {

      GeneradorAleatorio.iniciar();
      String nom;
      String corte = "zzz";
      Hotel hilton = new Hotel(20); //Genero un hotel de 20 habitaciones.

      System.out.println("---------- | Sistema de Gestion del Hotel | ----------\n");
      System.out.println("----- Gestion de Reserva ----->\n");
      System.out.print("Ingrese nombre del cliente: ");
      nom = Lector.leerString();
      System.out.println("");

      while (hilton.getOcupacionActual() < hilton.getCapacidadHotel() && !nom.equals(corte)) {

         //Cargo al cliente
         Cliente c = new Cliente();
         c.setNombre(nom);
         System.out.print("Ingrese dni del cliente: ");
         c.setDNI(Lector.leerInt());
         System.out.println("");
         System.out.print("Ingrese Edad del cliente: ");
         c.setEdad(Lector.leerInt());
         System.out.println("");

         do {
            System.out.print("¿Que habitacion desea reservar? -Ingrese Numero entre 1 y 20-: ");
            c.setNroHabitacion(Lector.leerInt() - 1);
            System.out.println("");

            if (c.getNroHabitacion() < 0 || c.getNroHabitacion() >= hilton.getCapacidadHotel()) {
               System.out.println("La habitacion requerida no existe, intente nuevamente.\n");
            } else if (hilton.habitacionOcupada(c.getNroHabitacion())) {
               System.out.println("La habitación está ocupada, elija otra.\n");
               c.setNroHabitacion(-1); // Valor inválido para repetir el bucle
            }
         } while (c.getNroHabitacion() < 0 || c.getNroHabitacion() >= hilton.getCapacidadHotel());

         //Reservo Habitacion
         hilton.reservarHabitacion(c);

         //Inicio carga nuevo cliente
         System.out.println("----- Gestion de Reserva ----->\n");
         System.out.print("Ingrese nombre del cliente: ");
         nom = Lector.leerString();
         System.out.println("");
      }

      //Imprime estado de las habitaciones del hotel.
      System.out.println("---------- | Estado de ocupacion del Hotel | ----------\n");
      hilton.mostrarHotel();
      System.out.println("--------------------------------------------------\n");

      //Aumento precio de todas las habitaciones del hotel.
      System.out.print("Ingrese monto de aumento para las habitaciones del hotel: ");
      hilton.aumentarPrecio(Lector.leerDouble());
      System.out.println("--------------------------------------------------\n");

      //Imprime estado de las habitaciones del hotel.
      System.out.println("---------- | Estado de ocupacion del Hotel | ----------\n");
      hilton.mostrarHotel();
      System.out.println("--------------------------------------------------\n");

      System.out.println("---------- | Habitaciones Reservadas | ----------\n");
      hilton.mostrarHabitacionesReservadas();
      System.out.println("");
      System.out.println("--------------------------------------------------\n");
   }

}
