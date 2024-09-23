public class triangulo {
    
    private double lado1;
    private double lado2;
    private double lado3;
    private String colorRelleno;
    private String colorLinea;
    
    //Constructores
    
    public triangulo(){
        
    }
    
    public triangulo(double unLado, double dosLado, double tresLado, String unColorRelleno, String unColorLinea){
        
        lado1 = unLado;
        lado2 = dosLado;
        lado3 = tresLado;
        colorRelleno = unColorRelleno;
        colorLinea = unColorLinea;
    }
    
    //Comportamientos:
    
    //Getters
    
    public double getLado1(){
        return this.lado1;
    }
    
    public double getLado2(){
        return this.lado2;
    }
    
    public double getLado3(){
        return this.lado3;
    }
    
    public String getColorRelleno(){
        return this.colorRelleno;
    }
    
    public String getColorLinea(){
        return this.colorLinea;
    }
    
    //Setters
    
    public void setLado1(double unLado){
        this.lado1 = unLado;
    }
    
    public void setLado2(double unLado){
        this.lado2 = unLado;
    }
    
    public void setLado3(double unLado){
        this.lado3 = unLado;
    }
    
    public void setColorRelleno(String unColorRelleno){
        this.colorRelleno = unColorRelleno;
    }
    
    public void setColorLinea(String unColorLinea){
        this.colorLinea = unColorLinea;
    }
    
    //Calculo del Perimetro:
    
    public double calcularPerimetro(){
      return lado1 + lado2 + lado3;
    }
    
    //Calculo del Area
    
    public double calcularArea(){
      double semiP = (lado1+lado2+lado3)/2;
      return Math.sqrt(semiP * (semiP-lado1) * (semiP-lado2) * (semiP-lado3));
    }
    
    //Cadena de texto
    
    public String toString(){
        String aux = "Triangulo. " + "Lado 1: " + lado1 + " cm. " + "Lado 2: " + lado2 +" cm. " + "Lado 3: " + lado3 +" cm.";
        String aux2 = " Color de relleno: " + colorRelleno + ". Color de Linea: " + colorLinea + ".";
        return aux + aux2;
    }
}