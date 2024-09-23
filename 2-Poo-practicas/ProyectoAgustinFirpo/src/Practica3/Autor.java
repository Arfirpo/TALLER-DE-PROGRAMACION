package Practica3;

public class Autor {

    private String nombre;
    private String biografia;
    private String origen;

    // Constructores

    // Constructor vacío

    public Autor() {
        
    }

    public Autor(String unNombre, String unaBiografia, String unOrigen) {
        this.nombre = unNombre;
        this.biografia = unaBiografia;
        this.origen = unOrigen;
    }

    // Comportamientos

    // Getters
    public String getNombre() {
        return nombre;
    }

    public String getBiografia() {
        return biografia;
    }

    public String getOrigen() {
        return origen;
    }

    // Setters
    public void setNombre(String unNombre) {
        this.nombre = unNombre;
    }

    public void setBiografia(String unaBiografia) {
        this.biografia = unaBiografia;
    }

    public void setOrigen(String unOrigen) {
        this.origen = unOrigen;
    }

    // Representación en cadena de texto
    @Override
    public String toString() {
        return nombre + ". Biografía: " + biografia + ". Origen: " + origen + ".";
    }
}
