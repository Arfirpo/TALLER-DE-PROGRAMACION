/*
  2-A- Modifique la clase Libro.java (carpeta tema3) para ahora considerar que el primer autor es un objeto instancia de la clase Autor.
  Implemente la clase Autor, sabiendo que se caracterizan por nombre, biografía y origen y que deben permitir devolver/modificar el valor de sus atributos y devolver una   representación String formada por nombre, biografía y origen.
  Luego realice las modificaciones necesarias en la clase Libro.
*/

package Practica3;

public class Ejercicio2P3_AF{

  public static void main(String args[]){

    Autor a = new Autor();
    Libro l = new Libro();

    //cargo el autor.
    a.setNombre("Agustin Firpo");
    a.setBiografia("Nacido en 1993, 27 de Abril. Abogado. Estudiante de Informatica");  
    a.setOrigen("La Plata,Bs.As. - Argentina"); 

    //cargo el libro.
    l.setTitulo("El arte de la Programacion Legal.");
    l.setPrimerAutor(a);
    l.setEditorial("Planeta");
    l.setAñoEdicion(2035);
    l.setISBN("ABRFG-ER");
    l.setPrecio(190,90);

    System.out.println("---------- Datos del Libro ----------");
    System.out.println();
    System.out.println(l.toString());

  }

}