unit UCalculadora;

interface

uses
  System.SysUtils, System.Math;

type
  TCalculador = class
  public
    class function CalcularValorMedio(const Datos: TArray<Double>): Double;
    class function CalcularDesviacionEstandard(const Datos: TArray<Double>; Media: Double): Double;
    class function CalcularErrorPromedio(const Datos: TArray<Double>; Desviacion: Double): Double;
    class function CalcularErrorMedicion(ErrorPromedio, Precision: Double): Double;

  end;

implementation

class function TCalculador.CalcularValorMedio(const Datos: TArray<Double>): Double;
var
  Suma: Double;
  I: Integer;
begin
  if Length(Datos) = 0 then Exit(0);
  Suma := 0;
  for I := 0 to High(Datos) do Suma := Suma + Datos[I];
  Result := Suma / Length(Datos);
end;

class function TCalculador.CalcularDesviacionEstandard(const Datos: TArray<Double>; Media: Double): Double;
var
  SumaCuadrados: Double;
  I: Integer;
begin
  if Length(Datos) <= 1 then Exit(0);
  SumaCuadrados := 0;
  for I := 0 to High(Datos) do
    SumaCuadrados := SumaCuadrados + Power(Datos[I] - Media, 2);
  Result := Sqrt(SumaCuadrados / (Length(Datos) - 1));
end;

class function TCalculador.CalcularErrorPromedio(const Datos: TArray<Double>; Desviacion: Double): Double;
begin
  if Length(Datos) = 0 then Exit(0);
  Result := Desviacion / Sqrt(Length(Datos));
end;

class function TCalculador.CalcularErrorMedicion(ErrorPromedio, Precision: Double): Double;
begin
  Result := Sqrt(Power(ErrorPromedio, 2) + Power(Precision, 2));
end;

end.
