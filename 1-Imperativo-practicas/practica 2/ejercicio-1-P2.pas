{1.- Implementar un programa que invoque a los siguientes modulos.
a. Un modulo recursivo que retorne un vector de a lo sumo 15 numeros enteros random mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con 
el valor 20.
b. Un modulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un modulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un modulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
e. Un modulo recursivo que reciba el vector generado en a) y devuelva el maximo valor del vector.
f. Un modulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
g. Un modulo que reciba el vector generado en a) e imprima, para cada numero contenido en el vector, sus digitos en el orden en que aparecen en el numero. 
Debe implementarse un modulo recursivo que reciba el numero e imprima lo pedido. Ejemplo si se lee el valor 142, se debe imprimir 1  4  2
}

Program Clase2MI;
const 
  dimF = 15;
  min = 10;
  max = 155;

type 
  vector = array [1..dimF] of integer;     

procedure CargarVector (var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var 
    valor: integer;
  begin
    valor:= min + random (max - min + 1);
    if ((valor <> 20 ) and (dimL < dimF)) 
    then begin
      dimL:= dimL + 1;
      v[dimL]:= valor;
      CargarVectorRecursivo (v, dimL);
    end;
  end;
  
begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;

procedure ImprimirVector (v: vector; dimL: integer);
var
  i: integer;
begin
  for i:= 1 to dimL do
      write ('----');
  writeln;
  write (' ');
  for i:= 1 to dimL do begin
    write(v[i], ' | ');
  end;
  writeln;
  for i:= 1 to dimL do
      write ('----');
  writeln;
  writeln;
End;     

procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
begin    
  if dimL > 0 then begin
    ImprimirVectorRecursivo(v,dimL -1);
    write(' ',v[dimL],' |');
  end;
end; 

function Sumar (v: vector; dimL: integer): integer; 

  function SumarRecursivo (v: vector; pos, dimL: integer): integer;
  Begin
    if (pos <= dimL)  
    then 
      SumarRecursivo:= SumarRecursivo (v, pos + 1, dimL) + v[pos]  
    else 
      SumarRecursivo:=0  
  End;

  function SumarParesRecursivo (v: vector; dimL: integer): integer;
  Begin
    if (dimL = 0) then
      SumarParesRecursivo:= 0
    else if (v[dimL] mod 2 = 0) then
      SumarParesRecursivo:= SumarParesRecursivo (v, dimL -1) + v[dimL]
    else
      SumarParesRecursivo := SumarParesRecursivo (v, dimL -1);
  End;

begin
  Sumar:= SumarParesRecursivo (v, dimL);
end;

function  ObtenerMaximo (v: vector; dimL: integer): integer;
  
  function mayor(a,b: integer): integer;
  begin
    if a > b then
      mayor := a
    else 
      mayor := b;
  end;
  
  function maximoRecursivo(v: vector; diml: integer): integer;
  begin
    if(dimL = 0) then
      maximoRecursivo := 0
    else
      maximoRecursivo := mayor(v[dimL],maximoRecursivo(v,dimL-1));
  end;

begin
  ObtenerMaximo := maximoRecursivo(v,dimL);
end;     

function BuscarValor(v: vector; dimL, x: integer): boolean;

  function BuscarValorRecursivo(v: vector; dimL, x,p: integer): boolean;
  begin
      if(p > dimL) then
	 BuscarValorRecursivo := false
      else begin
	 if (v[p] = x) then
	    BuscarValorRecursivo := true;
	 else
	    BuscarValorRecursivo := BuscarValorRecursivo(v,dimL,x,p+1); 
      end;      
  end;

var p: integer
begin
  p := 1;
  BuscarValor := BuscarValorRecursivo(v, dimL, x,p);
end;

procedure ImprimirDigitos (v: vector; dimL: integer);

	procedure ImprimirDigitosRecursivo (num: integer);
	var
		dig: integer;
	begin
		if (num <> 0) then begin
			ImprimirDigitosRecursivo(num DIV 10);
			dig:= num MOD 10;
			write(dig);
			write('  ');
		end;
	end;
	
	
var
	i: integer;
begin    
	for i:= 1 to dimL do begin
		ImprimirDigitosRecursivo(v[i]);
		writeln();
	end;
end;

var dimL,suma, maximo, valor : integer; 
  v: vector;
  encontre: boolean;
Begin
  Randomize;
  CargarVector (v, dimL);
  writeln;
  if (dimL = 0) then 
    writeln ('--- Vector sin elementos ---')
  else begin
    writeln('Vector impresion normal: ');
    ImprimirVector (v, dimL);
    writeln('Vector impresion recursiva: ');
    ImprimirVectorRecursivo (v, dimL);
  end;
  writeln;
  writeln;

  suma:= Sumar(v, dimL);
  writeln;
  writeln;
  writeln('La suma de los valores pares del vector es ', suma); 
  writeln;
  writeln;
  maximo:= ObtenerMaximo(v, dimL);
  writeln;
  writeln;
  writeln('El maximo del vector es ', maximo); 
  writeln;
  writeln;
  write ('Ingrese un valor a buscar: ');
  read (valor);
  encontre:= BuscarValor(v, dimL, valor);
  writeln;
  writeln;
  if (encontre) then 
    writeln('El ', valor, ' esta en el vector')
  else 
    writeln('El ', valor, ' no esta en el vector');
  writeln;
  writeln;
  ImprimirDigitos (v, dimL);
End.
