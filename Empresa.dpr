program Empresa;

uses
  Vcl.Forms,
  Empresa.View in 'View\Empresa.View.pas' {FEmpresa} ,
  Empresa.Controller in 'Controller\Empresa.Controller.pas',
  Empresa.Model in 'Model\Empresa.Model.pas',
  Empresa.Dados.View in 'View\Empresa.Dados.View.pas' {FEmpresaDados} ,
  Conexao.Model in 'Model\Conexao.Model.pas' {DMConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFEmpresa, FEmpresa);
  Application.CreateForm(TFEmpresaDados, FEmpresaDados);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.Run;

end.
