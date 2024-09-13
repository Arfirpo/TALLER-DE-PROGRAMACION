
Program firpoAgustin;

Type 
  rangoDiag = 1..6;

  atencion = Record
    matricula: integer;
    dni: integer;
    dia: integer;
    diagnostico: char;
  End;

  lDocumentos = ^nDocumentos;
  nDocumentos = Record
    dato: integer;
    sig: lDocumentos;
  End;

  vDiagnosticos = array[rangoDiag] Of lDocumentos;

  medico = Record
    nroMat: integer;
    cantAtenciones: integer;
  End;

  arbMatriculas = ^Nmatriculas;
  Nmatriculas = Record
    dato: medico;
    HI,HD: arbMatriculas;
  End;

  {modulos}

Procedure inicializarEstructuras(Var v:vDiagnosticos;
                                 Var dimL: rangoDiag;
                                 Var a: arbMatriculas);

Procedure inicializarVector(Var v: vDiagnosticos);

Var i: rangoDiag;
Begin
  For i := 'a' To 'f' Do
    v[i] := Nil;
End;

Procedure inicializarArbol(Var a: arbMatriculas);
Begin
  a := Nil;
End;

Begin
  inicializarVector(v,dimL);
  inicializarArbol(a);
End;

Procedure generarEstructuras(Var v: vDiagnosticos; Var dimL: rangoDiag; Var a: arbMatriculas);

Procedure leerAtencion(Var a: atencion);

Var v: array[rangoDiag] Of string = ('a','b','c','d','e','f');
Begin
  a.dni := Random(5000);
  If (a.dni <> 0) Then
    Begin
      a.matricula := Random(1000) + 2000;
      a.dia := Random(31) + 1;
      a.diagnostico := v[Random(6) + 1];
    End;
End;

Var a: atencion;
Begin
  leerAtencion(a);
  While (a.dni <> 0) Do
    Begin
      agregarAlVector(v,a)
    End;
End;


  {Programa Principal}

Var 
  v: vDiagnosticos;
  dimL: rangoDiag;
  a: arbMatriculas;
Begin
  inicializarEstructuras(v,dimL,a);
  generarEstructuras(v,a);
End.
