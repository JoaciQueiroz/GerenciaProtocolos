unit DadosRequerente;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs,
  System.MaskUtils, Vcl.StdCtrls;

type
  TDadosRequerente = class
  private

  protected
    FConnection: TFDConnection;
    FTransaction: TFDTransaction;
    function GerarNumeroProtocolo(DataEntrada: TDateTime): string;
    function GetUltimoID_ATENDIMENTO: Integer;

  var

  public
    constructor Create(Connection: TFDConnection);
    procedure ConsultarPorNome(const Nome: string; lstRequerente: TListBox);

    function ConsultarRequerentePorID(const IDRequerente: Integer;
      var Nome, Cpf, Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular,
      Whatsapp, Email, Endereco, Complemento, Numero, bairro, cep: string;
      var DtNascimento, DtAdmissao: TDateTime; var IDEndereco: Integer)
      : Boolean;

    function ConsultaReqId(const IDRequerente: Integer;
      var Id_PF, Id_fn, Id_En: Integer): Boolean;

    procedure GravarRequerimento(const ID_REQUERENTE, Id_PF, ID_Funcionario,
      ID_ATENDIMENTO, ID_Endereco: Integer;
      const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp,
      edtEmail, edtComplemento, edtNum, edtBairro, edtCep: string;
      jvDtNascimento, jvDtEntrada: TDateTime; const edtMatricula, edtLotacao,
      edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
      tbl_servicos_solicitados: TFDMemTable);

    function ConsultaEnderecos(const IDEndereco: Integer;
      var logradouro, Endereco, municipio, uf: string): Boolean;

    function TextoSelecionado(const Text: string; var ID: Integer;
      var Nome, Cpf: string): Boolean;
    function IDRequerenteJaExiste(IDRequerente: Integer): Boolean;

  var
    // Variaveis caso o requerente já esteja cadastrado
    vIDRequerente, vIDPFisica, vIDEndereco, vIDFuncionario: Integer;

    // Variaveis caso  seja um novo requerente
    vUtiID_REQUERENTE, vUtiID_ENDERECO, vUtiID_PF, vUtiID_Funcionario: Integer;

    // Variaveis um novo atendimento
    vUtiID_ATENDIMENTO: Integer;
    // variarvel do Id da Secretaria solicitante
    vID_SECRETARIA: Integer;
    // variavel para pesquisa por nome
    qryConstNome: TFDQuery;

  end;

implementation

uses uDmPrincipal, uFrmTesteCadastros;

{ TDadosRequerente }

function TDadosRequerente.ConsultaEnderecos(const IDEndereco: Integer;
  var logradouro, Endereco, municipio, uf: string): Boolean;

var
  qryEndereco: TFDQuery;
begin
  qryEndereco := TFDQuery.Create(nil);
  try
    qryEndereco.Connection := FConnection;
    // Consulta de endereço
    qryEndereco.SQL.Text :=
      'SELECT lg.logradouro, en.endereco, mn.municipio, et.uf ' +
      'FROM tbl_endereco en ' +
      'JOIN tbl_logradouro as lg ON en.id_logradouro = lg.id_logradouro ' +
      'JOIN tbl_municipio as mn ON en.id_municipio = mn.id_municipio ' +
      'JOIN tbl_estado as et ON mn.idestado = et.id_estado ' +
      'WHERE en.id_endereco = :idEnd;';

    qryEndereco.Params.ParamByName('idEnd').AsInteger := IDEndereco;
    qryEndereco.Close;
    qryEndereco.Open;

    // verifica se a consulta retornou algum resultado
    if not qryEndereco.IsEmpty then
    begin
      logradouro := qryEndereco.FieldByName('logradouro').AsString;
      Endereco := qryEndereco.FieldByName('Endereco').AsString;
      municipio := qryEndereco.FieldByName('Municipio').AsString;
      uf := qryEndereco.FieldByName('Uf').AsString;

      Result := True;
    end
    else
    begin
      Result := False;
      ShowMessage('erro endereco')
    end;
    // Result := not qryEndereco.IsEmpty;
  finally
    qryEndereco.Free;
  end;
end;

