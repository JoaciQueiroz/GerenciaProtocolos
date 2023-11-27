unit uFrmCadastroRequerimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseCadastro, Data.DB,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  JvExStdCtrls, JvButton, JvCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  FireDAC.Comp.Client,
  Vcl.WinXPickers, Vcl.ComCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Error, FireDAC.Stan.Intf, FireDAC.Stan.Consts,
  Vcl.DBCtrls;

type
  TfrmCadastroRequerimento = class(TfrmBaseCadastro)
    edtIdPessoa: TEdit;
    edtIdTpPessoa: TEdit;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtWhatsApp: TEdit;
    edtEmail: TEdit;
    edtCpf: TEdit;
    edtIdFuncionario: TEdit;
    edtIdPessoaFunc: TEdit;
    edtMatricula: TEdit;
    edtLotacao: TEdit;
    edtLocalTrabalho: TEdit;
    edtCargo: TEdit;
    edtIdRequerente: TEdit;
    edtIdFuncionarioReqt: TEdit;
    edtIdServicoReqt: TEdit;
    edtNumProtocolo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    dtmDtEntrada: TJvDateEdit;
    Label23: TLabel;
    Label24: TLabel;
    dtmDtNascimento: TJvDateEdit;
    edtLogradouro: TEdit;
    edtEndereco: TEdit;
    edtNum: TEdit;
    edtBairro: TEdit;
    edtComplemento: TEdit;
    edtCep: TEdit;
    Label25: TLabel;
    edtMunicipio: TEdit;
    edtUf: TEdit;
    memObservacao: TMemo;
    edtCodigoServico: TEdit;
    dbgServicos: TDBGrid;
    Label21: TLabel;
    dtmDtAdmissao: TJvDateEdit;
    edtIdLogradouro: TEdit;
    edtIdEndereco: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    cbxSexo: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
  private
    { Private declarations }
  protected

    function GetUltimoID_PESSOA: Integer;
    function GetUltimoID_Funcionario: Integer;
    function GetUltimoID_Endereco: Integer;
    function GetUltimoID_Requerimento: Integer;

  var
    UltimoId_Pessoa, UltimoID_Funcionario, UltimoID_Endereco,
      UltimoID_Requerimento: Integer;
    vData: TDate;
    vD, vM, vA: String;

  public
    { Public declarations }
  end;

var
  frmCadastroRequerimento: TfrmCadastroRequerimento;

implementation

{$R *.dfm}

uses uDmPrincipal;

{ TfrmCadastroRequerimento }

procedure TfrmCadastroRequerimento.actGravarExecute(Sender: TObject);
var
  Query: TFDQuery;
  Transacao: TFDTransaction;
  Sucesso: Boolean;
