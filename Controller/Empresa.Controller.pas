unit Empresa.Controller;

interface

uses Empresa.Model, System.Math, System.SysUtils, IdHTTP, System.Classes,
  System.json, Vcl.Dialogs;

type
  IController = interface
    ['{005D3335-986C-40FA-B106-3E958CE92796}']
  end;

type
  TEmpresaController = class
  private

  public
    constructor Create;
    function IsValidCNPJ(pCNPJ: string): boolean;
    procedure Salvar(const objetoEmpresa: TEmpresaModel);
    procedure PopularDBGEmpresa();
    procedure PopularCNAE();
    procedure PopularCombobox();
  end;

implementation

uses Conexao.Model, Empresa.Dados.View;

constructor TEmpresaController.Create;
begin

end;

procedure TEmpresaController.PopularCombobox();
var
  objetoEmpresa: TEmpresaModel;
begin
  objetoEmpresa := TEmpresaModel.Create;
  objetoEmpresa.PopularCombobox;

  FEmpresaDados.CBCnae1.Items.Clear;
  FEmpresaDados.CBCnae2.Items.Clear;

  DMConexao.FDQCnae.Close;
  DMConexao.FDQCnae.Open;
  DMConexao.FDQCnae.First;
  while not DMConexao.FDQCnae.Eof do
  begin
    FEmpresaDados.CBCnae1.AddItem
      (UTF8ToString(DMConexao.FDQCnaeDS_CNAE.AsString),
      TObject(DMConexao.FDQCnaeCD_CNAE.AsString));
    FEmpresaDados.CBCnae2.AddItem
      (UTF8ToString(DMConexao.FDQCnaeDS_CNAE.AsString),
      TObject(DMConexao.FDQCnaeCD_CNAE.AsString));
    DMConexao.FDQCnae.Next;
  end;

end;

procedure TEmpresaController.PopularCNAE();
var
  ParamList: TStringList;
  HTTP: TIdHTTP;
  jsonStringData: String;

  i: integer;
  JSonValue: TJSonValue;

  JSonArray: TJSONArray;

  objetoEmpresa: TEmpresaModel;

begin
  ParamList := TStringList.Create;
  HTTP := TIdHTTP.Create(nil);
  try
    {
      Endereço: http://3.20.200.202:3333/cnae
      Não foi possível fazer a leitura do JSON diretamente do endereço informado,
      mas a funcionalidade foi testada em outra URL removendo os dois lançamentos
      vazios ao final do JSON e funcionou corretamente.
    }
    jsonStringData := HTTP.Post('https://grck.com.br/cnae.json', ParamList);
    JSonValue := TJSONObject.ParseJSONValue(jsonStringData);
    JSonArray := JSonValue as TJSONArray;

    objetoEmpresa := TEmpresaModel.Create;
    objetoEmpresa.PopularDBGEmpresa;

    for i := 0 to (JSonArray.Count - 1) do
    begin
      objetoEmpresa.CnaeCod := JSonValue.GetValue<string>
        ('[' + IntToStr(i) + '].id_cnae');
      objetoEmpresa.CnaeDes :=
        UTF8ToString(JSonValue.GetValue<string>('[' + IntToStr(i) +
        '].ds_cnae'));
      objetoEmpresa.SalvarCnae(objetoEmpresa);
    end;

    JSonValue.Free;
    HTTP.Free;
    ParamList.Free;
  except
    on E: Exception do
    begin
      ShowMessage
        ('Não foi possível atualizar tabela CNAE. Será usada a versão atual');
    end;
  end;

end;

procedure TEmpresaController.PopularDBGEmpresa();
var
  objetoEmpresa: TEmpresaModel;
begin
  objetoEmpresa := TEmpresaModel.Create;
  objetoEmpresa.PopularDBGEmpresa;
end;

procedure TEmpresaController.Salvar(const objetoEmpresa: TEmpresaModel);
begin
  objetoEmpresa.Salvar(objetoEmpresa);
end;

function TEmpresaController.IsValidCNPJ(pCNPJ: string): boolean;
var
  v: array [1 .. 2] of Word;
  Cnpj: array [1 .. 14] of Byte;
  i: Byte;
begin
  Result := False;
  { Conferindo se todos dígitos são iguais }
  if ((pCNPJ = StringOfChar('0', 14)) or (pCNPJ = StringOfChar('1', 14)) or
    (pCNPJ = StringOfChar('2', 14)) or (pCNPJ = StringOfChar('3', 14)) or
    (pCNPJ = StringOfChar('4', 14)) or (pCNPJ = StringOfChar('5', 14)) or
    (pCNPJ = StringOfChar('6', 14)) or (pCNPJ = StringOfChar('7', 14)) or
    (pCNPJ = StringOfChar('8', 14)) or (pCNPJ = StringOfChar('9', 14))) then
    Exit;
  { Calcular o digito verificador }
  try
    for i := 1 to 14 do
      Cnpj[i] := StrToInt(pCNPJ[i]);
    v[1] := 5 * Cnpj[1] + 4 * Cnpj[2] + 3 * Cnpj[3] + 2 * Cnpj[4];
    v[1] := v[1] + 9 * Cnpj[5] + 8 * Cnpj[6] + 7 * Cnpj[7] + 6 * Cnpj[8];
    v[1] := v[1] + 5 * Cnpj[9] + 4 * Cnpj[10] + 3 * Cnpj[11] + 2 * Cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    v[2] := 6 * Cnpj[1] + 5 * Cnpj[2] + 4 * Cnpj[3] + 3 * Cnpj[4];
    v[2] := v[2] + 2 * Cnpj[5] + 9 * Cnpj[6] + 8 * Cnpj[7] + 7 * Cnpj[8];
    v[2] := v[2] + 6 * Cnpj[9] + 5 * Cnpj[10] + 4 * Cnpj[11] + 3 * Cnpj[12];
    v[2] := v[2] + 2 * v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);
    Result := ((v[1] = Cnpj[13]) and (v[2] = Cnpj[14]));
  except
    on E: Exception do
      Result := False;
  end;
end;

end.
