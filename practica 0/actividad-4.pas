program programaListasOrdenadas;

type
  lEnteros = ^nEnteros;

  nEnteros = record
    dato: integer;
    sig: lEnteros;
  end;

{modulos}

procedure insertarOrdenado(var l: lEnteros; e: integer);
var
  nue, ant, act: lEnteros;
begin
  new(nue);
  nue^.dato := e;
  act := l;
  ant := nil;
  while (act <> nil) and (act^.dato < e) do begin
    ant := act;
    act := act^.sig;
  end;
  if ant = nil then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure cargarListaOrdenada(var l: lEnteros);
var
  e: integer;
begin
  e := Random(150 - 100 + 1) + 100;
  while (e <> 120) do begin
    insertarOrdenado(l, e);
    e := Random(150 - 100 + 1) + 100;
  end;
end;

procedure imprimirLista(l: lEnteros);
begin
  while l <> nil do begin
    writeln('Numero: ', l^.dato);
    l := l^.sig;
  end;
end;

function buscarElementoOrdenado(l: lEnteros; num: integer): boolean;
begin
  buscarElementoOrdenado := false;
  while(l <> nil) and (l^.dato < num) do
    l := l^.sig;
  if (l <> nil) and (l^.dato = num) then
    buscarElementoOrdenado := true;
end;

{programa principal}
var
  pri: lEnteros;
  num: integer;
begin
  Randomize;
  pri := nil;
  cargarListaOrdenada(pri);
  imprimirLista(pri);
  write('Ingrese un numero a buscar: ');
  readln(num);
  write(buscarElementoOrdenado(pri,num));
end.