function TDadosRequerente.ConsultaReqId(const IDRequerente: Integer;
  var Id_PF, Id_fn, Id_En: Integer): Boolean;

var
  qryConstReqId: TFDQuery;

begin

  qryConstReqId := TFDQuery.Create(nil);
  try
    qryConstReqId.Connection := FConnection;
    qryConstReqId.Close;
    qryConstReqId.SQL.Text :=
      ' SELECT rq.id_requerente, rq.id_tp_pessoa, pf.id_pessoa_fisica, ' +
      'fn.id_funcionario, rq.id_endereco FROM tbl_requerente  rq ' +
      'join tbl_pessoa_fisica as pf on pf.id_requerente = rq.id_requerente ' +
      'join tbl_funcionario as fn on pf.id_pessoa_fisica = fn.id_funcionario ' +
      'join tbl_endereco as en on rq.id_endereco = en.id_endereco ' +
      ' WHERE rq.id_requerente = :idreq;';

    qryConstReqId.Params.ParamByName('idreq').AsInteger := IDRequerente;
    qryConstReqId.Open;

    if not qryConstReqId.IsEmpty then
    begin
      vIDRequerente := qryConstReqId.FieldByName('id_requerente').AsInteger;
      vIDPFisica := qryConstReqId.FieldByName('id_pessoa_fisica').AsInteger;
      vIDFuncionario := qryConstReqId.FieldByName('id_funcionario').AsInteger;
      vIDEndereco := qryConstReqId.FieldByName('id_endereco').AsInteger;
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    qryConstReqId.Free;
  end;
end;

procedure TDadosRequerente.ConsultarPorNome(const Nome: string;
  lstRequerente: TListBox);
var
  qryConstNome: TFDQuery;
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

function TDadosRequerente.ConsultarRequerentePorID(const IDRequerente: Integer;
  var Nome, Cpf, Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular,
  Whatsapp, Email, Endereco, Complemento, Numero, bairro, cep: string;
  var DtNascimento, DtAdmissao: TDateTime; var IDEndereco: Integer): Boolean;
var
  qryDadosRequerente: TFDQuery;
begin
  qryDadosRequerente := TFDQuery.Create(nil);

  try
    qryDadosRequerente.Connection := FConnection;
    qryDadosRequerente.Close;
    qryDadosRequerente.SQL.Text :=
      'SELECT rq.id_requerente, rq.id_tp_pessoa, rq.id_endereco, rq.nome, pf.cpf, '
      + 'pf.rg, pf.sexo, rq.data_nascimento, fn.data_admissao, fn.matricula, fn.lotacao, '
      + 'fn.local_trabalho, fn.cargo, rq.celular, rq.whatsapp, rq.email, en.endereco, rq.complemento, '
      + 'rq.numero, rq.bairro, rq.cep ' + 'FROM tbl_requerente rq ' +
      'join tbl_pessoa_fisica as pf on rq.id_requerente = pf.id_requerente ' +
      'join tbl_funcionario as fn on rq.id_requerente = fn.id_funcionario ' +
      'join tbl_endereco as en on rq.id_endereco = en.id_endereco ' +
      'WHERE rq.id_requerente = :ID;';

    qryDadosRequerente.Params.ParamByName('ID').AsInteger := IDRequerente;
    // qryDadosRequerente.Close;
    qryDadosRequerente.Open;

    // verifica se a consulta retornou algum resultado
    if not qryDadosRequerente.IsEmpty then
    begin
      Nome := qryDadosRequerente.FieldByName('Nome').AsString;
      Cpf := qryDadosRequerente.FieldByName('Cpf').AsString;
      Rg := qryDadosRequerente.FieldByName('Rg').AsString;
      Sexo := qryDadosRequerente.FieldByName('sexo').AsString;
      Matricula := qryDadosRequerente.FieldByName('Matricula').AsString;
      Lotacao := qryDadosRequerente.FieldByName('Lotacao').AsString;
      LTrabalho := qryDadosRequerente.FieldByName('local_trabalho').AsString;
      Cargo := qryDadosRequerente.FieldByName('Cargo').AsString;
      Celular := qryDadosRequerente.FieldByName('Celular').AsString;
      Whatsapp := qryDadosRequerente.FieldByName('Whatsapp').AsString;
      Email := qryDadosRequerente.FieldByName('Email').AsString;
      Endereco := qryDadosRequerente.FieldByName('Endereco').AsString;
      Complemento := qryDadosRequerente.FieldByName('Complemento').AsString;
      Numero := qryDadosRequerente.FieldByName('Numero').AsString;
      bairro := qryDadosRequerente.FieldByName('Bairro').AsString;
      cep := qryDadosRequerente.FieldByName('Cep').AsString;
      DtNascimento := qryDadosRequerente.FieldByName('Data_nascimento')
        .AsDateTime;
      DtAdmissao := qryDadosRequerente.FieldByName('Data_admissao').AsDateTime;
      IDEndereco := qryDadosRequerente.FieldByName('id_endereco').AsInteger;
      Result := True;
    end
    else
    begin
      Result := False;
    end;

  finally
    qryDadosRequerente.Free;

  end;
