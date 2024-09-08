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
    datPrest: prestamo2;
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
      New(a);
      a^.dato := p;
      a^.HI := nil;
      a^.HD := nil;
    end
    else begin
      if(p.isbn < a^.dato.isbn) then generarArbolPrestamos(a^.HI, p)
      else generarArbolPrestamos(a^.HD, p);
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
      New(nue);
      nue^.dato := p;
      nue^.sig := l;
      l := nue;
    end;

  begin
    if(b = nil) then begin
      New(b);
      b^.dato.isbn := p.isbn;
      inicializarLista(b^.dato.prestamos);
      agregarNodoLista(b^.dato.prestamos, p.datPrest);
      b^.HI := nil;
      b^.HD := nil;
    end
    else begin
      if(p.isbn = b^.dato.isbn) then begin
        agregarNodoLista(b^.dato.prestamos, p.datPrest);
      end
      else begin
        if(p.isbn > b^.dato.isbn) then generarArbolLibros(b^.HD, p)
        else generarArbolLibros(b^.HI, p);
      end;
    end;
  end;

var p: prestamo;
begin
  a := nil;
  b := nil;
  leerPrestamos(p);
  while (p.isbn <> 0) do begin
    generarArbolPrestamos(a, p);
    generarArbolLibros(b, p);
    leerPrestamos(p);
  end;
end;

procedure imprimirArboles(a: arbPrestamos; b: arbLibros);

  procedure imprimirArbolPrestamos(a: arbPrestamos; var f: Text);
  begin
    if(a <> nil) then begin
      if(a^.HI <> nil) then imprimirArbolPrestamos(a^.HI, f);
      WriteLn(f, '| ISBN del Libro: ', a^.dato.isbn, ' | Nro. de Socio: ', a^.dato.datPrest.codS, ' | Fecha de Prestamo: ', a^.dato.datPrest.fecha.dia, '/', a^.dato.datPrest.fecha.mes, ' | Dias de Prestamo: ', a^.dato.datPrest.diasPrestamo);
      if(a^.HD <> nil) then imprimirArbolPrestamos(a^.HD, f);
    end;
  end;

  procedure imprimirArbolLibros(b: arbLibros; var f: Text);

    procedure imprimirPrestamos(l: lPrestamos; var f: Text);
    begin
      while(l <> nil) do begin
        WriteLn(f, '| Nro. de Socio: ', l^.dato.codS, ' | Fecha de Prestamo: ', l^.dato.fecha.dia, '/', l^.dato.fecha.mes, ' | Dias de Prestamo: ', l^.dato.diasPrestamo);
        l := l^.sig;
      end;
    end;

  begin
    if(b <> nil) then begin
      if(b^.HI <> nil) then imprimirArbolLibros(b^.HI, f);
      if(b^.dato.prestamos <> nil) then begin
        WriteLn(f, '------------------------------------');
        WriteLn(f, 'ISBN Nro. ', b^.dato.isbn, ' - Listado de prestamos: ');
        WriteLn(f, '------------------------------------');
        WriteLn(f);
        imprimirPrestamos(b^.dato.prestamos, f);
        WriteLn(f);
      end
      else begin
        WriteLn(f, '------------------------------------------------------------');
        WriteLn(f, 'El libro con ISBN Nro. ', b^.dato.isbn, ' no registra prestamos a la fecha.');
        WriteLn(f, '------------------------------------------------------------');
        WriteLn(f);
      end;
      if(b^.HD <> nil) then imprimirArbolLibros(b^.HD, f);
    end;
  end;

var
  f: Text;
begin
  Assign(f, 'arbolPrestamos.txt');
  Rewrite(f);
  
  WriteLn(f, '------------------------------ ARBOL DE PRESTAMOS ------------------------------');
  WriteLn(f, '----------------------- Informar prestamos ordenados por ISBN ----------------->');
  imprimirArbolPrestamos(a, f);
  
  Close(f);

  Assign(f, 'arbolLibros.txt');
  Rewrite(f);
  WriteLn(f, '------------------------------ ARBOL DE LIBROS ------------------------------');
  WriteLn(f, '----------------------- Informar Libros (y sus prestamos) ordenados por ISBN ----------------->');
  imprimirArbolLibros(b, f);
  
  Close(f);
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
  WriteLn('----------------------- Informar ISBN mas grande ----------------->');
  WriteLn('El ISBN mas grande es el Nro. ', CodLibroMax(a));
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
  WriteLn('----------------------- Informar ISBN mas chico ----------------->');
  WriteLn('El ISBN mas chico es el Nro. ', CodLibroMin(b));
