program nombrePrograma;

Const
  dimF_rubro = 8;
  dimF_rubro3 = 30;

type

  rRubro = 1..dimF_rubro;
  rRubro3 = 0..dimF_rubro3;

  producto = record
    codP: integer;
    codR: rRubro;
    precio: real;
  end;

  lProductos = ^nProductos;

  nProductos = record
    dato: producto;
    sig: lProductos;
  end;
  
  vRubros = array[rRubro] of lProductos;
  vRubro3 = array[1..dimF_rubro3] of producto;

{modulos}

procedure leerProducto(var p: producto);
var
  num1,num2: integer;
begin
  with p do begin
    codP := Random(150);
    if (codP <> 0) Then begin
      codR := Random(dimF_rubro) + 1;
      num1 := Random(1000) + 1;
      num2 := Random(10) + 1;
      precio := (num1 / num2);
    end;  
  end;
end;

Procedure insertarOrdenado(var l: lProductos; p: producto);
var
  nue,ant,act: lProductos;
begin
  new(nue);
  nue^.dato := p;
  act := l;
  ant := l;
  while (act <> nil) and (p.codP > act^.dato.codP) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  Else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure inicializarVector(var v: vRubros);
var
  i: rRubro;
begin
  for i := 1 to dimF_rubro do begin
    v[i] := nil;
  end;
end;

procedure cargarVector(var v: vRubros);
var
  p: producto;
begin
  leerProducto(p);
  while (p.codP <> 0) do begin
    insertarOrdenado(v[p.codR],p);
    leerProducto(p);
  end;
end;

procedure imprimirVector(v: vRubros);
var
  i: rRubro; 
  l: lProductos;
begin
  for i := 1 to dimF_rubro do begin
    writeln('                 ----------------------         ');
    writeln('                 Productos del Rubro: ', i, '.');
    writeln('                 ----------------------         ');
    l := v[i];
    while (l <> nil) do begin
      write('|Codigo de Producto: ', l^.dato.codP, '|');
      write(' Codigo de Rubro: ', l^.dato.codR, '|');
      write(' Precio del Producto: ', l^.dato.precio:0:2, '|');
      writeln;
      l := l^.sig;
    end;
  end;
  
end;



procedure cargarVector2(l: lProductos; var v: vRubro3; var dimL: rRubro3);
begin
  dimL := 0;
  while (dimL < dimF_rubro3) and (l <> nil)  do begin
    dimL := dimL + 1;
    v[dimL] := l^.dato;
    l := l^.sig;
  end;
end;

Procedure ordenacionInsercion (Var v: vRubro3; dimL: rRubro3);

Var 
  j, i: rRubro3;
  act: producto;
Begin
  For i:= 2 To dimL Do
    Begin
      act := v[i];
      j := i-1;
      While (j > 0) And (v[j].precio > act.precio) Do
        Begin
          v[j+1] := v[j];
          j := j -1;
        End;
      v[j+1] := act;
    End;
End;

procedure imprimirVector2(v: vRubro3; dimL: rRubro3);
var
  i: rRubro3;
begin
  for i := 1 to dimL do begin
    write('| Codigo de Producto: ',v[i].codP);
    write('| Codigo de Rubro: ',v[i].codR);
    write('| Precio del Producto: ',v[i].precio:0:2,' |');
    writeln;
  end;
end;

{Programa Principal}
var
  vR: vRubros;
  vR3: vRubro3;
  dimL: rRubro3;
begin
  Randomize;
  inicializarVector(vR);
  cargarVector(vR);
  imprimirVector(vR);
  

  writeln('                 --------------------------------        ');
  writeln('                 Productos del Rubro 3 - S/Orden'         );
  writeln('                 --------------------------------        ');
  cargarVector2(vR[3],vR3,dimL);
  imprimirVector2(vR3,dimL);

  writeln('                 --------------------------------        ');
  writeln('                 Productos del Rubro 3 - Ordenados'       );
  writeln('                 --------------------------------        ');
  ordenacionInsercion(vR3,dimL);
  imprimirVector2(vR3,dimL);
end.
