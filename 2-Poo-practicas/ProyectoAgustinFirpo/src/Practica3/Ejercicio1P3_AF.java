/*
1-A- Definir una clase para representar triángulos. Un triángulo se caracteriza por el tamaño de sus 3 lados (double), el color de relleno (String) y el color de línea (String).
Provea un constructor que reciba todos los datos necesarios para iniciar el objeto.
Provea métodos para:
- Devolver/modificar el valor de cada uno de sus atributos (métodos get y set)
- Calcular el perímetro y devolverlo (método calcularPerimetro)
- Calcular el área y devolverla (método calcularArea)
B- Realizar un programa que instancie un triángulo, le cargue información leída desde
teclado e informe en consola el perímetro y el área.
*/

package Practica3;

import PaqueteLectura.Lector;

public class Ejercicio1P3_AF {

  public static void main(String args[]) {

    //declaro objeto triangulo y lo creo vacio.
    Triangulo t = new Triangulo();

    //Cargo los valores del triagulo.
    System.out.print("Ingrese medida del lado 1: ");
    t.setLado1(Lector.leerInt());
    System.out.print("Ingrese medida del lado 2: ");
    t.setLado2(Lector.leerInt());
    System.out.print("Ingrese medida del lado 3: ");
    t.setLado3(Lector.leerInt());
    System.out.print("Ingrese el color de relleno: ");
    t.setColorRelleno(Lector.leerString());
    System.out.print("Ingrese el color de linea: ");
    t.setColorLinea(Lector.leerString());

    //Imprimir valores del objeto triangulo
    System.out.println(t.toString());
    System.out.println("El perimetro del triangulo es: %.2f\n" + t.calcularPerimetro());
    System.out.printf("El Area del triangulo es: %.2f\n", t.calcularArea());
  }
}