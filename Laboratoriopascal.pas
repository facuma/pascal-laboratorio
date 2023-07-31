program tema4.pas;
  uses CRT;
  
  type
    xcom = record
      nombre_clave: string[30];
      cantidad: integer;
      estado: string[100];
    end;
  
  var 
    contB,contL,contP,cont, centena, decena, unidad, cantnro, i, j:integer;
    tecnologia: char;
    codigo, resgnombre, resgestado, digitocod: string;
    codigodeseado: string[5];
    codigostr: string[5];
    archsalida: file of xcom;
    sec, secsalida:file of char;
    v:char;
    reg: xcom;

  function CONVERTIR(x:char):integer;
    begin
      case x of
      '0':CONVERTIR:= 0;
      '1':CONVERTIR:= 1;
      '2':CONVERTIR:= 2;
      '3':CONVERTIR:= 3;
      '4':CONVERTIR:= 4;
      '5':CONVERTIR:= 5;
      '6':CONVERTIR:= 6;
      '7':CONVERTIR:= 7;
      '8':CONVERTIR:= 8;
      '9':CONVERTIR:= 9;
      end;
    end;

  procedure ESCRIBIRSECSALIDA;
    begin
      if tecnologia <> 'B' then
        write(secsalida,v);
    end;

  procedure INICIALIZACION;
    begin
      cont := 0;
      digitocod:='';
      codigostr:= '';
      codigo := '';
      resgnombre := '';
      contB:=0; 
      contL:=0; 
      contP:=0;
      centena:=0; 
      decena:=0; 
      unidad:=0;
      cantnro:=0;
      i:=0;
      j:=0;
      assign(archsalida,'C:\\Users\\fmati\\Desktop\\gitPascal\\archivo de salida.dat');
        assign(sec,'C:\\Users\\fmati\\Desktop\\gitPascal\\secuencia de entrada.txt');
        assign(secsalida,'C:\\Users\\fmati\\Desktop\\gitPascal\\secuencia de salida.txt');
 //antes era .txt
      {$I-}
      reset(sec);
      {$I+}
      {$I-}
      rewrite(archsalida);
      {$I+}
      {$I-}
      rewrite(secsalida);
      {$I+}
      read(sec,v)
    end;

  procedure TRANSFORMAR;
    begin
      centena:= CONVERTIR(v)*100;
      ESCRIBIRSECSALIDA;
      read(sec,v);

      decena:= CONVERTIR(v)*10;
      ESCRIBIRSECSALIDA;
      read(sec,v);

      unidad:= CONVERTIR(v);
      cantnro:= centena + decena + unidad;
      ESCRIBIRSECSALIDA;
    end;

  procedure ACUMULARCANTIDAD;
    begin
      case tecnologia of
        'B': contB:= contB + cantnro;
        'L': contL:= contL + cantnro;
        'P': contP:= contP + cantnro;
      end;
    end;

begin
  INICIALIZACION;
write('Ingrese el codigo a analizar: ');
readln(codigodeseado);
delay(1000);

writeln('_______________________________________________________________');
writeln('Los materiales con la tecnologia B son: ');
writeln('');
writeln('     ______________________________________________________     ');
write('     |      Material            |');
write('    Cantidad             |');
writeln('');
writeln('     |____________________________________________________|     ');


if not EOF(sec) then
  read(sec,v);
while not EOF(sec) do
  begin
  codigo:= '';
    For i :=1 to 5 do
    begin
      if not EOF(sec) then
      begin
        digitocod:= v;
        codigo := codigo + digitocod;
        read(sec,v);
      end;
    end;
    codigostr := codigo;
    if not EOF(sec) then
    begin
      tecnologia:=v;
      ESCRIBIRSECSALIDA;
      read(sec, v);
    end;
    reg.nombre_clave:= '';
    while (not EOF(sec)) and (v <>'#') do
      begin
        ESCRIBIRSECSALIDA;

        reg.nombre_clave:= reg.nombre_clave + v;
        if not EOF(sec) then
          read(sec,v);
      end;
    if not EOF(sec) then
    begin
      ESCRIBIRSECSALIDA;
      read(sec,v);
    end;
    TRANSFORMAR;
    ACUMULARCANTIDAD;
    reg.cantidad := cantnro;
    if not EOF(sec) then
    begin
      read(sec,v);
    end;
    reg.estado:= '';
    For i :=1 to 100 do
    begin
      if not EOF(sec) then
      begin
        reg.estado:= reg.estado + v;
        read(sec,v);
      end;
    end;

    if tecnologia = 'B' then
    begin
      write('     |');
      write(reg.nombre_clave);
      write('               |         ');
      write(reg.cantidad);
      writeln('             |');
    end;
    
    if tecnologia = 'L' then
    begin
      if codigostr = codigodeseado then
      begin
        cont := cont+1;
        write(archsalida, reg);
      end;
    end;

  end;

  writeln('_______________________________________________________________');
  writeln('');
  write('La cantidad de materiales en B es de: ');
  writeln(contB);
  write('La cantidad de materiales en L es de: ');
  writeln(contL);
  write('La cantidad de materiales en P es de: ');
  writeln(contP);

  writeln('_______________________________________________________________');
  writeln('');

  write('Se han guardado: ');
  write(cont);
  writeln(' registros en el archivo de salida.');

  close(sec);
  close(secsalida);
  close(archsalida);


end.