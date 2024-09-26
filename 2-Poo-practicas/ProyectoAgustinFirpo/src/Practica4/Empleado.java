package Practica4;

public abstract class Empleado{

  private String nombre;
  private double sueldoBasico;
  private int antiguedad;

  //Constructor

  public Empleado(String unNombre, double unSueldoBasico, int unaAntiguedad){
    this.setNombre(unNombre);
    this.setSueldoBasico(unSueldoBasico);
    this.setAntiguedad(unaAntiguedad);
  }

  //Setters

  public void setNombre(unNombre){
    this.nombre = unNombre;
  }

  public void setSueldoBasico(unSueldoBasico){
    this.sueldoBasico = unSueldoBasico;
  }

  public void setAntiguedad(unaAntiguedad){
    this.antiguedad = unaAntiguedad;
  }

  //Getters

  public String getNombre(){
    return this.nombre ;
  }
  
  public double getSueldoBasico(){
    return this.sueldoBasico;
  }
  
  public int getAntiguedad(){
    return this.antiguedad;
  }
  
  //Otros Metodos

  public double calcularExtraAntiguedad(){
    return (this.getSueldoBasico() * 0.1) * this.getAntiguedad();
  }

  public double calcularSueldoACobrar(){
    double aux = this.getSueldoBasico() + this.calcularExtraAntiguedad();
    if(this.calcularEfectividad() > 0) aux += this.getSueldoBasico();
    return aux
  };

  public abstract double calcularSueldoACobrar();
  public abstract double calcularEfectividad();

  public String toString(){
    String aux = "Nombre: " + this.getNombre() + "\n"
                + "Sueldo a cobrar: " + this.calcularSueldoACobrar + "\n"
                + "Efectividad: " + this.calcularEfectividad() + "\n";
    return aux;
  }

}