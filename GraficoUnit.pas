unit GraficoUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMXTee.Series, FMXTee.Engine,
  FMXTee.Procs, FMXTee.Chart,System.Math;

type
  TGraficoGauss = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    SALIR: TButton;
    Graphico: TChart;
    Series1: TPointSeries;
    Series2: TLineSeries;
    procedure SALIRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarDatos(const Datos: TArray<Double>; Media: Double;Desviacion:Double);
  end;

var
  GraficoGauss: TGraficoGauss;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TGraficoGauss.CargarDatos(const Datos: TArray<Double>; Media, Desviacion: Double);
var
  x, y, MinX, MaxX, Paso: Double;
begin
  Series1.Clear; // Puntos
  Series2.Clear; // Campana


  for var i := 0 to High(Datos) do
    Series1.AddXY(Datos[i], 0);


  if Desviacion > 0 then
  begin

    MinX := Media - (4 * Desviacion);
    MaxX := Media + (4 * Desviacion);
    Paso := (MaxX - MinX) / 100;

    x := MinX;
    while x <= MaxX do
    begin

      y := (1 / (Desviacion * Sqrt(2 * Pi))) * Exp(-0.5 * Sqr((x - Media) / Desviacion));
      Series2.AddXY(x, y);
      x := x + Paso;
    end;
  end;
end;

procedure TGraficoGauss.SALIRClick(Sender: TObject);
begin
  Close;
end;

end.
