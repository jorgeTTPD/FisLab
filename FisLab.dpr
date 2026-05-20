program FisLab;



uses
  System.StartUpCopy,
  FMX.Forms,
  Pmain in 'Pmain.pas' {Main},
  PMedidaDirectaU in 'PMedidaDirectaU.pas' {FMedidaDirectaU},
  PSerieDirectas in 'PSerieDirectas.pas' {FSerieDirectas},
  PSerieIndirectas in 'PSerieIndirectas.pas' {FSerieIndirectas},
  PMedidor in 'PMedidor.pas',
  UCalculadora in 'UCalculadora.pas',
  PTokenizadorColumnas in 'PTokenizadorColumnas.pas',
  ULectorTXT in 'ULectorTXT.pas',
  UConversorStringToDouble in 'UConversorStringToDouble.pas',
  GraficoUnit in 'GraficoUnit.pas' {GraficoGauss};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
