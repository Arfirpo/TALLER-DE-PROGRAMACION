program ProgramaListas.pas;

type
	lEnteros = ^nEnteros;
	
	nEnteros = record
		dato: integer;
		sig: lEnteros;
	end;
	
{modulos}

procedure agregarAtras(var pri,ult: lEnteros; e: integer);
var
	nue: lEnteros;
begin
	new(nue);
	nue^.dato := e;
	nue^.sig := nil;
	if(pri = nil) then
		pri := nue
	else
		ult^.sig := nue;
	ult := nue;
end;

procedure cargarLista(var pri: lEnteros);
var
	ult: lEnteros;
	e: integer;
begin
	ult:= nil;
	e := Random(150 - 50 + 1) + 50;
	while (e <> 120) do begin
		agregarAtras(pri,ult,e);
		e := Random(150 - 50 + 1) + 50;
	end;
end;

procedure imprimirLista(l: lEnteros);
begin
	while (l <> nil) do begin
		writeln(l^.dato);
		l := l^.sig;
	end;
end;

function buscarElemento(l: lEnteros; num: integer):boolean;
var
	esta: boolean;
begin
	esta := false;
	while (l <> nil) and (not esta) do begin
		if(l^.dato = num) then esta := true;
		l := l^.sig;
	end;
	buscarElemento := esta;
end;

{programa principal}
var
	pri: lEnteros;

	num: integer;
begin
	Randomize;
	pri := nil;
	cargarLista(pri); {punto a}
	imprimirLista(pri); {punto b}

	write('Ingrese un numero: ');
	readln(num);
	write (buscarElemento(pri,num));
end.
