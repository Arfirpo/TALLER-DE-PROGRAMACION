
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
      id := Random(2137560006) -1;
      write('Ingrese DNI del Propietario: ');
      readln(dniProp);
      valorExp := Random(10001);
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

Procedure imprimirVector(v: vOficinas; dimL: rOfi);

Var 
  i: integer;
Begin
  For i := 1 To dimL Do
    Begin
      write)''
      writeln(v[i].id);
      writeln(v[i].dniProp);
      writeln(v[i].valorExp:0:2);
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
  imprimirVector(v,dimL);
End.
