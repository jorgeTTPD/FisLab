unit ULectorTXT;

interface

uses
  System.Classes, System.SysUtils, PTokenizadorColumnas;

type
  TLectorTXT = class
  public
    class function CargarArchivo(const RutaArchivo: string): TArray<Double>;
  end;

implementation

class function TLectorTXT.CargarArchivo(const RutaArchivo: string): TArray<Double>;
var
  LineasArchivo: TStringList;
begin
  if not FileExists(RutaArchivo) then
    raise Exception.CreateFmt(' El archivo "%s" no existe.', [RutaArchivo]);

  LineasArchivo := TStringList.Create;
  try
    LineasArchivo.LoadFromFile(RutaArchivo);

    Result := TTokenizador.ExtraerDatos(LineasArchivo);
  finally
    LineasArchivo.Free;
  end;
end;

end.
