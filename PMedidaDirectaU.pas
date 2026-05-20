unit PMedidaDirectaU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TFMedidaDirectaU = class(TForm)
    Rectangle1: TRectangle;
    f1: TBrushObject;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Valor: TEdit;
    Error: TEdit;
    UnidadMedida: TEdit;
    CONVERTIR: TButton;
    Label5: TLabel;
    Medicion: TEdit;
    VOLVER: TButton;
    LIMPIAR: TButton;
    procedure VOLVERClick(Sender: TObject);
    procedure CONVERTIRClick(Sender: TObject);
    procedure LIMPIARClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMedidaDirectaU: TFMedidaDirectaU;

implementation
  uses PMedidor;

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TFMedidaDirectaU.CONVERTIRClick(Sender: TObject);
var
  valorD, errorD: Double;
  vTxt, eTxt: string;
  unidadStr: string;
begin
  try
    vTxt := Valor.Text.Replace('.', ',');
    eTxt := Error.Text.Replace('.', ',');
    valorD := StrToFloat(vTxt);
    errorD := StrToFloat(eTxt);
    unidadStr := UnidadMedida.Text;

    if errorD <= 0 then
    begin
      ShowMessage('El error debe ser mayor a 0');
      Medicion.Text := 'Error > 0';
      Exit;
    end;

    Medicion.Text := TMedidor.GenerarFormatoMedicion(valorD, errorD, unidadStr);

  except
    on E: Exception do
    begin
      ShowMessage('llena correctamente los espacios');
      Medicion.Text := 'datos no validos';
    end;
  end;
end;

procedure TFMedidaDirectaU.LIMPIARClick(Sender: TObject);
begin
  Valor.Text := '';
  Error.Text := '';
  UnidadMedida.Text := '';
  Medicion.Text := '';
end;

procedure TFMedidaDirectaU.VOLVERClick(Sender: TObject);
begin
Close;
end;

end.
