object FEmpresaDados: TFEmpresaDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 241
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LCnpj: TLabel
    Left = 8
    Top = 19
    Width = 25
    Height = 13
    Caption = 'CNPJ'
  end
  object LRazaoSocial: TLabel
    Left = 8
    Top = 46
    Width = 59
    Height = 13
    Caption = 'Raz'#227'o social'
  end
  object LNomeFantasia: TLabel
    Left = 8
    Top = 73
    Width = 71
    Height = 13
    Caption = 'Nome Fantasia'
  end
  object LDataAbertura: TLabel
    Left = 8
    Top = 99
    Width = 68
    Height = 13
    Caption = 'Data abertura'
  end
  object LCnae1: TLabel
    Left = 8
    Top = 127
    Width = 36
    Height = 13
    Caption = 'CNAE 1'
  end
  object LCnae2: TLabel
    Left = 8
    Top = 154
    Width = 33
    Height = 13
    Caption = 'CNAE2'
  end
  object MECnpj: TMaskEdit
    Left = 88
    Top = 16
    Width = 118
    Height = 21
    EditMask = '99.999.999/9999-99;1; '
    MaxLength = 18
    TabOrder = 0
    Text = '  .   .   /    -  '
    OnExit = MECnpjExit
  end
  object MEDataAbertura: TMaskEdit
    Left = 88
    Top = 97
    Width = 75
    Height = 21
    EditMask = '!99/99/9999;1; '
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
    OnExit = MEDataAberturaExit
  end
  object BSalvar: TButton
    Left = 230
    Top = 193
    Width = 75
    Height = 37
    Caption = '&Salvar'
    TabOrder = 6
    OnClick = BSalvarClick
  end
  object BVoltar: TButton
    Left = 88
    Top = 192
    Width = 75
    Height = 37
    Cancel = True
    Caption = '&Voltar'
    TabOrder = 7
    OnClick = BVoltarClick
  end
  object CBCnae1: TComboBox
    Left = 88
    Top = 124
    Width = 269
    Height = 21
    TabOrder = 4
  end
  object CBCnae2: TComboBox
    Left = 88
    Top = 151
    Width = 269
    Height = 21
    TabOrder = 5
  end
  object DBECnpj: TDBEdit
    Left = 224
    Top = 16
    Width = 121
    Height = 21
    DataSource = DMConexao.DSEmpresa
    TabOrder = 8
    Visible = False
    OnChange = DBECnpjChange
  end
  object DBERazaoSocial: TDBEdit
    Left = 88
    Top = 43
    Width = 269
    Height = 21
    DataSource = DMConexao.DSEmpresa
    TabOrder = 1
  end
  object DBENomeFantasia: TDBEdit
    Left = 88
    Top = 70
    Width = 269
    Height = 21
    DataSource = DMConexao.DSEmpresa
    TabOrder = 2
  end
end
