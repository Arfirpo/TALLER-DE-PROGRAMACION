package Practica2;

import java.text.DecimalFormat;

public class Persona {

  //Declaracion de estado
  private String nombre;
  private int DNI;
  private int edad;

  // Constructor 1 - con tres parametros
  public Persona(String unNombre, int unDNI, int unaEdad) {
    nombre = unNombre;
    DNI = unDNI;
    edad = unaEdad;
  }

  // Constructor 2 - vacio
  public Persona() {

  }
  //Comportamientos

  public boolean esMayor(int unaEdad) {
    if (edad > unaEdad) {
      return true;
    } else {
      return false;
    }
  }

  //Getters
  public int getDNI() {
    return DNI;
  }

  public int getEdad() {
    return edad;
  }

  public String getNombre() {
    return nombre;
  }

  //Setters
  public void setDNI(int unDNI) {
    DNI = unDNI;
  }

  public void setEdad(int unaEdad) {
    edad = unaEdad;
  }

  public void setNombre(String unNombre) {
    nombre = unNombre;
  }
  //To String

  @Override
  public String toString() {
    DecimalFormat mf = new DecimalFormat("#,###.00");
    String aux;
    aux = "Mi nombre es " + this.getNombre() + "\n"
            + "Mi DNI es " + mf.format(this.getDNI()) + "\n"
            + "Tengo " + this.getEdad() + " años.\n";
    return aux;
  }

}
