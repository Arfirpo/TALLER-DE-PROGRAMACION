
Program ej1Mod1;

Uses 
sysUtils;

Const 
  dimF = 20;

Type 

  rVentas = 1..dimF;
  rCodP = 0..15;
  rCantProd = 1..99;

  venta = Record
    codP: rCodP;
    cantProd: rCantProd;
  End;

  vVentas = array[rVentas] Of venta;

{modulos}

Procedure leerVenta(Var v: venta);
Begin
  With v Do
    Begin
      codP := Random(15);
      If (codP <> 0) Then
        Begin
          write('Ingrese cantidad de unidades vendidas: ');
          readln(cantProd);
        End;
    End;
End;

Function esta(v: vVentas; codigo: rCodP; dimL: integer): boolean;

Var 
  p: rVentas;
  encontre: boolean;
Begin
  p := 1;
  encontre := false;
  While (p <= dimL) And (Not encontre) Do
    Begin
      If (v[p].codP <> codigo) Then
        p := p + 1
      Else
        encontre := true;
    End;
  esta := encontre;
End;

Procedure cargarVector(Var v: vVentas; Var dimL: integer);

Var 
  ve: venta;
Begin
  leerVenta(ve);
  While (dimL < dimF) And (ve.codP <> 0) Do
    Begin
      dimL := dimL + 1;
      If (Not esta(v,ve.codP,dimL)) Then
        v[dimL] := ve;
      leerVenta(ve);
    End;
End;

Procedure imprimirVector(v: vVentas; dimL: integer);

Var 
  i: rVentas;
Begin
  For i := 1 To dimL Do
    Begin
      writeln('Codigo del producto: ',v[i].codP,'');
      writeln('Cantidad del producto comprada: ',v[i].cantProd,'');
    End;
End;

{Programa principal}

Var 
  v: vVentas;
  dimL: integer;
Begin
  Randomize;
  dimL := 0;
  cargarVector(v,dimL);
  imprimirVector(v,dimL);
End.
