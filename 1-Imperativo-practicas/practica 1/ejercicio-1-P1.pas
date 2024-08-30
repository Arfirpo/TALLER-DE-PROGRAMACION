Program Clase1MI;

Const 
  dimF = 50;

Type 
  dias = 0..31;
  rango1 = 0..15;
  rango2 = 1..99;
  rango3 = 0..dimF;

  venta = Record
    dia: dias;
    codigoP: rango1;
    cantidad: rango2;
  End;

  vector = array [1..dimF] Of venta;

  elemento = Record
    codigoP: rango1;
    cantTotal: integer;
  End;

  lista = ^nodo;

  nodo = Record
    dato: elemento;
    sig: lista;
  End;

Procedure AlmacenarInformacion (Var v: vector; Var dimL: rango3); {módulo que retorne la información de las ventas en un vector}

  Procedure LeerVenta (Var v: venta);
  Begin
    Randomize;
    write ('Dia: ');
    v.dia := random(32);
    writeln (v.dia);
    If (v.dia <> 0)
      Then
      Begin
        write ('Codigo de producto: ');
        v.codigoP := random(16) + 1; {El código debe generarse automáticamente (random)}
        writeln (v.codigoP);
        write ('Ingrese cantidad (entre 1 y 99): '); {la cantidad se debe leer}
        readln (v.cantidad);
      End;
  End;

Var unaVenta: venta;
Begin
  dimL := 0;
  LeerVenta (unaVenta);
  While (unaVenta.dia <> 0)  And ( dimL < dimF ) Do {El ingreso de las ventas finaliza con el día de venta 0 (no se procesa)}
    Begin
      dimL := dimL + 1;
      v[dimL] := unaVenta;
      LeerVenta (unaVenta);
    End;
End;

Procedure ImprimirVector (v: vector; dimL: rango3); {módulo que muestre el contenido del vector resultante}
Var 
  i: integer;
Begin
  write ('         -');
  For i:= 1 To dimL Do
    write ('-----');
  writeln;
  write ('  Codigo:| ');
  For i:= 1 To dimL Do
    Begin
      If (v[i].codigoP <= 9)Then
        write ('0');
      write(v[i].codigoP, ' | ');
    End;
  writeln;
  writeln;
  write ('Cantidad:| ');
  For i:= 1 To dimL Do
    Begin
      If (v[i].cantidad <= 9)Then
        write ('0');
      write(v[i].cantidad, ' | ');
    End;
  writeln;
  write ('         -');
  For i:= 1 To dimL Do
    write ('-----');
  writeln;
  writeln;
End;

Procedure Ordenar (Var v: vector; dimL: rango3); {módulo que ordene (por Selección, de menor a mayor) el vector de ventas por código}
Var 
  i, j, pos: rango3;
  item: venta;
Begin
  For i:= 1 To dimL - 1 Do
    Begin 
    {busca el mínimo y guarda en pos la posición}
      pos := i;
      For j := i+1 To dimL Do
        If (v[j].codigoP < v[pos].codigoP) Then pos := j;
    {intercambia v[i] y v[pos]}
      item := v[pos];
      v[pos] := v[i];
      v[i] := item;
    End;
End;

Procedure Eliminar (Var v: vector; Var dimL: rango3; valorInferior, valorSuperior: rango1);

  Function BuscarPosicion (v: vector; dimL: rango3; elemABuscar: rango1): rango3;
  Var 
    pos: rango3;
  Begin
    pos := 1;
    While (pos <= dimL) And (elemABuscar > v[pos].codigoP) Do
      pos := pos + 1;
    If (pos > dimL) Then 
      BuscarPosicion := 0
    Else 
      BuscarPosicion := pos;
  End;

  Function BuscarPosicionDesde (v: vector; dimL, pos : integer; elemABuscar: rango1): rango3;
  Begin
    While (pos <= dimL) And (elemABuscar >= v[pos].codigoP) Do
      pos := pos + 1;
    If (pos > dimL) Then 
      BuscarPosicionDesde := dimL
    Else 
      BuscarPosicionDesde := pos - 1;
  End;

Var 
  posInferior, posSuperior, salto, i: rango3;
Begin
  i := 1;
  posInferior := BuscarPosicion (v, dimL, valorInferior);
  If (posInferior <> 0) Then Begin
    posSuperior := BuscarPosicionDesde (v, dimL, posInferior, valorSuperior);

    
  end;
{Escribir el código correspondiente para hacer el corrimiento y disminuir la dimensión lógica}
  salto := posSuperior - posInferior + 1;
  For i := posInferior To (dimL - salto) Do
    v[i] := v[i + salto];
  
  dimL := dimL - salto;
End;

Procedure GenerarLista (v: vector; dimL: rango3; Var L: lista); {Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada código par de producto junto a la cantidad total de productos vendidos.}

  Procedure AgregarAtras (Var L, ult: lista; elem: elemento);
  var
    nue: lista;
  Begin
    new(nue);
    nue^.dato := elem;
    nue^.sig := nil;
    if(l = nil) then
      l := nue
    else
      ult^.sig := nue;
    ult := nue;
  End;

Var 
  i: rango3;
  ult: lista;
  e: elemento;
Begin
  L := Nil; ult := Nil;
  i := 1;
  While (i <= dimL) Do Begin  
    e.codigoP :=  v[i].codigoP;
    e.cantTotal := 0;
    While ((i <= dimL) And (e.codigoP =  v[i].codigoP)) Do Begin {corte de control por codigo de producto}
      e.cantTotal := e.cantTotal + v[i].cantidad; {cantidad total de productos vendidos por codigo d producto}
      i := i + 1;
    End;
    AgregarAtras (L, ult, e);
  End;
End;

Procedure ImprimirLista (L: lista); {módulo que muestre la información obtenida en el punto g)}
Begin
  while (L <> Nil) do begin
    writeln('Código de Producto: ', L^.dato.codigoP, ' - Cantidad Total: ', L^.dato.cantTotal);
    L := L^.sig;
  end;
End;

{Programa Principal}
Var 
  v: vector;
  dimL: rango3;
  valorInferior, valorSuperior: rango1;
  L: lista;
Begin
  AlmacenarInformacion (v, dimL); {-------------------------------------> punto a}
  writeln;
  If (dimL = 0) Then 
    writeln ('--- Vector sin elementos ---')
  Else Begin
    writeln ('--- Vector ingresado --->');
    writeln;
    ImprimirVector (v, dimL); {-----------------------------------------> punto b}
    writeln;
    writeln ('--- Vector ordenado --->');
    writeln;
    Ordenar (v, dimL); {------------------------------------------------> punto c}
    ImprimirVector (v, dimL); {-----------------------------------------> punto d}
    write ('Ingrese valor inferior: ');
    readln (valorInferior);
    write ('Ingrese valor superior: ');
    readln (valorSuperior); 
    Eliminar (v, dimL, valorInferior, valorSuperior); {-----------------> punto e}
    if (dimL = 0) then 
      writeln ('--- Vector sin elementos, luego de la eliminacion ---')
    else begin
      writeln;
      writeln ('--- Vector luego de la eliminacion --->');
      writeln;
      ImprimirVector (v, dimL); {---------------------------------------> punto f}
      GenerarLista (v, dimL, L); {--------------------------------------> punto g}
      if (L = nil) then 
        writeln ('--- Lista sin elementos ---')
      else begin
        writeln;
        writeln ('--- Lista obtenida --->');
        writeln;
        ImprimirLista (L); {--------------------------------------------> punto h}
      end;
    end;
  End;
End.

