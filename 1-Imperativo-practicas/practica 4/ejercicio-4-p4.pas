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

program nombrePrograma;

type
  dias = 1..31;
  meses = 1..12;

  fechas = record
    dia: dias;
    mes: meses;
  end;

  prestamo2 = record
    codS: integer;
    fecha: fechas;
    diasPrestamo: integer;
  end;

  prestamo = record
    isbn: integer;
    datPrest: prestamo2
  end;

  lPrestamos = ^nPrestamos;
  nPrestamos = record
    dato: prestamo2;
    sig: lPrestamos;
  end;

  libro = record
    isbn: integer;
    prestamos: lPrestamos;
  end;

  libro2 = record
    isbn: integer;
    cantPrestamos: integer;
  end;

  arbPrestamos = ^nArbPrestamos;
  nArbPrestamos = record
    dato: prestamo;
    HI: arbPrestamos;
    HD: arbPrestamos;
  end;

  arbLibros = ^nArbLibros;
  nArbLibros = record
    dato: libro;
    HI: arbLibros;
    HD: arbLibros;
  end;

  lLibros = ^nLibros;
  nLibros = record
    dato: libro2;
    sig: lLibros;
  end;

procedure generarArboles(var a: arbPrestamos; var b: arbLibros);

  procedure leerPrestamos(var p: prestamo);
  begin
    with p do begin
      isbn := Random(51);
      if(isbn <> 0) then begin
        datPrest.codS := 1 + Random(50);
        datPrest.fecha.dia := 1 + Random(31);
        datPrest.fecha.mes := 1 + Random(12);
        datPrest.diasPrestamo := 1 + Random(365);
      end;
    end;
  end;

  procedure generarArbolPrestamos(var a: arbPrestamos; p: prestamo);
  begin
    if(a = nil) then begin
      new(a);
      a^.dato := p;
      a^.HI := nil;
      a^.HD := nil;
    end
    else begin
      if(a <> nil) then begin
        if(p.isbn < a^.dato.isbn) then generarArbolPrestamos(a^.HI,p)
        else generarArbolPrestamos(a^.HD,p);
      end;
    end;
  end;

  procedure generarArbolLibros(var b: arbLibros; p: prestamo);

    procedure inicializarLista(var l: lPrestamos);
    begin
      l := nil;
    end;

    procedure agregarNodoLista(var l: lPrestamos; p: prestamo2);
    var nue: lPrestamos;
    begin
      new(nue);
      nue^.dato := p;
      nue^.sig := l;
      l := nue;
    end;

  begin
    if(b = nil) then begin
      new(b);
      b^.dato.isbn := p.isbn;
      inicializarLista(b^.dato.prestamos);
      agregarNodoLista(b^.dato.prestamos,p.datPrest);
      b^.HI := nil;
      b^.HD := nil;
    end
    else begin
      if(p.isbn = b^.dato.isbn) then begin
        b^.dato.isbn := p.isbn;
        agregarNodoLista(b^.dato.prestamos,p.datPrest);
      end
      else begin
        if(p.isbn > b^.dato.isbn) then generarArbolLibros(b^.HD,p)
        else generarArbolLibros(b^.HI,p);
      end;
    end;
  end;

var p:prestamo;
begin
  a := nil;
  b := nil;
  leerPrestamos(p);
  while (p.isbn <> 0) do begin
    generarArbolPrestamos(a,p);
    generarArbolLibros(b,p);
    leerPrestamos(p);
  end;
end;

