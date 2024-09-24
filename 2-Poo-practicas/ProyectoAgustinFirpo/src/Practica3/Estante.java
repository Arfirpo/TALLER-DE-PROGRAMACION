/*
    3-A- Defina una clase para representar estantes. 
    Un estante almacena a lo sumo 20 libros.
    Implemente un constructor que permita iniciar el estante sin libros. 
    Provea métodos para:
    (i) devolver la cantidad de libros que se ecuentran almacenados 
    (ii) devolver si el estante está lleno
    (iii) agregar un libro al estante 
    (iv) devolver el libro con un título particular que se recibe.
    B- Realice un programa que instancie un estante. Cargue varios libros. A partir del estante, busque e informe el autor del libro “Mujercitas”.
    C- Piense: ¿Qué modificaría en la clase definida para ahora permitir estantes que almacenen como máximo N libros? ¿Cómo instanciaría el estante?
 */

package Practica3;


public class Estante {
    
    //Constante dimension fisica del estante
    private final int MAX_CAPACIDAD = 20;
    
    
    private final Libro[] estante;
    private int dimL_cantLibros;
    
    //Constructor.
    public Estante(){
        this.estante = new Libro[MAX_CAPACIDAD];
        this.dimL_cantLibros = 0;        
    }
    
    //Comportamientos

    //Setters
    
    //Agregar un libro al estante:
    public void agregarLibros(Libro unLibro) {
        if (this.dimL_cantLibros < MAX_CAPACIDAD) {
            this.estante[this.dimL_cantLibros] = unLibro;
            this.dimL_cantLibros++;
        } else{
            System.out.println("El estante esta lleno.");
        }
    }
    
    //Getters
    
    //Devolver si el estante está lleno:
    public boolean estaLleno(){
        return this.dimL_cantLibros == MAX_CAPACIDAD;
    }
    
    //Devolver la cantidad de libros que se ecuentran almacenados: 
    public int getCantidadLibros(){
        return this.dimL_cantLibros;
    }
    
    public void mostrarLibros(){
        for (int i = 0; i < this.dimL_cantLibros; i++) {
            System.out.println(this.estante[i]);
        }
    }
    
    //Devolver el libro con un título particular que se recibe:
    public Libro getLibro(String unTitulo) {
        int p = 0;
        while (p < this.dimL_cantLibros) {
            Libro libro = this.estante[p];
            if (unTitulo.equalsIgnoreCase(libro.getTitulo())) {
                return libro; //el return termina la funcion.
            } else {
                p++;
            }
        }
        
        return null;
    }
}

/*
    public class Estante {

        private Libro[] estante;
        private int capacidad;
        private int cantLibros;

        // Constructor que permite definir la capacidad
        
        public Estante(int capacidad) {
            this.capacidad = capacidad;
            this.estante = new Libro[this.capacidad];
            this.cantLibros = 0;        
        }

        // Constructor por defecto (capacidad 20 libros)
        public Estante() {
            this(20); // Llama al otro constructor con capacidad por defecto de 20
        }

        // Método para agregar un libro
        public void agregarLibros(Libro unLibro) {
            if (this.cantLibros < this.capacidad) {
                this.estante[this.cantLibros] = unLibro;
                this.cantLibros++;
            } else {
                System.out.println("El estante está lleno.");
            }
        }

        // Otros métodos (para devolver cantidad de libros, verificar si está lleno, etc.)
        public int getCantidadLibros() {
            return this.cantLibros;
        }

        public boolean estaLleno() {
            return this.cantLibros == this.capacidad;
        }

        public Libro getLibro(String unTitulo) {
            for (int i = 0; i < this.cantLibros; i++) {
                if (this.estante[i].getTitulo().equalsIgnoreCase(unTitulo)) {
                    return this.estante[i];
                }
            }
            return null; // Si no encuentra el libro, retorna null
        }
    }

*/
