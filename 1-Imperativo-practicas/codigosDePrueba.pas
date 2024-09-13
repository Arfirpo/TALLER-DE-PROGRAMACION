{

   
}


program codigos de prueba;

{modulos}

// Metodos de ordenación y busqueda ordenada

procedure ordenarPorSeleccion(v: Vector; dimL: indice);
var i,j,p: indice; item: tipoElemento;
begin
   for i := 1 to dimL -1 do begin
      p := i;
      for j := i + 1 to dimL do 
	 if(v[j] > v[p]) then p := j;
      
      item := v[p];
      v[p] := v[i];
      v[i] := item;
   end;
end;

function busquedaDicotomica(v: Vector; dimL: indice; val: integer): integer;
var inf,sup,med: indice;
begin
   inf := 1;
   sup := dimL;
   med := (inf + sup) div 2;
   
   while(inf <= sup) and (val <> v[med]) do begin
      if(val < v[med]) then
	 sup := med - 1
      else
	 inf := med + 1;
      med := (inf + sup) div 2;
   end;
   if(inf <= sup) and (val = v[med]) then
      busquedaDicotomica := med
   else
      busquedaDicotomica := -1;
end;


// Recursividad

{sumar valores}

function sumarPares(v: Vector; dimL: indice): integer;

   function sumarParesRecursivo(v: Vector; dimL,p: indice): integer;
   begin
      if(p <= dimL) then begin
	 if(v[p] mod 2 = 0) then
	    sumarParesRecursivo := v[p] + sumarParesRecursivo(v,dimL,p+1)
	 else
	    sumarParesRecursivo := sumarParesRecursivo(v,dimL,p+1)
      end
      else
	 sumarParesRecursivo := 0;
   end;

var p: indice;
begin
   p := 1;
   sumarPares := sumarParesRecursivo(v,dimL,p);
end;

{buscar valores}

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

{Descomponer numeros}

procedure imprimirDigitos(v: Vector; dimL: indice);

   procedure imprimirDigitosRecursivo(num: integer);
   var dig: integer;
   begin
      if(num <> 0) then begin
	 imprimirDigitosRecursivo(num div 10);
	 dig := num mod 10;
	 writeln(dig);
      end;
   end;

var i: indice;
begin
   for i := 1 to dimL do
      imprimirDigitosRecursivo(v[i])
end;


function busquedaDicotomica(v: Vector; dimL: indice): integer;

   function busquedaDicotomicaRecursiva(v: Vector; dimL,inf,sup: indice; val: integer): integer;
   var med: indice;
   begin
      if(inf > sup) then
	 busquedaDicotomicaRecursiva := -1
      else begin
	 med := (inf + sup) div 2;
	 if(val = v[med]) then busquedaDicotomicaRecursiva := med
	 else begin
	    if(val < v[med]) then busquedaDicotomicaRecursiva := busquedaDicotomicaRecursiva(v,dimL,inf,med-1,val)
	    else busquedaDicotomicaRecursiva := busquedaDicotomicaRecursiva(v,dimL,med+1,sup,val)
	 end;
      end;
   end;

var inf,sup: indice; val: integer;
begin
   inf := 1;
   sup := dimL;
   readln(val);
   busquedaDicotomica := busquedaDicotomicaRecursiva(v,dimL,inf,sup,val);
end;


BEGIN
	
	
END.

