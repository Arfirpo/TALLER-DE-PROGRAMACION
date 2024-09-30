class Auto{
  
  private String nombreDueño;
  private String patente;
  
  // Constructores
  public Auto() {}
  
  public Auto(String unNombre, String unaPatente){
    this.nombreDueño = unNombre;
    this.patente = unaPatente;
  }
  
  public String getNombreDueño(){
    return nombreDueño;
  }
  
  public String getPatente(){
    return patente;
  }
  
  public void setNombreDueño(String unNombre){
    this.nombreDueño = unNombre;
  }
  
  public void setPatente(String unaPatente){
    this.patente = unaPatente;
  }
  
  @Override
  public String toString(){
    return "Auto. Patente: " + this.patente + " - Dueño: " + this.nombreDueño + ".\n";
  }
  
}

class Estacionamiento{
  
  private String nombre;
  private String direccion;
  private String horaApertura;
  private String horaCierre;
  private Auto[][] estacionamiento;
  private int cantAutos;
  private int pisos;
  private int plazas;
  
  // Constructores
  public Estacionamiento(String unNombre, String unaDireccion){
    this.nombre = unNombre;
    this.direccion = unaDireccion;
    this.horaApertura = "8:00";
    this.horaCierre = "21:00";
    this.pisos = 5;
    this.plazas = 10;
    this.estacionamiento = new Auto[pisos][plazas];
    this.cantAutos = 0;
  }
  
  public Estacionamiento(String unNombre, String unaDireccion, String horaIni, String horaFin,
                        int cantPisos, int cantPlazas){
    this.nombre = unNombre;
    this.direccion = unaDireccion;
    this.horaApertura = horaIni;
    this.horaCierre = horaFin;
    this.pisos = cantPisos;
    this.plazas = cantPlazas;
    this.estacionamiento = new Auto[pisos][plazas];
    this.cantAutos = 0;
  }
  
  public String getNombre(){
    return nombre;
  }
  
  public String getDireccion(){
    return direccion;
  }
  
  public String getHoraApertura(){
    return horaApertura;
  }
  
  public String getHoraCierre(){
    return horaCierre;
  }
  
  public int getCapacidadMaxima(){
    return this.pisos * this.plazas;
  }
  
  public void setNombre(String unNombre){
    this.nombre = unNombre;
  }
  
  public void setDireccion(String unaDireccion){
    this.direccion = unaDireccion;
  }
  
  public void setHoraApertura(String unaHoraAp){
    this.horaApertura = unaHoraAp;
  }
  
  public void setHoraCierre(String unaHoraCie){
    this.horaCierre = unaHoraCie;
  }
  
  public void ingresarAuto(Auto A, int X, int Y){
    if (!this.estaLleno() && !this.estaOcupado(X,Y)) {
      estacionamiento[X][Y] = A;
      this.cantAutos++;
    } else if(this.estaLleno()){
      System.out.println("El estacionamiento esta lleno.");
    } else{
      System.out.println("La plaza esta ocupada.");
    }
  }
  
  public boolean estaOcupado(int X, int Y) {
    if (X >= 0 && X < this.pisos && Y >= 0 && Y < this.plazas) {
        return estacionamiento[X][Y] != null;
    }
    return false;
  }
  
  public String mostrarUbicacion(String unaPatente){
    for (int i = 0; i < this.pisos; i++) {
      for (int j = 0; j < this.plazas; j++) {
        if (estacionamiento[i][j] != null && unaPatente.equalsIgnoreCase(estacionamiento[i][j].getPatente())) {
          return "El auto con patente " + unaPatente + " se encuentra estacionado en el piso " + (i + 1) + " - Plaza " + (j + 1);
        }
      }
    }
    return "Auto inexistente.";
  }
  
  public boolean estaLleno(){
    return this.cantAutos == this.getCapacidadMaxima();
  }
  
  public String mostrarEstacionamiento(){
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < this.pisos; i++) {
      sb.append("\n---Piso " + i + "---\n");
      for (int j = 0; j < this.plazas; j++) {
        if (estacionamiento[i][j] == null) {
          sb.append("\n-Plaza " + (j + 1) + " - Libre.\n");
        } else {
          sb.append("\n-Plaza " + (j + 1) + ": " + estacionamiento[i][j].toString());
        }
      }
    }
    return sb.toString();
  }
  
  public int cantAutosPorPlaza(int unaPlaza){
    int cantAutos = 0;
    for (int i = 0; i < this.pisos; i++) {
      if (estacionamiento[i][unaPlaza] != null) {
        cantAutos++;
      }
    }
    return cantAutos;
  }

  @Override
  public String toString(){
    return "Estacionamiento " + this.nombre + ".\n" 
           + "Direccion: " + this.direccion + "\n"
           + "Horario de Atencion: " + this.horaApertura + " a " + this.horaCierre + " Hs.\n" 
           + this.mostrarEstacionamiento();
  }
}

public class Main {
  public static void main(String[] args) {
    Estacionamiento e = new Estacionamiento("Pepito", "Calle Centenario", "08:00", "22:00", 3, 3);
    
    Auto a1 = new Auto("Pedro", "TXO-456");
    Auto a2 = new Auto("Pablo", "DDP-860");
    Auto a3 = new Auto("Jorge", "JKR-159");
    Auto a4 = new Auto("Maria", "QPD-951");
    Auto a5 = new Auto("Luisa", "RSB-761");
    Auto a6 = new Auto("Camila", "MSJ-167");
    
    e.ingresarAuto(a1, 0, 2);
    e.ingresarAuto(a2, 2, 2);
    e.ingresarAuto(a3, 1, 1);
    e.ingresarAuto(a4, 2, 0);
    e.ingresarAuto(a5, 0, 0);
    e.ingresarAuto(a6, 2, 1);
    
    System.out.println(e.toString());
    System.out.println("Cantidad de autos en la Plaza 1: " + e.cantAutosPorPlaza(1));
  }
}

