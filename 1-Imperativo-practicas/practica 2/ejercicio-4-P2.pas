
Program ejercicio4P2;

{ Módulos }

Procedure decAbinRecursivo(N: integer);
Begin
  If N < 2 Then
    write(N)
  Else
    Begin
      decAbinRecursivo(N Div 2);
      write(N Mod 2);
    End;
End;

Procedure convertirRecursivo;

Var 
  N: integer;
Begin
  write('Ingrese decimal a convertir (0 para salir): ');
  readln(N);

  If N <> 0 Then
    Begin
      write('Binario resultante: ');
      decAbinRecursivo(N);
      writeln;
      writeln;
      convertirRecursivo;  { Llamada recursiva para continuar el proceso }
    End
  Else
    Begin
      writeln('Programa finalizado.');
      writeln;
    End;
End;

{ Programa Principal }

Begin
  writeln;
  convertirRecursivo;
  writeln;
End.
