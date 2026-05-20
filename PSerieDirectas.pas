unit PSerieDirectas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Edit,
  PTokenizadorColumnas,
  PMedidor,
  UCalculadora,
  ULectorTXT,
  UConversorStringToDouble;

type
  TFSerieDirectas = class(TForm)
    Rectangle1: TRectangle;
    f2: TBrushObject;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    UNID: TLabel;
    Edit1: TEdit;
    Rectangle2: TRectangle;
    rr: TBrushObject;
    Rectangle3: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    S: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CERRAR: TButton;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Precision: TEdit;
    Label12: TLabel;
    ValorMedio: TEdit;
    DesviacionEstandard: TEdit;
    ErrorPromedio: TEdit;
    ErrorMedicion: TEdit;
    ResultadoInforme: TEdit;
    OBTENER: TButton;
    Grafico: TButton;
    Lector: TButton;
    LIMPIAR: TButton;
    procedure CERRARClick(Sender: TObject);
    procedure OBTENERClick(Sender: TObject);
    procedure LectorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GraficoClick(Sender: TObject);
    procedure LIMPIARClick(Sender: TObject);
  private
    FVectorParaGrafico: TArray<Double>;
    FMediaParaGrafico: Double;
    FDesviacionParaGrafico: Double;
  public
    { Public declarations }
  end;

var
  FSerieDirectas: TFSerieDirectas;

implementation
uses GraficoUnit;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}
{$R *.GGlass.fmx ANDROID}
{$R *.Moto360.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TFSerieDirectas.CERRARClick(Sender: TObject);
begin
  Close;
end;
procedure TFSerieDirectas.FormCreate(Sender: TObject);
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
end;
procedure TFSerieDirectas.GraficoClick(Sender: TObject);
begin

  if not Assigned(GraficoGauss) then
    GraficoGauss := TGraficoGauss.Create(Application);

  GraficoGauss.CargarDatos(FVectorParaGrafico, FMediaParaGrafico, FDesviacionParaGrafico);

  GraficoGauss.Show;
end;

procedure TFSerieDirectas.OBTENERClick(Sender: TObject);
var
  VectorDatos: TArray<Double>;
  Media, Desviacion, ErrPromedio, ErrMedicion, ValorPrecision: Double;
  PrecisionDecimales: Integer;
begin
  try

    VectorDatos := TTokenizador.ExtraerDatos(Memo1.Lines);

    try
      ValorPrecision := TConversor.TextoANumero(Precision.Text);
    except
      raise Exception.Create('valor no valido para la Precision');
    end;


    Media       := TCalculador.CalcularValorMedio(VectorDatos);
    Desviacion  := TCalculador.CalcularDesviacionEstandard(VectorDatos, Media);
    ErrPromedio := TCalculador.CalcularErrorPromedio(VectorDatos, Desviacion);
    ErrMedicion := TCalculador.CalcularErrorMedicion(ErrPromedio, ValorPrecision);


    PrecisionDecimales := TMedidor.CalcularNumeroDecimales(ErrMedicion);


    ValorMedio.Text          := FloatToStrF(Media, ffFixed, 15, PrecisionDecimales);
    DesviacionEstandard.Text := FloatToStrF(Desviacion, ffFixed, 15, PrecisionDecimales);
    ErrorPromedio.Text       := FloatToStrF(ErrPromedio, ffFixed, 15, PrecisionDecimales);
    ErrorMedicion.Text       := FloatToStrF(ErrMedicion, ffFixed, 15, PrecisionDecimales);

    ResultadoInforme.Text := TMedidor.GenerarFormatoMedicion(Media, ErrMedicion, Edit1.Text);
    FVectorParaGrafico := VectorDatos;
    FMediaParaGrafico := Media;
    FDesviacionParaGrafico := Desviacion;
    Grafico.Enabled:= True;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFSerieDirectas.LectorClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  VectorCargado: TArray<Double>;
  Valor: Double;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := 'Archivos de texto (*.txt)|*.txt';
    OpenDialog.Title := 'Cargar Mediciones desde TXT';

    if OpenDialog.Execute then
    begin

      VectorCargado := TLectorTXT.CargarArchivo(OpenDialog.FileName);
      Memo1.Lines.BeginUpdate;
      try
        Memo1.Lines.Clear;
        for Valor in VectorCargado do
          Memo1.Lines.Add(FloatToStr(Valor));
      finally
        Memo1.Lines.EndUpdate;
      end;


      OBTENERClick(Sender);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFSerieDirectas.LIMPIARClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Edit1.Text := '';
  Precision.Text := '';
  ValorMedio.Text := '';
  DesviacionEstandard.Text := '';
  ErrorPromedio.Text := '';
  ErrorMedicion.Text := '';
  ResultadoInforme.Text := '';
  SetLength(FVectorParaGrafico, 0);
  FMediaParaGrafico := 0.0;
  FDesviacionParaGrafico := 0.0;
  Grafico.Enabled := False;
  Memo1.SetFocus;
end;

end.
