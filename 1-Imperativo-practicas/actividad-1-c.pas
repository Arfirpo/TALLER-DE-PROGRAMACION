{Actividad  1c}
program ProgramaNumAleatorio;

var ale,A,B,F: integer;

begin
  randomize;
  write('Ingrese inicio de rango A: ');
  readln(A);
  write('Ingrese fin de rango B: ');
  readln(B);
  repeat
    write('Ingrese numero F: ');
    readln(F);
  until ((F >= A) and (F <= B));
  ale := random (B - A +1) + A; {devuelve N valores aleatorios en el intervalo A - B}
  while (ale <> F) do begin
    writeln ('El numero aleatorio generado es: ', ale);
    writeln ('Presione cualquier tecla para finalizar');
    readln;
    ale := random (B - A +1) + A; {devuelve N valores aleatorios en el intervalo A - B}
  end;
end.
