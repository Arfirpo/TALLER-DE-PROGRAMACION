{
  Una oficina requiere el procesamiento de los reclamos de las personas. 
	De cada reclamo se ingresa código, DNI de la persona, año y tipo de reclamo. 
	El ingreso finaliza con el código de igual a 0. Se pide:
		a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
		se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
		b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
		reclamos efectuados por ese DNI.
		c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
		reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
		d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
		los reclamos realizados en el año recibido.
}
	
program ejercicio4P5;

const
	minDni = 1000;
	maxDni = 1100;
	minAnio = 1950;
	maxAnio = 2024;

type
	str20 = string[20];
	
	reclamo2 = record
		cod: integer;
		anioRec: integer;
		tipoR: str20;
	end;
	
	reclamo = record
		dniUsuario: longint;
		infoRec: reclamo2;
	end;
	
	lReclamos = ^nReclamos;
	nReclamos = record
		dato: reclamo2;
		sig: lReclamos;
	end;
	
	usuario = record
		dni: longint;
		cantReclamos: integer;
		reclamos: lReclamos;
	end;
	
	arbDni = ^nArbDni;
	nArbDni = record
		dato: usuario;
		HI,HD: arbDni;
	end;
	
	lCodigos = ^nCodigos;
	nCodigos = record
		dato: integer;
		sig: lCodigos;
	end;
	
{modulos}

procedure generarArbol(var a: arbDni);

	procedure leerReclamo(var r: reclamo);
	var tR: array[0..3] of str20 = ('precio','cortes','demora','otro');
	begin
		with r do begin
			infoRec.cod := Random(51);
			if (infoRec.cod <> 0) then begin
				dniUsuario := minDni + Random(maxDni - minDni +1);
				infoRec.anioRec := minAnio + Random(maxAnio - minAnio + 1);
				infoRec.tipoR := tR[Random(4)];				
			end;
		end;
	end;
	
	procedure agregarNodo(var a: arbDni; r: reclamo);
		
		procedure agregarReclamo(var l: lReclamos; r: reclamo2);
		var nue: lReclamos;
		begin
			new(nue);
			nue^.dato := r;
			nue^.sig := l;
			l := nue;
		end;
	
		procedure cargarDatos(var u: usuario; r: reclamo);
		begin
			u.dni := r.dniUsuario;
			u.cantReclamos := 1;
			u.reclamos := nil;
			agregarReclamo(u.reclamos,r.infoRec)
		end;
		
		procedure actualizarDatos(var u: usuario; r: reclamo2);		
		begin
			u.cantReclamos := u.cantReclamos + 1;
			agregarReclamo(u.reclamos,r);
		end;
		
	begin
		if(a = nil) then begin
			new(a);
			cargarDatos(a^.dato,r);
			a^.HI := nil;
			a^.HD := nil;
		end
		else if (r.dniUsuario = a^.dato.dni) then
			actualizarDatos(a^.dato,r.infoRec)
		else begin
			if(r.dniUsuario < a^.dato.dni) then
				agregarNodo(a^.HI,r)
			else
				agregarNodo(a^.HD,r);
		end;
	end;
	
	procedure imprimirArbol(a: arbDni);
	
		procedure imprimirNodo(u: usuario);
		
			procedure imprimirLista(l: lReclamos);
			begin
				while(l <> nil) do begin
					writeln('| Codigo de reclamo: ',l^.dato.cod,' | Anio del reclamo: ',l^.dato.anioRec,' | Tipo de Reclamo: ',l^.dato.tipoR,' |');
					l := l^.sig;
				end;
			end;
		
		begin
			writeln;
			writeln('| Dni del Usuario: ',u.dni,' | Cantidad de Reclamos: ',u.cantReclamos,' |'); 
			writeln;
			writeln('Lista de reclamos del usuario: ');
			writeln;
			imprimirLista(u.reclamos);
			writeln;
			writeln('--------------------------------------------------------------------------------');
		end;
	
	begin
		if(a <> nil) then begin
			imprimirArbol(a^.HI);
			imprimirNodo(a^.dato);
			imprimirArbol(a^.HD);
		end;
	end;
	
	
var r: reclamo;
begin
	a := nil;
	leerReclamo(r);
	while (r.infoRec.cod <> 0) do begin
		agregarNodo(a,r);
		leerReclamo(r);
	end;
	writeln('-------------------- Arbol de Usuarios (ordenado por DNI) --------------------');
	imprimirArbol(a);
	writeln;
end;

