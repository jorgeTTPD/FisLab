unit PTokenizadorColumnas;

interface

uses
  System.Classes, System.SysUtils, UConversorStringToDouble;

type
  TTokenizador = class
  public
    class function ExtraerDatos(Lineas: TStrings): TArray<Double>;
  end;

implementation

class function TTokenizador.ExtraerDatos(Lineas: TStrings): TArray<Double>;
var
  Linea: string;
  LineaLimpia: string;
  VectorDefinitivo: TArray<Double>;
begin
  if (not Assigned(Lineas)) or (Lineas.Count = 0) then
  begin
    raise EConvertError.Create('Error: El cuadro de datos está completamente vacío.');
  end;

  SetLength(VectorDefinitivo, 0);

  for Linea in Lineas do
  begin

    LineaLimpia := Trim(Linea.Replace(',', '.'));

    if LineaLimpia = '' then
      Continue;

    try

      SetLength(VectorDefinitivo, Length(VectorDefinitivo) + 1);
      VectorDefinitivo[High(VectorDefinitivo)] := TConversor.TextoANumero(LineaLimpia);
    except
      on E: EConvertError do
      begin
        SetLength(VectorDefinitivo, 0);
        raise EConvertError.CreateFmt(
          ' "%s" no es un número valido.',
          [LineaLimpia]
        );
      end;
    end;
  end;

  if Length(VectorDefinitivo) = 0 then
  begin
    raise EConvertError.Create(' No se encontraron mediciones validas en el cuadro de datos');
  end;

  Result := VectorDefinitivo;
end;

end.
