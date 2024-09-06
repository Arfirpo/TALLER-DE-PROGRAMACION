{2. Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo
necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.
}

Program ImperativoClase3;

Type 
  rangoEdad = 12..100;

  cadena15 = string [15];

  socio = Record
    numero: integer;
    nombre: cadena15;
    edad: rangoEdad;
  End;

  arbol = ^nodoArbol;

  nodoArbol = Record
    dato: socio;
    HI: arbol;
    HD: arbol;
  End;

{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. 
La informacion de cada socio debe generarse aleatoriamente. }

Procedure GenerarArbol (Var a: arbol);

  Procedure CargarSocio (Var s: socio);
  Var 
    vNombres: array [0..9] Of string = ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola');
  Begin
    s.numero := random (51) * 100;
    If (s.numero <> 0) Then
      Begin
        s.nombre := vNombres[random(10)];
        s.edad := 12 + random (79);
      End;
  End;

  Procedure InsertarElemento (Var a: arbol; elem: socio);
  Begin
    If (a = Nil) Then
      Begin
        new(a);
        a^.dato := elem;
        a^.HI := Nil;
        a^.HD := Nil;
      End
    Else If (elem.numero < a^.dato.numero) Then
      InsertarElemento(a^.HI, elem)
    Else
      InsertarElemento(a^.HD, elem);
  End;

Var unSocio: socio;
Begin
  writeln;
  writeln ('----- Ingreso de socios y armado del arbol ----->');
  writeln;
  a := Nil;
  CargarSocio (unSocio);
  While (unSocio.numero <> 0) Do
    Begin
      InsertarElemento (a, unSocio);
      CargarSocio (unSocio);
    End;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
End;

{ Informar los datos de los socios en orden creciente. }

Procedure InformarSociosOrdenCreciente (a: arbol);

  Procedure InformarDatosSociosOrdenCreciente (a: arbol);
  Begin
    If (a^.HI <> Nil)Then
      InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    If (a^.HD <> Nil)Then
      InformarDatosSociosOrdenCreciente (a^.HD);
  End;

Begin
  if(a <> nil) then begin
    writeln;
    writeln ('----- Socios en orden creciente por numero de socio ----->');
    writeln;
    InformarDatosSociosOrdenCreciente (a);
    
  end
  else write('El arbol esta vacio.');
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
End;

{Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.}

Function InformarExistenciaNombreSocio(a: arbol): boolean;

  Function buscarSocioRecursiva(a: arbol; nom: cadena15): boolean;
  begin
    if (a = nil) then 
      buscarSocioRecursiva := false
    else if(a^.dato.nombre = nom) then 
      buscarSocioRecursiva := true
    else begin
      buscarSocioRecursiva := buscarSocioRecursiva(a^.HI,nom) or buscarSocioRecursiva(a^.HD,nom);
    end;
  end;

var nom: cadena15;
begin
  write('Ingrese Nombre de socio: ');
  readln(nom);
  writeln;
  InformarExistenciaNombreSocio := buscarSocioRecursiva(a,nom);
end;


{Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.}
procedure informarNumeroSocioMax(a: arbol);

  function obtenerMasxSocio(a: arbol): integer;
  begin
    if(a <> nil) then begin
      if(a^.HD <> nil) then
        obtenerMasxSocio := obtenerMasxSocio(a^.HD)
      else obtenerMasxSocio := a^.dato.numero;
    end;
  end;

begin
  writeln('---------------- Informar Numero de Socio Mas grande -------->');
  writeln;
  writeln('El numero de socio mas grande es: ',obtenerMasxSocio(a));
  writeln;
end;


{Informar los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.}
procedure informarDatosSocioNumMin(a: arbol);
begin
  if(a <> nil) then
    if(a^.HI = nil) then writeln('| Socio Nro: ',a^.dato.Numero,' | Nombre: ',a^.dato.nombre,' | Edad: ',a^.dato.edad)
    else informarDatosSocioNumMin(a^.HI);
end;

{Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.}
procedure existeNumSocio(a: arbol);

  function buscarNumeroSoc(a: arbol; n: integer): boolean;
  begin
    if (a = nil) then 
      buscarNumeroSoc := false
    else begin
      if(a^.dato.numero = n) then buscarNumeroSoc := true
      else if (a^.dato.numero > n) then buscarNumeroSoc := buscarNumeroSoc(a^.HI,n)
      else buscarNumeroSoc := buscarNumeroSoc(a^.HD,n)
    end;
  end;

var num: integer;
begin
  writeln('------------------ Informar Existencia de Numero de Socio ----------->');
  writeln;
  write('Ingresar Numero a buscar: ');
  readln(num);
  writeln;
  writeln;
  if(buscarNumeroSoc(a,num)) then
    writeln('El numero de socio ingresado existe.')
  else
    writeln('El numero de socio ingresado no existe.');
  writeln;
  writeln;
end;



{Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.}



{Programa Principal}
Var a: arbol;
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  writeln;
  writeln;
  informarNumeroSocioMax(a);
  writeln;
  writeln;
  writeln('-------------------- Informar datos Socio con menor numero --------->');
  writeln;
  writeln;
  informarDatosSocioNumMin(a);
  writeln;
  writeln;
  existeNumSocio(a);
End.