program tema4.pas;
  uses CRT;
  
  type
    xcom = record
      nombre_clave: string[30];
      cantidad: integer;
      estado: string[100];
    end;
  
  var 
    contB,contL,contP, centena, decena, unidad, cantnro, i, j:integer;
    tecnologia: char;
    codigodeseado, codigo, resgnombre, resgestado, codigostr: string;
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
read(codigodeseado);
delay(1000);
writeln('Los materiales con la tecnologia B son: ');
write('            Material            |');
write('    Cantidad     |');
writeln('');


if not EOF(sec) then
  read(sec,v);
while not EOF(sec) do
  begin
  codigo:= '';
    For i :=1 to 5 do
      begin
        if not EOF(sec) then
        begin
          codigo:= codigo + v;
          
          read(sec,v);
        end;
      end;
    Str(codigo, codigostr);
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
    writeln(' ');
    if not EOF(sec) then
    begin
      ESCRIBIRSECSALIDA;
      read(sec,v);
    end;
    TRANSFORMAR;
    ACUMULARCANTIDAD;
    reg.cantidad := cantnro;
    writeln('');
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
      write(reg.nombre_clave);
      write('   |     ');
      writeln(reg.cantidad);
    end;
    if tecnologia = 'L' and codigostr = codigodeseado then
    begin
      write(archsalida, reg);
    end;

  end;

  write('');

  write('La cantidad de materiales en B es de: ');
  writeln(contB);
  write('La cantidad de materiales en L es de: ');
  writeln(contL);
  write('La cantidad de materiales en P es de: ');
  writeln(contP);

  close(sec);
  close(secsalida);
  close(archsalida);


end.