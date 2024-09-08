
{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. 
La informacion de cada socio debe generarse aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente.
    ii. Informar los datos de los socios en orden decreciente.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.
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

{ Informar los datos de los socios en orden decreciente. }

procedure InformarSociosOrdenDecreciente(a: arbol);

  Procedure InformarDatosSociosOrdenDecreciente (a: arbol);
    Begin
      If (a^.HD <> Nil)Then
        InformarDatosSociosOrdenDecreciente (a^.HD);
      writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
      If (a^.HI <> Nil)Then
        InformarDatosSociosOrdenDecreciente (a^.HI);
    End;
begin
  if(a <> nil) then begin
    writeln;
    writeln ('----- Socios en orden decreciente por numero de socio ----->');
    writeln;
    InformarDatosSociosOrdenDecreciente (a);
    end
    else 
      write('El arbol esta vacio.');
  writeln;
  writeln('//////////////////////////////////////////////////////////');
  writeln;
end;

{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }
Procedure InformarNumeroSocioConMasEdad (a: arbol);

  Procedure actualizarMaximo(Var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
  Begin
    If (nuevoValor >= maxValor) Then
      Begin
        maxValor := nuevoValor;
        maxElem := nuevoElem;
      End;
  End;

  Procedure NumeroMasEdad (a: arbol; Var maxEdad: integer; Var maxNum: integer);
  Begin
    If (a <> Nil) Then
      Begin
        actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
        numeroMasEdad(a^.hi, maxEdad,maxNum);
        numeroMasEdad(a^.hd, maxEdad,maxNum);
      End;
  End;

Var maxEdad, maxNum: integer;
Begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  If (maxEdad = -1)
    Then writeln ('Arbol sin elementos')
  Else
    Begin
      writeln;
      writeln ('Numero de socio con mas edad: ', maxNum);
      writeln;
    End;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
End;

{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
Procedure AumentarEdadNumeroImpar (a: arbol);

  Function AumentarEdad (a: arbol): integer;
  Var resto: integer;
  Begin
    If (a = Nil)
      Then AumentarEdad := 0
    Else
      Begin
        resto := a^.dato.edad Mod 2;
        If (resto = 1) Then a^.dato.edad := a^.dato.edad + 1;
        AumentarEdad := resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
      End;
  End;

Begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
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

function InformarCantidadSocios(a: arbol): integer;
begin
  if (a = nil) then InformarCantidadSocios := 0
  else
    InformarCantidadSocios := InformarCantidadSocios(a^.HI) + 1 + InformarCantidadSocios(a^.HD);
end;

function InformarPromedioDeEdad(a: arbol): real;

  function sumaEdadRecursiva(a: arbol): integer;
  begin
    if(a = nil) then sumaEdadRecursiva := 0
    else
      sumaEdadRecursiva := sumaEdadRecursiva(a^.HI) + a^.dato.edad + sumaEdadRecursiva(a^.HD);
  end;

begin
  InformarPromedioDeEdad := sumaEdadRecursiva(a);
end;

{Programa Principal}
Var a: arbol; cantSocios: integer;
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  InformarSociosOrdenDecreciente (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  writeln;
  if(InformarExistenciaNombreSocio (a)) then writeln('El socio existe.')
  else writeln('El socio no existe.');
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
  cantSocios := InformarCantidadSocios (a);
  write('La cantidad de socios es de: ');
  writeln(cantSocios); 
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
  write('El promedio de edad de los socios es de: ');
  writeln((InformarPromedioDeEdad (a) / cantSocios):0:2);
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
End.