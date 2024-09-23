package Practica3;

public class Main {

  import PaqueteLectura.Lector;
  
  public static void main(String args[]) {

    //declaro objeto triangulo y lo creo vacio.
    triangulo t = new triangulo();

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
    System.out.println("El perimetro del triangulo es: " + t.calcularPerimetro());
    System.out.printf("El Area del triangulo es: %.2f\n", t.calcularArea());
  }
}