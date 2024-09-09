
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
  
  lAniosFab = ^nAniosFab;
  nAniosFab = record
   dato: auto;
   sig: lAniosFab;
  end;


{modulos}

Procedure generarArboles(Var a: arbPatentes; Var b: arbMarcas);

Procedure leerAuto(Var a: auto);

Var 
  modelos: array [0..4] Of str20 = ('kronos', 'confort', 'spectre', 'chad', 'pepePlus');
  marcas: array [1..6] Of str20 = ('volkswagen', 'renault', 'ford', 'ferrari', 'lamborghini','MMM');
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

Procedure imprimirNodo(a: auto);
Begin
  writeln('| Patente: ',a.info.patente,' | Marca: ',a.marca,' | Modelo: ',a.info.modelo,' | A. de Fabricacion: ',a.info.anioFab,' |');
End;

Procedure imprimirArboles(a: arbPatentes; b: arbMarcas);


Procedure recorrerArbolPatentes(a: arbPatentes);

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

procedure contadorAutosPorMarca(a: arbPatentes);

   function contador(a: arbPatentes; mrc: str20): integer;
   begin
      if(a = nil) then
	 contador := 0
      else if  (mrc = a^.dato.marca) then contador := 1 + contador(a^.HI,mrc) + contador(a^.HD,mrc)
      else contador := contador(a^.HI,mrc) + contador(a^.HD,mrc);
   end;
   
var mrc: str20;
begin
   writeln;
   writeln('--------------------- Cantidad de Autos por Marca (Arbol de Patentes) ------------------>');
   writeln;
   repeat
      writeln;
      write('Ingrese una marca: ');
      readln(mrc);
      writeln;      
   until ((mrc = 'volkswagen') or (mrc ='renault') or (mrc = 'ford') or (mrc = 'ferrari') or (mrc = 'lamborghini'));
   writeln;
   writeln('La concesionaria tiene ',contador(a,mrc),' autos de la marca ',mrc);
   writeln;
end;

procedure contadorAutosPorMarca2(a: arbMarcas);
   
   function recorrerArbolMarcas(a: arbMarcas; mrc: str20): integer;
   
      function contadorLista(l: lAutos): integer;
      begin
	 contadorLista := 0;
	 while(l <> nil) do begin
	    contadorLista := contadorLista + 1;
	    l := l^.sig;
	 end;
      end;
      
   begin
      if(a = nil) then 
	 recorrerArbolMarcas := 0
      else if(mrc = a^.dato.empresa) then 
	 recorrerArbolMarcas := contadorLista(a^.dato.autos) + recorrerArbolMarcas(a^.HI,mrc) + recorrerArbolMarcas(a^.HD,mrc)
      else 
	 recorrerArbolMarcas := recorrerArbolMarcas(a^.HI,mrc) + recorrerArbolMarcas(a^.HD,mrc);
   end;
      

var mrc: str20;
begin
   writeln;
   writeln('--------------------- Cantidad de Autos por Marca (Arbol de Marcas) ------------------>');
   writeln;
   repeat
      writeln;
      write('Ingrese una marca: ');
      readln(mrc);
      writeln;      
   until ((mrc = 'volkswagen') or (mrc ='renault') or (mrc = 'ford') or (mrc = 'ferrari') or (mrc = 'lamborghini'));
   writeln;
   writeln('La concesionaria tiene ',recorrerArbolMarcas(a,mrc),' autos de la marca ',mrc);
   writeln;
end;

procedure generarListaPorAnioFab(a: arbPatentes);

   procedure recorrerArbolPatentes2(a: arbPatentes; var l: lAniosFab);
   
      procedure insertarOrdenado(var l: lAniosFab; a: auto);
      var nue,ant,act: lAniosFab;
      begin
	 new(nue);
	 nue^.dato := a;
	 ant := l;
	 act := l;
	 while(act <> nil) and (a.info.anioFab > act^.dato.info.anioFab) do begin
	    ant := act;
	    act := act^.sig;
	 end;
	 if(act = ant) then
	    l := nue
	 else
	    ant^.sig := nue;
	 nue^.sig := act;
      end;
   
   begin
      if(a <> nil) then begin
	 if(a^.HI <> nil) then recorrerArbolPatentes2(a^.HI,l);
	 insertarOrdenado(l,a^.dato);
	 if(a^.HD <> nil) then recorrerArbolPatentes2(a^.HD,l);
      end;
   end;
   
   procedure imprimirListaAnios(l: lAniosFab);
   begin
      while(l <> nil) do begin
	 imprimirNodo(l^.dato);
	 writeln;
	 l := l^.sig;
      end;
   end;

