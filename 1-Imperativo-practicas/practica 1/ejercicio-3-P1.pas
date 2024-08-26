program ejercicio3P1;

Const
  dimF_gen = 8;

type
  rGen: 1..dimF_gen;

  pelicula = Record
    cod: integer;
    gen: rGen;
    cal: real;
  end;

  lPeliculas = ^nPeliculas;

  nPeliculas = record
    dato: pelicula;
    sig: lPeliculas;
  end;

  lista = record
    pri: lPeliculas;
    ult: lPeliculas;
  end;

  vGeneneros = array[rGen] of lista;


{modulos}

  procedure leerPelicula(var p: pelicula);
  begin
    with p do begin
      cod := Random(102) - 1;
      gen := Random(dimF_gen) + 1;
      cal := Random(10) + 1;
    end;
  end;

  procedure agregarAtras(var l: lista; p: pelicula);
  var
    nue: lPeliculas;
  begin
    new(nue);
    nue^.dato := p;
    if l.pri = nil then
      l.pri := nue
    else
      l.ult^.sig := nue;
    l.ult := nue;
  end;

  procedure generarLista(var l: lista);
  var
    p: pelicula;
  begin
    leerPelicula(p);
    while (p.cod <> -1) do begin
      agregarAtras(l,p);
      leerPelicula(p);
    end;
  end;

  procedure inicializarVector(var v: vGeneneros);
  var
    i: rGen;
  begin
    for i := 1 to dimF_gen do
      v[i].pri := Nil;
      v[i].ult := Nil;
  end;

  procedure cargarVector(var v:vGeneneros);
  var
    i: rGen;
    p: pelicula;
  begin
    leerPelicula(p);
    while
  end;

{Programa principal}
var
  v: vGeneneros;
begin
  Randomize;
  inicializarVector(v);
  cargarVector(v);
  
end.