procedure buscarDni(a: arbDni);

	function cantRec(a: arbDni; num: longint): integer;
	begin
		if(a <> nil) then begin
			if (num = a^.dato.dni) then cantRec := a^.dato.cantReclamos
			else begin
				if (a^.dato.dni < num) then cantRec := cantRec(a^.HD,num)
				else cantRec := cantRec(a^.HI,num);
			end;
		end
		else cantRec := 0;
	end;

var num: longint;
begin
	writeln;
	writeln('-------------- Informar la cantidad de reclamos efectuados por un Dni seleccionado -------->');
	repeat
		writeln;
		write('Ingresar un numero: ');
		readln(num);
		writeln;
	until(num > 0);
	writeln;
	writeln('La cantidad de reclamos efectuados por el DNI Nro. ',num,' es: ',cantRec(a,num),'.');
	writeln;
end;

	procedure entreRangos(a: arbDni);
	
	function sumarReclamos(a: arbDni; inf,sup: longint): integer;
	begin
		if(a <> nil) then begin
			if(a^.dato.dni >= inf) and (a^.dato.dni <= sup) then
				sumarReclamos := a^.dato.cantReclamos + sumarReclamos(a^.HI,inf,sup) + sumarReclamos(a^.HD,inf,sup)
			else begin
				if(a^.dato.dni < inf) then sumarReclamos := sumarReclamos(a^.HD,inf,sup)
				else sumarReclamos := sumarReclamos(a^.HI,inf,sup);
			end;
		end
		else
			sumarReclamos := 0;
	end;
	
	
	var num1,num2: longint;
	begin
		writeln;
		writeln('-------------- Informar la cantidad de reclamos efectuados entre todos los dnis de un rango seleccionado -------->');
		repeat
			writeln;
			write('Ingresar un numero: ');
			readln(num1);
			writeln;
			write('Ingresar otro numero: ');
			readln(num2);
			writeln;
		until(num1 <> num2);
		writeln;
		if(num1 < num2) then
			writeln('La cantidad de reclamos efectuados en el rango seleccionado es: ',sumarReclamos(a,num1,num2),'.')
		else
			writeln('La cantidad de reclamos efectuado sen el rango seleccionado es: ',sumarReclamos(a,num2,num1),'.');
		writeln;
	end;
	
	{d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de los reclamos realizados en el año recibido.}
	procedure reclamosPorAnio(a: arbDni);
	
		procedure buscarEnLista(lRec: lReclamos; var lCod: lCodigos; anio: integer);
		
			procedure agregarCodigo(var l: lCodigos; codigo: integer);
			var nue: lCodigos;
			begin
				new(nue);
				nue^.dato := codigo;
				nue^.sig := l;
				l := nue;
			end;
		
		begin
			while(lRec <> nil) do begin
				if(lRec^.dato.anioRec = anio) then
					agregarCodigo(lCod,lRec^.dato.cod);
				lrec := lrec^.sig;
			end;
		end;
	
		procedure contadorReclamosAnual(a: arbDni; anio: integer; var l: lCodigos);
		begin
			if(a <> nil) then begin
				if(a^.HI <> nil) then contadorReclamosAnual(a^.HI,anio,l);
				buscarEnLista(a^.dato.reclamos,l,anio);
				if(a^.HD <> nil) then contadorReclamosAnual(a^.HD,anio,l);
			end
		end;
		
		var i: integer;
		procedure imprimirListaCodigos(l: lCodigos);
		begin
			i := 1;
			while(l <> nil) do begin
				writeln(i,'. Codigo del Reclamo: ',l^.dato);
				i := i + 1;
				l := l^.sig;
			end;
		end;
	
	var anio: integer; pri: lCodigos;
	begin
		writeln('-------------- Informar los codigos de reclamos efectuados segun anio seleccionado -------->');
		repeat
			pri := nil;
			writeln;
			repeat
				writeln;
				write('Ingresar un anio (2000 para finalizar): ');
				readln(anio);
				writeln;
			until (anio >= minAnio) and (anio <= maxAnio);
			contadorReclamosAnual(a,anio,pri);
			if(pri <> nil) then begin
				writeln('-------------------------------------------------');
				writeln('Lista de Reclamos efectuados en el anio ',anio,'.');
				writeln;
				imprimirListaCodigos(pri);
				writeln('-------------------------------------------------');
			end
			else writeln('No existen reclamos en el anio seleccionado.');
			writeln;
		until(anio = 2000);
	end;
	
{Programa Principal}

var a: arbDni;
BEGIN
	Randomize;
	generarArbol(a);
	buscarDni(a);
	entreRangos(a);
	reclamosPorAnio(a);
END.

