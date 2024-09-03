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

program nombrePrograma;

Const
  minAnio = 2000;
  maxAnio = 2024;

type
  
  dias = 1..31;
  meses = 1..12;
  anios = minAnio..maxAnio;
  notas = 1..10;

  fechas = record
    dia: dias;
    mes: meses;
    anio: anios;
  end;
{podria hacer un registro aluFinal que tenga legajo y un registro final}
  final = record
    leg: integer;
    codMat: integer;
    fecha: fechas;
    nota: notas;
  end;

  final2 = record
    codMat: integer;
    fecha: fechas;
    nota: notas;
  end;

  lFinales = ^nFinales;
  
  nFinales = record
    dato: final2;
    sig: lFinales;
  end;

  alumno = record
    leg: integer;
    finales: lFinales;
  end;

  arbLeg = ^nArbLeg;

  nArbLeg = record
    dato: alumno;
    HI: arbLeg;
    HD: arbLeg;
  end;

{modulos}

procedure generarArbol(var a: arbLeg);

  procedure leerFinal(var f: final);
  begin
    with f do begin
      leg := Random(101);
      if leg <> 0 then begin
        codMat := Random(24) + 1;
        fecha.dia := 1 + Random(31);
        fecha.mes := 1 + Random(12);
        fecha.anio := Random(maxAnio - minAnio + 1) + minAnio;
        nota := 1 + Random(10);        
      end;
    end;
  end;

  procedure agregar(var a: arbLeg; f: final);

    procedure AgregarAdelante(var l: lFinales; f: final);
    var nue: lFinales;
    begin
      new(nue);
      nue^.dato.codMat := f.codMat;
      nue^.dato.fecha := f.fecha;
      nue^.dato.nota := f.nota;
      nue^.sig := l;
      l := nue;
    end;
    
    procedure copiarDatos(var a: alumno; f: final);
    begin
      a.leg := f.leg;
      a.finales := nil;
      AgregarAdelante(a.finales,f);
    end;

  begin
    if (a = nil) then begin
      new(a);
      copiarDatos(a^.dato,f);
      a^.HI := nil;
      a^.HD := nil;
    end
    else begin
      if(f.leg = a^.dato.leg) then
        AgregarAdelante(a^.dato.finales,f)
      else begin
        if (f.leg > a^.dato.leg) then
          agregar(a^.HD,f)
        else
          agregar(a^.HI,f);
      end;      
    end;
  end;
var f: final;
begin
  a := nil;
  leerFinal(f);
  while(f.leg <> 0) do begin
    agregar(a,f);
    leerFinal(f);
  end;
end;

procedure imprimirArbol(a: arbLeg);

  procedure imprimirListaFinales(l: lFinales);
  begin
    
    while(l <> nil) do begin
      
      writeln('Materia Nro ',l^.dato.codMat,' | Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio,' | Nota obtenida: ',l^.dato.nota,'.');
      
      l := l^.sig;
    end;
    
    
  end;

  procedure imprimirNodo(a: alumno);
  begin
    writeln;
    writeln('-----------------------------------------------------');
    writeln('|  Finales rendidos por el Alumno Legajo Nro: ',a.leg,'.  |');
    writeln('-----------------------------------------------------');
    writeln;
    imprimirListaFinales(a.finales);
  end;

begin
  if (a <> nil) then begin
    if(a^.HI <> nil) then
      imprimirArbol(a^.HI);
    imprimirNodo(a^.dato);
    if( a^.HD <> nil) then
      imprimirArbol(a^.HD);
  end;
end;

{Programa principal}
var
  a: arbLeg;
begin
  Randomize;
  generarArbol(a);
  if (a <> nil) then begin
    writeln;
    writeln(' --------------------------ARBOL DE LEGAJOS --------------------------');
    imprimirArbol(a);
    writeln;    
  end;
    
end.
