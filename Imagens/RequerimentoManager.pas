unit RequerimentoManager;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs,
  System.MaskUtils, Vcl.StdCtrls;

type
  TRequerimentoManager = class

  private
    FConnection: TFDConnection;
    FTransaction: TFDTransaction;

  protected
   function GetUltimoID_ATENDIMENTO: Integer;

   function GerarNumeroProtocolo(DataEntrada: TDateTime): string;

    var
    //variaveis para receber o ultimo id
    UltimoID_REQUERENTE, UltimoID_ENDERECO, UltimoID_PF, UltimoID_Funcionario: Integer;
    UltimoID_ATENDIMENTO: Integer;

    vgID_Endereco, vID_SECRETARIA: Integer;

    qryConstNome: TFDQuery;

  public
    constructor Create(Connection: TFDConnection);

    procedure ConsultarPorNome(const Nome: string; lstRequerente: TListBox);

    procedure GravarRequerimento(const UltimoID_REQUERENTE, UltimoID_PF,
      UltimoID_Funcionario, UltimoID_ATENDIMENTO: Integer; const vgID_Endereco: Integer;
      const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp, edtEmail,
      edtComplemento, edtNum, edtBairro, edtCep: string; jvDtNascimento, jvDtEntrada: TDateTime;
      const edtMatricula, edtLotacao, edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
      tbl_servicos_solicitados: TFDMemTable);

    function IDRequerenteJaExiste(IDRequerente: Integer): Boolean;

    function ParseSelectedText(const Text: string; var ID: Integer;
      var Nome, Cpf: string): Boolean;

    var
    vIDReq: integer;

  end;

implementation

uses uDmPrincipal, uFrmCadRequerimento;

procedure TRequerimentoManager.ConsultarPorNome(const Nome: string;
  lstRequerente: TListBox);
{var
  qryConstNome: TFDQuery;}

begin
qryConstNome := TFDQuery.Create(nil);
  try
    qryConstNome.Connection := FConnection;
    qryConstNome.Close;
    qryConstNome.SQL.Text := 'SELECT r.ID_Requerente, r.Nome, pf.CPF ' +
      'FROM tbl_requerente r ' +
      'JOIN tbl_pessoa_fisica pf on r.ID_Requerente = pf.ID_Requerente ' +
      'WHERE r.Nome containing :pNome;';
    qryConstNome.ParamByName('pNome').AsString := Nome;
    qryConstNome.Open;

    if not qryConstNome.IsEmpty then
    begin
      lstRequerente.Visible := True;
      lstRequerente.Width := 320;
    end
    else
    begin
      lstRequerente.Visible := False;
    end;

    lstRequerente.Clear; // Limpa o TListBox

    // Preenche o TListBox com os resultados da consulta
    while not qryConstNome.Eof do
    begin
      // Formatando o CPF com máscaras
      // Exemplo: 123.456.789-01
      var
      Cpf := FormatMaskText('000\.000\.000\-00;0;_',
        qryConstNome.FieldByName('CPF').AsString);

      lstRequerente.Items.Add(Format('%d | %s | %s',
        [qryConstNome.FieldByName('ID_Requerente').AsInteger,
        qryConstNome.FieldByName('Nome').AsString, Cpf]));

      qryConstNome.Next;
    end;
  finally
    qryConstNome.Free;
  end;
end;

constructor TRequerimentoManager.Create(Connection: TFDConnection);
begin
  FConnection := DmPrincipal.ConexaoBd;
  FTransaction := TFDTransaction.Create(nil);
  FTransaction.Connection := FConnection;

  //Criando os Ids necessários:
  UltimoID_ATENDIMENTO := GetUltimoID_ATENDIMENTO;

end;


function TRequerimentoManager.ParseSelectedText(const Text: string;
  var ID: Integer; var Nome, Cpf: string): Boolean;
var
  Values: TArray<string>;
begin
  Result := False;
  Values := Text.Split(['|']);

  if Length(Values) = 3 then
  begin
    ID := StrToInt(Trim(Values[0]));
    Nome := Trim(Values[1]);
    Cpf := Trim(Values[2]);

    vIDReq := ID;
    // Chama a função IDRequerenteJaExiste
    Result := IDRequerenteJaExiste(ID);
  end;
end;


function TRequerimentoManager.GerarNumeroProtocolo(
  DataEntrada: TDateTime): string;
 var
//  data: TDateTime;
  vDataFormatada: string;
  vNumProtocolo: String;
begin
   // vamos formatar
  vDataFormatada := FormatDateTime('ddmmyy', DataEntrada);
  vNumProtocolo := IntToStr(UltimoID_ATENDIMENTO)+vDataFormatada+'-'+IntToStr(vID_SECRETARIA);

  // vamos exibir o resultado
  Result := vNumProtocolo;

end;

function TRequerimentoManager.GetUltimoID_ATENDIMENTO: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'SELECT COALESCE(MAX(ID_ATENDIMENTO),0)AS LAST_ID FROM TBL_ATENDIMENTO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;

