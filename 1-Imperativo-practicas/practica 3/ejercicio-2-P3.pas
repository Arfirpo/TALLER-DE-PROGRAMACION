program ejercicio2P3;

Const
  dMax = 31;
  mMax = 12;
  anio_min = 2020;
  anio_act = 2024;

{-------------------- tipos de datos --------------------}
  type
    dias = 1..dMax;
    meses = 1..mMax;
    anios = anio_min..anio_act;

    fechas = record
      dia: dias;
      mes: meses;
      anio: integer;
    end;

    venta = record
      codigo: integer;
      fecha: fechas;
      u_vendidas: integer;
    end;

    arb_Ventas = ^nArb_Ventas;

    nArb_Ventas = record
      dato: venta;
      HI: arb_Ventas;
      HD: arb_Ventas;
    end;

    producto = record
      codigo: integer;
      totVendido: integer;
    end;

    arb_productos = ^nArb_Productos;

    nArb_Productos = record
      dato: producto;
      HI: arb_productos;
      HD: arb_productos;
    end;

    venta2 = record
      fecha: fechas;
      u_vendidas: integer;
    end;

    lVentas = ^nVentas;

    nVentas = record
      dato: venta2;
      sig: lVentas;
    end;

    producto2 = record
      codigo: integer;
      ventas: lVentas;
    end;

    arb_productos2 = ^nArb_Productos2;
    
    nArb_Productos2 = record
      dato: producto2;
      HI: arb_productos2;
      HD: arb_productos2;
    end;

