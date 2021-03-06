unit unSolido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CPort, DB, ADODB, Mask, DBCtrls,
  ComCtrls;

type
  TfrmSolido = class(TForm)
    clbEscolheCor: TColorBox;
    pnlColor: TPanel;
    btnSalvar: TBitBtn;
    btnPronto: TBitBtn;
    comport: TComPort;
    tbLuminCor: TTrackBar;
    edtCodigoHex: TLabeledEdit;
    Panel1: TPanel;
    lblStatus: TLabel;
    lblMensagem: TLabel;
    pnlIcon: TPanel;
    procedure clbEscolheCorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnProntoClick(Sender: TObject);
    procedure tbLuminCorChange(Sender: TObject);
    procedure comportRxChar(Sender: TObject; Count: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSolido: TfrmSolido;
  R,G,B: Byte;

implementation

uses unDataModule, unEfeito;

{$R *.dfm}

procedure resetEfeito();
begin
  dmPrincipal.adEfeito.Edit;
  dmPrincipal.adEfeito.FieldByName('efeito').Value := 'Nenhum';
  dmPrincipal.adEfeito.FieldByName('numero').Value := 0;
  dmPrincipal.adEfeito.FieldByName('ativo').Value := 0;
  dmPrincipal.adEfeito.Post;
  dmPrincipal.adEfeito.Refresh;
  frmEfeito.lblMensagem.Caption := 'O Cor S�lida est� ativo neste momento.';
  frmEfeito.pnlIcon.Color := clGray;
end;

function ColorToHtml(const Color: Integer): AnsiString;
const
  Hex = '0123456789ABCDEF';
var
  b, s: Byte;
begin
  Result := '';
  s := 0;
  repeat
    b := (Color shr s) and $FF;
    Result := Result + Hex[b div 16 + 1] + Hex[b mod 16 + 1];
    Inc(s, 8);
  until s = 24;
end;

procedure TfrmSolido.btnProntoClick(Sender: TObject);
begin
  comport.Close;
  frmSolido.Close;
end;

procedure TfrmSolido.btnSalvarClick(Sender: TObject);
begin
  lblMensagem.Caption := 'Aguarde...';
  pnlIcon.Color := clRed;
  dmPrincipal.adCor.Edit;
  dmPrincipal.adCor.FieldByName('hexadecimal').Value := ColorToHtml(clbEscolheCor.Selected);
  dmPrincipal.adCor.FieldByName('tcolor').Value := ColorToString(clbEscolheCor.Selected);
  dmPrincipal.adCor.FieldByName('luminosidade').Value := tbLuminCor.Position;
  dmPrincipal.adCor.FieldByName('r').Value := R;
  dmPrincipal.adCor.FieldByName('g').Value := G;
  dmPrincipal.adCor.FieldByName('b').Value := B;
  dmPrincipal.adCor.FieldByName('ativo').Value := 1;
  dmPrincipal.adCor.Post;
  dmPrincipal.adCor.Refresh;
  resetEfeito();
  comport.WriteStr(IntToStr(dmPrincipal.adCor.FieldByName('r').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('g').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('b').Value)+','+IntToStr(dmPrincipal.adCor.FieldByName('luminosidade').Value)+'!');
  btnSalvar.Enabled := False;
end;

procedure TfrmSolido.clbEscolheCorChange(Sender: TObject);
var
color: LongInt;
tcolor: String;
begin
  pnlColor.Color := clbEscolheCor.Selected;
  color := ColorToRGB(clbEscolheCor.Selected);
  R := GetRValue(color);
  G := GetGValue(color);
  B := GetBValue(color);
  edtCodigoHex.Text := ColorToHtml(clbEscolheCor.Selected);
  if(clbEscolheCor.Selected <> StringToColor(dmPrincipal.adCor.FieldByName('tcolor').Value)) then
  begin
    tcolor := ColorToString(clbEscolheCor.Selected);
    lblMensagem.Caption := 'Trocando para R: '+IntToStr(R)+' G: '+IntToStr(G)+' B: '+IntToStr(B)+' Lumi: '+IntToStr(tbLuminCor.Position)+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    ShowMessage('Voc� selecionou a mesma cor que estava!');
    btnSalvar.Enabled := False;
  end;

end;

procedure TfrmSolido.comportRxChar(Sender: TObject; Count: Integer);
var
  RxCount: Integer;
  RxComport: string;
begin
  RxCount := comport.InputCount;
  comport.ReadStr(RxComport, RxCount);
  lblMensagem.Caption := RxComport;
  pnlIcon.Color := clGreen;
end;

procedure TfrmSolido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  comport.Close;
end;

procedure TfrmSolido.FormShow(Sender: TObject);
begin
  Try
    comport.Open;
    if comport.Connected then
    begin
      clbEscolheCor.Enabled := True;
      pnlColor.Enabled := True;
      edtCodigoHex.Enabled := True;
      tbLuminCor.Enabled := True;
      btnPronto.Enabled := True;
    end
    else
      ShowMessage('FALHA ao abrir conex�o com ('+comport.Port+')');

    Except on E : Exception do
    begin
      ShowMessage('ERRO ao abrir conex�o. Detalhes > '+ E.Message);
    end;
  end;

  pnlColor.Color := StringToColor(dmPrincipal.adCor.FieldByName('tcolor').Value);
  clbEscolheCor.Selected := StringToColor(dmPrincipal.adCor.FieldByName('tcolor').Value);
  edtCodigoHex.Text := dmPrincipal.adCor.FieldByName('hexadecimal').Value;
  tbLuminCor.Position := dmPrincipal.adCor.FieldByName('luminosidade').Value;

end;

procedure TfrmSolido.tbLuminCorChange(Sender: TObject);
begin
if(tbLuminCor.Position <> dmPrincipal.adCor.FieldByName('luminosidade').Value) then
  begin
    lblMensagem.Caption := 'Trocando para R: '+IntToStr(R)+' G: '+IntToStr(G)+' B: '+IntToStr(B)+' Lumi: '+IntToStr(tbLuminCor.Position)+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    //ShowMessage('Voc� selecionou a mesma luminosidade que estava!');
    btnSalvar.Enabled := False;
  end;
end;

end.