end;

procedure cantPrestamosSocio(a: arbPrestamos);
var
  function sumaPrestamos(a: arbPrestamos; n: integer): integer;
  begin
    if(a <> nil) then begin
      if(n = a^.dato.datPrest.codS) then 
        sumaPrestamos := 1 + sumaPrestamos(a^.HI, n) + sumaPrestamos(a^.HD, n)
      else
        sumaPrestamos := sumaPrestamos(a^.HI, n) + sumaPrestamos(a^.HD, n);
    end
    else
      sumaPrestamos := 0;
  end;

var 
  numSocio: integer; 
  cant: integer;
begin
  cant := 0;
  WriteLn('----------------------- Informar Cantidad de Prestamos Por Nro. de Socio Seleccionado ----------------->');
  Write('Ingrese Nro. de Socio: ');
  ReadLn(numSocio);
  cant := sumaPrestamos(a, numSocio);
  if(cant > 0) then
    WriteLn('El socio Nro. ', numSocio, ' realizo ', cant, ' prestamos.')
  else
    WriteLn('El socio Nro. ', numSocio, ' no realizo prestamos.');
end;

procedure cantPrestamosSocio2(b: arbLibros);

  function contadorPrestamos(l: lPrestamos; n: integer): integer;
  begin
    if(l <> nil) then begin
      if(l^.dato.codS = n) then 
        contadorPrestamos := 1 + contadorPrestamos(l^.sig, n)
      else
        contadorPrestamos := contadorPrestamos(l^.sig, n);
    end
    else
      contadorPrestamos := 0;
  end;

  function sumaPrestamos2(b: arbLibros; n: integer): integer;
  begin
    if(b <> nil) then begin
      if(n = b^.dato.isbn) then 
        sumaPrestamos2 := contadorPrestamos(b^.dato.prestamos, n) + sumaPrestamos2(b^.HI, n) + sumaPrestamos2(b^.HD, n)
      else
        sumaPrestamos2 := sumaPrestamos2(b^.HI, n) + sumaPrestamos2(b^.HD, n);
    end
    else
      sumaPrestamos2 := 0;
  end;

var 
  numISBN: integer; 
  cant: integer;
begin
  cant := 0;
  WriteLn('----------------------- Informar Cantidad de Prestamos Por ISBN Seleccionado ----------------->');
  Write('Ingrese ISBN: ');
  ReadLn(numISBN);
  cant := sumaPrestamos2(b, numISBN);
  if(cant > 0) then
    WriteLn('El libro con ISBN Nro. ', numISBN, ' ha sido prestado ', cant, ' veces.')
  else
    WriteLn('El libro con ISBN Nro. ', numISBN, ' no ha sido prestado.');
end;

procedure generarListaLibros(a: arbPrestamos);

  procedure agregarNodoListaLibros(var l: lLibros; isbn: integer);
  var nue: lLibros;
  begin
    New(nue);
    nue^.dato.isbn := isbn;
    nue^.dato.cantPrestamos := 1;
    nue^.sig := l;
    l := nue;
  end;

  procedure actualizarListaLibros(var l: lLibros; isbn: integer);
  var
    aux: lLibros;
  begin
    aux := l;
    while(aux <> nil) do begin
      if(aux^.dato.isbn = isbn) then begin
        aux^.dato.cantPrestamos := aux^.dato.cantPrestamos + 1;
        Exit;
      end;
      aux := aux^.sig;
    end;
    agregarNodoListaLibros(l, isbn);
  end;

  procedure recorrerArbol(a: arbPrestamos; var l: lLibros);
  begin
    if(a <> nil) then begin
      actualizarListaLibros(l, a^.dato.isbn);
      recorrerArbol(a^.HI, l);
      recorrerArbol(a^.HD, l);
    end;
  end;

var
  l: lLibros;
  f: Text;
begin
  l := nil;
  recorrerArbol(a, l);
  Assign(f, 'listaLibros.txt');
  Rewrite(f);
  while(l <> nil) do begin
    WriteLn(f, 'ISBN: ', l^.dato.isbn, ' | Cantidad de veces Prestado: ', l^.dato.cantPrestamos);
    l := l^.sig;
  end;
  Close(f);
