
Program nombrePrograma;

Const 
  dimF_ofi = 300;

Type 
  rOfi = 0..dimF_ofi;

  oficina = Record
    id: integer;
    dniProp: longint;
    valorExp: real;
  End;

  vOficinas = array[1..dimF_ofi] Of oficina;

{modulos}

Procedure leerOficina(Var o: oficina);
Begin
  With o Do
    Begin
      id := Random(12) -1;
      write('Ingrese DNI del Propietario: ');
      readln(dniProp);
      valorExp := Random(10001) / 100;
    End;
End;

Procedure cargarVector(Var v: vOficinas; Var dimL: rOfi);

Var o: oficina;
Begin
  leerOficina(o);
  While (dimL < dimF_ofi) And (o.id <> -1) Do
    Begin
      dimL := dimL +1;
      v[dimL] := o;
      leerOficina(o);
    End;
End;

Procedure ordenarSeleccion(Var v: vOficinas; dimL: integer);

Var 
  i, j, pos: integer;
  item: oficina;
Begin
  For i:= 1 To dimL - 1 Do
    Begin
      pos := i;
      For j := i+1 To dimL Do
        If (v[j].id < v[pos].id) Then
          pos := j;
      item := v[pos];
      v[pos] := v[i];
      v[i] := item;
    End;
End;


Procedure imprimirVector(v: vOficinas; dimL: rOfi);

Var 
  i: integer;
Begin
  For i := 1 To dimL Do
    Begin
      writeln;
      write('| Id de la Oficina: ',v[i].id,' | ');
      write('DNI del Propietario: ',v[i].dniProp,' | ');
      writeln('Valor de las expensas: ',v[i].valorExp:0:2,' |');
    End;
End;

Procedure ordenarInsercion(Var v: vOficinas; dimL: integer);

Var 
  i,j: integer;
  actual: oficina;
Begin
  For i:= 2 To dimL Do
    Begin
      actual := v[i];
      j := i - 1;
      While (j > 0) And (v[j].id < actual.id) Do
        Begin
          v[j+1] := v[j];
          j := j - 1;
        End;
      v[j+1] := actual;
    End;
End;

{Programa principal}

Var 
  v: vOficinas;
  dimL: rOfi;
Begin
  Randomize;
  dimL := 0;
  cargarVector(v,dimL);
  If dimL <> 0 Then
    Begin
      writeln;
      write('|      Vector original cargado sin orden     |');
      writeln;
      imprimirVector(v,dimL);
      ordenarSeleccion(v,dimL);
      writeln;
      write('|      Vector ordenando de menor a mayor, por seleccion      |');
      writeln;
      imprimirVector(v,dimL);
      writeln;
      write('|      Vector ordenando de mayor a menor, por insercion      |');
      writeln;
      125
      ordenarInsercion(v,dimL);
      imprimirVector(v,dimL);
    End;
End.