procedure imprimirArboles(a: arbPrestamos; b: arbLibros);

  procedure imprimirArbolPrestamos(a: arbPrestamos);
  begin
    if(a <> nil) then begin
      if(a^.HI <> nil) then imprimirArbolPrestamos(a^.HI);
      writeln('| ISBN del Libro: ',a^.dato.isbn,' | Nro. de Socio: ',a^.dato.datPrest.codS,' | Fecha de Prestamo: ',a^.dato.datPrest.fecha.dia,'/',a^.dato.datPrest.fecha.mes,' | Dias de Prestamo: ',a^.dato.datPrest.diasPrestamo);
      if(a^.HD <> nil) then imprimirArbolPrestamos(a^.HD);
    end;
  end;

  procedure imprimirArbolLibros(b: arbLibros);

  procedure imprimirPrestamos(l: lPrestamos);
  begin
    while(l <> nil) do begin
      writeln('| Nro. de Socio: ',l^.dato.codS,' | Fecha de Prestamo: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,' | Dias de Prestamo: ',l^.dato.diasPrestamo);
      l := l^.sig;
    end;
  end;

  begin
    if(b <> nil) then begin
      if(b^.HI <> nil) then imprimirArbolLibros(b^.HI);
      if(b^.dato.prestamos <> nil) then begin
        writeln('------------------------------------');
        writeln('ISBN Nro. ',b^.dato.isbn,' - Listado de prestamos: ');
        writeln('------------------------------------');
        writeln;
        imprimirPrestamos(b^.dato.prestamos);
        writeln;        
      end
      else begin
        writeln('------------------------------------------------------------');
        writeln('El libro con ISBN Nro. ',b^.dato.isbn,' no registra prestamos a la fecha.');
        writeln('------------------------------------------------------------');
        writeln;
      end;
      if(b^.HD <> nil) then imprimirArbolLibros(b^.HD);
    end;
  end;

begin
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
end;

procedure codigoLibroMasGrande(a: arbPrestamos);

  function CodLibroMax(a: arbPrestamos): integer;
begin
  if(a = nil) then
    CodLibroMax := 0
  else if(a^.HD = nil) then
    CodLibroMax := a^.dato.isbn
  else
    CodLibroMax := CodLibroMax(a^.HD);
end;

begin
  writeln('----------------------- Informar ISBN mas grande ----------------->');
  writeln;
  writeln('El ISBN mas grande es el Nro. ',CodLibroMax(a));
  writeln;
end;

procedure codigoLibroMasChico(b: arbLibros);

  function CodLibroMin(b: arbLibros): integer;
  begin
    if(b = nil) then
      CodLibroMin := 0
    else if(b^.HI = nil) then
      CodLibroMin := b^.dato.isbn
    else
      CodLibroMin := CodLibroMin(b^.HI);
  end;

begin
  writeln('----------------------- Informar ISBN mas chico ----------------->');
  writeln;
  writeln('El ISBN mas chico es el Nro. ',CodLibroMin(b));
  writeln;
end;

procedure cantPrestamosSocio(a: arbPrestamos);

  function sumaPrestamos(a: arbPrestamos; n: integer): integer;
  begin
    if( a <> nil) then begin
      if (n = a^.dato.datPrest.codS) then 
        sumaPrestamos := 1 + sumaPrestamos(a^.HI,n) + sumaPrestamos(a^.HD,n)
      else sumaPrestamos := sumaPrestamos(a^.HI,n) + sumaPrestamos(a^.HD,n);
    end
    else
      sumaPrestamos := 0;
  end;

var numSocio: integer; cant: integer;
begin
  cant := 0;
  writeln('----------------------- Informar Cantidad de Prestamos Por Nro. de Socio Seleccionado ----------------->');
  writeln;
  write('Ingrese Nro. de Socio: ');
  readln(numSocio);
  writeln;
  cant := sumaPrestamos(a,numSocio);
  if(cant > 0) then
    writeln('El socio Nro. ',numSocio,' realizo ',cant,' prestamos.')
  else
    writeln('El socio Nro. ',numSocio,' no existe.');
  writeln;
end;

procedure cantPrestamosSocio2(b: arbLibros);

  function sumaPrestamos2(b: arbLibros; n: integer): integer;

    function contadorPrestamos(l: lPrestamos; n: integer): integer;
    var contador: integer;
    begin
      contador := 0;
      while(l <> nil) do begin
        if(n = l^.dato.codS) then
          contador := contador + 1;
        l := l^.sig;
      end;
      contadorPrestamos := contador;
    end;

  begin
    if(b <> nil) then
        sumaPrestamos2 := contadorPrestamos(b^.dato.prestamos,n) + sumaPrestamos2(b^.HI,n) + sumaPrestamos2(b^.HD,n)
    else
      sumaPrestamos2 := 0;
  end;

var numSocio,cant: integer;
begin
  cant := 0;
  writeln('----------------------- Informar Cantidad de Prestamos Por Nro. de Socio Seleccionado II ----------------->');
  writeln;
  write('Ingrese Nro. de Socio: ');
  readln(numSocio);
  writeln;
  cant := sumaPrestamos2(b,numSocio);
  if(cant > 0) then
    writeln('El socio Nro. ',numSocio,' realizo ',cant,' prestamos.')
  else
    writeln('El socio Nro. ',numSocio,' no existe.');
  writeln;
end;

  procedure imprimirLista(l: lLibros);
  begin
    while(l <> nil) do begin
      writeLn;
      writeln('| ISBN Nro. ',l^.dato.isbn,' | Cantidad de veces Prestado: ',l^.dato.cantPrestamos,' |');
      writeLn;
      l := l^.sig;
    end;
  end;

{  f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
  ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
  que se prestó.}

procedure generarListaLibros(a: arbPrestamos);

  procedure recorrerArbol(a: arbPrestamos; var pri,ult: lLibros);

    procedure agregarNodoLista2(isbn: integer; var pri,ult: lLibros);
    var nue,act: lLibros;
    begin
      act := pri;
      while(act <> nil) and (isbn <> act^.dato.isbn) do
        act := act^.sig;
      if(act = nil) then begin
        new(nue);
        nue^.dato.isbn := isbn;
        nue^.dato.cantPrestamos := 1;
        nue^.sig := nil;
        if(pri = nil) then
          pri := nue
        else
          ult^.sig := nue;
        ult := nue;
      end
      else
        act^.dato.cantPrestamos := act^.dato.cantPrestamos + 1;
    end;

  begin
    if(a <> nil) then begin
      if(a^.HI <> nil) then recorrerArbol(a^.HI,pri,ult);
      agregarNodoLista2(a^.dato.isbn,pri,ult);
      if(a^.HD <> nil) then recorrerArbol(a^.HD,pri,ult);
    end;
  end;

var pri,ult: lLibros;
begin
  pri:= nil; ult := nil;
  recorrerArbol(a,pri,ult);
  writeLn;
  writeln('----------------------- Lista de Libros (Arbol de Prestamos) y cantidad de prestamos ----------------->');
  writeLn;
  imprimirLista(pri);
  writeLn;
end;

function conteoPrestamos(l: lPrestamos): integer;
begin
  conteoPrestamos := 0;
  while(l <> nil) do begin
    conteoPrestamos := conteoPrestamos + 1;
    l := l^.sig;
  end;
end;

procedure generarListaLibros2(b: arbLibros);

  procedure recorrerArbol2(b: arbLibros; var pri,ult: lLibros);

    procedure agregarNodoLista3(l: libro; var pri,ult: lLibros);

    var nue: lLibros;
    begin
      new(nue);
      nue^.dato.isbn := l.isbn;
      nue^.dato.cantPrestamos := conteoPrestamos(l.prestamos);
      if(pri = nil) then
        pri := nue
      else
        ult^.sig := nue;
      ult := nue;
    end;

  begin
    if(b <> nil) then begin
      if(b^.HI <> nil) then recorrerArbol2(b^.HI,pri,ult);
      agregarNodoLista3(b^.dato,pri,ult);
      if(b^.HD <> nil) then recorrerArbol2(b^.HD,pri,ult);
    end;
  end;

var pri,ult: lLibros;
begin
  pri := nil;
  ult := nil;
  recorrerArbol2(b,pri,ult);
  writeLn;
  writeln('----------------------- Lista de Libros (Arbol de Libros) y cantidad de prestamos ----------------->');
  writeLn;
  imprimirLista(pri);
  writeLn;
end;

procedure prestamosEntreRangos(a: arbPrestamos);

  function obtenerCantidadRangos(a: arbPrestamos; inf,sup: integer): integer;
  begin
    if(a <> nil) then begin
      if(a^.dato.isbn >= inf) and (a^.dato.isbn <= sup) then 
        obtenerCantidadRangos := 1 + obtenerCantidadRangos(a^.HI,inf,sup) + obtenerCantidadRangos(a^.HD,inf,sup)
      else if (a^.dato.isbn < inf) then 
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HD,inf,sup)
      else 
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HI,inf,sup);
    end
    else
      obtenerCantidadRangos := 0;
  end;

