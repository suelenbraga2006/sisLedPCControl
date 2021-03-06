unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, AppEvnts, Menus, CPort;

type
  TfrmPrincipal = class(TForm)
    btnCorSolida: TBitBtn;
    btnEfeitos: TBitBtn;
    tiPrincipal: TTrayIcon;
    pmTrayIconPrincipal: TPopupMenu;
    FecharAplicativo1: TMenuItem;
    FecharAplicativo2: TMenuItem;
    comport: TComPort;
    procedure btnCorSolidaClick(Sender: TObject);
    procedure btnEfeitosClick(Sender: TObject);
    procedure tiPrincipalDblClick(Sender: TObject);
    procedure aePrincipalMinimize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FecharAplicativo1Click(Sender: TObject);
    procedure FecharAplicativo2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unSolido, unEfeito, unDataModule;

{$R *.dfm}

procedure TfrmPrincipal.aePrincipalMinimize(Sender: TObject);
begin
  Self.Hide();
  Self.WindowState := wsMinimized;
  tiPrincipal.Visible := True;
  tiPrincipal.ShowBalloonHint;
end;

procedure TfrmPrincipal.btnCorSolidaClick(Sender: TObject);
begin
  frmSolido.Show;
end;

procedure TfrmPrincipal.btnEfeitosClick(Sender: TObject);
begin
  frmEfeito.Show;
end;

procedure TfrmPrincipal.FecharAplicativo1Click(Sender: TObject);
begin
  tiPrincipal.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmPrincipal.FecharAplicativo2Click(Sender: TObject);
begin
  Application.ProcessMessages;
  Application.Terminate;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caNone;
frmPrincipal.Hide();
frmPrincipal.WindowState := wsMinimized;
tiPrincipal.Visible := True;
tiPrincipal.ShowBalloonHint;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  ativo: Integer;
begin
  Try
    comport.Open;
    if comport.Connected then
    begin
      ativo := dmPrincipal.adCor.FieldByName('ativo').Value;
      if(ativo = 1)then
      begin
        sleep(2000);
        comport.WriteStr(IntToStr(dmPrincipal.adCor.FieldByName('r').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('g').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('b').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('luminosidade').Value)+'!');
        frmSolido.lblMensagem.Caption := 'Efeito Ativado!';
        frmSolido.pnlIcon.Color := clGreen;
      end
      else
      begin
        sleep(2000);
        comport.WriteStr(IntToStr(dmPrincipal.adEfeito.FieldByName('numero').Value)+'!');
        frmEfeito.lblMensagem.Caption := 'Efeito Ativado!';
        frmEfeito.pnlIcon.Color := clGreen;
      end;
    end
    else
      ShowMessage('FALHA ao abrir conex�o com ('+comport.Port+')');

    Except on E : Exception do
    begin
      ShowMessage('ERRO ao abrir conex�o. Detalhes > '+ E.Message);
    end;
  end;
  comport.Close;
end;

procedure TfrmPrincipal.tiPrincipalDblClick(Sender: TObject);
begin
  tiPrincipal.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
