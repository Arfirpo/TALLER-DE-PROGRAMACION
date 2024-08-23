program ProgramaListas.pas;


type
	lEnteros = ^nEnteros;
	
	nEnteros = record
		dato: integer;
		sig: lEnteros;
	end;
	
{modulos}
procedure cargarLista(var l: lEnteros; e: integer);
var
	nue: lEnteros;
begin
	new(nue);
	nue^.dato := e;
	nue^.sig := l;
	l:= nue;
end;

procedure imprimirLista(l: lEnteros);
begin
	while (l <> nil) do begin
		writeln(l^.dato);
		l := l^.sig;
	end;
end;

{programa principal}
var
	pri: lEnteros;
	e: integer;
begin
	Randomize;
	pri := nil;
	e := Random(150 - 50 + 1) + 50;
	while (e <> 120) do begin
		cargarLista(pri,e);
		e := Random(150 - 50 + 1) + 50;
	end;
	imprimirLista(pri);
end.

	