var num1,num2: integer;
begin
  writeLn;
  writeLn('------------------ Informar Cantidad de Prestamos entre rango de ISBN seleccionado (Arbol de Prestamos) ----------->');
  writeLn;
  repeat
    write('Ingrese un numero (mayor a 0): ');
    readln(num1);  
    write('Ingrese un numero (mayor a 0): ');
    readln(num2);
  until(num1 <> num2);
  writeLn;
  if(num1 < num2) then
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num1,num2))
  else
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num2,num1));
  writeLn;
end;

procedure prestamosEntreRangos2(a: arbLibros);

  function obtenerCantidadRangos(a: arbLibros; inf,sup: integer): integer;
  begin
    if(a <> nil) then begin
      if(a^.dato.isbn >= inf) and (a^.dato.isbn <= sup) then 
        obtenerCantidadRangos := conteoPrestamos(a^.dato.prestamos) + obtenerCantidadRangos(a^.HI,inf,sup) + obtenerCantidadRangos(a^.HD,inf,sup)
      else if (a^.dato.isbn < inf) then 
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HD,inf,sup)
      else 
        obtenerCantidadRangos := obtenerCantidadRangos(a^.HI,inf,sup);
    end
    else
      obtenerCantidadRangos := 0;
  end;

var num1,num2: integer;
begin
  writeLn;
  writeLn('------------------ Informar Cantidad de Prestamos entre rango de ISBN seleccionado (Arbol de Libros) ----------->');
  writeLn;
    repeat
      write('Ingrese un numero (mayor a 0): ');
      readln(num1);  
      write('Ingrese un numero (mayor a 0): ');
      readln(num2);
    until(num1 <> num2);
  writeLn;
  if(num1 < num2) then
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num1,num2))
  else
    writeln('La cantidad total de Prestamos efectuados a los ISBN del rango seleccionado es: ',obtenerCantidadRangos(a,num2,num1));
  writeLn;
end;

{Programa principal}
var
  a: arbPrestamos;
  b: arbLibros;
begin
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
end.
