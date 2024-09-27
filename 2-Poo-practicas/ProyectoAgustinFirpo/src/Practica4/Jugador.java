package Practica4;

public class Jugador extends Empleado{

  private int partidosJugados;
  private int golesAnotados;
  
  //Constructores

  public Jugador(){
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
  
  @Override
  public double calcularEfectividad(){
    return this.getPartidosJugados() > 0 ? (double) this.getGolesAnotados() / this.getPartidosJugados() : 0;
  };

  @Override
  public double getValorBono() {
    return this.getSueldoBasico();
  }

  @Override
  public boolean pagarBono() {
    return (this.calcularEfectividad() > 0.5);
  }

  //Objeto en Cadena de texto.
  @Override
  public String toString(){
    String aux = super.toString() 
            + "Partidos Jugados: " + this.getPartidosJugados() + "\n"
            + "Goles Anotados: " + this.getGolesAnotados() + "\n";
    return aux;
  }

}