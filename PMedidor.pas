unit PMedidor;

interface

uses
  System.SysUtils, System.Math;

type
  TMedidor = class
  public
    class function CalcularNumeroDecimales(Error: Double): Integer;
    class function GenerarFormatoMedicion(Valor, Error: Double; Unidad: string): string;
  end;

implementation

class function TMedidor.CalcularNumeroDecimales(Error: Double): Integer;
begin
  if (Error <=0)then
    Result :=0
  else
  begin
    // ceil(1.4)=2 sube al numero mayor cercano
    Result := Max(0, Ceil(-Log10(Error)));
  end;
end;

class function TMedidor.GenerarFormatoMedicion(Valor: Double; Error: Double; Unidad: string): string ;
var
  Precision: Integer;
  ValorStr, ErrorStr: string;
  ErrorRel: Double;
  ErrorAux: Double;
begin
  Precision := CalcularNumeroDecimales(Error);


  ValorStr := FloatToStrF(Valor, ffFixed, 15, Precision);
  ErrorAux:= SimpleRoundTo(Error, -Precision);
  ErrorStr := FloatToStrF(ErrorAux,ffFixed,15,Precision);


  if Valor <> 0 then
    ErrorRel := (Error / Abs(Valor)) * 100
  else
    ErrorRel := 0;

  if ErrorRel >= 1.0 then
    // example:2%
    Result := Format('(%s ± %s) [%s]; %.0f%%', [ValorStr, ErrorStr, Unidad, ErrorRel])
  else if ErrorRel > 0 then
    // example:0.25%
    Result := Format('(%s ± %s) [%s]; %.2f%%', [ValorStr, ErrorStr, Unidad, ErrorRel])
  else
    // si es cero
    Result := Format('(%s ± %s) [%s]; 0%%', [ValorStr, ErrorStr, Unidad]);
end;

end.
