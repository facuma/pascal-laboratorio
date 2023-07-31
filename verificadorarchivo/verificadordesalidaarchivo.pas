program LeerArchivo;

type
  xcom = record
    nombre_clave: string[30];
    cantidad: integer;
    estado: string[100];
  end;

var
  f: file of xcom;
  reg: xcom;

begin
  assign(f, 'C:\\Users\\facun\\OneDrive\\Escritorio\\LABORATORIO PASCAL\\gitpascal\\pascal-laboratorio\\archivo de salida.dat');
  reset(f);
  writeln;
  writeln('El archivo contiene:');
  while not eof(f) do
  begin
    read(f, reg);
    writeln;
    

    writeln('nombre_clave: ', reg.nombre_clave);
    writeln('cantidad: ', reg.cantidad);
    writeln('estado: ', reg.estado);
    writeln;
  end;
  close(f);
end.