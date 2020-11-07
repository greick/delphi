unit Conexao.Model;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMConexao = class(TDataModule)
    FDCConexao: TFDConnection;
    FDQConexao: TFDQuery;
    FDGUWCConexao: TFDGUIxWaitCursor;
    FDPFBDLConexao: TFDPhysFBDriverLink;
    DSEmpresa: TDataSource;
    FDQCnae: TFDQuery;
    FDQCnaeCD_CNAE: TStringField;
    FDQCnaeDS_CNAE: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

end.
