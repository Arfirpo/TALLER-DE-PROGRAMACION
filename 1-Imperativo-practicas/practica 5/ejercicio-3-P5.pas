


{
   Un supermercado requiere el procesamiento de sus productos. De cada producto se
   conoce código, rubro (1..10), stock y precio unitario. Se pide:
      a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
      vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
      más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
      b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
      de producto y retorne si dicho código existe o no para ese rubro.
      c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
      rubro, el código y stock del producto con mayor código.
      d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
      retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
      ingresados.
}

Program ejercicio3P4;

Const 
  dimF = 10;

Type 
  rango = 1..dimF;
  rango2 = 0..dimF;

  producto2 = Record
    cod: integer;
    stock: integer;
    pUnitario: real;
  End;

  producto = Record
    rubro: rango2;
    infoProd: producto2;
  End;

  arbProductos = ^nArbProductos;
  nArbProductos = Record
    dato: producto2;
    HI,HD: arbProductos;
  End;

  vArboles = array[rango] Of arbProductos;
  vContador = array[rango] Of integer;

{modulos}

Procedure inicializarVector(Var v: vArboles);

Var i: rango2;
Begin
  For i := 1 To dimF Do
    Begin
      v[i] := Nil;
    End;
End;

Procedure cargarVector(Var v: vArboles);

Procedure leerProducto(Var p:producto);
Begin
  With p Do
    Begin
      infoProd.cod := Random(51);
      If (infoProd.cod <> 0) Then
        Begin
          rubro := 1 + Random(10);
          infoProd.stock := 1 + Random(100);
          infoProd.pUnitario := 1 + ((1 + Random(1000))) / (1 + (Random(10)));
        End;
    End;
End;

Procedure generarArbol(Var a: arbProductos; p: producto2);

Begin
  If (a = Nil) Then
    Begin
      new(a);
      a^.dato := p;
      a^.HI := Nil;
      a^.HD := Nil;
    End
  Else If (p.cod < a^.dato.cod) Then generarArbol(a^.HI,p)
  Else generarArbol(a^.HD,p);
End;

Var p: producto;
Begin
  leerProducto(p);
  While (p.infoProd.cod <> 0) Do
    Begin
      generarArbol(v[p.rubro],p.infoProd);
      leerProducto(p);
    End;
End;

Procedure imprimirVector(v: vArboles);

Procedure imprimirArbol(a: arbProductos);

Procedure imprimirNodo(p: producto2);
Begin
  writeln;
  writeln('| Codigo: ',p.cod,' | Stock: ',p.stock,' | Precio Unitario: ',p.pUnitario:0:2,' |');
  writeln;
End;

Begin
  If (a <> Nil) Then
    Begin
      imprimirArbol(a^.HI);
      imprimirNodo(a^.dato);
      imprimirArbol(a^.HD);
    End;
End;

Var i: rango;
Begin
  For i := 1 To dimF Do
    Begin
      If (v[i] <> Nil) Then
        Begin
          writeln('----- Arbol de Productos del Rubro ',i,' -----');
          imprimirArbol(v[i]);
          writeln('--------------------------------------------');
          writeln;
        End;
    End;
End;

Procedure buscarCod(v: vArboles);

Function buscarEnArbol(a: arbProductos; codigo: integer): boolean;
Begin
  If (a = Nil) Then buscarEnArbol := false
  Else
    Begin
      If (codigo = a^.dato.cod) Then buscarEnArbol := true
      Else
        Begin
          If (codigo < a^.dato.cod) Then buscarEnArbol := buscarEnArbol(a^.HI,codigo)
          Else buscarEnArbol := buscarEnArbol(a^.HD,codigo);
        End
    End;
End;

Var codigo: integer;
  rubro: rango;
Begin
  writeln;
  writeln('----------- Informar existencia de un codigo en un rubro seleccionado ------->');
  writeln;
  write('Ingrese un Codigo a buscar: ');
  readln(codigo);
  writeln;
  write('Ingrese un Rubro (entre 1 y ',dimF,'): ');
  readln(rubro);
  writeln;
  If (buscarEnArbol(v[rubro],codigo)) Then
    writeln('El codigo existe en el rubro seleccionado.')
  Else
    writeln('El codigo no existe en el rubro seleccionado.');
  writeln;
End;


{c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
   rubro, el código y stock del producto con mayor código.}
Procedure maxCod(v: vArboles);

Procedure maxPorRango(a: arbProductos; Var maxCod,maxStock: integer);
Begin
  If (a <> Nil) Then
    Begin
      If (a^.HD = Nil) Then
        Begin
          maxCod := a^.dato.cod;
          maxStock := a^.dato.stock;
        End
      Else maxPorRango(a^.HD,maxCod,maxStock);
    End;
End;

Var i: rango;
  maxCod,maxStock: integer;
Begin
  writeln('----------- Informar por cada rubro el codigo mas grande y su stock ------->');
  For i := 1 To dimF Do
    Begin
      maxCod := -1;
      maxStock := 0;
      maxPorRango(v[i],maxCod,maxStock);
      writeln;
      If (maxCod <> -1) Then
        writeln('Para el rubro ',i,' el Codigo mas grande es el ',maxCod,' y su stock actual es de ',maxStock,' unidades.')
      Else
        writeln('El Rubro no posee productos.');
    End;
End;

Procedure inicializarVectorContador(Var v: vContador);

Var i: rango;
Begin
  For i:= 1 To dimF Do
    Begin
      v[i] := 0;
    End;
End;




{d) Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, 
   la cantidad de productos con códigos entre los dos valores ingresados.}

Procedure contadorEntreRangos(v: vArboles; Var v2: vContador);

Function contador(a: arbProductos; inf,sup: integer): integer;
Begin
  If (a = Nil) Then contador := 0
  Else If (a^.dato.cod >= inf) And (a^.dato.cod <= sup) Then contador := 1 + contador(a^.HI,inf,sup) + contador(a^.HD,inf,sup)
  Else
    Begin
      If (a^.dato.cod < inf) Then contador := contador(a^.HD,inf,sup)
      Else contador := contador(a^.HI,inf,sup);
    End;
End;

Procedure imprimirVectorContador(v: vContador);

Var i: rango;
Begin
  For i := 1 To dimF Do
    Begin
      writeln;
      writeln('La cantidad de productos del rubro ',i,' dentro del rango seleccionado es ',v[i]);
      writeln;
    End;
End;

Var num1,num2: integer;
  i: rango;
Begin
  Repeat
    writeln;
    writeln('----------- Informar cantidad de productos entre rango seleccionado por cada rubro ------->');
    writeln;
    write('Ingrese un numero: ');
    readln(num1);
    writeln;
    write('Ingrese otro numero: ');
    readln(num2);
    writeln;
  Until (num1 <> num2);

  For i := 1 To dimF Do
    Begin
      If (num1 < num2) Then
        v2[i] := contador(v[i],num1,num2)
      Else
        v2[i] := contador(v[i],num2,num1);
    End;
  imprimirVectorContador(v2);
End;

{Programa Principal}

Var 
  v: vArboles;
  v2: vContador;
Begin
  Randomize;
  inicializarVector(v);
  cargarVector(v);
  imprimirVector(v);
  buscarCod(v);
  maxCod(v);
  inicializarVectorContador(v2);
  contadorEntreRangos(v,v2);
End.
