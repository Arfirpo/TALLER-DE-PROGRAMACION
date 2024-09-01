program ejercicio2P3;

Const
  dMax = 31;
  mMax = 12;
  anio_min = 1950;
  anio_act = 2024;

type
  dias = 1..dMax;
  meses = 1..mMax;
  anios = anio_min..anio_act;

  fechas = record
    dia: dias;
    mes: meses;
    anio: integer;
  end;

  venta = record
    codigo: integer;
    fecha: fechas;
    u_vendidas: integer;
  end;

  arb_Ventas = ^nArb_Ventas;

  nArb_Ventas = record
    dato: venta;
    HI: arb_Ventas;
    HD: arb_Ventas;
  end;

{modulos}

procedure generarArbol(var a: arb_Ventas);

  Procedure cargarVenta(var v: venta);
  begin
    with v do begin
      codigo := Random(101);
      if codigo <> 0 then begin
        u_vendidas := 1 + Random(100);
        fecha.dia := 1 + Random(dMax);
        fecha.mes := 1 + Random(mMax);
        fecha.anio := anio_min + Random(anio_act - anio_min + 1);
      end;
    end;
  end;

  procedure InsertarElemento(var a: arb_Ventas; v: venta);
  begin
    if(a = nil) then begin
      new(a);
      a^.dato := v;
      a^.HI := nil;
      a^.HD := nil;  
    end
    else if (v.codigo >= a^.dato.codigo) then
      InsertarElemento(a^.HD,v)
    else
      InsertarElemento(a^.HI,v);
  end;

var v: venta;
begin
  a := nil;
  cargarVenta(v);
  while(v.codigo <> 0) do begin
    InsertarElemento(a,v);
    cargarVenta(v);
  end;
end;

procedure imprimirArbol(a: arb_Ventas);
begin
  if (a <> nil) then begin
    imprimirArbol(a^.HI);
    writeln('| Codigo de Producto: ',a^.dato.codigo,' | Fecha: ',a^.dato.fecha.dia,'/',a^.dato.fecha.mes,'/',a^.dato.fecha.anio,' | Unidades vendidas: ',a^.dato.u_vendidas);
    imprimirArbol(a^.HD);
  end;
end;

{Programa principal}
var
  a: arb_Ventas;
begin
  Randomize;
  generarArbol(a);
  writeln;
  if(a <> nil) then begin
    writeln('Informacion Ventas: ');
    writeln;
    imprimirArbol(a);
    writeln;
  end
  else write('l arbol esta vacio.');
  writeln('//////////////////////////////////////////////////////////');
  writeln;
end.