end;

procedure generarListaLibros2(b: arbLibros);

  procedure agregarNodoListaLibros2(var l: lLibros; isbn: integer);
  var nue: lLibros;
  begin
    New(nue);
    nue^.dato.isbn := isbn;
    nue^.dato.cantPrestamos := 1;
    nue^.sig := l;
    l := nue;
  end;

  procedure actualizarListaLibros2(var l: lLibros; isbn: integer);
  var
    aux: lLibros;
  begin
    aux := l;
    while(aux <> nil) do begin
      if(aux^.dato.isbn = isbn) then begin
        aux^.dato.cantPrestamos := aux^.dato.cantPrestamos + 1;
        Exit;
      end;
      aux := aux^.sig;
    end;
    agregarNodoListaLibros2(l, isbn);
  end;

  procedure recorrerArbol2(b: arbLibros; var l: lLibros);
  begin
    if(b <> nil) then begin
      actualizarListaLibros2(l, b^.dato.isbn);
      recorrerArbol2(b^.HI, l);
      recorrerArbol2(b^.HD, l);
    end;
  end;

var
  l: lLibros;
  f: Text;
begin
  l := nil;
  recorrerArbol2(b, l);
  Assign(f, 'listaLibros2.txt');
  Rewrite(f);
  while(l <> nil) do begin
    WriteLn(f, 'ISBN: ', l^.dato.isbn, ' | Cantidad de veces Prestado: ', l^.dato.cantPrestamos);
    l := l^.sig;
  end;
  Close(f);
end;

procedure prestamosEntreRangos(a: arbPrestamos);
var
  min, max: integer;

  function prestamosEnRango(a: arbPrestamos; min, max: integer): integer;
  begin
    if(a <> nil) then begin
      if(a^.dato.isbn >= min) and (a^.dato.isbn <= max) then 
        prestamosEnRango := 1 + prestamosEnRango(a^.HI, min, max) + prestamosEnRango(a^.HD, min, max)
      else
        prestamosEnRango := prestamosEnRango(a^.HI, min, max) + prestamosEnRango(a^.HD, min, max);
    end
    else
      prestamosEnRango := 0;
  end;

begin
  WriteLn('----------------------- Informar Cantidad de Prestamos en Rango de ISBN ----------------->');
  Write('Ingrese ISBN mínimo: ');
  ReadLn(min);
  Write('Ingrese ISBN máximo: ');
  ReadLn(max);
  WriteLn('La cantidad de prestamos entre ', min, ' y ', max, ' es: ', prestamosEnRango(a, min, max));
end;

procedure prestamosEntreRangos2(b: arbLibros);
var
  min, max: integer;

  function prestamosEnRango2(b: arbLibros; min, max: integer): integer;
  begin
    if(b <> nil) then begin
      if(b^.dato.isbn >= min) and (b^.dato.isbn <= max) then 
        prestamosEnRango2 := 1 + prestamosEnRango2(b^.HI, min, max) + prestamosEnRango2(b^.HD, min, max)
      else
        prestamosEnRango2 := prestamosEnRango2(b^.HI, min, max) + prestamosEnRango2(b^.HD, min, max);
    end
    else
      prestamosEnRango2 := 0;
  end;

begin
  WriteLn('----------------------- Informar Cantidad de Prestamos en Rango de ISBN en el Arbol de Libros ----------------->');
  Write('Ingrese ISBN mínimo: ');
  ReadLn(min);
  Write('Ingrese ISBN máximo: ');
  ReadLn(max);
  WriteLn('La cantidad de prestamos entre ', min, ' y ', max, ' es: ', prestamosEnRango2(b, min, max));
end;

var
  a: arbPrestamos;
  b: arbLibros;
begin
  Randomize;
  generarArboles(a, b);
  
  // Guardar árboles y listas en archivos de texto
  imprimirArboles(a, b);
  
  generarListaLibros(a);
  generarListaLibros2(b);
  
  // Imprimir y otras operaciones
  codigoLibroMasGrande(a);
  codigoLibroMasChico(b);
  cantPrestamosSocio(a);
  cantPrestamosSocio2(b);
  prestamosEntreRangos(a);
  prestamosEntreRangos2(b);
end.
