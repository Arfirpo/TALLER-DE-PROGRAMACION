/*
A- Incluya la clase Triángulo a la jerarquía de figuras vista (carpeta tema4). 
Triángulo debe heredar de Figura todo lo que es común y definir su constructor y sus     atributos y métodos propios. 
Además debe redefinir el método toString.
*/

package Practica4;

public class Triangulo extends Figura {

    private double lado1;
    private double lado2;
    private double lado3;

    //Constructores
    public Triangulo(String unCR, String unCL) {
        super(unCR, unCL);
        this.lado1 = 0.0;
        this.lado2 = 0.0;
        this.lado3 = 0.0;
    }

    public Triangulo(double lado1, double lado2, double lado3, String colorRelleno, 
                     String colorLinea, String unCR, String unCL) {
        super(unCR, unCL);
        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 = lado3;
    }

    //Comportamientos:
    //Getters
    public double getLado1() {
        return this.lado1;
    }

    public double getLado2() {
        return this.lado2;
    }

    public double getLado3() {
        return this.lado3;
    }

    //Setters
    public void setLado1(double unLado) {
        this.lado1 = unLado;
    }

    public void setLado2(double unLado) {
        this.lado2 = unLado;
    }

    public void setLado3(double unLado) {
        this.lado3 = unLado;
    }

    //Calculo del Perimetro:
    @Override
    public double calcularPerimetro() {
        return lado1 + lado2 + lado3;
    }

    //Calculo del Area
    @Override
    public double calcularArea() {
        double semiP = (lado1 + lado2 + lado3) / 2;
        return Math.sqrt(semiP * (semiP - lado1) * (semiP - lado2) * (semiP - lado3));
    }

    //Objeto en cadena de texto
    @Override
    public String toString() {
        String aux = "Triangulo. " + "Lado 1: " + lado1 + " cm. " + "Lado 2: " + lado2 + " cm. " + "Lado 3: " + lado3 + " cm.";
        String aux2 = " Color de relleno: " + getColorRelleno() + ". Color de Linea: " + getColorLinea() + ".";
        return aux + aux2;
    }
}
