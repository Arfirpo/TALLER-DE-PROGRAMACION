/*
1-
A- Incluya la clase Triángulo a la jerarquía de figuras vista (carpeta tema4). Triángulo debe heredar de Figura todo lo que es común y definir su constructor y sus atributos y métodos propios. Además debe redefinir el método toString.
B- De igual manera, incluya la clase Círculo a la jerarquía de figuras.
C- Añada a la representación String el valor del perímetro. Piense ¿qué método toString debe modificar: el de cada subclase o el de Figura?
D- Añada el método despintar que establece los colores de la figura a línea “negra” y relleno “blanco”. Piense ¿dónde debe definir el método: en cada subclase o en Figura?
E- Realizar un programa que instancie un triángulo y un círculo. Muestre en consola la representación String de cada uno. Pruebe el funcionamiento del método despintar.
 */
package Practica4;

import PaqueteLectura.Lector;

public class Ejercicio1P4_AF {

  public static void main(String[] args) {

    //instanciacion de un triangulo y un circulo
    System.out.print("Ingresar Color de Relleno y de Linea del Triangulo: ");
    Triangulo t = new Triangulo(Lector.leerString(), Lector.leerString());
    System.out.print("Ingrese medida del lado 1: ");
    t.setLado1(Lector.leerDouble());
    System.out.print("Ingrese medida del lado 2: ");
    t.setLado2(Lector.leerDouble());
    System.out.print("Ingrese medida del lado 3: ");
    t.setLado3(Lector.leerDouble());
    System.out.println("");
    System.out.print("Ingresar Color de Relleno y de Linea del Circulo: ");

    Circulo c = new Circulo(Lector.leerString(), Lector.leerString());
    
    System.out.print("Ingrese radio del Circulo: ");
    c.setRadio(Lector.leerDouble());
    System.out.println("");

    for (int i = 0; i < 2; i++) {
      
      System.out.println("----- | Datos Triangulo |-----\n");
      System.out.println(t.toString());
      System.out.println("");
      System.out.println("----- | Datos Circulo |-----\n");
      System.out.println(c.toString());
      System.out.println("");
      
      if(i < 1){
        //limpieza de colores
        System.out.println("Se despintaron las figuras.\n");
        t.despintar();
        c.despintar();
      }
    }
  }

}
