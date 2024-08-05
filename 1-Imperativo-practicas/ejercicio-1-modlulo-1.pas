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
    codP := Random(rCodP);
    if (codP <> 0) then begin  
      write('Ingrese cantidad de unidades vendidas');
      readln(cantProd);
    end;
  end;
end;

procedure cargarVector(var v: vVentas; var dimL: integer;);
var
  v: venta;
begin
  leerVenta(v);
  while (dimL <= dimF) and (v.codP <> 0) do begin
    dimL := dimL + 1;
    v[dimL] := v;
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
end.
