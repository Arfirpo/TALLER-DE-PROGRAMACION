package Practica3;

public class Libro {

    private String titulo;
    private Autor primerAutor; 
    private String editorial;
    private int añoEdicion;
    private String ISBN; 
    private double precio;
    
    // Constructores
    public Libro(String unTitulo, String unaEditorial, int unAñoEdicion, Autor unPrimerAutor, String unISBN, double unPrecio) {
        this.titulo = unTitulo;
        this.editorial = unaEditorial; 
        this.añoEdicion = unAñoEdicion;
        this.primerAutor = unPrimerAutor;
        this.ISBN = unISBN;
        this.precio = unPrecio;
    }
    
    public Libro(String unTitulo, String unaEditorial, Autor unPrimerAutor, String unISBN) {
        this.titulo = unTitulo;
        this.editorial = unaEditorial; 
        this.añoEdicion = 2015; // Valor por defecto
        this.primerAutor = unPrimerAutor;
        this.ISBN = unISBN;
        this.precio = 100; // Valor por defecto
    }
    
    public Libro() {
        // Constructor vacío
    }
    
    // Getters
    public String getTitulo() {
        return titulo;
    }

    public String getEditorial() {
        return editorial;
    }

    public int getAñoEdicion() {
        return añoEdicion;
    }

    public Autor getPrimerAutor() {
        return primerAutor;
    } 

    public String getISBN() {
        return ISBN;
    } 

    public double getPrecio() {
        return precio;
    }

    // Setters
    public void setTitulo(String unTitulo) {
        this.titulo = unTitulo;
    }

    public void setEditorial(String unaEditorial) {
        this.editorial = unaEditorial;
    }

    public void setAñoEdicion(int unAñoEdicion) {
        this.añoEdicion = unAñoEdicion;
    }

    public void setPrimerAutor(Autor unPrimerAutor) {
        this.primerAutor = unPrimerAutor;
    }

    public void setISBN(String unISBN) {
        this.ISBN = unISBN;
    }

    public void setPrecio(double unPrecio) {
        this.precio = unPrecio;
    }

    @Override
    public String toString() {
        return titulo + " por " + primerAutor.getNombre() + " - Anio: " + añoEdicion + " - ISBN: " + ISBN + " - Precio: $" + precio;
    }
}
