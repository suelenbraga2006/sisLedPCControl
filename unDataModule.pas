unit unDataModule;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBDatabase, ADODB;

type
  TdmPrincipal = class(TDataModule)
    ADOConnection1: TADOConnection;
    dsCor: TDataSource;
    dsEfeito: TDataSource;
    adEfeito: TADOTable;
    adCor: TADOTable;
    adCorCódigo: TAutoIncField;
    adCorhexadecimal: TWideStringField;
    adCortcolor: TWideStringField;
    adCorluminosidade: TIntegerField;
    adCorr: TIntegerField;
    adCorg: TIntegerField;
    adCorb: TIntegerField;
    adCorativo: TIntegerField;
    adEfeitoCódigo: TAutoIncField;
    adEfeitoefeito: TWideStringField;
    adEfeitonumero: TIntegerField;
    adEfeitoativo: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{$R *.dfm}

end.
