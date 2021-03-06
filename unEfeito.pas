unit unEfeito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPort, Buttons, DB, ADODB, Mask, DBCtrls, ComCtrls, ImgList,
  ExtCtrls;

type
  TfrmEfeito = class(TForm)
    comport: TComPort;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    btnSalvar: TBitBtn;
    btnPronto: TBitBtn;
    lblEfeitoSel: TLabel;
    edtEfeitoSelecionado: TEdit;
    Button5: TButton;
    Button6: TButton;
    edtNumeroEfeito: TEdit;
    Panel1: TPanel;
    lblStatus: TLabel;
    lblMensagem: TLabel;
    pnlIcon: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProntoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure comportRxChar(Sender: TObject; Count: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEfeito: TfrmEfeito;

implementation

uses unDataModule, unSolido;

{$R *.dfm}

procedure resetCor();
begin
  dmPrincipal.adCor.Edit;
  dmPrincipal.adCor.FieldByName('hexadecimal').Value := '000000';
  dmPrincipal.adCor.FieldByName('tcolor').Value := 'clBlack';
  dmPrincipal.adCor.FieldByName('luminosidade').Value := 255;
  dmPrincipal.adCor.FieldByName('r').Value := 0;
  dmPrincipal.adCor.FieldByName('g').Value := 0;
  dmPrincipal.adCor.FieldByName('b').Value := 0;
  dmPrincipal.adCor.FieldByName('ativo').Value := 0;
  dmPrincipal.adCor.Post;
  dmPrincipal.adCor.Refresh;
  frmSolido.lblMensagem.Caption := 'O Efeito de Cores est� ativo neste momento.';
  frmSolido.pnlIcon.Color := clGray;
end;

procedure TfrmEfeito.btnProntoClick(Sender: TObject);
begin
  comport.Close;
  frmEfeito.Close;
end;

procedure TfrmEfeito.btnSalvarClick(Sender: TObject);
begin
  lblMensagem.Caption := 'Aguarde...';
  pnlIcon.Color := clRed;
  dmPrincipal.adEfeito.Edit;
  dmPrincipal.adEfeito.FieldByName('efeito').Value := edtEfeitoSelecionado.Text;
  dmPrincipal.adEfeito.FieldByName('numero').Value := edtNumeroEfeito.Text;
  dmPrincipal.adEfeito.FieldByName('ativo').Value := 1;
  dmPrincipal.adEfeito.Post;
  dmPrincipal.adEfeito.Refresh;
  resetCor();
  comport.WriteStr(IntToStr(dmPrincipal.adEfeito.FieldByName('numero').Value)+'!');
  btnSalvar.Enabled := False;
end;

procedure TfrmEfeito.Button1Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button1.Caption;
  edtNumeroEfeito.Text := Button1.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button1.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button1.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    ShowMessage('Voc� selecionou o efeito que j� estava!');
    btnSalvar.Enabled := False;
  end;
end;

procedure TfrmEfeito.Button2Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button2.Caption;
  edtNumeroEfeito.Text := Button2.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button2.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button2.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    ShowMessage('Voc� selecionou o efeito que j� estava!');
    btnSalvar.Enabled := False;
  end;
end;

procedure TfrmEfeito.Button3Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button3.Caption;
  edtNumeroEfeito.Text := Button3.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button3.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button3.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    ShowMessage('Voc� selecionou o efeito que j� estava!');
    btnSalvar.Enabled := False;
  end;
end;

procedure TfrmEfeito.Button4Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button4.Caption;
  edtNumeroEfeito.Text := Button4.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button4.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button4.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
  begin
    ShowMessage('Voc� selecionou o efeito que j� estava!');
    btnSalvar.Enabled := False;
  end;
end;

procedure TfrmEfeito.Button5Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button5.Caption;
  edtNumeroEfeito.Text := Button5.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button5.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button5.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
    ShowMessage('Voc� selecionou o efeito que j� estava!');
end;

procedure TfrmEfeito.Button6Click(Sender: TObject);
begin
  edtEfeitoSelecionado.Text := Button6.Caption;
  edtNumeroEfeito.Text := Button6.CommandLinkHint;
  if(dmPrincipal.adEfeito.FieldByName('efeito').Value <> Button6.Caption)then
  begin
    lblMensagem.Caption := 'Trocando para '+Button6.Caption+'. Clique em Salvar!';
    pnlIcon.Color := clYellow;
    btnSalvar.Enabled := True;
  end
  else
    ShowMessage('Voc� selecionou o efeito que j� estava!');
end;

procedure TfrmEfeito.comportRxChar(Sender: TObject; Count: Integer);
var
  RxCount: Integer;
  RxComport: string;
begin
  RxCount := comport.InputCount;
  comport.ReadStr(RxComport, RxCount);
  lblMensagem.Caption := RxComport;
  pnlIcon.Color := clGreen;
end;

procedure TfrmEfeito.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  comport.Close;
end;

procedure TfrmEfeito.FormShow(Sender: TObject);
begin
  Try
    comport.Open;
    if comport.Connected then
    begin
      Button1.Enabled := True;
      Button2.Enabled := True;
      Button3.Enabled := True;
      Button4.Enabled := True;
      Button5.Enabled := True;
      edtEfeitoSelecionado.Enabled := True;
      edtNumeroEfeito.Enabled := True;
      btnPronto.Enabled := True;
    end
    else
      ShowMessage('FALHA ao abrir conex�o com ('+comport.Port+')');

    Except on E : Exception do
    begin
      ShowMessage('ERRO ao abrir conex�o. Detalhes > '+ E.Message);
    end;
  end;

  edtEfeitoSelecionado.Text := dmPrincipal.adEfeito.FieldByName('efeito').Value;
  edtNumeroEfeito.Text := dmPrincipal.adEfeito.FieldByName('numero').Value;

  if(lblMensagem.Caption = 'Efeito ativado!')then
    pnlIcon.Color := clGreen;

end;

end.
