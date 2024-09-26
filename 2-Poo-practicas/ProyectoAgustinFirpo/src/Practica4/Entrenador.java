package Practica4;

public class Entrenador extends Empleado{

  private int campeonatosGanados;

  //Constructores

  public Entrenador(String unNombre, double unSueldoBasico, int unaAntiguedad){
    super(unNombre,unSueldoBasico,unaAntiguedad);
    this.setCampeonatosGanados(0);
  }

  public Entrenador(String unNombre, double unSueldoBasico, int unaAntiguedad, int campeonatosGanados){
    super(unNombre,unSueldoBasico,unaAntiguedad);
    this.setCampeonatosGanados(campeonatosGanados);
  }

  //Setters.

  public void setCampeonatosGanados(int campeonatosGanados){
    this.campeonatosGanados = campeonatosGanados;
  }

  public void actualizarCampeonatosGanados(){
    this.campeonatosGanados++;
  }
  
  public double calcularEfectividad(){
    
  }

  //Getters

  public int getCampeonatosGanados(){
    return this.campeonatosGanados;
  }


  //Otros metodos



  //Objeto en Cadena de texto

}