begin
  // inherited;
  Query := TFDQuery.Create(nil);
  Transacao := TFDTransaction.Create(nil);

  try
    Query.Connection := dmPrincipal.ConexaoBd;
    Transacao.Connection := dmPrincipal.ConexaoBd;
    Query.Transaction := Transacao;

    Transacao.StartTransaction;
    Sucesso := True;

    try

      // populando a tabela de endereço
      Query.SQL.Text :=
        'INSERT INTO TBL_ENDERECO (ID_ENDERECO, ID_MUNICIPIO, ID_LOGRADOURO, ENDERECO, NUM, BAIRRO, COMPLEMENTO, CEP) '
        + 'VALUES (:ID_ENDERECO, :ID_MUNICIPIO, :ID_LOGRADOURO, :ENDERECO, :NUM, :BAIRRO, :COMPLEMENTO, :CEP);';

      // UltimoID_Endereco := GetUltimoID_Endereco;
      Query.Params.ParamByName('ID_ENDERECO').AsInteger :=
        StrToInt(edtIdEndereco.Text);;
      Query.Params.ParamByName('ID_MUNICIPIO').AsInteger := 1;
      Query.Params.ParamByName('ID_LOGRADOURO').AsInteger :=
        StrToInt(edtIdLogradouro.Text);
      Query.Params.ParamByName('ENDERECO').AsString := edtEndereco.Text;
      Query.Params.ParamByName('NUM').AsString := edtNum.Text;
      Query.Params.ParamByName('BAIRRO').AsString := edtBairro.Text;
      Query.Params.ParamByName('COMPLEMENTO').AsString := edtComplemento.Text;
      Query.Params.ParamByName('CEP').AsString := edtCep.Text;
      Query.ExecSQL;

      // populando a tabela de pessoa
      Query.SQL.Text :=
        'INSERT INTO TBL_PESSOA (ID_PESSOA, ID_TIPO_PESSOA, ID_ENDERECO, NOME, DATA_NASCIMENTO, TELEFONE, WHATSAPP, EMAIL, DATA_CADASTRO, CPF, SEXO) '
        + 'VALUES (:ID_PESSOA, :ID_TIPO_PESSOA, :ID_ENDERECO, :NOME, :DATA_NASCIMENTO, :TELEFONE, :WHATSAPP, :EMAIL, :DATA_CADASTRO, :CPF, :SEXO);';

      // UltimoId_Pessoa := GetUltimoID_PESSOA;
      Query.Params.ParamByName('ID_PESSOA').AsInteger :=
        StrToInt(edtIdPessoa.Text);
      Query.Params.ParamByName('ID_TIPO_PESSOA').AsInteger :=
        StrToInt(edtIdTpPessoa.Text);
      Query.Params.ParamByName('ID_ENDERECO').AsInteger :=
        StrToInt(edtIdEndereco.Text);
      Query.Params.ParamByName('NOME').AsString := edtNome.Text;
      Query.Params.ParamByName('DATA_NASCIMENTO').AsDate :=
        dtmDtNascimento.Date; // EncodeDate(1990, 1, 1);
      Query.Params.ParamByName('TELEFONE').AsString := edtTelefone.Text;
      Query.Params.ParamByName('WHATSAPP').AsString := edtWhatsApp.Text;
      Query.Params.ParamByName('EMAIL').AsString := edtEmail.Text;
      Query.Params.ParamByName('DATA_CADASTRO').AsDateTime := Now;
      Query.Params.ParamByName('CPF').AsString := edtCpf.Text;
      Query.Params.ParamByName('SEXO').AsString := cbxSexo.Text;
      Query.ExecSQL;

      // populando a tabela de funcionário
      Query.SQL.Text :=
        'INSERT INTO TBL_FUNCIONARIO (ID_FUNCIONARIO, ID_PESSOA, DATA_ADMISSAO, MATRICULA, LOTACAO, LOCAL_TRABALHO, CARGO) '
        + 'VALUES (:ID_FUNCIONARIO, :ID_PESSOA, :DATA_ADMISSAO, :MATRICULA, :LOTACAO, :LOCAL_TRABALHO, :CARGO);';

      // UltimoID_Funcionario := GetUltimoID_Funcionario;
      Query.Params.ParamByName('ID_FUNCIONARIO').AsInteger :=
        StrToInt(edtIdFuncionario.Text);
      Query.Params.ParamByName('ID_PESSOA').AsInteger :=
        StrToInt(edtIdPessoa.Text);
      Query.Params.ParamByName('DATA_ADMISSAO').AsDate := dtmDtAdmissao.Date;
      Query.Params.ParamByName('MATRICULA').AsString := edtMatricula.Text;
      Query.Params.ParamByName('LOTACAO').AsString := edtLotacao.Text;
      Query.Params.ParamByName('LOCAL_TRABALHO').AsString :=
        edtLocalTrabalho.Text;
      Query.Params.ParamByName('CARGO').AsString := edtCargo.Text;
      Query.ExecSQL;

      // populando a tabela de requerente
      Query.SQL.Text :=
        'INSERT INTO TBL_REQUERENTE (ID_REQUERENTE, ID_FUNCIONARIO, ID_SERVICO, NUM_PROTOCOLO, OBSERVACAO) '
        + 'VALUES (:ID_REQUERENTE, :ID_FUNCIONARIO, :ID_SERVICO, :NUM_PROTOCOLO, :OBSERVACAO);';
      Query.Params.ParamByName('ID_REQUERENTE').AsInteger :=
        StrToInt(edtIdRequerente.Text);
      Query.Params.ParamByName('ID_FUNCIONARIO').AsInteger :=
        StrToInt(edtIdFuncionarioReqt.Text);
      Query.Params.ParamByName('ID_SERVICO').AsInteger :=
        StrToInt(edtIdServicoReqt.Text);
      Query.Params.ParamByName('NUM_PROTOCOLO').AsString :=
        edtNumProtocolo.Text;
      Query.Params.ParamByName('OBSERVACAO').AsString := memObservacao.Text;
      Query.ExecSQL;

      Transacao.Commit;
    except
      Transacao.Rollback;
      Sucesso := False;
    end;

    if Sucesso then
      ShowMessage('Tabelas populadas com sucesso!')
    else
      ShowMessage
        ('Erro ao gravar dados nas tabelas. Nenhum registro foi alterado.');
  finally
    Query.Free;
    Transacao.Free;
  end;

end;

procedure TfrmCadastroRequerimento.FormShow(Sender: TObject);
begin
  inherited;

  UltimoId_Pessoa := GetUltimoID_PESSOA;
  edtIdPessoa.Text := IntToStr(UltimoId_Pessoa);
  edtIdPessoaFunc.Text := edtIdPessoa.Text;
  dtmDtEntrada.Date := Now;

  UltimoID_Funcionario := GetUltimoID_Funcionario;
  edtIdFuncionario.Text := IntToStr(UltimoID_Funcionario);
  edtIdFuncionarioReqt.Text := edtIdFuncionario.Text;

  UltimoID_Requerimento := GetUltimoID_Requerimento;
  edtNumProtocolo.Text := IntToStr(UltimoID_Requerimento);

  UltimoID_Endereco := GetUltimoID_Endereco;
  edtIdEndereco.Text := IntToStr(UltimoID_Endereco);
  edtMunicipio.Text := 'Pinheiro';
  edtUf.Text := 'MA';
  edtCep.Text := '65200000';
  edtIdTpPessoa.Text := '1';
  edtIdRequerente.Text := IntToStr(UltimoID_Requerimento);

  vData := now;
  vD := formatdatetime('dd', vData);
  vM := formatdatetime('mm', vData);
  vA := formatdatetime('yy', vData);

  edtNumProtocolo.Text :=  IntToStr(UltimoID_Requerimento)+'.'+ IntToStr(UltimoID_Funcionario)+'.' + vd + vM +'-' +vA;



end;

function TfrmCadastroRequerimento.GetUltimoID_Endereco: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_ENDERECO), 0) AS LAST_ID FROM TBL_ENDERECO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TfrmCadastroRequerimento.GetUltimoID_Funcionario: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_FUNCIONARIO), 0) AS LAST_ID FROM TBL_FUNCIONARIO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;

end;

function TfrmCadastroRequerimento.GetUltimoID_PESSOA: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_PESSOA), 0) AS LAST_ID FROM TBL_PESSOA';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TfrmCadastroRequerimento.GetUltimoID_Requerimento: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_REQUERENTE), 0) AS LAST_ID FROM TBL_REQUERENTE';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

end.