{----------------------- modulos -----------------------}

  procedure generarArbol(var a:arb_Ventas; var b: arb_productos; var c: arb_productos2);
  
  { -------------------------------- ARBOL I --------------------------------}
    procedure generarArbol1(var a: arb_Ventas);

      Procedure cargarVenta(var v: venta);
      begin
        with v do begin
          codigo := Random(101);
          if codigo <> 0 then begin
            u_vendidas := 1 + Random(100);
            fecha.dia := 1 + Random(dMax);
            fecha.mes := 1 + Random(mMax);
            fecha.anio := anio_min + Random(anio_act - anio_min + 1);
          end;
        end;
      end;

      procedure InsertarElemento(var a: arb_Ventas; v: venta);
      begin
        if(a = nil) then begin
          new(a);
          a^.dato := v;
          a^.HI := nil;
          a^.HD := nil;  
        end
        else if (v.codigo >= a^.dato.codigo) then
          InsertarElemento(a^.HD,v)
        else
          InsertarElemento(a^.HI,v);
      end;

    var v: venta;
    begin
      a := nil;
      cargarVenta(v);
      while(v.codigo <> 0) do begin
        InsertarElemento(a,v);
        cargarVenta(v);
      end;
    end;

  {-------------------------------- ARBOL II --------------------------------}
    procedure generarArbol2(var aProd: arb_productos; aVentas: arb_Ventas);

      procedure cargarProducto(var p: producto; codigo,u_vendidas: integer);
      begin
        p.codigo := codigo;
        p.totVendido := u_vendidas;
      end;

      procedure agregarOactualizar(var aProd: arb_productos; codigo,u_vendidas: integer);
      begin
        if(aProd = nil) then begin
          new(aProd);
          cargarProducto(aProd^.dato,codigo,u_vendidas);
          aProd^.HI := nil;
          aProd^.HD := nil;
        end
        else begin
          if(codigo = aProd^.dato.codigo) then
            aProd^.dato.totVendido := aProd^.dato.totVendido + u_vendidas
          else begin
            if(codigo > aProd^.dato.codigo) then
              agregarOactualizar(aProd^.HD,codigo,u_vendidas)
            else
              agregarOactualizar(aProd^.HI,codigo,u_vendidas);
          end
        end;
      end;

      procedure recorrerArbVentas(var aProd: arb_productos; aVentas: arb_Ventas);
      begin
        if(aVentas <> nil) then begin
          if(aVentas^.HD <> nil) then
            recorrerArbVentas(aProd, aVentas^.HD);
          agregarOactualizar(aProd,aVentas^.dato.codigo,aVentas^.dato.u_vendidas);
          if(aVentas^.HI <> nil) then
            recorrerArbVentas(aProd, aVentas^.HI);
        end;
      end;

    begin
      aProd := nil;
      recorrerArbVentas(aprod,aVentas);
    end;
  
  {-------------------------------- ARBOL III --------------------------------}
    procedure generarArbol3(var c: arb_productos2; a: arb_Ventas);

      procedure recorrerArbVentas2(var c: arb_productos2; a: arb_Ventas);

        procedure agregar(var c: arb_productos2; v: venta);

          procedure cargarProducto2(var p2: producto2; v: venta);
          var l: lVentas;
          begin
            p2.codigo := v.codigo;
            new(p2.ventas);
            l := p2.ventas;
            l^.dato.fecha := v.fecha;
            l^.dato.u_vendidas := v.u_vendidas;
            l^.sig := nil;
          end;

          procedure insertarOrdenado(var l: lVentas; v: venta);
          var 
            nue,ant,act: lVentas;
            v2: venta2;
          begin
            v2.fecha := v.fecha;
            v2.u_vendidas := v.u_vendidas;
            new(nue);
            nue^.dato := v2;
            ant := l;
            act := l;
            while(act <> nil) and ((v.fecha.anio > act^.dato.fecha.anio) or ((v.fecha.anio = act^.dato.fecha.anio) and (v.fecha.mes > act^.dato.fecha.mes)) or ((v.fecha.anio = act^.dato.fecha.anio) and (v.fecha.mes = act^.dato.fecha.mes) and ((v.fecha.dia > act^.dato.fecha.dia)))) do begin
              ant := act;
              act := act^.sig;
            end;
            if(act = ant) then
              l := nue
            else
              ant^.sig := nue;
            nue^.sig := act;
            
          end;

        begin
          if (c = nil) then begin
            new(c);
            cargarProducto2(c^.dato,v);
            c^.HI := nil;
            c^.HD := nil;
          end
          else begin
            if(c^.dato.codigo = v.codigo) then 
              insertarOrdenado(c^.dato.ventas,v)
            else begin
              if(v.codigo > c^.dato.codigo) then
                agregar(c^.HD,v)
              else
                agregar(c^.HI,v);
            end;
          end;
        end;

      begin
        if(a <> nil) then begin
          if(a^.HD <> nil) then
            recorrerArbVentas2(c,a^.HD);
          agregar(c,a^.dato);
          if(a^.HI <> nil) then
            recorrerArbVentas2(c,a^.HI);
        end;
      end;

    begin
      c := nil;
      recorrerArbVentas2(c,a);
    end;

  begin
    generarArbol1(a);
    generarArbol2(b,a);
    generarArbol3(c,a);
  end;

  procedure imprimirArbol(a:arb_Ventas;b: arb_productos;c: arb_productos2);
  
  { -------------------------------- ARBOL I --------------------------------}
    procedure imprimirArbol1(a: arb_Ventas);
    begin
      if (a <> nil) then begin
        imprimirArbol1(a^.HI);
        writeln('| Codigo de Producto: ',a^.dato.codigo,' | Fecha: ',a^.dato.fecha.dia,'/',a^.dato.fecha.mes,'/',a^.dato.fecha.anio,' | Unidades vendidas: ',a^.dato.u_vendidas,' |');
        imprimirArbol1(a^.HD);
      end;
    end;
  
  {-------------------------------- ARBOL II --------------------------------}
    procedure imprimirArbol2(a: arb_productos);
    begin
      if (a <> nil) then begin
        imprimirArbol2(a^.HI);
        writeln('| Codigo de Producto: ',a^.dato.codigo,' | Total de Unidades vendidas: ',a^.dato.totVendido,' |');
        imprimirArbol2(a^.HD);
      end;
    end;
  
  {-------------------------------- ARBOL III --------------------------------}
    procedure imprimirArbol3(a: arb_productos2);

      procedure imprimirVentas(l: lVentas);
      begin
        while (l <> nil) do begin
          
          write('Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio);
          writeln(' | Cantidad de unidades vendidas: ',l^.dato.u_vendidas);
          l := l^.sig;
        end;
      end;

      procedure imprimirNodo(p: producto2);
      begin
        writeln;
        writeln('-----------------------------------------------------');
        write('Codigo de Producto: ',p.codigo,' - ');
        writeln('Ventas ordenadas por fecha');
        writeln;
        imprimirVentas(p.ventas);
      end;

    begin
      if (a <> nil) then begin
        imprimirArbol3(a^.HI);
        imprimirNodo(a^.dato);
        imprimirArbol3(a^.HD);
      end;
    end;
  begin
    if(a <> nil) then begin
      writeln('        --------------- | ARBOL I | ---------------');
      writeln;
      imprimirArbol1(a);
      writeln;
    end
    else write('El arbol esta vacio.');
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
    if(b <> nil) then begin
      writeln('        --------------- | ARBOL II | ---------------');
      writeln;
      imprimirArbol2(b);
      writeln;
    end
    else write('El arbol esta vacio.');
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
    if(c <> nil) then begin
      writeln('        --------------- | ARBOL III | ---------------');
      writeln;
      imprimirArbol3(c);
      writeln;
    end
    else write('El arbol esta vacio.');
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
  end;

  procedure ventasPorFecha(a: arb_Ventas);

    procedure cargarFecha(var f: fechas);
    begin
      with f do begin
        repeat
          write('Ingrese un dia del mes (entre 1 y 31): ');
          readln(dia);
        until (dia >= 1) and (dia <= 31);
        repeat
          write('Ingrese un mes del anio (entre 1 y 12): ');
          readln(mes);
        until (mes >= 1) and (mes <= 12);
        repeat
          write('Ingrese un anio (entre ',anio_min,' y ',anio_act,'): ');
          readln(anio);
        until (anio >= anio_min) and (anio <= anio_act);
      end;
    end;

    function cantVentas(a: arb_Ventas;f: fechas): integer;
    begin
      if (a = nil) then
        cantVentas := 0
      else if((a^.dato.fecha.dia = f.dia) and (a^.dato.fecha.mes = f.mes) and (a^.dato.fecha.anio = f.anio)) then
          cantVentas := a^.dato.u_vendidas + cantVentas(a^.HI,f) + cantVentas(a^.HD,f)
      else
        cantVentas := cantVentas(a^.HI,f) + cantVentas(a^.HD,f);
    end;
  
  var f: fechas;
  begin
    cargarFecha(f);
    writeln;
    writeln('----------------------------- Total Ventas por Fecha (ARBOL I) -----------------------------');
    writeln;
    writeln('El ',f.dia,'/',f.mes,'/',f.anio,' se reegistraron un total de ',cantVentas(a,f),' ventas.');
    writeln;
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
  end;


  procedure prodMaxVentas(a: arb_productos);

    function masVentas(a: arb_productos): integer;

      procedure obtenermax(a: arb_productos; var maxVentas,maxCod: integer);

        procedure actualizarMax(p: producto; var maxVentas,maxCod: integer);
        begin
          if(p.totVendido > maxVentas) then begin
            maxVentas := p.totVendido;
            maxCod := p.codigo;
          end;
        end;

      begin
        if (a <> nil) then begin
          obtenermax(a^.HI,maxVentas,maxCod);
          actualizarMax(a^.dato,maxVentas,maxCod);
          obtenermax(a^.HD,maxVentas,maxCod);
        end;
      end;


    var maxVentas,maxCod: integer;
    begin
      maxVentas := -1; maxCod := 0;
      obtenermax(a,maxVentas,maxCod);
      masVentas := maxCod;
    end;
    
  begin
    writeln('------------------------- Producto con mayores Ventas (ARBOL II) -------------------------');
    writeln;
    writeLN('El producto con el codigo ',masVentas(a),' es el que tiene la mayor cantidad de unidades vendidas.');
    writeln;
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
  end;


  procedure prodMaxVentas2(a: arb_productos2);

    function masVentas2(a: arb_productos2): integer;

      procedure obtenermax2(a: arb_productos2; var maxVentas,maxCod: integer);

        function contarVentas(l: lVentas): integer;
        var cant: integer;
        begin
          cant := 0;
          while(l <> nil) do begin
            cant := cant + 1;
            l := l^.sig;
          end;
          contarVentas := cant;
        end;

        procedure actualizarMax2(cantVentas,codigo: integer; var maxVentas,maxCod: integer);
        begin
          if(cantVentas > maxVentas) then begin
            maxVentas := cantVentas;
            maxCod := codigo;
          end;
        end;

      begin
        if (a <> nil) then begin
          obtenermax2(a^.HI,maxVentas,maxCod);
          actualizarMax2(contarVentas(a^.dato.ventas),a^.dato.codigo,maxVentas,maxCod);
          obtenermax2(a^.HD,maxVentas,maxCod);
        end;
      end;
    
    var maxVentas,maxCod: integer;
    begin
      maxVentas := -1; maxCod := 0;
      obtenermax2(a,maxVentas,maxCod);
      masVentas2 := maxCod;
    end;

  begin
    writeln('------------------------- Producto con mayores Ventas (ARBOL III) -------------------------');
    writeln;
    writeLN('El producto con el codigo ',masVentas2(a),' es quien tiene la mayor cantidad de ventas.');
    writeln;
    writeln('    //////////////////////////////////////////////////////////');
    writeln;
  end;

{------------------ Programa principal ------------------}
  
  var
    a: arb_Ventas;
    b: arb_productos;
    c: arb_productos2;
  begin
    Randomize;
    generarArbol(a,b,c);
    imprimirArbol(a,b,c);
    ventasPorFecha(a);
    prodMaxVentas(b);
    prodMaxVentas2(c);
  end.