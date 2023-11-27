unit ReqTeste;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs;

type
   TReqTeste = class
  private
    FConnection: TFDConnection;
    FTransaction: TFDTransaction;
    function IDRequerenteJaExiste(IDRequerente: Integer): Boolean;

  protected
   function GetUltimoID_ATENDIMENTO: Integer;

   function GerarNumeroProtocolo(DataEntrada: TDateTime): string;




  public
    constructor Create(Connection: TFDConnection);
    procedure GravarRequerimento(const UltimoID_REQUERENTE, UltimoID_PF,
      UltimoID_Funcionario, UltimoID_ATENDIMENTO: Integer; const vgID_Endereco: Integer;
      const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp, edtEmail,
      edtComplemento, edtNum, edtBairro, edtCep: string; jvDtNascimento, jvDtEntrada: TDateTime;
      const edtMatricula, edtLotacao, edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
      tbl_servicos_solicitados: TFDMemTable);

    procedure RetornaRequerente(const IdReq: integer; const edtNome: string);
   end;

   var  //variaveis para receber o ultimo id
    UltimoID_REQUERENTE, UltimoID_ENDERECO, UltimoID_PF, UltimoID_Funcionario: Integer;
    UltimoID_ATENDIMENTO: Integer;

    vId_Requerente, vID_SECRETARIA: Integer;



implementation

uses uDmPrincipal, uFrmTesteCadastros;

constructor TReqTeste.Create(Connection: TFDConnection);
begin
  FConnection := DmPrincipal.ConexaoBd;
  FTransaction := TFDTransaction.Create(nil);
  FTransaction.Connection := FConnection;

  //Criando os Ids necessários:
  UltimoID_ATENDIMENTO := GetUltimoID_ATENDIMENTO;
  ShowMessage(IntToStr(UltimoID_ATENDIMENTO));


end;

function TReqTeste.IDRequerenteJaExiste( IDRequerente: Integer): Boolean;
 var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'SELECT COUNT(*) FROM TBL_REQUERENTE WHERE ID_REQUERENTE = :ID_REQUERENTE';
    Query.Params.ParamByName('ID_REQUERENTE').AsInteger := IDRequerente;
    Query.Open;
    Result := Query.Fields[0].AsInteger > 0;
  finally
    Query.Free;
  end;
end;

procedure TReqTeste.RetornaRequerente(const IdReq: integer; const edtNome: string);
var
 qryRetonraRequerente: TFDQuery;
 vEdtNome: string;

begin
 qryRetonraRequerente := TFDQuery.Create(nil);

 qryRetonraRequerente.SQL.Text :=
      'SELECT req.id_requerente, req.id_tp_pessoa, req.id_endereco, req.nome,req.data_nascimento, pf.cpf,' +
      'pf.rg, pf.sexo, req.celular, req.whatsapp, req.email, req.complemento, req.numero, req.bairro, req.cep' +
      'FROM tbl_requerente  req ' +
      'join tbl_pessoa_fisica as pf on req.id_requerente = pf.id_requerente WHERE req.id_requerente = :idreq';
  qryRetonraRequerente.ParamByName('idreq').AsInteger := IdReq;
  qryRetonraRequerente.ParamByName('edtNome').AsString := vEdtNome;

  vEdtNome := qryRetonraRequerente.Params.ParamByName('edtNome').asString;



  qryRetonraRequerente.Open;
end;


