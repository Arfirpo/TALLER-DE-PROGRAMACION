package Practica4;

public class Entrenador extends Empleado {

  private int campeonatosGanados;

  //Constructores.
  public Entrenador() {
  }

  public Entrenador(String unNombre, double unSueldoBasico, int unaAntiguedad, int campeonatosGanados) {
    super(unNombre, unSueldoBasico, unaAntiguedad);
    this.setCampeonatosGanados(campeonatosGanados);
  }

  //Getters.
  public int getCampeonatosGanados() {
    return campeonatosGanados;
  }

  //Setters.
  public void setCampeonatosGanados(int campeonatosGanados) {
    this.campeonatosGanados = campeonatosGanados;
  }

  @Override
  public double calcularEfectividad() {
    return this.getAntiguedad() > 0 ? (double) this.getCampeonatosGanados() / this.getAntiguedad() : 0;
  }

  @Override
  public double getValorBono() {
    if (this.getCampeonatosGanados() >= 1 && this.getCampeonatosGanados() <= 4) {
      return 5000.00;
    } else if (this.getCampeonatosGanados() >= 5 && this.getCampeonatosGanados() <= 10) {
      return 30000.00;
    } else {
      return 50000.00;
    }
  }

  @Override
  public boolean pagarBono() {
    return this.getCampeonatosGanados() > 0;
  }

  @Override
  public String toString() {

    return super.toString()
            + "Campeonatos Ganados: " + this.getCampeonatosGanados() + "\n";
  }
}
