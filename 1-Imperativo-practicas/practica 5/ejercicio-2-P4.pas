
{
   Una agencia dedicada a la venta de autos ha organizado su stock y tiene la información de los autos en venta. 
   Implementar un programa que:
      a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
      modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
	 i. Una estructura eficiente para la búsqueda por patente.
	 ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
	 almacenar todos juntos los autos pertenecientes a ella.
      b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
      cantidad de autos de dicha marca que posee la agencia.
      c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
      la cantidad de autos de dicha marca que posee la agencia.
      d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
      la información de los autos agrupados por año de fabricación.
      e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
      modelo del auto con dicha patente.
      f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
      modelo del auto con dicha patente.
}

Program ejercicio2P4;

Const 
  minAnioFab = 2010;
  maxAnioFab = 2018;

Type 
  str20 = string[20];
  rangoFab = minAnioFab..maxAnioFab;

  datosAuto = Record
    patente: integer;
    anioFab: rangoFab;
    modelo: str20;
  End;

  auto = Record
    marca: str20;
    info: datosAuto;
  End;

  lAutos = ^nAutos;
  nAutos = Record
    dato: datosAuto;
    sig: lAutos;
  End;

  marca = Record
    empresa: str20;
    autos: lAutos;
  End;

  arbPatentes = ^nArbPatentes;
  nArbPatentes = Record
    dato: auto;
    HI,HD: arbPatentes;
  End;

  arbMarcas = ^nArbMarcas;
  nArbMarcas = Record
    dato: marca;
    HI,HD: arbMarcas;
  End;


{modulos}

Procedure generarArboles(Var a: arbPatentes; Var b: arbMarcas);

Procedure leerAuto(Var a: auto);

Var 
  modelos: array [0..4] Of str20 = ('kronos', 'confort', 'spectre', 'chad', 'pepePlus');
  marcas: array [1..6] Of str20 = ('volskwagen', 'renault', 'ford', 'ferrari', 'lamborghini','MMM');
Begin
  With a Do
    Begin
      marca := marcas[1 + Random(6)];
      If (marca <> 'MMM') Then
        Begin
          info.anioFab := minAnioFab + Random(maxAnioFab - minAnioFab + 1);
          info.patente := 1 + Random(1001);
          info.modelo := modelos[Random(5)];
        End;
    End;
End;

Procedure generarArbolPatentes(Var a: arbPatentes; at: auto);
Begin
  If (a = Nil) Then
    Begin
      new(a);
      a^.dato := at;
      a^.HI := Nil;
      a^.HD := Nil;
    End
  Else If (at.info.patente < a^.dato.info.patente ) Then
         generarArbolPatentes(a^.HI,at)
  Else
    generarArbolPatentes(a^.HD,at);
End;

Procedure generarArbolMarcas(Var a: arbMarcas; at: auto);

Procedure agregarNodoLista(Var l: lAutos; a: datosAuto);

Var nue: lAutos;
Begin
  new(nue);
  nue^.dato := a;
  nue^.sig := l;
  l := nue;
End;

Procedure cargarDato(Var m: marca; at: auto);

Procedure inicializarLista(Var l: lAutos);
Begin
  l := Nil;
End;

Begin
  m.empresa := at.marca;
  inicializarLista(m.autos);
  agregarNodoLista(m.autos,at.info);
End;

Begin
  If (a = Nil) Then
    Begin
      new(a);
      cargarDato(a^.dato, at);
      a^.HI := Nil;
      a^.HD := Nil;
    End
  Else
    Begin
      If (at.marca = a^.dato.empresa) Then
        agregarNodoLista(a^.dato.autos,at.info)
      Else If (at.marca < a^.dato.empresa) Then
             generarArbolMarcas(a^.HI,at)
      Else
        generarArbolMarcas(a^.HD,at);
    End;
End;

Var at: auto;
Begin
  a := Nil;
  b := Nil;
  leerAuto(at);
  While (at.marca <> 'MMM') Do
    Begin
      generarArbolPatentes(a,at);
      generarArbolMarcas(b,at);
      leerAuto(at);
    End;
End;

Procedure imprimirArboles(a: arbPatentes; b: arbMarcas);


Procedure recorrerArbolPatentes(a: arbPatentes);

Procedure imprimirNodo(a: auto);
Begin
  writeln('| Patente: ',a.info.patente,' | Marca: ',a.marca,' | Modelo: ',a.info.modelo,' | A. de Fabricacion: ',a.info.anioFab,' |');
End;

Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then recorrerArbolPatentes(a^.HI);
      imprimirNodo(a^.dato);
      If (a^.HD <> Nil) Then recorrerArbolPatentes(a^.HD);
    End
  Else
    writeln('El arbol esta vacio.');
End;

Procedure recorrerArbolMarcas(a: arbMarcas);

Procedure imprimirNodo2(m: marca);

Procedure imprimirLista(l: lAutos);
Begin
  While (l <> Nil) Do
    Begin
      writeln('| Patente: ',l^.dato.patente,' | Modelo: ',l^.dato.modelo,' | A. de Fabricacion: ',l^.dato.anioFab,' |');
      l := l^.sig;
    End;
End;

Begin
  writeln('------------- Listado de autos de la Marca ',m.empresa,' ---------->');
  writeln;
  imprimirLista(m.autos);
  writeln;
End;

Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then recorrerArbolMarcas(a^.HI);
      imprimirNodo2(a^.dato);
      If (a^.HD <> Nil) Then recorrerArbolMarcas(a^.HD);
    End
  Else
    writeln('El arbol esta vacio.');
End;

Begin
  writeln;
  writeln('---------------- Arbol de Patentes ----------------');
  writeln;
  recorrerArbolPatentes(a);
  writeln;
  writeln('---------------- Arbol de Marcas ----------------');
  writeln;
  recorrerArbolMarcas(b);
  writeln
End;


{Programa Principal}

Var 
  a: arbPatentes;
  b: arbMarcas;
Begin
  Randomize;
  generarArboles(a,b);
  imprimirArboles(a,b);
End.
