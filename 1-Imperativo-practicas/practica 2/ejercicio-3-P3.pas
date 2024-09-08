program ejercicio3P3;

const
  dimF = 20;
  min = 300;
  max = 1500;

type
  indice = 1..dimF;
  vEnteros = array[indice] of integer;

{modulos}
procedure cargarVector(var v: vEnteros);

  procedure cargarVectorR(var V: vEnteros; i: integer);
  var num: integer;
  begin
    num := min + Random(max - min + 1);
    if i < dimF then begin
      i := i + 1;
      v[i] := num;
      cargarVectorR(v, i);
    end;
  end;

var i: integer;
begin
  i := 0;
  cargarVectorR(v, i);
end;

procedure imprimirVector(v: vEnteros);

  procedure ImprimirVectorRecursivo(v: vEnteros; i: integer);
  begin
    if i <= dimF then begin
      write('Numero ', i, ': ');
      writeln(v[i]);
      ImprimirVectorRecursivo(v, i + 1);
    end;
  end;

var i: integer;
begin
  i := 1;
  ImprimirVectorRecursivo(v, i);
end;

Procedure ordenacionInsercion(var v: vEnteros);

Var 
  j, i, act: integer;
Begin
  For i := 2 To dimF Do
  Begin
    act := v[i];
    j := i - 1;
    While (j > 0) And (v[j] > act) Do
    Begin
      v[j + 1] := v[j];
      j := j - 1;
    End;
    v[j + 1] := act;
  End;
End;

function busquedaDicotomica(v: vEnteros; dato: integer): integer;

  procedure busquedaDicotomicaRecursiva(v: vEnteros; ini, fin: indice; dato: integer; var p: integer);
  var medio: integer;
  begin
    if (ini <= fin) then begin
      medio := (ini + fin) div 2;
      if (dato = v[medio]) then
        p := medio
      else begin
        if (dato < v[medio]) then
          busquedaDicotomicaRecursiva(v, ini, medio - 1, dato, p)
        else
          busquedaDicotomicaRecursiva(v, medio + 1, fin, dato, p);
      end;
    end
    else
      p := -1;
  end;

var 
  ini, fin: indice;
  p: integer;
begin
  ini := 1;
  fin := dimF;
  p := -1;  { Inicializamos p a -1 en caso de no encontrar el dato }
  busquedaDicotomicaRecursiva(v, ini, fin, dato, p);
  busquedaDicotomica := p;
end;

{Programa principal}
var 
  v: vEnteros;
  dato, posicion: integer;
begin
  Randomize;
  cargarVector(v);
  writeln;
  writeln('Vector de Numeros enteros: ');
  writeln;
  ImprimirVector(v);
  writeln;
  ordenacionInsercion(v);
  writeln;
  writeln('Vector Ordenado de menor a mayor: ');
  writeln;
  ImprimirVector(v);
  writeln;
  
  write('Ingresar valor a buscar: ');
  readln(dato);
  posicion := busquedaDicotomica(v, dato);

  if (posicion <> -1) then begin
    writeln;
    writeln('El valor se encuentra en el vector, en la posicion: ', posicion, '.');
  end
  else begin
    writeln;
    writeln('El valor no se encuentra en el vector.');
  end;
  
  writeln;
end.