end;

constructor TDadosRequerente.Create(Connection: TFDConnection);
begin
  FConnection := DmPrincipal.ConexaoBd;
  FTransaction := TFDTransaction.Create(nil);
  FTransaction.Connection := FConnection;

end;

function TDadosRequerente.GerarNumeroProtocolo(DataEntrada: TDateTime): string;
var
  // data: TDateTime;
  vDataFormatada: string;
  vNumProtocolo: String;
begin
  // vamos formatar
  vDataFormatada := FormatDateTime('ddmmyy', DataEntrada);
  vNumProtocolo := IntToStr(vUtiID_ATENDIMENTO) + vDataFormatada + '-' +
    IntToStr(vID_SECRETARIA);

  // vamos exibir o resultado
  Result := vNumProtocolo;

end;

function TDadosRequerente.GetUltimoID_ATENDIMENTO: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_ATENDIMENTO),0)AS LAST_ID FROM TBL_ATENDIMENTO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

procedure TDadosRequerente.GravarRequerimento(const ID_REQUERENTE, Id_PF,
  ID_Funcionario, ID_ATENDIMENTO, ID_Endereco: Integer;
  const edtNome, edtNumCPF, edtRg, cbxSexo, edtCelular, edtWhastApp, edtEmail,
  edtComplemento, edtNum, edtBairro, edtCep: string;
  jvDtNascimento, jvDtEntrada: TDateTime; const edtMatricula, edtLotacao,
  edtLocalTrabalho, edtCargo, edtNumProtocolo: string;
  tbl_servicos_solicitados: TFDMemTable);

