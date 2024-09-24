/*
  Un hotel posee N habitaciones. De cada habitación conoce costo por noche, si está ocupada y, en caso de estarlo, guarda el cliente que la reservó (nombre, DNI y edad).
    (i) Genere las clases necesarias. Para cada una provea métodos getters/setters adecuados.
    (ii) Implemente los constructores necesarios para iniciar: los clientes a partir de nombre, DNI, edad; el hotel para N habitaciones, cada una desocupada y con costo aleatorio e/ 2000 y 8000.
    (iii) Implemente en las clases que corresponda todos los métodos necesarios para:
    - Ingresar un cliente C en la habitación número X. Asuma que X es válido (es decir, está en el rango 1..N) y que la habitación está libre.
    - Aumentar el precio de todas las habitaciones en un monto recibido.
    - Obtener la representación String del hotel, siguiendo el formato: 
      {Habitación 1: costo, libre u ocupada, información del cliente si está ocupada}
  …   {Habitación N: costo, libre u ocupada, información del cliente si está ocupada} 
  NOTAS: Reúse la clase Persona. Para cada método solicitado piense a qué clase debe delegar la responsabilidad de la operación.
*/
package Practica3;

public class Hotel{

  //Variables de instanciacion

  private Habitacion [] hotel; //v.i. - vector de habitaciones.
  private int capacidadHotel; // v.i. - dimension fisica del vector de habitaciones.
  private int ocupacionActual; // v.i. - dimension logica del vector de habitaciones

  //constructor

  public Hotel(int unaCapacidad){
    this.capacidadHotel = unaCapacidad
    this.hotel = new Habitacion[this.capacidadHotel];
    for(int i=0; i<this.capacidadHotel;i++){
      Habitacion habitacion = this.hotel[i];
      habitacion.setOcupacion(false);
    }
    this.ocupacionActual = 0;
  }

  //comportamiento

  //Getters

  public int getCapacidadHotel(){
    return this.capacidadHotel;
  }

  public int getOcupacionActual(){
    return this.ocupacionActual;
  }

  public void mostrarHotel(){
    for(int i = 0; i< this.ocupacionActual; i++){
      Habitacion habitacion = this.hotel[i];
      System.out.print("Habitacion Nro. " + (i+1) + " | Costo: " + habitacion.getPrecio() + " | Estado: " + habitacion.getEstadoOcupacion() + " | ");
      if(!Habitacion.estaLibre())
        System.out.print("por el cliente: " + habitacion.getHuesped().toString());
    }

  //Setters.
  
  //Agregar una Habitacion al Hotel.
  public void agregarHabitacion(Habitacion unaHabitacion){
    if(this.ocupacionActual < this.capacidadHotel){
      if(this.hotel[])
      this.hotel[this.ocupacionActual] = unaHabitacion;
      this.ocupacionActual++;
    } else{
      System.out.println("El Hotel posee todas sus habitaciones ocupadas.");
    }
  }

  public void aumentarPrecio(double unMonto){
    for(int i=0;i<this.ocupacionActual;i++){
      Habitacion habitacion = this.hotel[i];
      habitacion.setCostoNoche(habitacion.getCostoNoche() + unMonto);
    }
  }

  }
}