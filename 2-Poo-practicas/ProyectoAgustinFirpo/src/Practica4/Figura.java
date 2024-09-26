package Practica4;

import java.text.DecimalFormat;

public abstract class Figura {
  
  private String colorRelleno;
  private String colorLinea;
  
  public Figura(String unCR, String unCL) {
    setColorRelleno(unCR);
    setColorLinea(unCL);
  }
  
  public String getColorRelleno() {
    return colorRelleno;
  }
  
  public void setColorRelleno(String unColor) {
    colorRelleno = unColor;
  }
  
  public String getColorLinea() {
    return colorLinea;
  }
  
  public void setColorLinea(String unColor) {
    colorLinea = unColor;
  }
  
  public void despintar() {
    setColorRelleno("blanco");
    setColorLinea("negra");
  }
  
  public abstract double calcularArea();
  
  public abstract double calcularPerimetro();
  
  @Override
  public String toString() {
    DecimalFormat df = new DecimalFormat("0.00");
    String aux = "Area: " + df.format(calcularArea()) + "\n"
            + "Perimetro " + df.format(calcularPerimetro()) + "\n" + "CR: " + getColorRelleno() + "\n"
            + "CL: " + getColorLinea() + "\n";
    return aux;
  }
}