var
  qryCadRequerimento, qryServSolicitado: TFDQuery;
  Sucesso: Boolean;
  //vIdfuncAtualiza, vIdPFAtualiza: Integer;

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
      if IDRequerenteJaExiste(vIDRequerente) then

      begin

        qryCadRequerimento.SQL.Text :=
          'UPDATE TBL_REQUERENTE SET NOME = :NOME, DATA_NASCIMENTO = :DATA_NASCIMENTO, '+
          'CELULAR = :CELULAR, WHATSAPP = :WHATSAPP, EMAIL = :EMAIL, COMPLEMENTO = :COMPLEMENTO, '+
          'NUMERO = :NUMERO, BAIRRO = :BAIRRO, CEP = :CEP ' +
          'WHERE ID_REQUERENTE = :ID_REQUERENTE;';

        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDRequerente;

        // Parametros para atualização
        qryCadRequerimento.Params.ParamByName('NOME').AsString := edtNome;
        qryCadRequerimento.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('CELULAR').AsString := edtCelular;
        qryCadRequerimento.Params.ParamByName('WHATSAPP').AsString := edtWhastApp;
        qryCadRequerimento.Params.ParamByName('EMAIL').AsString := edtEmail;
        qryCadRequerimento.Params.ParamByName('COMPLEMENTO').AsString := edtComplemento;
        qryCadRequerimento.Params.ParamByName('NUMERO').AsString := edtNum;
        qryCadRequerimento.Params.ParamByName('BAIRRO').AsString := edtBairro;
        qryCadRequerimento.Params.ParamByName('CEP').AsString := edtCep;
        qryCadRequerimento.ExecSQL;

        // Atualizar a tabela pessoa fisica
        qryCadRequerimento.SQL.Text :=
          'UPDATE TBL_PESSOA_FISICA SET ID_REQUERENTE = :ID_REQUERENTE, CPF = :CPF, '+
          'RG = :RG, SEXO = :SEXO WHERE ID_REQUERENTE = :ID_REQUERENTE;';

        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDRequerente;
        qryCadRequerimento.Params.ParamByName('CPF').AsString := edtNumCPF;
        qryCadRequerimento.Params.ParamByName('RG').AsString := edtRg;
        qryCadRequerimento.Params.ParamByName('SEXO').AsString := cbxSexo;
        qryCadRequerimento.ExecSQL;

        // Atualizar a tabela funcionarios
        qryCadRequerimento.SQL.Text :=
          'UPDATE TBL_FUNCIONARIO SET ID_PESSOA_FISICA = :ID_PESSOA_FISICA, ' +
          'DATA_ADMISSAO = :DATA_ADMISSAO, MATRICULA = :MATRICULA , LOTACAO = :LOTACAO, ' +
          'LOCAL_TRABALHO = :LOCAL_TRABALHO, CARGO = :CARGO '+
          'WHERE ID_PESSOA_FISICA = :ID_PESSOA_FISICA;';

        qryCadRequerimento.Params.ParamByName('ID_PESSOA_FISICA').AsInteger := vIDPFisica;
        qryCadRequerimento.Params.ParamByName('DATA_ADMISSAO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('MATRICULA').AsString := edtMatricula;
        qryCadRequerimento.Params.ParamByName('LOTACAO').AsString := edtLotacao;
        qryCadRequerimento.Params.ParamByName('LOCAL_TRABALHO').AsString := edtLocalTrabalho;
        qryCadRequerimento.Params.ParamByName('CARGO').AsString := edtCargo;
        qryCadRequerimento.ExecSQL;

      end
      else
      begin
        // populando a tabela de REQUERENTE

        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_REQUERENTE (ID_REQUERENTE, ID_TP_PESSOA, ID_ENDERECO, NOME, DATA_NASCIMENTO, CELULAR, WHATSAPP, EMAIL, COMPLEMENTO, NUMERO, BAIRRO, CEP, DATA_CADASTRO) '
          + 'VALUES (:ID_REQUERENTE, :ID_TP_PESSOA, :ID_ENDERECO, :NOME, :DATA_NASCIMENTO, :CELULAR, :WHATSAPP, :EMAIL, :COMPLEMENTO, :NUMERO, :BAIRRO, :CEP, :DATA_CADASTRO);';

        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vUtiID_REQUERENTE;
        qryCadRequerimento.Params.ParamByName('ID_TP_PESSOA').AsInteger := 1;
        qryCadRequerimento.Params.ParamByName('ID_ENDERECO').AsInteger := vIDEndereco;
        qryCadRequerimento.Params.ParamByName('NOME').AsString := edtNome;
        qryCadRequerimento.Params.ParamByName('DATA_NASCIMENTO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('CELULAR').AsString := edtCelular;
        qryCadRequerimento.Params.ParamByName('WHATSAPP').AsString := edtWhastApp;
        qryCadRequerimento.Params.ParamByName('EMAIL').AsString := edtEmail;
        qryCadRequerimento.Params.ParamByName('COMPLEMENTO').AsString := edtComplemento;
        qryCadRequerimento.Params.ParamByName('NUMERO').AsString := edtNum;
        qryCadRequerimento.Params.ParamByName('BAIRRO').AsString := edtBairro;
        qryCadRequerimento.Params.ParamByName('CEP').AsString := edtCep;
        qryCadRequerimento.Params.ParamByName('DATA_CADASTRO').asDate := now;
        qryCadRequerimento.ExecSQL;

        // populando a tabela pessoa fisica
        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_PESSOA_FISICA (ID_PESSOA_FISICA, ID_REQUERENTE, CPF, RG, SEXO) '
          + 'VALUES (:ID_PESSOA_FISICA, :ID_REQUERENTE, :CPF, :RG, :SEXO);';

        qryCadRequerimento.Params.ParamByName('ID_PESSOA_FISICA').AsInteger := vUtiID_PF;
        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDRequerente;
        qryCadRequerimento.Params.ParamByName('CPF').AsString := edtNumCPF;
        qryCadRequerimento.Params.ParamByName('RG').AsString := edtRg;
        qryCadRequerimento.Params.ParamByName('SEXO').AsString := cbxSexo;
        qryCadRequerimento.ExecSQL;

        // populando a tabela funcionarios
        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_FUNCIONARIO (ID_FUNCIONARIO,ID_PESSOA_FISICA, DATA_ADMISSAO, MATRICULA, LOTACAO, LOCAL_TRABALHO, CARGO) '
          + 'VALUES (:ID_FUNCIONARIO,:ID_PESSOA_FISICA, :DATA_ADMISSAO, :MATRICULA, :LOTACAO, :LOCAL_TRABALHO, :CARGO);';

        qryCadRequerimento.Params.ParamByName('ID_FUNCIONARIO').AsInteger := vUtiID_Funcionario;
        qryCadRequerimento.Params.ParamByName('ID_PESSOA_FISICA').AsInteger := vUtiID_PF;
        qryCadRequerimento.Params.ParamByName('DATA_ADMISSAO').asDate := jvDtNascimento;
        qryCadRequerimento.Params.ParamByName('MATRICULA').AsString := edtMatricula;
        qryCadRequerimento.Params.ParamByName('LOTACAO').AsString := edtLotacao;
        qryCadRequerimento.Params.ParamByName('LOCAL_TRABALHO').AsString := edtLocalTrabalho;
        qryCadRequerimento.Params.ParamByName('CARGO').AsString := edtCargo;
        qryCadRequerimento.ExecSQL;

      end;

      begin
        // populando a tabela de atendimento

        vUtiID_ATENDIMENTO := GetUltimoID_ATENDIMENTO;
       // ShowMessage('Novo ID de Atendimento: ' + IntToStr(vUtiID_ATENDIMENTO));

        qryCadRequerimento.SQL.Text :=
          'INSERT INTO TBL_ATENDIMENTO (ID_ATENDIMENTO,ID_REQUERENTE, ID_SECRETARIA, NUM_PROTOCOLO, DATA_ENTRADA, STATUS) '
          + 'VALUES (:ID_ATENDIMENTO,:ID_REQUERENTE, :ID_SECRETARIA, :NUM_PROTOCOLO, :DATA_ENTRADA, :STATUS);';

        qryCadRequerimento.Params.ParamByName('ID_ATENDIMENTO').AsInteger := vUtiID_ATENDIMENTO;
        qryCadRequerimento.Params.ParamByName('ID_REQUERENTE').AsInteger := vIDRequerente;
        qryCadRequerimento.Params.ParamByName('ID_SECRETARIA').AsInteger := 3;
        qryCadRequerimento.Params.ParamByName('NUM_PROTOCOLO').AsString := GerarNumeroProtocolo(now);
        qryCadRequerimento.Params.ParamByName('DATA_ENTRADA').asDate := jvDtEntrada;
        qryCadRequerimento.Params.ParamByName('STATUS').AsString := 'A';
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
      while not tbl_servicos_solicitados.Eof do
      begin
        qryServSolicitado.ParamByName('ID_Atendimento').AsInteger := vUtiID_ATENDIMENTO; //  tbl_servicos_solicitados.FieldByName('ID_Atendimento').AsInteger;
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

function TDadosRequerente.IDRequerenteJaExiste(IDRequerente: Integer): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text :=
      'SELECT COUNT(*) FROM TBL_REQUERENTE WHERE ID_REQUERENTE = :pIDReq';

    Query.Params.ParamByName('pIDReq').AsInteger := IDRequerente;
    Query.Open;

    Result := Query.Fields[0].AsInteger > 0;
  finally
    Query.Free;
  end;
end;

function TDadosRequerente.TextoSelecionado(const Text: string; var ID: Integer;
  var Nome, Cpf: string): Boolean;
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
    Result := True;

    vIDRequerente := ID;

  end;
end;

end.
