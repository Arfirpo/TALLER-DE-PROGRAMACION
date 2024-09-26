/*
1-
A- Incluya la clase Triángulo a la jerarquía de figuras vista (carpeta tema4). Triángulo debe heredar de Figura todo lo que es común y definir su constructor y sus     atributos y métodos propios. Además debe redefinir el método toString.
B- De igual manera, incluya la clase Círculo a la jerarquía de figuras.
C- Añada a la representación String el valor del perímetro. Piense ¿qué método toString debe modificar: el de cada subclase o el de Figura?
D- Añada el método despintar que establece los colores de la figura a línea “negra” y relleno “blanco”. Piense ¿dónde debe definir el método: en cada subclase o en Figura?
E- Realizar un programa que instancie un triángulo y un círculo. Muestre en consola la representación String de cada uno. Pruebe el funcionamiento del método despintar.
 */
package Practica4;

import java.text.DecimalFormat;

public class Circulo extends Figura {

    private double radio;

    //Constructores.
    public Circulo(String unCR, String unCL) {
        super(unCR, unCL);
    }

    public Circulo(double radio, String unCR, String unCL) {
        super(unCR, unCL);
        this.radio = radio;
    }

    //Comportamientos.
    //Setters
    public void setRadio(double unRadio) {
        if (unRadio >= 0) {
            this.radio = unRadio;
        } else {
            System.out.println("El radio no puede ser negativo.");
        }
    }

    //Getters
    public double getRadio() {
        return this.radio;
    }

    @Override
    public double calcularPerimetro() {
        return 2 * Math.PI * this.radio;
    }

    @Override
    public double calcularArea() {
        return Math.PI * (this.radio * this.radio);
    }

    @Override
    public String toString() {
      DecimalFormat df = new DecimalFormat("0.00");
        String aux = super.toString()
                + "Radio: " + df.format(this.radio) + "\n";
        return aux;
    }

}
