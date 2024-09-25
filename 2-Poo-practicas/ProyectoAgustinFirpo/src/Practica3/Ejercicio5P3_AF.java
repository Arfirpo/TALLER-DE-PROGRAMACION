/*
  5-A- Definir una clase para representar círculos. Los círculos se caracterizan por su radio (double), el color de relleno (String) y el color de línea (String).
  Provea un constructor que reciba todos los datos necesarios para iniciar el objeto.
  Provea métodos para:
    - Devolver/modificar el valor de cada uno de sus atributos (métodos get y set)
    - Calcular el perímetro y devolverlo (método calcularPerimetro)
    - Calcular el área y devolverla (método calcularArea)
  B- Realizar un programa que instancie un círculo, le cargue información leída de teclado e
  informe en consola el perímetro y el área.
  NOTA: la constante PI es Math.PI
*/

package Practica3;

import PaqueteLectura.Lector;

public class Ejercicio5P3_AF {

  public static void main(String args[]){

    Circulo c = new Circulo();

    System.out.print("Ingrese Radio del Circulo: ");
    c.setRadio(Lector.leerDouble());
    System.out.print("Ingrese Color de Relleno del Circulo: ");
    c.setColorRelleno(Lector.leerString());
    System.out.print("Ingrese Color de Linea del Circulo: ");
    c.setColorLinea(Lector.leerString());

    System.out.printf("El perímetro del círculo es: %.2f\n", c.calcularPerimetro());
    System.out.printf("El área del círculo es: %.2f\n", c.calcularArea());

  }

}