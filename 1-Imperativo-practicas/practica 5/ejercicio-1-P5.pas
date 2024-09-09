{
  1. El administrador de un edificio de oficinas tiene la información del pago de las expensas
  de dichas oficinas. 
  Implementar un programa con:
    a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
    administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
    propietario y valor de la expensa. La lectura finaliza cuando llega el código de
    identificación 0.
    b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
    código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
    vistos en la cursada.
    c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
    generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
    retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
    Luego el programa debe informar el DNI del propietario o un cartel indicando que no
    se encontró la oficina.
    d) Un módulo recursivo que retorne el monto total de las expensas.
}

program ejercicio1P4;

const 
  dimF = 300;
  minDoc = 30000000;
  maxDoc = 40000000;

type
  
  rangoOfi = 0..dimF;
  
  oficina = record
    id: integer;
    dniProp: longint;
    valExp: real;
  end;
  
  vOficinas = array[rangoOfi] of oficina;

{modulos}

procedure cargarVector(var v: vOficinas; var dimL: rangoOfi);

  procedure leerOficina(var o: oficina);
  begin
    with o do begin
      id := Random(31);
      if(id <> 0) then begin
	dniProp := minDoc + Random(maxDoc - minDoc + 1);
	valExp := (1000 + Random(2000)) /(1 + random(10));
      end;
    end;
  end;

var o: oficina;
begin
  dimL := 0;
  leerOficina(o);
  while(dimL < dimF) and (o.id <> 0) do begin
    dimL := dimL + 1;
    v[dimL] := o;
    leerOficina(o);
  end;
end;

procedure imprimirVector(v: vOficinas; dimL: rangoOfi);
var i: rangoOfi;
begin
  writeln;
  writeln('Vector de Oficinas: ');
  writeln;
  for i := 1 to dimL do begin
    writeln('| ID: ',v[i].id,' | Dni del Propietario: ',v[i].dniProp,' | Valor de sus Expensas: $',v[i].valExp:0:2,' |');
    writeln;
  end;
end;

procedure ordenarVectorSeleccion(var v: vOficinas; dimL: rangoOfi);
var
  i,j,p: rangoOfi;
  item: oficina;
begin
  for i := 1 to dimL -1 do begin
    p := i;
    for j := i + 1 to dimL do begin
      if(v[j].id < v[p].id) then
	p := j;
    end;
    item := v[p];
    v[p] := v[i];
    v[i] := item;
  end;
end;

procedure busqueda(v: vOficinas; dimL: rangoOfi);

  function busquedaDicotomica(v: vOficinas; dimL: rangoOfi; n: integer): integer;
  var inf,sup,med: rangoOfi;
  begin
    inf := 1;
    sup := dimL;
    med := (inf + sup) div 2;
    
    while(inf <= sup)and (n <> v[med].id) do begin
      if(n < v[med].id) then
	sup := med - 1
      else
	inf := med + 1;
      med := (inf + sup) div 2;
    end;
    
    if(inf <= sup) and (n = v[med].id) then
      busquedaDicotomica := med
    else
      busquedaDicotomica := 0;
  end;

var n: integer; p: rangoOfi;
begin
writeln;
  write('Ingrese un id a buscar: ');
  readln(n);
  writeln;
  p := busquedaDicotomica(v,dimL,n);
  if(p <> 0) then
    writeln('El dni del Propietario de la oficina ',v[p].id,' es ',v[p].dniProp)
  else
    writeln('La oficina buscada no existe.');
  writeln;
end;

procedure totalExpensas(v: vOficinas; dimL: integer);

  function totExpensasRecursivo(v: vOficinas; dimL: integer): real;
  begin
    if(dimL = 0) then totExpensasRecursivo := 0
    else
      totExpensasRecursivo := totExpensasRecursivo(v,dimL-1) + v[dimL].valExp;
  end;
  
begin
  writeln('EL monto total de las expensas del edificio es: $ ',totExpensasRecursivo(v,dimL):0:2);
end;

{Programa Principal}

var v: vOficinas; dimL: rangoOfi;
BEGIN
  Randomize;
  cargarVector(v,dimL);
  writeln('------------ Vector sin orden ----> ');
  if(dimL > 0) then begin
    imprimirVector(v,dimL);
    writeln;
    ordenarVectorSeleccion(v,dimL);
    writeln('------------ Vector ordenado ----> ');
    writeln;
    imprimirVector(v,dimL);
    writeln;
    writeln('------------ Busqueda Dicotomica (Vector ordenado) ----> ');
    busqueda(v,dimL);
    writeln('------------ Informar Valor Total Expensas ----> ');
    writeln;
    totalExpensas(v,dimL);
  end;
END.

