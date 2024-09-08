
{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. 
Implementar un programa con:
  a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
  los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
  ser eficientes para buscar por ISBN.
    i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
    insertarlos a la derecha.
    ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
    (prestar atención sobre los datos que se almacenan).
  b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
  grande.
  c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
  pequeño.
  d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
  módulo debe retornar la cantidad de préstamos realizados a dicho socio.
  e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
  módulo debe retornar la cantidad de préstamos realizados a dicho socio.
  f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
  ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
  que se prestó.
  g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
  ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
  que se prestó.
  h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
  i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
  módulo debe retornar la cantidad total de préstamos realizados a los ISBN
  comprendidos entre los dos valores recibidos (incluidos).
  j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
  módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
}

Program ejercicio4P4;

Type 
  dias = 1..31;
  meses = 1..12;

  fechas = Record
    dia: dias;
    mes: meses;
  End;

  prestamo2 = Record
    codS: integer;
    fecha: fechas;
    diasPrestamo: integer;
  End;

  prestamo = Record
    isbn: integer;
    datPrest: prestamo2
  End;

  lPrestamos = ^nPrestamos;
  nPrestamos = Record
    dato: prestamo2;
    sig: lPrestamos;
  End;

  libro = Record
    isbn: integer;
    prestamos: lPrestamos;
  End;

  libro2 = Record
    isbn: integer;
    cantPrestamos: integer;
  End;

  arbPrestamos = ^nArbPrestamos;
  nArbPrestamos = Record
    dato: prestamo;
    HI: arbPrestamos;
    HD: arbPrestamos;
  End;

  arbLibros = ^nArbLibros;
  nArbLibros = Record
    dato: libro;
    HI: arbLibros;
    HD: arbLibros;
  End;

  lLibros = ^nLibros;
  nLibros = Record
    dato: libro2;
    sig: lLibros;
  End;

Procedure generarArboles(Var a: arbPrestamos; Var b: arbLibros);

Procedure leerPrestamos(Var p: prestamo);
Begin
  With p Do
    Begin
      isbn := Random(51);
      If (isbn <> 0) Then
        Begin
          datPrest.codS := 1 + Random(50);
          datPrest.fecha.dia := 1 + Random(31);
          datPrest.fecha.mes := 1 + Random(12);
          datPrest.diasPrestamo := 1 + Random(365);
        End;
    End;
End;

Procedure generarArbolPrestamos(Var a: arbPrestamos; p: prestamo);
Begin
  If (a = Nil) Then
    Begin
      new(a);
      a^.dato := p;
      a^.HI := Nil;
      a^.HD := Nil;
    End
  Else
    Begin
      If (a <> Nil) Then
        Begin
          If (p.isbn < a^.dato.isbn) Then generarArbolPrestamos(a^.HI,p)
          Else generarArbolPrestamos(a^.HD,p);
        End;
    End;
End;

Procedure generarArbolLibros(Var b: arbLibros; p: prestamo);

Procedure inicializarLista(Var l: lPrestamos);
Begin
  l := Nil;
End;

Procedure agregarNodoLista(Var l: lPrestamos; p: prestamo2);

Var nue: lPrestamos;
Begin
  new(nue);
  nue^.dato := p;
  nue^.sig := l;
  l := nue;
End;

Begin
  If (b = Nil) Then
    Begin
      new(b);
      b^.dato.isbn := p.isbn;
      inicializarLista(b^.dato.prestamos);
      agregarNodoLista(b^.dato.prestamos,p.datPrest);
      b^.HI := Nil;
      b^.HD := Nil;
    End
  Else
    Begin
      If (p.isbn = b^.dato.isbn) Then
        Begin
          b^.dato.isbn := p.isbn;
          agregarNodoLista(b^.dato.prestamos,p.datPrest);
        End
      Else
        Begin
          If (p.isbn > b^.dato.isbn) Then generarArbolLibros(b^.HD,p)
          Else generarArbolLibros(b^.HI,p);
        End;
    End;
End;

Var p: prestamo;
Begin
  a := Nil;
  b := Nil;
  leerPrestamos(p);
  While (p.isbn <> 0) Do
    Begin
      generarArbolPrestamos(a,p);
      generarArbolLibros(b,p);
      leerPrestamos(p);
    End;
