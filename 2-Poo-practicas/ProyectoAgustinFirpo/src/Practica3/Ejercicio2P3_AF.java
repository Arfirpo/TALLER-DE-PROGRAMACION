/*
  2-A- Modifique la clase Libro.java (carpeta tema3) para ahora considerar que el primer autor es un objeto instancia de la clase Autor.
  Implemente la clase Autor, sabiendo que se caracterizan por nombre, biografía y origen y que deben permitir devolver/modificar el valor de sus atributos y devolver una   representación String formada por nombre, biografía y origen.
  Luego realice las modificaciones necesarias en la clase Libro.
*/

package Practica3;

import PaqueteLectura.Lector;

public class Ejercicio2P3_AF{

  public static void main(String args[]){

    Autor a = new Autor();
    Libro l = new Libro();
    
    //cargo el autor.
    System.out.println("---------- Carga de datos del Autor ----------");
    System.out.println("");
    System.out.print("Ingrese Nombre del Autor del Libro: ");
    a.setNombre(Lector.leerString());
    System.out.print("Ingrese Breve Biografia del Autor: ");
    a.setBiografia(Lector.leerString()); 
    System.out.print("Ingrese localidad de origen del Autor: ");
    a.setOrigen(Lector.leerString()); 
    System.out.println("");
    //cargo el libro.
    System.out.println("---------- Carga de datos del Libro ----------");
    System.out.println("");
    System.out.print("Ingrese el titulo del libro: ");
    l.setTitulo(Lector.leerString());
    l.setPrimerAutor(a);
    System.out.print("Ingrese editorial del libro: ");
    l.setEditorial(Lector.leerString());
    System.out.print("Ingrese anio de edicion: ");
    l.setAñoEdicion(Lector.leerInt());
    System.out.print("Ingrese ISBN del libro: ");
    l.setISBN(Lector.leerString());
    System.out.print("Ingrese precio del libro: ");
    l.setPrecio(Lector.leerDouble());
    System.out.println("");
    System.out.println("---------- Datos del Libro ----------");
    System.out.println();
    System.out.println(l.toString());
  }

}