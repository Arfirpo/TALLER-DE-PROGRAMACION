package Practica4;

import java.text.DecimalFormat;

public abstract class Empleado{

  private String nombre;
  private double sueldoBasico;
  private int antiguedad;

  //Constructor
  
  public Empleado(){
  }

  public Empleado(String unNombre, double unSueldoBasico, int unaAntiguedad){
    this.setNombre(unNombre);
    this.setSueldoBasico(unSueldoBasico);
    this.setAntiguedad(unaAntiguedad);
  }

  //Setters

  public void setNombre(String unNombre){
    this.nombre = unNombre;
  }

  public void setSueldoBasico(double unSueldoBasico){
    this.sueldoBasico = unSueldoBasico;
  }

  public void setAntiguedad(int unaAntiguedad){
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
    if(pagarBono()) aux += this.getValorBono();
    return aux;
  };

  public abstract double calcularEfectividad();
  public abstract double getValorBono();
  public abstract boolean pagarBono();
  
  @Override
  public String toString(){
    DecimalFormat df = new DecimalFormat("0.00");
    DecimalFormat mf = new DecimalFormat("#,###.00");
    String aux = "Nombre: " + this.getNombre() + "\n"
                + "Sueldo a cobrar: $" + mf.format(this.calcularSueldoACobrar()) + "\n"
                + "Efectividad: " + df.format(this.calcularEfectividad()*100) + "%\n";
    return aux;
  }

}