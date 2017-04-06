program prjPCLed;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unSolido in 'unSolido.pas' {frmSolido},
  unEfeito in 'unEfeito.pas' {frmEfeito},
  unDataModule in 'unDataModule.pas' {dmPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmSolido, frmSolido);
  Application.CreateForm(TfrmEfeito, frmEfeito);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
