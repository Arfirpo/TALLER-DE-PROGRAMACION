program ej1Mod1;

uses
  sysUtils;

const
  dimF = 20;

type

  rVentas = 1..dimF;
  rCodP = 0..15;
  rCantProd = 1..99;

  venta = record
    codP: rCodP;
    cantProd: rCantProd;
  end;

  vVentas = array[rVentas] of venta;

{modulos}

procedure leerVenta(var v: venta);
begin
  with v do begin
    codP := Random(15);
    if (codP <> 0) then begin  
      write('Ingrese cantidad de unidades vendidas: ');
      readln(cantProd);
    end;
  end;
end;

function esta(v: vVentas; codigo: rCodP; dimL: integer):boolean;
var
  p: rVentas;
  encontre: boolean;
begin
  p := 1;
  encontre := false;
  while(p <= dimL) and (not encontre) do begin
    if (v[p].codP <> codigo) then
      p := p + 1
    else
      encontre := true;
  end;
  esta := encontre;
end;

procedure cargarVector(var v: vVentas; var dimL: integer);
var
  ve: venta;
begin
  leerVenta(ve);
  while (dimL < dimF) and (ve.codP <> 0) do begin
    dimL := dimL + 1;
    if(not esta(v,ve.codP,dimL)) then
      v[dimL] := ve;
    leerVenta(ve);
  end;
end;

procedure imprimirVector(v: vVentas; dimL: integer);
var
  i: rVentas;
begin
  for i := 1 to dimL do begin
    writeln('Codigo del producto: ',v[i].codP,'');
    writeln('Cantidad del producto comprada: ',v[i].cantProd,'');
  end;
end;

{Programa principal}
var
  v: vVentas;
  dimL: integer;
begin
  Randomize;
  dimL := 0;
  cargarVector(v,dimL);
  imprimirVector(v,dimL);
end.