End;

Procedure imprimirArboles(a: arbPrestamos; b: arbLibros);

Procedure imprimirArbolPrestamos(a: arbPrestamos);
Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then imprimirArbolPrestamos(a^.HI);
      writeln('| ISBN del Libro: ',a^.dato.isbn,' | Nro. de Socio: ',a^.dato.datPrest.codS,' | Fecha de Prestamo: ',a^.dato.datPrest.fecha.dia,'/',a^.
              dato.datPrest.fecha.mes,' | Dias de Prestamo: ',a^.dato.datPrest.diasPrestamo);
      If (a^.HD <> Nil) Then imprimirArbolPrestamos(a^.HD);
    End;
End;

Procedure imprimirArbolLibros(b: arbLibros);

Procedure imprimirPrestamos(l: lPrestamos);
Begin
  While (l <> Nil) Do
    Begin
      writeln('| Nro. de Socio: ',l^.dato.codS,' | Fecha de Prestamo: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,' | Dias de Prestamo: ',l^.dato.
              diasPrestamo);
      l := l^.sig;
    End;
End;

Begin
  If (b <> Nil) Then
    Begin
      If (b^.HI <> Nil) Then imprimirArbolLibros(b^.HI);
      If (b^.dato.prestamos <> Nil) Then
        Begin
          writeln('------------------------------------');
          writeln('ISBN Nro. ',b^.dato.isbn,' - Listado de prestamos: ');
          writeln('------------------------------------');
          writeln;
          imprimirPrestamos(b^.dato.prestamos);
          writeln;
        End
      Else
        Begin
          writeln('------------------------------------------------------------');
          writeln('El libro con ISBN Nro. ',b^.dato.isbn,' no registra prestamos a la fecha.');
          writeln('------------------------------------------------------------');
          writeln;
        End;
      If (b^.HD <> Nil) Then imprimirArbolLibros(b^.HD);
    End;
End;

Begin
  writeln;
  writeln('------------------------------ ARBOL DE PRESTAMOS ------------------------------');
  writeln;
  writeln('----------------------- Informar prestamos ordenados por ISBN ----------------->');
  writeln;
  imprimirArbolPrestamos(a);
  writeln;
  writeln('     /////////////////////////////////////////////////////////////////////////////////');
  writeln;
  writeln('------------------------------ ARBOL DE LIBROS ------------------------------');
  writeln;
  writeln('----------------------- Informar Libros (y sus prestamos) ordenados por ISBN ----------------->');
  writeln;
  imprimirArbolLibros(b);
  writeln;
  writeln('     /////////////////////////////////////////////////////////////////////////////////');
  writeln;
End;

Procedure codigoLibroMasGrande(a: arbPrestamos);

Function CodLibroMax(a: arbPrestamos): integer;
Begin
  If (a = Nil) Then
    CodLibroMax := 0
  Else If (a^.HD = Nil) Then
         CodLibroMax := a^.dato.isbn
  Else
    CodLibroMax := CodLibroMax(a^.HD);
End;

Begin
  writeln('----------------------- Informar ISBN mas grande ----------------->');
  writeln;
  writeln('El ISBN mas grande es el Nro. ',CodLibroMax(a));
  writeln;
End;

Procedure codigoLibroMasChico(b: arbLibros);

Function CodLibroMin(b: arbLibros): integer;
Begin
  If (b = Nil) Then
    CodLibroMin := 0
  Else If (b^.HI = Nil) Then
         CodLibroMin := b^.dato.isbn
  Else
    CodLibroMin := CodLibroMin(b^.HI);
End;

Begin
  writeln('----------------------- Informar ISBN mas chico ----------------->');
  writeln;
  writeln('El ISBN mas chico es el Nro. ',CodLibroMin(b));
  writeln;
End;

Procedure cantPrestamosSocio(a: arbPrestamos);

Function sumaPrestamos(a: arbPrestamos; n: integer): integer;
Begin
  If ( a <> Nil) Then
    Begin
      If (n = a^.dato.datPrest.codS) Then
        sumaPrestamos := 1 + sumaPrestamos(a^.HI,n) + sumaPrestamos(a^.HD,n)
      Else sumaPrestamos := sumaPrestamos(a^.HI,n) + sumaPrestamos(a^.HD,n);
    End
  Else
    sumaPrestamos := 0;
