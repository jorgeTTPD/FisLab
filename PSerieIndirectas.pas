unit PSerieIndirectas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Media,
  System.IOUtils;

type
  TFSerieIndirectas = class(TForm)
    Rectangle1          : TRectangle;
    ds                  : TLabel;
    Button1             : TButton;
    Label2              : TLabel;
    BROMA               : TButton;
    MediaPlayer1        : TMediaPlayer;
    MediaPlayerControl1 : TMediaPlayerControl;
    Timer1              : TTimer;
    procedure Button1Click(Sender: TObject);
    procedure BROMAClick(Sender: TObject);
    procedure FormShow(Sender: TObject); // CAMBIADO: De FormCreate a FormShow
    procedure Timer1Timer(Sender: TObject);
  private
    FSegundos : Integer;
    procedure ExtraerAudioDesdeRecursos(const Ruta: string);
  public
  end;

var
  FSerieIndirectas: TFSerieIndirectas;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R recursos.res} // CORREGIDO: Sintaxis limpia y multiplataforma para Android

procedure TFSerieIndirectas.FormShow(Sender: TObject); // CORREGIDO
begin
  MediaPlayerControl1.Visible     := False;
  MediaPlayerControl1.MediaPlayer := MediaPlayer1;

  // Nos aseguramos que inicie en blanco absoluto
  MediaPlayer1.FileName := '';

  Timer1.Interval := 1000;
  Timer1.Enabled  := False;
  Label2.Text     := '';
end;

procedure TFSerieIndirectas.ExtraerAudioDesdeRecursos(const Ruta: string);
var
  ResStream: TResourceStream;
  FileStream: TFileStream;
begin
  if not TFile.Exists(Ruta) then
  begin
    try
      // Al usar la directiva corregida, Android ya encontrará 'MI_AUDIO'
      ResStream := TResourceStream.Create(HInstance, 'MI_AUDIO', RT_RCDATA);
      try
        FileStream := TFileStream.Create(Ruta, fmCreate);
        try
          FileStream.CopyFrom(ResStream, ResStream.Size);
        finally
          FileStream.Free;
        end;
      finally
        ResStream.Free;
      end;
    except
      on E: Exception do
        ShowMessage('Error al desempaquetar el audio: ' + E.Message);
    end;
  end;
end;

procedure TFSerieIndirectas.BROMAClick(Sender: TObject);
var
  RutaAudio: string;
begin
  BROMA.Enabled   := False;
  Button1.Enabled := False;

  RutaAudio := TPath.Combine(TPath.GetDocumentsPath, 'manicurew.wav');

  ExtraerAudioDesdeRecursos(RutaAudio);

  if TFile.Exists(RutaAudio) then
  begin
    MediaPlayerControl1.Visible := True;
    MediaPlayer1.FileName       := RutaAudio;
    MediaPlayer1.CurrentTime    := 0;
    MediaPlayer1.Play;

    FSegundos      := 30;
    Label2.Text    := ' 30 seg';
    Timer1.Enabled := True;
  end
  else
  begin
    ShowMessage('No se pudo encontrar ni extraer el archivo de audio.');
    BROMA.Enabled   := True;
    Button1.Enabled := True;
  end;
end;

procedure TFSerieIndirectas.Timer1Timer(Sender: TObject);
begin
  Dec(FSegundos);
  Label2.Text := IntToStr(FSegundos) + ' seg';

  if FSegundos <= 0 then
  begin
    Timer1.Enabled  := False;
    BROMA.Enabled   := True;
    Button1.Enabled := True;
    BROMA.Text      := 'Broma';
    Label2.Text     := '';
  end;
end;

procedure TFSerieIndirectas.Button1Click(Sender: TObject);
begin
  MediaPlayer1.Stop;
  Timer1.Enabled := False;
  Close;
end;

end.
