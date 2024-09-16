package Practica1;

import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio1P1_AF {

    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int dimF = 11;
        int [] tabla2 = new int[dimF];
        int i = 0;
        int v;
        v = GeneradorAleatorio.generarInt(30);
        while((v != 11) && (i < dimF)){
            tabla2[i] = v * 2;
            System.out.println("2x" + v + "=" + tabla2[i]);
            i++;
            v = GeneradorAleatorio.generarInt(30);
        }
    }
}