var pri: lAniosFab;
begin
   pri := nil;
   recorrerArbolPatentes2(a,pri);
   writeln('--------------------- Lista de autos por anio de fabricacion ------------------>');
   writeln;
   imprimirListaAnios(pri);
end;

procedure informarModelo(a: arbPatentes);

   procedure buscarPatente(a: arbPatentes; pat: integer; var mdl: str20);
   begin
      if(a <> nil) then begin
	 if(pat = a^.dato.info.patente) then
	    mdl := a^.dato.info.modelo
	 else if (pat < a^.dato.info.patente) then
	    buscarPatente (a^.HI,pat,mdl)
	 else
	    buscarPatente(a^.HD,pat,mdl);
      end
      else
	 mdl := 'no existe';
   end;

var pat: integer; mdl: str20;
begin
   writeln;
   writeln('--------------------- Informar Modelo de Auto por patente seleccionada (Arbol de Patentes) ------------------>');
   writeln;
   repeat
      writeln;
      write('Ingrese un numero de patente (mayor a 0): ');
      readln(pat);
      writeln;
   until(pat > 0);
   buscarPatente(a,pat,mdl);
   if(mdl <> 'no existe') then begin
      writeln;
      writeln('La patente Nro. ',pat,' pertenece al auto modelo: ',mdl);
      writeln;
   end
   else
      writeln('La patente Nro. ',pat,' no pertenece a ningun modelo de auto de la concesionaria');   
end;

procedure informarModelo2(a: arbMarcas);

   procedure buscarPorMarca(l: lAutos; pat: integer; var mdl: str20; var esta: boolean);
   begin
      while (l <> nil) and (not esta) do
      begin
         if (l^.dato.patente = pat) then
         begin
            mdl := l^.dato.modelo;
            esta := true;  // Marcar que se encontró
         end;
         l := l^.sig;
      end;
   end;

   procedure buscarPatente2(a: arbMarcas; pat: integer; var mdl: str20; var esta: boolean);
   begin
      if (a <> nil) and (not esta) then  // Verificar si no se ha encontrado aún
      begin
         buscarPorMarca(a^.dato.autos, pat, mdl, esta);  // Buscar en la lista de autos de la marca
         
         if not esta then  // Si no se encontró en la lista actual, seguir buscando en el árbol
         begin
            buscarPatente2(a^.HI, pat, mdl, esta);
            if not esta then
               buscarPatente2(a^.HD, pat, mdl, esta);
         end;
      end;
   end;

var
   pat: integer;
   mdl: str20;
   esta: boolean;
begin
   writeln;
   writeln('--------------------- Informar Modelo de Auto por patente seleccionada (Arbol de Marcas) ------------------>');
   writeln;
   repeat
      writeln;
      write('Ingrese un numero de patente (mayor a 0): ');
      readln(pat);
      writeln;
   until(pat > 0);
   
   esta := false;  // Inicializar como no encontrado
   buscarPatente2(a, pat, mdl, esta);  // Llamar al procedimiento de búsqueda

   if (esta) then
   begin
      writeln;
      writeln('La patente Nro. ', pat, ' pertenece al auto modelo: ', mdl);
      writeln;
   end
   else
      writeln('La patente Nro. ', pat, ' no pertenece a ningun modelo de auto de la concesionaria');   
end;


{Programa Principal}

Var 
  a: arbPatentes;
  b: arbMarcas;
Begin
  Randomize;
  generarArboles(a,b);
  imprimirArboles(a,b);
  contadorAutosPorMarca(a);
  contadorAutosPorMarca2(b);
  generarListaPorAnioFab(a);
  informarModelo(a);
  informarModelo2(b);
End.
