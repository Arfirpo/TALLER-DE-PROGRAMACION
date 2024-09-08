{3. Implementar un programa modularizado para una librería. 
Implementar módulos para:
  a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto. 
    De cada producto deben quedar almacenados su código, la cantidad total de unidades vendidas y el monto total. 
    De cada venta se lee código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las ventas finaliza cuando se lee el código de venta -1.
  b. Imprimir el contenido del árbol ordenado por código de producto.
  c. Retornar el código de producto con mayor cantidad de unidades vendidas.
  d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
  e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.}

program ejercicio3P4;

type

  venta = record
    codV: integer;
    codP: integer;
    uVendidas: integer;
    pUnitario: real;
  end;

  producto = record
    codP: integer;
    totUnidades: integer;
    montoTot: real;
  end;

  arbProd = ^nArbProd;

  nArbProd = record
    dato: producto;
    HI: arbProd;
    HD: arbProd;
  end;

{modulos}
procedure generarArbol(var a: arbProd);

  procedure leerVenta(var v: venta);
  begin
    with v do begin
      codV := Random(51) - 1;
      if(codV <> -1) then begin
        codP := 1 + Random(100);
        uVendidas := 1 + Random(501);
        pUnitario := (1 + Random(50)) / (1 + Random(10));
        writeln('| CodP: ', codP, ' | CodV: ', codV, ' | Unidades: ', uVendidas, ' | Precio Unitario: ', pUnitario:0:2,' |');
      end;
    end;
  end;

  procedure agregarNodo(var a: arbProd; v: venta);

    procedure cargarProducto(var p: producto; var v: venta);
    begin
      p.codP := v.codP;
      p.totUnidades := v.uVendidas;
      p.montoTot := v.pUnitario * v.uVendidas;
    end;

    procedure actualizarNodo(var totUnidades: integer; var montoTot: real;  v: venta);
    begin
      totUnidades := totUnidades + v.uVendidas;
      montoTot := montoTot + (v.uVendidas * v.pUnitario);
    end;

  begin
    if(a = nil) then begin
      new(a);
      cargarProducto(a^.dato,v);
      a^.HI := nil;
      a^.HD := nil;
    end
    else begin
      if(v.codP = a^.dato.codP) then actualizarNodo(a^.dato.totUnidades,a^.dato.montoTot,v)
      else begin
        if(v.codP > a^.dato.codP) then agregarNodo(a^.HD,v)
        else agregarNodo(a^.HI,v);
      end;
    end;
  end;

var v: venta;
begin
  a := nil;
  writeln;
  writeln('--------------- Ventas Realizadas ------->');
  writeln;
  leerVenta(v);
  while(v.codV <> -1) do begin
    agregarNodo(a,v);
    leerVenta(v);
  end;
end;

procedure  imprimirArbolProd(a: arbProd);

  procedure imprimirArbol(a: arbProd);
  begin
    if(a <> nil) then begin
      if(a^.HI <> nil) then imprimirArbol(a^.HI);
      writeln('| Codigo de producto: ',a^.dato.codP,' | Total Unidades Vendidas: ',a^.dato.totUnidades,' | Monto Total de Ventas: $',a^.dato.montoTot:0:2);
      if(a^.HD <> nil) then imprimirArbol(a^.HD);
    end;
  end;

begin
    writeln;
    writeln('------------------- ARBOL DE PRODUCTOS -------------------');
    writeln;
    writeln('--------------- Imprimir Arbol en orden Ascendente ------->');
    writeln;
    imprimirArbol(a);
    writeln;
end;

procedure maxUnidadesVendidas(a: arbProd);

  procedure actualizarMaximo(codP,totUnidades: integer; var maxCant, maxCodP: integer);
  begin
    if(totUnidades > maxCant) then begin
      maxCant := totUnidades;
      maxCodP := codP;
    end;
  end;

  procedure obtenerMaxCant(a: arbProd; var maxCant,maxCodP: integer);
  begin
    if(a <> nil) then begin
      if(a^.HI <> nil) then obtenerMaxCant(a^.HI,maxCant,maxCodP);
      actualizarMaximo(a^.dato.codP,a^.dato.totUnidades,maxCant,maxCodP);
      if(a^.HD <> nil) then obtenerMaxCant(a^.HD,maxCant,maxCodP);
    end;
  end;

var maxCant,maxCodP: integer; 
begin
  maxCant := -1;
  writeln;
  writeln('--------------- Informar Producto con mayor cantidad de unidades vendidas ------->');
  writeln;
  obtenerMaxCant(a,maxCant,maxCodP);
  writeln('El producto con mayor cantidad de unidades vendidas es el Nro. ',maxCodP);
  writeln;
end;

procedure codigosMenores(a: arbProd);

  function obtenerMinCod(a: arbProd; n: integer): integer;
  begin
    if(a = nil) then obtenerMinCod := 0
    else begin
      if(a^.dato.codP < n) then 
        obtenerMinCod := 1 + obtenerMinCod(a^.HI,n) + obtenerMinCod(a^.HD,n)
      else 
        obtenerMinCod := obtenerMinCod(a^.HI,n)
    end;
  end;

var num: integer;
begin
  writeln;
  writeln('--------------- Informar Cantidad de Productos con codigo menor al valor Ingresado ------->');
  writeln;
  write('Ingrese un numero: ');
  readln(num);
  writeln;
  writeln(obtenerMinCod(a,num),' Codigos son menores que el valor ingresado.');
  writeln;
end;

procedure entreRangos(a: arbProd);

  function contarEntreRangos(a: arbProd; inf,sup: integer): real;
  begin
    if(a <> nil) then begin
      if((a^.dato.codP > inf) and (a^.dato.codP < sup)) then
        contarEntreRangos :=  a^.dato.montoTot +  contarEntreRangos(a^.HI,inf,sup) + contarEntreRangos(a^.HD,inf,sup)
      else if (a^.dato.codP >= sup) then contarEntreRangos := contarEntreRangos(a^.HI,inf,sup)
      else 
        contarEntreRangos := contarEntreRangos(a^.HD,inf,sup);
    end
    else 
      contarEntreRangos := 0;
  end;

var num1,num2: integer;
begin
  writeln;
  writeln('--------------- Informar monto total de Productos con codigo dentro del rango de valores ingresados ------->');
  repeat
    writeln;
    write('Ingrese un numero: ');
    readln(num1);
    write('Ingrese otro numero: ');
    readln(num2);
  until(num1 <> num2);
  writeln;
  if(num1 < num2) then
    writeln('El monto total de los productos que se encuentran dentro del rango seleccionado es de: $ ',contarEntreRangos(a,num1,num2):0:2)
  else
    writeln('El monto total de los productos que se encuentran dentro del rango seleccionado es de: $ ',contarEntreRangos(a,num2,num1):0:2);
end;


{Programa Principal}
var
  a: arbProd;

begin
  Randomize;
  generarArbol(a);
  imprimirArbolProd(a);
  maxUnidadesVendidas(a);
  codigosMenores(a);
  entreRangos(a);
end.
