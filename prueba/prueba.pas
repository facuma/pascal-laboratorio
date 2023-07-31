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
    codigodeseado, codigo, resgnombre, resgestado: string;
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
      assign(archsalida,'C:\\Users\\fmati\\Desktop\\LaboratorioPascal\\archivo de salida.dat');
        assign(sec,'C:\\Users\\fmati\\Desktop\\LaboratorioPascal\\secuencia de entrada.txt');
        assign(secsalida,'C:\\Users\\fmati\\Desktop\\LaboratorioPascal\\secuencia de salida.txt');
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
  if not EOF(sec) then
    read(sec,v);
  while not EOF(sec) do
    begin
        For i :=1 to 5 do
        begin
            if not EOF(sec) then
            begin
              write(v);
              read(sec,v);
            end;
        end;
        writeln(' ');
        write('La tecnologia es');
        writeln(v);
        if not EOF(sec) then
            read(sec, v);
        write('El nombre clave es: ');
        while (not EOF(sec)) and (v <>'#') do
        begin
              write(v);
              if not EOF(sec) then
                read(sec,v);
        end;
        writeln(' ');
        if not EOF(sec) then
          read(sec,v);
        For i :=1 to 3 do
        begin
            if not EOF(sec) then
            begin
              write(v);
              read(sec,v);
            end;
        end;
        writeln('');

        For i :=1 to 100 do
        begin
            if not EOF(sec) then
            begin
              write(v);
              read(sec,v);
            end;
        end;
        writeln;
    end;
        writeln('Se ha terminado la secuencia');
end.