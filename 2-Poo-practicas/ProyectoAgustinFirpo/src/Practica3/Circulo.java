/*
5-A- Definir una clase para representar círculos. Los círculos se caracterizan por su radio
(double), el color de relleno (String) y el color de línea (String).
Provea un constructor que reciba todos los datos necesarios para iniciar el objeto.
Provea métodos para:
- Devolver/modificar el valor de cada uno de sus atributos (métodos get y set)
- Calcular el perímetro y devolverlo (método calcularPerimetro)
- Calcular el área y devolverla (método calcularArea)
B- Realizar un programa que instancie un círculo, le cargue información leída de teclado e
informe en consola el perímetro y el área.
NOTA: la constante PI es Math.PI
*/

package Practica3;

public class Circulo{

  private double radio;
  private String colorRelleno;
  private String colorLinea;

  //Constructores.

  public Circulo(){
    this.radio = 0.0;
    this.colorRelleno = "sin color";
    this.colorLinea = "sin color";
  }

  public Circulo(double unRadio, String unColorRelleno, String unColorLinea){
    setRadio(unRadio);
    setColorRelleno(unColorRelleno);
    setColorLinea(unColorLinea);
  }

  //Comportamientos.

  //Setters

  public void setRadio(double unRadio){
    if (unRadio >= 0) {
      this.radio = unRadio;
    } else {
      System.out.println("El radio no puede ser negativo.");
    }
  }

  public void setColorRelleno(String unColorRelleno){
    this.colorRelleno = unColorRelleno;
  }

  public void setColorLinea(String unColorLinea){
    this.colorLinea = unColorLinea;
  }

  //Getters

  public double getRadio(){
    return this.radio;
  }
  public String getColorRelleno(){
    return this.colorRelleno;
  }
  public String getColorLinea(){
    return this.colorLinea;
  }

  public double calcularPerimetro(){
    return 2 * Math.PI * this.radio;
  }

  public double calcularArea(){
    return Math.PI * (this.radio * this.radio);
  }

  public String toString(){
    return "Radio: " + this.radio + "\n" + "Color de Relleno: " + this.colorRelleno + "\n" + "Color de Linea: " + this.colorLinea +  "\n";
  }

}