end;

procedure TRequerimentoManager.GravarRequerimento(const UltimoID_REQUERENTE, UltimoID_PF,
  UltimoID_Funcionario, UltimoID_ATENDIMENTO: Integer; const vgID_Endereco: Integer;
  const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp, edtEmail,
  edtComplemento, edtNum, edtBairro, edtCep: string; jvDtNascimento, jvDtEntrada: TDateTime;
  const edtMatricula, edtLotacao, edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
  tbl_servicos_solicitados: TFDMemTable);

var
  qryCadRequerimento, qryServSolicitado: TFDQuery;
  Sucesso: Boolean;
  vid_Req: Integer;
  id_requerente, id_pessoa_fisica, id_funcionario, id_endereco: integer;

begin
  qryCadRequerimento := TFDQuery.Create(nil);
  qryServSolicitado := TFDQuery.Create(nil);

  try
   qryCadRequerimento.Connection := FConnection;
   qryServSolicitado.Connection := FConnection;
   qryCadRequerimento.Transaction := FTransaction;
   qryServSolicitado.Transaction := FTransaction;

   FTransaction.StartTransaction;

    Sucesso := True;

    try
     // Verificar se o requerente já existe
     //vIDReq :=  id_re

     ShowMessage('ID: '+ IntToStr(vIDReq));

    if IDRequerenteJaExiste(vIDReq) then

      begin
        // Atualizar os dados do requerente
        ShowMessage(IntToStr(vIDReq));
        qryCadRequerimento.SQL.Text :=
          'UPDATE TBL_REQUERENTE SET NOME = :NOME, DATA_NASCIMENTO = :DATA_NASCIMENTO, ' +
          'CELULAR = :CELULAR, WHATSAPP = :WHATSAPP, EMAIL = :EMAIL, COMPLEMENTO = :COMPLEMENTO, ' +
          'NUMERO = :NUMERO, BAIRRO = :BAIRRO, CEP = :CEP ' +
          'WHERE ID_REQUERENTE = :ID_REQUERENTE;';

        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := id_requerente;
        // Parametros para atualização
        qryCadRequerimento.Params.ParamByName('NOME').asString := edtNome;
        qryCadRequerimento.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('CELULAR').asString := edtCelular;
        qryCadRequerimento.Params.ParamByName('WHATSAPP').asString := edtWhastApp;
        qryCadRequerimento.Params.ParamByName('EMAIL').asString := edtEmail;
        qryCadRequerimento.Params.ParamByName('COMPLEMENTO').asString := edtComplemento;
        qryCadRequerimento.Params.ParamByName('NUMERO').asString := edtNum;
        qryCadRequerimento.Params.ParamByName('BAIRRO').asString := edtBairro;
        qryCadRequerimento.Params.ParamByName('CEP').asString := edtCep;
        qryCadRequerimento.ExecSQL;
      end
      else
      begin
      // populando a tabela de REQUERENTE
        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_REQUERENTE (ID_REQUERENTE, ID_TP_PESSOA, ID_ENDERECO, NOME, DATA_NASCIMENTO, CELULAR, WHATSAPP, EMAIL, COMPLEMENTO, NUMERO, BAIRRO, CEP, DATA_CADASTRO) '
          + 'VALUES (:ID_REQUERENTE, :ID_TP_PESSOA, :ID_ENDERECO, :NOME, :DATA_NASCIMENTO, :CELULAR, :WHATSAPP, :EMAIL, :COMPLEMENTO, :NUMERO, :BAIRRO, :CEP, :DATA_CADASTRO);';

        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := UltimoID_REQUERENTE;
        qryCadRequerimento.Params.ParamByName('ID_TP_PESSOA').AsInteger := 1;
        qryCadRequerimento.Params.ParamByName('ID_ENDERECO').AsInteger := vgID_Endereco;
        qryCadRequerimento.Params.ParamByName('NOME').asString := edtNome;
        qryCadRequerimento.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('CELULAR').asString := edtCelular;
        qryCadRequerimento.Params.ParamByName('WHATSAPP').asString := edtWhastApp;
        qryCadRequerimento.Params.ParamByName('EMAIL').asString := edtEmail;
        qryCadRequerimento.Params.ParamByName('COMPLEMENTO').asString := edtComplemento;
        qryCadRequerimento.Params.ParamByName('NUMERO').asString := edtNum;
        qryCadRequerimento.Params.ParamByName('BAIRRO').asString := edtBairro;
        qryCadRequerimento.Params.ParamByName('CEP').asString := edtCep;
        qryCadRequerimento.Params.ParamByName('DATA_CADASTRO').asDate := now;
        qryCadRequerimento.ExecSQL;
      end;
     // populando a tabela pessoa fisica
      qryCadRequerimento.SQL.Text :=
        'INSERT INTO TBL_PESSOA_FISICA (ID_PESSOA_FISICA, ID_REQUERENTE, CPF, RG, SEXO) '
        + 'VALUES (:ID_PESSOA_FISICA, :ID_REQUERENTE, :CPF, :RG, :SEXO);';

      qryCadRequerimento.Params.ParamByName('ID_PESSOA_FISICA').AsInteger := UltimoID_PF;
      qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDReq;
      qryCadRequerimento.Params.ParamByName('CPF').asString := edtNumCPF;
      qryCadRequerimento.Params.ParamByName('RG').asString := edtRg;
      qryCadRequerimento.Params.ParamByName('SEXO').asString := cbxSexo;
      qryCadRequerimento.ExecSQL;

      // populando a tabela funcionarios
      qryCadRequerimento.SQL.Text :=
        'INSERT INTO TBL_FUNCIONARIO (ID_FUNCIONARIO,ID_PESSOA_FISICA, DATA_ADMISSAO, MATRICULA, LOTACAO, LOCAL_TRABALHO, CARGO) '
        + 'VALUES (:ID_FUNCIONARIO,:ID_PESSOA_FISICA, :DATA_ADMISSAO, :MATRICULA, :LOTACAO, :LOCAL_TRABALHO, :CARGO);';

      qryCadRequerimento.Params.ParamByName('ID_FUNCIONARIO').AsInteger := UltimoID_Funcionario;
      qryCadRequerimento.Params.ParamByName('ID_PESSOA_FISICA').AsInteger := UltimoID_PF;
      qryCadRequerimento.Params.ParamByName('DATA_ADMISSAO').asDate := jvDtNascimento;
      qryCadRequerimento.Params.ParamByName('MATRICULA').asString := edtMatricula;
      qryCadRequerimento.Params.ParamByName('LOTACAO').asString := edtLotacao;
      qryCadRequerimento.Params.ParamByName('LOCAL_TRABALHO').asString := edtLocalTrabalho;
      qryCadRequerimento.Params.ParamByName('CARGO').asString := edtCargo;
      qryCadRequerimento.ExecSQL;

      begin
        // populando a tabela de atendimento
        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_ATENDIMENTO (ID_ATENDIMENTO,ID_REQUERENTE, ID_SECRETARIA, NUM_PROTOCOLO, DATA_ENTRADA, STATUS) '
          + 'VALUES (:ID_ATENDIMENTO,:ID_REQUERENTE, :ID_SECRETARIA, :NUM_PROTOCOLO, :DATA_ENTRADA, :STATUS);';
        qryCadRequerimento.Params.ParamByName('ID_ATENDIMENTO').AsInteger := UltimoID_ATENDIMENTO;
        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDReq;
        qryCadRequerimento.Params.ParamByName('ID_SECRETARIA').AsInteger := 3;
        qryCadRequerimento.Params.ParamByName('NUM_PROTOCOLO').asString := GerarNumeroProtocolo(now);;
        qryCadRequerimento.Params.ParamByName('DATA_ENTRADA').asDate := jvDtEntrada;
        qryCadRequerimento.Params.ParamByName('STATUS').asString := 'A';
        qryCadRequerimento.ExecSQL;
      end;

      // Commit da transação de inclusão de dados no banco
      FTransaction.Commit;

      // ############################

      // Gravando serviços solicitados
      qryServSolicitado.SQL.Text :=
        'INSERT INTO TBL_servico_solicitado (ID_Atendimento, ID_Servico) VALUES (:ID_Atendimento, :ID_Servico)';
      qryServSolicitado.Prepare;

      tbl_servicos_solicitados.First;
      while not tbl_servicos_solicitados.EOF do
      begin
        qryServSolicitado.ParamByName('ID_Atendimento').AsInteger :=
          tbl_servicos_solicitados.FieldByName('ID_Atendimento').AsInteger;
        qryServSolicitado.ParamByName('ID_Servico').AsInteger :=
          tbl_servicos_solicitados.FieldByName('ID_Servico').AsInteger;

        qryServSolicitado.ExecSQL;

        tbl_servicos_solicitados.Next;
      end;

      // ############################
    except
      FTransaction.Rollback;
      Sucesso := False;
    end;
    if Sucesso then
      ShowMessage('Tabelas populadas com sucesso!')
    else
      ShowMessage
        ('Erro ao gravar dados nas tabelas. Nenhum registro foi alterado.');
  finally
    qryCadRequerimento.Free;
    qryServSolicitado.Free;
  end;
end;


function TRequerimentoManager.IDRequerenteJaExiste(
  IDRequerente: Integer): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text :=
      'SELECT COUNT(*) FROM TBL_REQUERENTE WHERE ID_REQUERENTE = :ID_REQUERENTE';

    Query.Params.ParamByName('ID_REQUERENTE').AsInteger := IDRequerente;
    Query.Open;

    Result := Query.Fields[0].AsInteger > 0;
  finally
    Query.Free;
  end;
end;

end.
