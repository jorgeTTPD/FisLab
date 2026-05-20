unit UConversorStringToDouble;

interface

uses
  System.SysUtils;

type
  TConversor = class
  public
    class function TextoANumero(const Entrada: string): Double;
  end;

implementation

class function TConversor.TextoANumero(const Entrada: string): Double;
var
  FS: TFormatSettings;
  ValorEntrada: string;
begin
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';

  ValorEntrada := Trim(Entrada).Replace(',', '.');

  if ValorEntrada = '' then
    Exit(0);

  try
    Result := StrToFloat(ValorEntrada, FS);
  except
    on E: EConvertError do
      raise EConvertError.CreateFmt('"%s" no es un numero valido para el calculo', [Entrada]);
  end;
end;

end.