End;

Var numSocio: integer;
  cant: integer;
Begin
  cant := 0;
  writeln('----------------------- Informar Cantidad de Prestamos Por Nro. de Socio Seleccionado ----------------->');
  writeln;
  write('Ingrese Nro. de Socio: ');
  readln(numSocio);
  writeln;
  cant := sumaPrestamos(a,numSocio);
  If (cant > 0) Then
    writeln('El socio Nro. ',numSocio,' realizo ',cant,' prestamos.')
  Else
    writeln('El socio Nro. ',numSocio,' no existe.');
  writeln;
End;

Procedure cantPrestamosSocio2(b: arbLibros);

Function sumaPrestamos2(b: arbLibros; n: integer): integer;

Function contadorPrestamos(l: lPrestamos; n: integer): integer;

Var contador: integer;
Begin
  contador := 0;
  While (l <> Nil) Do
    Begin
      If (n = l^.dato.codS) Then
        contador := contador + 1;
      l := l^.sig;
    End;
  contadorPrestamos := contador;
End;

Begin
  If (b <> Nil) Then
    sumaPrestamos2 := contadorPrestamos(b^.dato.prestamos,n) + sumaPrestamos2(b^.HI,n) + sumaPrestamos2(b^.HD,n)
  Else
    sumaPrestamos2 := 0;
End;

Var numSocio,cant: integer;
Begin
  cant := 0;
  writeln('----------------------- Informar Cantidad de Prestamos Por Nro. de Socio Seleccionado II ----------------->');
  writeln;
  write('Ingrese Nro. de Socio: ');
  readln(numSocio);
  writeln;
  cant := sumaPrestamos2(b,numSocio);
  If (cant > 0) Then
    writeln('El socio Nro. ',numSocio,' realizo ',cant,' prestamos.')
  Else
    writeln('El socio Nro. ',numSocio,' no existe.');
  writeln;
End;

Procedure imprimirLista(l: lLibros);
Begin
  While (l <> Nil) Do
    Begin
      writeLn;
      writeln('| ISBN Nro. ',l^.dato.isbn,' | Cantidad de veces Prestado: ',l^.dato.cantPrestamos,' |');
      writeLn;
      l := l^.sig;
    End;
End;


{  f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
  ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
  que se prestó.}

Procedure generarListaLibros(a: arbPrestamos);

Procedure recorrerArbol(a: arbPrestamos; Var pri,ult: lLibros);

Procedure agregarNodoLista2(isbn: integer; Var pri,ult: lLibros);

Var nue,act: lLibros;
Begin
  act := pri;
  While (act <> Nil) And (isbn <> act^.dato.isbn) Do
    act := act^.sig;
  If (act = Nil) Then
    Begin
      new(nue);
      nue^.dato.isbn := isbn;
      nue^.dato.cantPrestamos := 1;
      nue^.sig := Nil;
      If (pri = Nil) Then
        pri := nue
      Else
        ult^.sig := nue;
      ult := nue;
    End
  Else
    act^.dato.cantPrestamos := act^.dato.cantPrestamos + 1;
End;

Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then recorrerArbol(a^.HI,pri,ult);
      agregarNodoLista2(a^.dato.isbn,pri,ult);
      If (a^.HD <> Nil) Then recorrerArbol(a^.HD,pri,ult);
    End;
End;

Var pri,ult: lLibros;
Begin
  pri := Nil;
  ult := Nil;
  recorrerArbol(a,pri,ult);
  writeLn;
  writeln('----------------------- Lista de Libros (Arbol de Prestamos) y cantidad de prestamos ----------------->');
  writeLn;
  imprimirLista(pri);
  writeLn;
End;

Function conteoPrestamos(l: lPrestamos): integer;
Begin
  conteoPrestamos := 0;
  While (l <> Nil) Do
    Begin
      conteoPrestamos := conteoPrestamos + 1;
      l := l^.sig;
    End;
End;

Procedure generarListaLibros2(b: arbLibros);

