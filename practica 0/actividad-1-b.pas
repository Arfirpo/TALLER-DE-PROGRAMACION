{Actividad  1b}
program ProgramaNumAleatorio;

var ale,i,N,A,B: integer;

begin
  randomize;
  write('Ingrese una cantidad N: ');
  readln(N);
  write('Ingrese inicio de rango A: ');
  readln(A);
  write('Ingrese fin de rango B: ');
  readln(B);
  for i:= 1 to N do begin
    ale := random (B - A +1) + A; {devuelve N valores aleatorios en el intervalo A - B}
    writeln ('El numero aleatorio generado es: ', ale);
    writeln ('Presione cualquier tecla para finalizar');
    readln;
  end;
end.
