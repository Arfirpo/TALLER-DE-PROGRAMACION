
Program ejercicio3P1;

Const 
  dimF_gen = 8;

Type 
  rGen  = 1..dimF_gen;

  pelicula = Record
    cod: integer;
    gen: rGen;
    cal: real;
  End;

  lPeliculas = ^nPeliculas;

  nPeliculas = Record
    dato: pelicula;
    sig: lPeliculas;
  End;

  maximos = Record
    codMax: integer;
    punMax: real;
  End;

  lista = Record
    pri: lPeliculas;
    ult: lPeliculas;
  End;

  vGeneneros = array[rGen] Of lista;
  vMax = array[rGen] Of maximos;

{modulos}

Procedure leerPelicula(Var p: pelicula);
Begin
  With p Do
    Begin
      cod := Random(22) - 1;
      If cod <> -1 Then
        Begin
          gen := Random(dimF_gen) + 1;
          cal := Random(10) + 1;
        End;
    End;
End;

Procedure agregarAtras(Var l: lista; p: pelicula);

Var 
  nue: lPeliculas;
Begin
  new(nue);
  nue^.dato := p;
  nue^.sig := Nil;
  If (l.pri = Nil) Then
    l.pri := nue
  Else
    l.ult^.sig := nue;
  l.ult := nue;
End;

Procedure cargarVector(Var v:vGeneneros);

Var 
  p: pelicula;
Begin
  leerPelicula(p);
  While (p.cod <> -1) Do
    Begin
      agregarAtras(v[p.gen],p);
      leerPelicula(p);
    End;
End;

Procedure inicializarVector(Var v: vGeneneros);

Var 
  i: rGen;
Begin
  For i := 1 To dimF_gen Do
    Begin
      v[i].pri := Nil;
      v[i].ult := Nil;
    End;
End;

Procedure inicializarMaximos(Var v: vMax);

Var 
  i: rGen;
Begin
  For i := 1 To dimF_gen Do
    Begin
      v[i].punMax := -1;
      v[i].codMax := -1;
    End;
End;

Procedure imprimirVector(v: vGeneneros);

Var 
  i: rGen;
  aux: lPeliculas;
Begin
  For i := 1 To dimF_gen Do
    Begin
      aux := v[i].pri;
      While (aux <> Nil) Do
        Begin
          writeln();
          write('Codigo de pelicula: ', aux^.dato.cod);
          writeln();
          write('Codigo de genero: ', aux^.dato.gen);
          writeln();
          write('Calificación de la pelicula: ', aux^.dato.cal);
          aux := aux^.sig;  { Avanzar en la lista }
        End;
    End;
End;

Procedure maxPeliculas(v: vGeneneros; Var vM: vMax);

Var 
  i: integer;
  act: lPeliculas;
Begin
  For i := 1 To dimF_gen Do
    Begin
      act := v[i].pri;
      While (act <> Nil) Do
        Begin
          If (act^.dato.cal > vM[i].punMax) Then
            Begin
              vM[i].punMax := act^.dato.cal;
              vM[i].codMax := act^.dato.cod;
            End;
          act := act^.sig;
        End;
    End;
End;

Procedure ordenacionInsercion (Var v: vMax);

Var 
  j, i: integer;
  aux: maximos;
Begin
  For i:= 2 To dimF_gen Do
    Begin
      aux := v[i];
      j := i-1;
      While (j > 0) And (v[j].punMax > aux.punMax) Do
        Begin
          v[j+1] := v[j];
          j := j -1;
        End;
      v[j+1] := aux;
    End;
End;

Procedure mostrarVecMax(Var v: vMax);

Var 
  i: integer;
Begin
  For i:= dimF_gen Downto 1 Do
    Begin
      If (i = dimF_gen)Then
        writeln('El codigo de pelicula con mayor puntaje es: ',v[i].codMax);
      If (i = 1)Then
        writeln('El codigo de pelicula con menor puntaje es: ',v[i].codMax);
    End;
End;

// procedure imprimirVector(v: vRubros);
// var
//   i: rRubro; 
//   l: lProductos;
// begin
//   for i := 1 to dimF_rubro do begin
//     writeln('                 ----------------------         ');
//     writeln('                 Productos del Rubro: ', i, '.');
//     writeln('                 ----------------------         ');
//     l := v[i];
//     while (l <> nil) do begin
//       write('|Codigo de Producto: ', l^.dato.codP, '|');
//       write(' Codigo de Rubro: ', l^.dato.codR, '|');
//       write(' Precio del Producto: ', l^.dato.precio:0:2, '|');
//       writeln;
//       l := l^.sig;
//     end;
//   end;
//   writeln('--------------------------------------');
// end;


{Programa principal}

Var 
  v: vGeneneros;
  vM: vMax;
Begin
  Randomize;

  inicializarVector(v);
  cargarVector(v);
  imprimirVector(v);

  inicializarMaximos(vM);
  maxPeliculas(v,vM);

  ordenacionInsercion(vM);
  mostrarVecMax(vM);
End.
