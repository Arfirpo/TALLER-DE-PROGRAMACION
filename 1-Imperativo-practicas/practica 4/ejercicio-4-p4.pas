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
  prestamo = record
    isbn: integer;
    codS: integer;
    fecha: fechas;
    diasPrestamo: integer;
  end;

  lPrestamos = ^nPrestamos;
  nPrestamos = record
    dato: prestamo;
    sig: lPrestamos;
  end;

  libro = record
    isbn: integer
    prestamos: lPrestamos;
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
    HI: arbPrestamos;
    HD: arbPrestamos;
  end;

procedure generarArboles(var a: arbPrestamos; var b: arbISBN);

  procedure leerPrestamos(var p: prestamo);
  begin
    with p do begin
      isbn := Random(101);
      if(isbn <> 0) then begin
        codS := 1 + Random(100);
        fecha.dia := 1 + Random(31);
        fecha.mes := 1 + Random(12);
        diasPrestamo := 1 + (365);
      end;
    end;
  end;

  procedure generarArbolPrestamos(var a: arbPrestamos; p: prestamo);
  begin
    if(a = nil) then begin
      a^.dato := p;
      a^.HI := nil;
      a^.HD := nil;
    end
    else begin
      
    end;
  end;

  procedure generarArbolLibros(var b: arbLibros; p: prestamo);

    procedure generarListaPrestamos(l: lPrestamos);

  begin
    if(b = nil) then begin
      generarListaPrestamos(b^.dato.prestamos,p);
      b^.HI := nil;
      b^.HD := nil;
    end
    else begin
      
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

{Programa principal}
var
  a: arbPrestamos;
  b: arbLibros;
begin
  Randomize;
  generarArboles(a,b);
end.
