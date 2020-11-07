object FEmpresa: TFEmpresa
  Left = 0
  Top = 0
  Caption = 'Teste Programador Delphi'
  ClientHeight = 458
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GBRight: TGroupBox
    Left = 421
    Top = 0
    Width = 185
    Height = 458
    Align = alRight
    TabOrder = 0
    object BIncluirEmpresa: TButton
      Left = 24
      Top = 16
      Width = 137
      Height = 37
      Caption = '&Incluir empresa'
      TabOrder = 0
      OnClick = BIncluirEmpresaClick
    end
    object BEditarEmpresa: TButton
      Left = 24
      Top = 72
      Width = 137
      Height = 37
      Caption = '&Editar empresa'
      TabOrder = 1
      OnClick = BEditarEmpresaClick
    end
    object BExcluirEmpresa: TButton
      Left = 24
      Top = 128
      Width = 137
      Height = 37
      Caption = 'E&xcluir empresa'
      TabOrder = 2
      OnClick = BExcluirEmpresaClick
    end
    object BSair: TButton
      Left = 24
      Top = 288
      Width = 137
      Height = 37
      Caption = '&Sair'
      TabOrder = 3
      OnClick = BSairClick
    end
  end
  object GBAllClient: TGroupBox
    Left = 0
    Top = 0
    Width = 421
    Height = 458
    Align = alClient
    TabOrder = 1
    object DBGEmpresa: TDBGrid
      Left = 2
      Top = 15
      Width = 417
      Height = 422
      Align = alClient
      DataSource = DMConexao.DSEmpresa
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CNPJ'
          Title.Alignment = taCenter
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAZAO_SOCIAL'
          Title.Caption = 'Raz'#227'o Social'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_FANTASIA'
          Title.Caption = 'Nome fantasia'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_ABERTURA'
          Title.Alignment = taCenter
          Title.Caption = 'Data de abertura'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DS_CNAE_1'
          Title.Caption = 'CNAE (1)'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DS_CNAE_2'
          Title.Caption = 'CNAE (2)'
          Width = 150
          Visible = True
        end>
    end
    object SBEmpresa: TStatusBar
      Left = 2
      Top = 437
      Width = 417
      Height = 19
      Panels = <
        item
          Text = 'Teste Programador Delphi ::. Jefferson Greick'
          Width = 50
        end>
    end
  end
end
