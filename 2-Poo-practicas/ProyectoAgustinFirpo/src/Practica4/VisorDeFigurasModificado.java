
package Practica4;

public class VisorDeFigurasModificado {

   private int guardadas;

   private int capacidadMaxima = 5;

   private Figura[] vectorFiguras;
   
   
   //COnstructores.

   public VisorDeFigurasModificado() {

      this.guardadas = 0;

      this.vectorFiguras = new Figura[capacidadMaxima];

   }

   public VisorDeFigurasModificado(int dimF) {

      this.capacidadMaxima = dimF;

      this.vectorFiguras = new Figura[dimF];

      this.guardadas = 0;

   }
   
   //Comportamientos.

   public void guardar(Figura f) {

      if (this.quedaEspacio()) {

         vectorFiguras[this.getGuardadas()] = f;

         this.guardadas++;

      }

   }

   public boolean quedaEspacio() {

      return this.getGuardadas() < this.capacidadMaxima;

   }

   public void mostrar() {

      for (int i = 0; i < this.getGuardadas(); i++) {

         System.out.println(vectorFiguras[i]);

      }

   }

   public int getGuardadas() {

      return guardadas;

   }

}
