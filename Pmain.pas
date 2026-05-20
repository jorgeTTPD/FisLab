unit Pmain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Ani; //FMX.Ani;

type
  TMain = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    MedidaDirectaUnica: TRadioButton;
    FloatKeyAnimation1: TFloatKeyAnimation;
    Rectangle2: TRectangle;
    SerieMedidasDirectas: TRadioButton;
    SerieMedidasIndirectas: TRadioButton;
    INICIAR: TButton;
    CERRRAR: TButton;
    procedure SerieMedidasIndirectasChange(Sender: TObject);
    procedure CERRRARClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure INICIARClick(Sender: TObject);
    procedure MedidaDirectaUnicaChange(Sender: TObject);
    procedure SerieMedidasDirectasChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation
  uses PSerieIndirectas, PMedidaDirectaU, PSerieDirectas;
{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TMain.CERRRARClick(Sender: TObject);
begin
Close;
end;

procedure TMain.FormCreate(Sender: TObject);
  begin
    
    INICIAR.Enabled := False;
  end;

procedure TMain.INICIARClick(Sender: TObject);
begin
  if (MedidaDirectaUnica.IsChecked) then
  begin
    // Si el formulario no ha sido creado en memoria, lo creamos
    if not Assigned(FMedidaDirectaU) then
      FMedidaDirectaU := TFMedidaDirectaU.Create(Application);

    FMedidaDirectaU.Show;
  end;

  if (SerieMedidasDirectas.IsChecked) then
  begin
    if not Assigned(FSerieDirectas) then
      FSerieDirectas := TFSerieDirectas.Create(Application);

    FSerieDirectas.Show;
  end;

  if (SerieMedidasIndirectas.IsChecked) then
  begin
    if not Assigned(FSerieIndirectas) then
      FSerieIndirectas := TFSerieIndirectas.Create(Application);

    FSerieIndirectas.Show;
  end;
end;
procedure TMain.MedidaDirectaUnicaChange(Sender: TObject);
begin
   INICIAR.Enabled := True;
end;

procedure TMain.SerieMedidasDirectasChange(Sender: TObject);
begin
   INICIAR.Enabled := True;
end;

procedure TMain.SerieMedidasIndirectasChange(Sender: TObject);
begin
   INICIAR.Enabled := True;
end;

end.
