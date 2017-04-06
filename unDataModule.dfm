object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 457
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Extended Properti' +
      'es="DBQ=E:\Arduino Projetos\InterfaceDelphiArduinoLEDS\appRGBLed' +
      'PCControl\bd\corefeitos.mdb;DefaultDir=E:\Arduino Projetos\Inter' +
      'faceDelphiArduinoLEDS\appRGBLedPCControl\bd;Driver={Microsoft Ac' +
      'cess Driver (*.mdb)};DriverId=25;FIL=MS Access;FILEDSN=E:\Arduin' +
      'o Projetos\InterfaceDelphiArduinoLEDS\appRGBLedPCControl\bd\cone' +
      'xaoaccess.dsn;MaxBufferSize=2048;MaxScanRows=8;PageTimeout=5;Saf' +
      'eTransactions=0;Threads=3;UID=admin;UserCommitSync=Yes;"'
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object dsCor: TDataSource
    DataSet = adCor
    Left = 208
    Top = 8
  end
  object dsEfeito: TDataSource
    DataSet = adEfeito
    Left = 216
    Top = 88
  end
  object adEfeito: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'efeito'
    Left = 128
    Top = 80
    object adEfeitoCódigo: TAutoIncField
      FieldName = 'C'#243'digo'
      ReadOnly = True
    end
    object adEfeitoefeito: TWideStringField
      FieldName = 'efeito'
      Size = 255
    end
    object adEfeitonumero: TIntegerField
      FieldName = 'numero'
    end
    object adEfeitoativo: TIntegerField
      FieldName = 'ativo'
    end
  end
  object adCor: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'cor'
    Left = 128
    Top = 10
    object adCorCódigo: TAutoIncField
      FieldName = 'C'#243'digo'
      ReadOnly = True
    end
    object adCorhexadecimal: TWideStringField
      FieldName = 'hexadecimal'
      Size = 255
    end
    object adCortcolor: TWideStringField
      FieldName = 'tcolor'
      Size = 255
    end
    object adCorluminosidade: TIntegerField
      FieldName = 'luminosidade'
    end
    object adCorr: TIntegerField
      FieldName = 'r'
    end
    object adCorg: TIntegerField
      FieldName = 'g'
    end
    object adCorb: TIntegerField
      FieldName = 'b'
    end
    object adCorativo: TIntegerField
      FieldName = 'ativo'
    end
  end
end
