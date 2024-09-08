







{3. Implementar un programa que contenga:
  
  a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
  Informática y los almacene en una estructura de datos. 
  La información que se lee es legajo, código de materia, fecha y nota. 
  La lectura de los alumnos finaliza con legajo 0. 
  La estructura generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
  guardarse los finales que rindió en una lista.
  
  b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
  legajo impar.
  
  c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
  su cantidad de finales aprobados (nota mayor o igual a 4).
  
  d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
  retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

Program nombrePrograma;

Const 
  minAnio = 2000;
  maxAnio = 2024;

Type 

  dias = 1..31;
  meses = 1..12;
  anios = minAnio..maxAnio;
  notas = 1..10;

  fechas = Record
    dia: dias;
    mes: meses;
    anio: anios;
  End;

  final = Record
    codMat: integer;
    fecha: fechas;
    nota: notas;
  End;

  aluFinal = Record
    leg: integer;
    fnl: final;
  End;

  lFinales = ^nFinales;

  nFinales = Record
    dato: final;
    sig: lFinales;
  End;

  alumno = Record
    leg: integer;
    finales: lFinales;
  End;

  arbLeg = ^nArbLeg;

  nArbLeg = Record
    dato: alumno;
    HI: arbLeg;
    HD: arbLeg;
  End;

  promAlu = Record
    leg: integer;
    prom: real;
  End;

  lPromedios = ^nPromedios;

  nPromedios = Record
    dato: promAlu;
    sig: lPromedios;
  End;

{modulos}

Procedure generarArbol(Var a: arbLeg);

Procedure leerAlu(Var af: aluFinal);
Begin
  With af Do
    Begin
      leg := Random(101);
      If leg <> 0 Then
        Begin
          fnl.codMat := Random(24) + 1;
          fnl.fecha.dia := 1 + Random(31);
          fnl.fecha.mes := 1 + Random(12);
          fnl.fecha.anio := Random(maxAnio - minAnio + 1) + minAnio;
          fnl.nota := 1 + Random(10);
        End;
    End;
End;

Procedure agregar(Var a: arbLeg; af: aluFinal);

Procedure AgregarAdelante(Var l: lFinales; f: final);

Var nue: lFinales;
Begin
  new(nue);
  nue^.dato.codMat := f.codMat;
  nue^.dato.fecha := f.fecha;
  nue^.dato.nota := f.nota;
  nue^.sig := l;
  l := nue;
End;

Procedure copiarDatos(Var a: alumno; af: aluFinal);
Begin
  a.leg := af.leg;
  a.finales := Nil;
  AgregarAdelante(a.finales,af.fnl);
End;

Begin
  If (a = Nil) Then
    Begin
      new(a);
      copiarDatos(a^.dato,af);
      a^.HI := Nil;
      a^.HD := Nil;
    End
  Else
    Begin
      If (af.leg = a^.dato.leg) Then
        AgregarAdelante(a^.dato.finales,af.fnl)
      Else
        Begin
          If (af.leg > a^.dato.leg) Then
            agregar(a^.HD,af)
          Else
            agregar(a^.HI,af);
        End;
    End;
End;

Var af: aluFinal;
Begin
  a := Nil;
  leerAlu(af);
  While (af.leg <> 0) Do
    Begin
      agregar(a,af);
      leerAlu(af);
    End;
End;

Procedure imprimirArbol(a: arbLeg);

Procedure imprimirListaFinales(l: lFinales);
Begin

  While (l <> Nil) Do
    Begin
      writeln('Materia Nro ',l^.dato.codMat,' | Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio,' | Nota obtenida: ',l^.dato.
              nota,'.');
      l := l^.sig;
    End;
End;

Procedure imprimirNodo(a: alumno);
Begin
  writeln;
  writeln('-----------------------------------------------------');
  writeln('|  Finales rendidos por el Alumno Legajo Nro: ',a.leg,'.  |');
  writeln('-----------------------------------------------------');
  writeln;
  imprimirListaFinales(a.finales);
End;

Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then
        imprimirArbol(a^.HI);
      imprimirNodo(a^.dato);
      If ( a^.HD <> Nil) Then
        imprimirArbol(a^.HD);
    End;
End;

Function legajosImpares(a: arbLeg): integer;
Begin
  If (a = Nil) Then legajosImpares := 0
  Else If (a^.dato.leg Mod 2 = 1) Then legajosImpares := legajosImpares(a^.HI) + 1 + legajosImpares(a^.HD)
  Else legajosImpares := legajosImpares(a^.HI) + legajosImpares(a^.HD);
End;

Procedure finalesAprobados(a: arbLeg);

Function cantFinales(l: lFinales): integer;

Var cant: integer;
Begin
  cant := 0;
  While (l <> Nil) Do
    Begin
      If (l^.dato.nota >= 4) Then cant := cant + 1;
      l := l^.sig;
    End;
  cantFinales := cant;
End;

Begin
  If (a <> Nil) Then
    Begin
      If (a^.HI <> Nil) Then finalesAprobados(a^.HI);
      writeln('La cantidad de finales aprobados por el alumno con legajo ',a^.dato.leg,' es: ',cantFinales(a^.dato.finales));
      If (a^.HD <> Nil) Then finalesAprobados(a^.HD);
    End;
End;

Procedure promediosAlu(a: arbLeg; n: real; Var l: lPromedios);

Procedure agregarListaProm(Var l: lPromedios; prom: real; leg: integer);

Var nue: lPromedios;
Begin
  new(nue);
  nue^.dato.leg := leg;
  nue^.dato.prom := prom;
  nue^.sig := l;
  l := nue;
End;

Function calcularProm(l: lFinales): real;

Var totNotas,cantNotas: integer;
Begin
  totNotas := 0;
  cantNotas := 0;
  While (l <> Nil) Do
    Begin
      totNotas := totNotas + l^.dato.nota;
      cantNotas := cantNotas + 1;
      l := l^.sig;
    End;
  If (cantNotas > 0) Then calcularProm := totNotas / cantNotas
  Else calcularProm := -1;
End;

Var prom: real;
Begin
  If (a <> Nil) Then
    Begin
      prom := 0;
      If (a^.HI <> Nil) Then promediosAlu(a^.HI,n,l);
      prom := calcularProm(a^.dato.finales);
      If (prom >= n) Then agregarListaProm(l,prom,a^.dato.leg);
      If (a^.HD <> Nil) Then promediosAlu(a^.HD,n,l);
    End;
End;

Procedure imprimirLista(l: lPromedios);
Begin
  While (l <> Nil) Do
    Begin
      writeln('| Legajo Nro. ',l^.dato.leg,' | Promedio: ',l^.dato.prom:0:2,' |');
      l := l^.sig;
    End;
End;

{Programa principal}

Var 
  a: arbLeg;
  numR: real;
  l: lPromedios;
Begin
  Randomize;
  generarArbol(a);
  If (a <> Nil) Then
    Begin
      writeln;
      writeln(' -------------------------- ARBOL DE LEGAJOS --------------------------');
      imprimirArbol(a);
      writeln;
      writeln(' ////////////////////////////////////////////////////////////////      ');
      writeln;
      writeln('La cantidad de legajos impares es: ',legajosImpares(a));
      writeln;
      writeln(' ////////////////////////////////////////////////////////////////      ');
      writeln;
      finalesAprobados(a);
      writeln;
      writeln(' ////////////////////////////////////////////////////////////////      ');
      writeln;
      write('Ingrese un promedio: ');
      readln(numR);
      writeln;
      writeln(' -------------------------- LISTADO DE LEGAJOS CON PROMEDIO ',numR:0:2,' O SUPERIOR --------------------------');
      writeln;
      promediosAlu(a,numR,l);
      If (l <> Nil) Then
        imprimirLista(l);
      writeln;
      writeln(' ////////////////////////////////////////////////////////////////      ');
      writeln;
    End;
End.
