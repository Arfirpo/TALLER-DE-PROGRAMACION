/*
    3-A- Defina una clase para representar estantes. 
    Un estante almacena a lo sumo 20 libros.
    Implemente un constructor que permita iniciar el estante sin libros. 
    Provea métodos para:
    (i) devolver la cantidad de libros que almacenados 
    (ii) devolver si el estante está lleno
    (iii) agregar un libro al estante 
    (iv) devolver el libro con un título particular que se recibe.
    B- Realice un programa que instancie un estante. Cargue varios libros. 
        A partir del estante, busque e informe el autor del libro “Mujercitas”.
    C- Piense: ¿Qué modificaría en la clase definida para ahora permitir estantes que almacenen como máximo N libros? ¿Cómo instanciaría el estante?
 */
package Practica3;

import PaqueteLectura.Lector;

public class Ejercicio3P3_AF {

    public static void main(String[] args) {
        Estante est = new Estante();
        String tit;

        System.out.print("Ingrese titulo del Libro: ");
        tit = Lector.leerString();

        while (!est.estaLleno() && !tit.equalsIgnoreCase("zzz")) {

            //Crear Autor.
            Autor a = new Autor();
            System.out.print("Ingresar Nombre del Autor: ");
            a.setNombre(Lector.leerString());
            System.out.print("Ingresar Biografia del Autor: ");
            a.setBiografia(Lector.leerString());
            System.out.print("Ingresar Origen del Autor: ");
            a.setOrigen(Lector.leerString());

            //CrearLibro.
            Libro l = new Libro();
            l.setPrimerAutor(a);
            l.setTitulo(tit);
            System.out.print("Ingrese editorial del libro: ");
            l.setEditorial(Lector.leerString());
            System.out.print("Ingrese anio de edicion del libro: ");
            l.setAñoEdicion(Lector.leerInt());
            System.out.print("Ingrese precio del libro: ");
            l.setPrecio(Lector.leerDouble());
            System.out.print("Ingrese ISBN del libro: ");
            l.setISBN(Lector.leerString());

            est.agregarLibros(l);

            System.out.print("Ingrese titulo del Libro: ");
            tit = Lector.leerString();
        }

        Libro buscado = est.getLibro("mujercitas");
        if (buscado != null) {
            System.out.println("El autor del libro 'Mujercitas' es: " + buscado.getPrimerAutor().getNombre());
        } else {
            System.out.println("El libro 'Mujercitas' no se encuentra en el estante.");
        }
    }

}
