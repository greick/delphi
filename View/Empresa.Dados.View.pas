unit Empresa.Dados.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.RegularExpressions, Empresa.Controller,
  Empresa.Model, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFEmpresaDados = class(TForm)
    MECnpj: TMaskEdit;
    LCnpj: TLabel;
    LRazaoSocial: TLabel;
    LNomeFantasia: TLabel;
    LDataAbertura: TLabel;
    MEDataAbertura: TMaskEdit;
    LCnae1: TLabel;
    LCnae2: TLabel;
    BSalvar: TButton;
    BVoltar: TButton;
    CBCnae1: TComboBox;
    CBCnae2: TComboBox;
    DBECnpj: TDBEdit;
    DBERazaoSocial: TDBEdit;
    DBENomeFantasia: TDBEdit;
    procedure BVoltarClick(Sender: TObject);
    procedure MECnpjExit(Sender: TObject);
    procedure MEDataAberturaExit(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DBECnpjChange(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    IncAlt: char;
  end;

var
  FEmpresaDados: TFEmpresaDados;
  objetoControle: TEmpresaController;
  objetoEmpresa: TEmpresaModel;

implementation

uses Conexao.Model;

{$R *.dfm}

procedure TFEmpresaDados.BSalvarClick(Sender: TObject);
var
  Mask: String;
begin
  Mask := MECnpj.EditMask;
  MECnpj.EditMask := '';
  objetoEmpresa.Cnpj := MECnpj.Text;
  MECnpj.EditMask := Mask;
  objetoEmpresa.RazaoSocial := DBERazaoSocial.Text;
  objetoEmpresa.NomeFantasia := DBENomeFantasia.Text;
  objetoEmpresa.DtAbertura := MEDataAbertura.Text;
  objetoEmpresa.CdCnae1 := String(CBCnae1.Items.Objects[CBCnae1.ItemIndex]);
  objetoEmpresa.CdCnae2 := String(CBCnae2.Items.Objects[CBCnae2.ItemIndex]);
  objetoEmpresa.IncAlt := IncAlt;

  {
    ShowMessage(String(MeuComboBox.Items.Objects
    [MeuComboBox.ItemIndex]) + ' -- ' + MeuComboBox.Items
    [MeuComboBox.ItemIndex]);
  }

  if objetoEmpresa.CdCnae1 = objetoEmpresa.CdCnae2 then
  begin
    ShowMessage('CNAE´s não podem ser iguais [' + objetoEmpresa.CdCnae1 + '=' +
      objetoEmpresa.CdCnae2);
    CBCnae1.SetFocus;
    Exit;
  end;

  objetoControle.Salvar(objetoEmpresa);

  MECnpj.Clear;
  DBERazaoSocial.Clear;
  DBENomeFantasia.Clear;
  MEDataAbertura.Clear;
  CBCnae1.Clear;
  CBCnae2.Clear;
  self.Close;
end;

procedure TFEmpresaDados.BVoltarClick(Sender: TObject);
begin
  MECnpj.Clear;
  DBERazaoSocial.Clear;
  DBENomeFantasia.Clear;
  MEDataAbertura.Clear;
  CBCnae1.Clear;
  CBCnae2.Clear;
  self.Close;
end;

procedure TFEmpresaDados.DBECnpjChange(Sender: TObject);
begin
  MECnpj.Text := Copy(DBECnpj.Text, 0, 2) + '.' + Copy(DBECnpj.Text, 3, 3) + '.'
    + Copy(DBECnpj.Text, 6, 3) + '/' + Copy(DBECnpj.Text, 9, 4) + '-' +
    Copy(DBECnpj.Text, 13, 2);
end;

procedure TFEmpresaDados.FormActivate(Sender: TObject);
var
  objetoControle: TEmpresaController;
begin
  objetoControle := TEmpresaController.Create;
  objetoControle.PopularCombobox;

  DBECnpj.DataField := 'CNPJ';
  DBERazaoSocial.DataField := 'RAZAO_SOCIAL';
  DBENomeFantasia.DataField := 'NOME_FANTASIA';

  MECnpj.SetFocus;
end;

procedure TFEmpresaDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(objetoEmpresa);
  FreeAndNil(objetoControle);
end;

procedure TFEmpresaDados.FormCreate(Sender: TObject);
begin
  objetoControle := TEmpresaController.Create;
  objetoEmpresa := TEmpresaModel.Create;
end;

procedure TFEmpresaDados.MECnpjExit(Sender: TObject);
var
  Mask: String;
begin
  Mask := MECnpj.EditMask;
  MECnpj.EditMask := '';
  if not objetoControle.IsValidCNPJ(MECnpj.Text) then
  begin
    ShowMessage('CNPJ não é válido');
    MECnpj.SetFocus;
  end;
  MECnpj.EditMask := Mask;
end;

procedure TFEmpresaDados.MEDataAberturaExit(Sender: TObject);
begin
  if not TRegEx.IsMatch(MEDataAbertura.Text,
    '^((0[1-9]|[12]\d)\/(0[1-9]|1[0-2])|30\/(0[13-9]|1[0-2])|31\/(0[13578]|1[02]))\/\d{4}$')
  then
  begin
    ShowMessage('Data não é válida');
    MEDataAbertura.SetFocus;
  end;
end;

end.
