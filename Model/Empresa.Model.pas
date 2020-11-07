unit Empresa.Model;

interface

uses
  SysUtils, System.Classes, Conexao.Model, Vcl.Dialogs;

type
  IModel = interface
    ['{AF45ADD6-E4D7-422D-B64F-86CC57B9A86B}']
  end;

type
  TEmpresaModel = class
  private
    FCnpj: string;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FDtAbertura: string;
    FCdCnae1: string;
    FCdCnae2: string;
    FIncAlt: char;
    FCnaeCod: string;
    FCnaeDes: string;
  public
    constructor Create;
    procedure PopularDBGEmpresa();
    procedure PopularCombobox();
    procedure Salvar(const objetoEmpresa: TEmpresaModel);
    procedure SalvarCnae(const objetoEmpresa: TEmpresaModel);

    property Cnpj: string read FCnpj write FCnpj;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property DtAbertura: string read FDtAbertura write FDtAbertura;
    property CdCnae1: string read FCdCnae1 write FCdCnae1;
    property CdCnae2: string read FCdCnae2 write FCdCnae2;
    property IncAlt: char read FIncAlt write FIncAlt;
    property CnaeCod: string read FCnaeCod write FCnaeCod;
    property CnaeDes: string read FCnaeDes write FCnaeDes;

  end;

implementation

constructor TEmpresaModel.Create;
begin
  FCnpj := '';
  FRazaoSocial := '';
  FNomeFantasia := '';
  FDtAbertura := '';
  FCdCnae1 := '';
  FCdCnae2 := '';
  FCnaeCod := '';
  FCnaeDes := '';
end;

procedure TEmpresaModel.PopularDBGEmpresa();
var
  Ssql: String;
begin
  Ssql := 'select empresa.*, cnae1.ds_cnae as ds_cnae_1, cnae2.ds_cnae as ds_cnae_2 from empresa left join cnae as cnae1 on cd_cnae_1 = cnae1.cd_cnae left join cnae as cnae2 on cd_cnae_2 = cnae2.cd_cnae order by empresa.razao_social';
  DMConexao.FDCConexao.Connected := true;
  with DMConexao.FDQConexao do
  begin
    sql.Clear;
    sql.Add(Ssql);
    open;
    Active := false;
    Active := true;
  end;
end;

procedure TEmpresaModel.PopularCombobox();
var
  Ssql: String;
begin
  Ssql := 'select * from cnae order by ds_cnae';
  DMConexao.FDCConexao.Connected := true;
  with DMConexao.FDQCnae do
  begin
    sql.Clear;
    sql.Add(Ssql);
    open;
    Active := false;
    Active := true;
  end;
end;

procedure TEmpresaModel.Salvar(const objetoEmpresa: TEmpresaModel);
var
  Ssql: string;
  rc: integer;
begin
  DMConexao.FDCConexao.Connected := true;

  if (objetoEmpresa.FIncAlt = 'A') then
  // Update
  begin
    Ssql := 'update cnae set a=1, CNPJ = ' + QuotedStr(objetoEmpresa.FCnpj) +
      ' , RAZAO_SOCIAL = ' + QuotedStr(objetoEmpresa.FRazaoSocial) +
      ' , NOME_FANTASIA = ' + QuotedStr(objetoEmpresa.FNomeFantasia) +
      ' , DT_ABERTURA = ' + QuotedStr(StringReplace(objetoEmpresa.FDtAbertura,
      '/', '.', [rfReplaceAll, rfIgnoreCase])) + ' , CD_CNAE_1 = ' +
      QuotedStr(objetoEmpresa.FCdCnae1) + ' , CD_CNAE_2 = ' +
      QuotedStr(objetoEmpresa.FCdCnae2) + ' where CNPJ = ' +
      QuotedStr(objetoEmpresa.FCnpj);
    with DMConexao.FDQConexao do
    begin
      Active := false;
      sql.Clear;
      sql.Add(Ssql);
      ExecSQL;
    end;
  end
  else
  // Insert
  begin
    Ssql := 'insert into empresa (CNPJ, RAZAO_SOCIAL, NOME_FANTASIA, DT_ABERTURA, CD_CNAE_1, CD_CNAE_2) values ('
      + QuotedStr(objetoEmpresa.FCnpj) + ',' +
      QuotedStr(objetoEmpresa.FRazaoSocial) + ',' +
      QuotedStr(objetoEmpresa.FNomeFantasia) + ',' +
      QuotedStr(StringReplace(objetoEmpresa.FDtAbertura, '/', '.',
      [rfReplaceAll, rfIgnoreCase])) + ',' + QuotedStr(objetoEmpresa.FCdCnae1) +
      ',' + QuotedStr(objetoEmpresa.FCdCnae2) + ')';

    with DMConexao.FDQConexao do
    begin
      sql.Clear;
      sql.Add(Ssql);
      ExecSQL;
    end;
  end;
  ShowMessage('Dados salvos com sucesso...');

end;

procedure TEmpresaModel.SalvarCnae(const objetoEmpresa: TEmpresaModel);
var
  Ssql: string;
  rc: integer;
begin
  DMConexao.FDCConexao.Connected := true;

  Ssql := 'select * from cnae where CD_CNAE = ' +
    QuotedStr(objetoEmpresa.CnaeCod);
  with DMConexao.FDQConexao do
  begin
    sql.Clear;
    sql.Add(Ssql);
    open;
    rc := RecordCount;
  end;

  if rc <> 0 then
  // Update
  begin
    Ssql := 'update cnae set DS_CNAE = ' + QuotedStr(objetoEmpresa.CnaeDes) +
      ' where CD_CNAE = ' + QuotedStr(objetoEmpresa.CnaeCod);
    with DMConexao.FDQConexao do
    begin
      Active := false;
      sql.Clear;
      sql.Add(Ssql);
      ExecSQL;
    end;
  end
  else
  // Insert
  begin
    Ssql := 'insert into cnae (CD_CNAE, DS_CNAE) values (' +
      QuotedStr(objetoEmpresa.CnaeCod) + ',' +
      QuotedStr(objetoEmpresa.CnaeDes) + ')';
    with DMConexao.FDQConexao do
    begin
      sql.Clear;
      sql.Add(Ssql);
      ExecSQL;
    end;
  end;

end;

end.