function TReqTeste.GerarNumeroProtocolo(
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

function TReqTeste.GetUltimoID_ATENDIMENTO: Integer;
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

procedure TReqTeste.GravarRequerimento(const UltimoID_REQUERENTE, UltimoID_PF,
  UltimoID_Funcionario, UltimoID_ATENDIMENTO: Integer; const vgID_Endereco: Integer;
  const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp, edtEmail,
  edtComplemento, edtNum, edtBairro, edtCep: string; jvDtNascimento, jvDtEntrada: TDateTime;
  const edtMatricula, edtLotacao, edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
  tbl_servicos_solicitados: TFDMemTable);
var
  Query, qryServSolicitado: TFDQuery;
  Sucesso: Boolean;
begin
  Query := TFDQuery.Create(nil);
  qryServSolicitado := TFDQuery.Create(nil);

  try
    Query.Connection := FConnection;
    qryServSolicitado.Connection := FConnection;

    Query.Transaction := FTransaction;
    qryServSolicitado.Transaction := FTransaction;

    FTransaction.StartTransaction;
    Sucesso := True;


    try
     // Verificar se o requerente já existe
     vId_Requerente := frmTesteCadastros.vgId_Requerente;
      if IDRequerenteJaExiste(vId_Requerente) then
      begin
        // Atualizar os dados do requerente
        Query.SQL.Text :=
          'UPDATE TBL_REQUERENTE SET NOME = :NOME, DATA_NASCIMENTO = :DATA_NASCIMENTO, ' +
          'CELULAR = :CELULAR, WHATSAPP = :WHATSAPP, EMAIL = :EMAIL, COMPLEMENTO = :COMPLEMENTO, ' +
          'NUMERO = :NUMERO, BAIRRO = :BAIRRO, CEP = :CEP ' +
          'WHERE ID_REQUERENTE = :ID_REQUERENTE;';

        //Query.Params.ParamByName('ID_REQUERENTE').AsInteger := UltimoID_REQUERENTE;
        // Parametros para atualização
        Query.Params.ParamByName('NOME').asString := edtNome;
        Query.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        Query.Params.ParamByName('CELULAR').asString := edtCelular;
        Query.Params.ParamByName('WHATSAPP').asString := edtWhastApp;
        Query.Params.ParamByName('EMAIL').asString := edtEmail;
        Query.Params.ParamByName('COMPLEMENTO').asString := edtComplemento;
        Query.Params.ParamByName('NUMERO').asString := edtNum;
        Query.Params.ParamByName('BAIRRO').asString := edtBairro;
        Query.Params.ParamByName('CEP').asString := edtCep;
        Query.ExecSQL;
      end
      else
      begin
    //  if not IDRequerenteJaExiste(UltimoID_REQUERENTE) then
    //  begin
        // populando a tabela de REQUERENTE
        Query.SQL.Text :=
          'INSERT INTO TBL_REQUERENTE (ID_REQUERENTE, ID_TP_PESSOA, ID_ENDERECO, NOME, DATA_NASCIMENTO, CELULAR, WHATSAPP, EMAIL, COMPLEMENTO, NUMERO, BAIRRO, CEP, DATA_CADASTRO) '
          + 'VALUES (:ID_REQUERENTE, :ID_TP_PESSOA, :ID_ENDERECO, :NOME, :DATA_NASCIMENTO, :CELULAR, :WHATSAPP, :EMAIL, :COMPLEMENTO, :NUMERO, :BAIRRO, :CEP, :DATA_CADASTRO);';

        Query.Params.ParamByName('ID_REQUERENTE').AsInteger := UltimoID_REQUERENTE;
        Query.Params.ParamByName('ID_TP_PESSOA').AsInteger := 1;
        Query.Params.ParamByName('ID_ENDERECO').AsInteger := vgID_Endereco;
        Query.Params.ParamByName('NOME').asString := edtNome;
        Query.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        Query.Params.ParamByName('CELULAR').asString := edtCelular;
        Query.Params.ParamByName('WHATSAPP').asString := edtWhastApp;
        Query.Params.ParamByName('EMAIL').asString := edtEmail;
        Query.Params.ParamByName('COMPLEMENTO').asString := edtComplemento;
        Query.Params.ParamByName('NUMERO').asString := edtNum;
        Query.Params.ParamByName('BAIRRO').asString := edtBairro;
        Query.Params.ParamByName('CEP').asString := edtCep;
        Query.Params.ParamByName('DATA_CADASTRO').asDate := now;
        Query.ExecSQL;
      end;

      // Commit da transação de inclusão de dados no banco
      FTransaction.Commit;

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
    Query.Free;
    qryServSolicitado.Free;
  end;
end;

end.