Procedure recorrerArbol2(b: arbLibros; Var pri,ult: lLibros);

Procedure agregarNodoLista3(l: libro; Var pri,ult: lLibros);

Var nue: lLibros;
Begin
  new(nue);
  nue^.dato.isbn := l.isbn;
  nue^.dato.cantPrestamos := conteoPrestamos(l.prestamos);
  If (pri = Nil) Then
    pri := nue
  Else
    ult^.sig := nue;
  ult := nue;
End;

Begin
  If (b <> Nil) Then
    Begin
      If (b^.HI <> Nil) Then recorrerArbol2(b^.HI,pri,ult);
      agregarNodoLista3(b^.dato,pri,ult);
      If (b^.HD <> Nil) Then recorrerArbol2(b^.HD,pri,ult);
    End;
End;

Var pri,ult: lLibros;
Begin
  pri := Nil;
  ult := Nil;
  recorrerArbol2(b,pri,ult);
  writeLn;
  writeln('----------------------- Lista de Libros (Arbol de Libros) y cantidad de prestamos ----------------->');
  writeLn;
  imprimirLista(pri);
  writeLn;
End;

Procedure prestamosEntreRangos(a: arbPrestamos);

Function obtenerCantidadRangos(a: arbPrestamos; inf,sup: integer): integer;
Begin
  If (a <> Nil) Then
    Begin
      If (a^.dato.isbn >= inf) And (a^.dato.isbn <= sup) Then
        obtenerCantidadRangos := 1 + obtenerCantidadRangos(a^.HI,inf,sup) + obtenerCantidadRangos(a^.HD,inf,sup)
      Else If (a^.dato.isbn < inf) Then
             obtenerCantidadRangos := obtenerCantidadRangos(a^.HD,inf,sup)
      Else
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HI,inf,sup);
    End
  Else
    obtenerCantidadRangos := 0;
End;

Var num1,num2: integer;
Begin
  writeLn;
  writeLn('------------------ Informar Cantidad de Prestamos entre rango de ISBN seleccionado (Arbol de Prestamos) ----------->');
  writeLn;
  Repeat
    write('Ingrese un numero (mayor a 0): ');
    readln(num1);
    write('Ingrese un numero (mayor a 0): ');
    readln(num2);
  Until (num1 <> num2);
  writeLn;
  If (num1 < num2) Then
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num1,num2))
  Else
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num2,num1));
  writeLn;
End;

Procedure prestamosEntreRangos2(a: arbLibros);

Function obtenerCantidadRangos(a: arbLibros; inf,sup: integer): integer;
Begin
  If (a <> Nil) Then
    Begin
      If (a^.dato.isbn >= inf) And (a^.dato.isbn <= sup) Then
        obtenerCantidadRangos := conteoPrestamos(a^.dato.prestamos) + obtenerCantidadRangos(a^.HI,inf,sup) + obtenerCantidadRangos(a^.HD,inf,sup)
      Else If (a^.dato.isbn < inf) Then
             obtenerCantidadRangos := obtenerCantidadRangos(a^.HD,inf,sup)
      Else
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HI,inf,sup);
    End
  Else
    obtenerCantidadRangos := 0;
End;

Var num1,num2: integer;
Begin
  writeLn;
  writeLn('------------------ Informar Cantidad de Prestamos entre rango de ISBN seleccionado (Arbol de Libros) ----------->');
  writeLn;
  Repeat
    write('Ingrese un numero (mayor a 0): ');
    readln(num1);
    write('Ingrese un numero (mayor a 0): ');
    readln(num2);
  Until (num1 <> num2);
  writeLn;
  If (num1 < num2) Then
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num1,num2))
  Else
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num2,num1));
  writeLn;
End;

{Programa principal}

Var 
  a: arbPrestamos;
  b: arbLibros;
Begin
  Randomize;
  generarArboles(a,b);
  imprimirArboles(a,b);
  codigoLibroMasGrande(a);
  codigoLibroMasChico(b);
  cantPrestamosSocio(a);
  cantPrestamosSocio2(b);
  generarListaLibros(a);
  generarListaLibros2(b);
  prestamosEntreRangos(a);
  prestamosEntreRangos2(b);
End.
