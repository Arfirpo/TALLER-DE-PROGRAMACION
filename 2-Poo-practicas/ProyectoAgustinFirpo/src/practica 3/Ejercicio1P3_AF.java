public class Main {
  
  public static void main(String args[]) {
    triangulo t = new triangulo(12,12,12,"rojo","verde");
    System.out.println(t.toString());
    System.out.println("El perimetro del triangulo es: " + t.calcularPerimetro());
    System.out.printf("El Area del triangulo es: %.2f\n", t.calcularArea());
  }
}