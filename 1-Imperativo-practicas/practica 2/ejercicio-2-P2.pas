program ejercicio2P2;

const
  dimF = 15;
  min = 100;
  max = 200;

type
  
  lEnteros = ^nEnteros;

  nEnteros = record
    dato: integer;
    sig: lEnteros;
  end;

{modulos}

procedure inicializarLista(var l: lEnteros);
begin
  l := nil;
end;

procedure agregarAdelante(var l: lEnteros; e: integer);
var nue: lEnteros;
begin
  new(nue); 
  nue^.dato := e; 
  nue^.sig := l; 
  l := nue;
end;

procedure cargarListaRecursiva(var l: lEnteros);
var e: integer;
begin
  e := min + Random(max - min + 1);
  if (e <> 100) then begin
    agregarAdelante(l,e);
    cargarListaRecursiva(l^.sig);
  end;
  // else
  //   agregarAdelante(l,e);  
end;

procedure imprimirListaRecursiva(l: lEnteros);
begin
  if l <> nil then begin
    write('| ');
    write(l^.dato,' ');
    imprimirListaRecursiva(l^.sig);
  end;
end;

procedure imprimirListaRecursivaInv(l: lEnteros);
begin
  if l <> nil then begin
    imprimirListaRecursivaInv(l^.sig);
    write('| ');
    write(l^.dato,' ');
  end;
end;

function minimoRecursivo(l: lEnteros): integer;
var num_min: integer;
begin
  if l = nil then
    minimoRecursivo := 9999
  else begin
    num_min := minimoRecursivo(l^.sig);
    if (l^.dato < num_min) then
      minimoRecursivo := l^.dato
    else
      minimoRecursivo := num_min;
  end;
end;

function buscarEnListaRecursivo(l: lEnteros; num: integer): boolean;
begin
  if l = nil then
    buscarEnListaRecursivo := false
  else if l^.dato = num then
    buscarEnListaRecursivo := true
  else
    buscarEnListaRecursivo := buscarEnListaRecursivo(l^.sig,num);
end;


{Programa Principal}
var
  pri: lEnteros;
  valor: integer;
begin
  Randomize;
  inicializarLista(pri);
  cargarListaRecursiva(pri);
  if (pri <> nil) then begin
    writeln;
    writeln('Lista Original: ');
    writeln;
    imprimirListaRecursiva(pri);
    write('|');
    writeln;
    writeln;
    writeln('Lista Orden Inverso: ');
    writeln;
    imprimirListaRecursivaInv(pri);
    write('|');
    writeln;
    writeln;
    write('El numero mas chico de la lista es el: ');
    write(minimoRecursivo(pri));
    writeln;
    writeln;
    write('Ingrese el numero a buscar: ');
    readln(valor);
    if(buscarEnListaRecursivo(pri,valor)) then begin
      writeln;
      write('El numero esta en la lista.')
    end
    else begin
      writeln;
      write('El numero no esta en la lista.');
    end;
    writeln;
    writeln;
  end;
end.
