
Program nombrePrograma;

Const 
  dimF_rubro = 8;
  dimF_rubro3 = 30;

Type 

  rRubro = 1..dimF_rubro;
  rRubro3 = 0..dimF_rubro3;

  producto = Record
    codP: integer;
    codR: rRubro;
    precio: real;
  End;

  lProductos = ^nProductos;

  nProductos = Record
    dato: producto;
    sig: lProductos;
  End;

  vRubros = array[rRubro] Of lProductos;
  vRubro3 = array[1..dimF_rubro3] Of producto;

{modulos}

Procedure leerProducto(Var p: producto);

Var 
  num1,num2: integer;
Begin
  With p Do
    Begin
      codP := Random(150);
      If (codP <> 0) Then
        Begin
          codR := Random(dimF_rubro) + 1;
          num1 := Random(1000) + 1;
          num2 := Random(10) + 1;
          precio := (num1 / num2);
        End;
    End;
End;

Procedure insertarOrdenado(Var l: lProductos; p: producto);

Var 
  nue,ant,act: lProductos;
Begin
  new(nue);
  nue^.dato := p;
  act := l;
  ant := l;
  While (act <> Nil) And (p.codP > act^.dato.codP) Do
    Begin
      ant := act;
      act := act^.sig;
    End;
  If (act = ant) Then
    l := nue
  Else
    ant^.sig := nue;
  nue^.sig := act;
End;

Procedure inicializarVector(Var v: vRubros);

Var 
  i: rRubro;
Begin
  For i := 1 To dimF_rubro Do
    Begin
      v[i] := Nil;
    End;
End;

Procedure cargarVector(Var v: vRubros);

Var 
  p: producto;
Begin
  leerProducto(p);
  While (p.codP <> 0) Do
    Begin
      insertarOrdenado(v[p.codR],p);
      leerProducto(p);
    End;
End;

Procedure imprimirVector(v: vRubros);

Var 
  i: rRubro;
  l: lProductos;
Begin
  For i := 1 To dimF_rubro Do
    Begin
      writeln('                 ----------------------         ');
      writeln('                 Productos del Rubro: ', i, '.');
      writeln('                 ----------------------         ');
      l := v[i];
      While (l <> Nil) Do
        Begin
          write('|Codigo de Producto: ', l^.dato.codP, '|');
          write(' Codigo de Rubro: ', l^.dato.codR, '|');
          write(' Precio del Producto: ', l^.dato.precio:0:2, '|');
          writeln;
          l := l^.sig;
        End;
    End;

End;



Procedure cargarVector2(l: lProductos; Var v: vRubro3; Var dimL: rRubro3);
Begin
  dimL := 0;
  While (dimL < dimF_rubro3) And (l <> Nil)  Do
    Begin
      dimL := dimL + 1;
      v[dimL] := l^.dato;
      l := l^.sig;
    End;
End;

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

Procedure imprimirVector2(v: vRubro3; dimL: rRubro3);

Var 
  i: rRubro3;
Begin
  For i := 1 To dimL Do
    Begin
      write('| Codigo de Producto: ',v[i].codP);
      write('| Codigo de Rubro: ',v[i].codR);
      write('| Precio del Producto: ',v[i].precio:0:2,' |');
      writeln;
    End;
End;

{Programa Principal}

Var 
  vR: vRubros;
  vR3: vRubro3;
  dimL: rRubro3;
Begin
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
End.
