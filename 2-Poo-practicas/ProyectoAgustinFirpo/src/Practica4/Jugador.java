package Practica4;

public class Jugador extends Empleado{

  private int partidosJugados = 0;
  private int golesAnotados = 0;
  
  //Constructores

  public Jugador(String unNombre, double unSueldoBasico, int unaAntiguedad){
    super(unNombre,unSueldoBasico,unaAntiguedad);
    this.setPartidosJugados(0);
    this.setGolesAnotados(0);
  }

  public Jugador(String unNombre, double unSueldoBasico, int unaAntiguedad, int partidosJugados,int golesAnotados){
    super(unNombre,unSueldoBasico,unaAntiguedad);
    this.setPartidosJugados(partidosJugados);
    this.setGolesAnotados(golesAnotados);
  }

  //Setters

  public void setPartidosJugados(int partidosJugados){
    this.partidosJugados = partidosJugados;
  }

  public void setGolesAnotados(int golesAnotados){
    this.golesAnotados = golesAnotados;
  }

  public void actualizarPartidosJugados(){
    this.partidosJugados++;
  }

  public void actualizarGolesAnotados(){
    this.golesAnotados++;
  }


  //Getters

  public int getPartidosJugados(){
    return this.partidosJugados;
  }

  public int getGolesAnotados(){
    return this.golesAnotados;
  }

  //Otros Metodos

  public double calcularEfectividad(){
    return this.getGolesAnotados() / this.getPartidosJugados();
  };

  //Objeto en Cadena de texto.

  public String toString(){
    String aux = super.toString() 
            + "Partidos Jugados: " + this.getPartidosJugados() + "\n"
            + "Goles Anotados: " + this.getGolesAnotados() + "\n";
    return aux;
  }

}