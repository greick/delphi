object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 293
  Width = 550
  object FDCConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\greic\OneDrive\Desenvolvimento\Tronsoft\Firebi' +
        'rd\TPD.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 48
  end
  object FDQConexao: TFDQuery
    Connection = FDCConexao
    Left = 168
    Top = 48
  end
  object FDGUWCConexao: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 120
  end
  object FDPFBDLConexao: TFDPhysFBDriverLink
    Left = 168
    Top = 120
  end
  object DSEmpresa: TDataSource
    DataSet = FDQConexao
    Left = 60
    Top = 205
  end
  object FDQCnae: TFDQuery
    Connection = FDCConexao
    SQL.Strings = (
      'select * from cnae order by ds_cnae')
    Left = 360
    Top = 160
    object FDQCnaeCD_CNAE: TStringField
      FieldName = 'CD_CNAE'
      Origin = 'CD_CNAE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 15
    end
    object FDQCnaeDS_CNAE: TStringField
      FieldName = 'DS_CNAE'
      Origin = 'DS_CNAE'
      Required = True
      Size = 200
    end
  end
end
