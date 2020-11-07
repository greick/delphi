unit Empresa.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Empresa.Controller, IdHTTP,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TFEmpresa = class(TForm)
    GBRight: TGroupBox;
    GBAllClient: TGroupBox;
    DBGEmpresa: TDBGrid;
    SBEmpresa: TStatusBar;
    BIncluirEmpresa: TButton;
    BEditarEmpresa: TButton;
    BExcluirEmpresa: TButton;
    BSair: TButton;
    procedure BSairClick(Sender: TObject);
    procedure BIncluirEmpresaClick(Sender: TObject);
    procedure BEditarEmpresaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BExcluirEmpresaClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FEmpresa: TFEmpresa;

implementation

{$R *.dfm}

uses Empresa.Dados.View;

procedure TFEmpresa.BEditarEmpresaClick(Sender: TObject);
begin
  FEmpresaDados.Caption := StringReplace(self.BEditarEmpresa.Caption, '&', '',
    [rfReplaceAll, rfIgnoreCase]);
  FEmpresaDados.IncAlt := 'A';

  FEmpresaDados.ShowModal;
end;

procedure TFEmpresa.BExcluirEmpresaClick(Sender: TObject);
begin
ShowMessage('ToDo!');
end;

procedure TFEmpresa.BIncluirEmpresaClick(Sender: TObject);
begin
  FEmpresaDados.Caption := StringReplace(self.BIncluirEmpresa.Caption, '&', '',
    [rfReplaceAll, rfIgnoreCase]);
  FEmpresaDados.IncAlt := 'I';
  FEmpresaDados.ShowModal;
end;

procedure TFEmpresa.BSairClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFEmpresa.FormActivate(Sender: TObject);
var
  objetoControle: TEmpresaController;
begin
  objetoControle := TEmpresaController.Create;
  objetoControle.PopularCNAE;
  objetoControle.PopularDBGEmpresa;
end;

end.
