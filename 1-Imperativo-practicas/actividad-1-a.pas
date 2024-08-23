{Actividad  2a}
program ProgramaNumAleatorio;

var ale, i: integer;

begin
  randomize; 
  for i:= 1 to 20 do begin
    ale := random (100); {devuelve un valor aleatorio en el intervalo 0 a 99}
    writeln ('El numero aleatorio generado es: ', ale);
    writeln ('Presione cualquier tecla para finalizar');
    readln;
  end;
end.
