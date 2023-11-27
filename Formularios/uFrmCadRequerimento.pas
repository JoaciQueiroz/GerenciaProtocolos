unit uFrmCadRequerimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseCadastro, Data.DB,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  JvExStdCtrls, JvButton, JvCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFrmCadRequerimento = class(TfrmBaseCadastro)
    pnlRequerente: TPanel;
    pnlServicos: TPanel;
    pnlEndereco: TPanel;
    edtNome: TEdit;
    edtNumProtocolo: TEdit;
    edtNumCPF: TEdit;
    edtMatricula: TEdit;
    edtLotacao: TEdit;
    edtCargo: TEdit;
    edtLocalTrabalho: TEdit;
    lblNome: TLabel;
    lblNumProtocolo: TLabel;
    lblCpf: TLabel;
    lblMatricula: TLabel;
    lblLotacao: TLabel;
    lblCargo: TLabel;
    lblLocalTrabalho: TLabel;
    lblDtNascimento: TLabel;
    lblDtEntrada: TLabel;
    lblSexo: TLabel;
    lblDtAdmissao: TLabel;
    jvDtNascimento: TJvDateEdit;
    jvDtEntrada: TJvDateEdit;
    jvDtAdmisao: TJvDateEdit;
    cbxSexo: TComboBox;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtEmail: TEdit;
    edtUF: TEdit;
    edtCep: TEdit;
    edtEndereco: TEdit;
    edtWhastApp: TEdit;
    edtNum: TEdit;
    lblLogradouro: TLabel;
    lblEndereco: TLabel;
    lblMunicipio: TLabel;
    lblUf: TLabel;
    lblCep: TLabel;
    lblWhastApp: TLabel;
    lblBairro: TLabel;
    lblNum: TLabel;
    lblComplemento: TLabel;
    pnlContato: TPanel;
    lblCelular: TLabel;
    lblEmail: TLabel;
    edtCelular: TEdit;
    pnlTopservicos: TPanel;
    dbgServicos: TDBGrid;
    memObservacoes: TMemo;
    lblCodServico: TLabel;
    edtCodServico: TEdit;
    lblServico: TLabel;
    edtServico: TEdit;
    btnIncluirServico: TButton;
    lstEndereco: TListBox;
    lblRg: TLabel;
    edtRg: TEdit;
    mnTblServicos: TFDMemTable;
    dtsServicos: TDataSource;
    dbgPesqServico: TDBGrid;
    qryPesqServico: TFDQuery;
    lstRequerente: TListBox;
    edtLogradouro: TEdit;
    edtMunicipio: TEdit;
    procedure actGravarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEnderecoChange(Sender: TObject);
    procedure lstEnderecoDblClick(Sender: TObject);
    procedure btnIncluirServicoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
 //   procedure dbgPesqServicoDblClick(Sender: TObject);
    procedure edtCodServicoDblClick(Sender: TObject);
//    procedure lkbMunicipioExit(Sender: TObject);
    procedure edtCodServicoEnter(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure lstRequerenteDblClick(Sender: TObject);
//    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  protected

    function GetUltimoID_REQUERENTE: Integer;
    function GetUltimoID_ENDERECO: Integer;
    function GetUltimoID_PF: Integer;
    function GetUltimoID_Funcionario: Integer;
    function GetUltimoID_ATENDIMENTO: Integer;

    // gerar numero do protocolo
    function GerarNumeroProtocolo(DataEntrada: TDateTime): string;
    procedure ConfigurarColunasGrid;
    procedure GravarServicosSolicitados;

  var
    // variaveis para receber o ultimo id
    { UltimoID_REQUERENTE, UltimoID_ENDERECO, UltimoID_PF,
      UltimoID_Funcionario: Integer;
      UltimoID_ATENDIMENTO: Integer; }

    // variavel para passar o Id do Endereço para tabela de requerente
    vgQryServicos: TFDQuery;
    vgMTblServicos: TFDMemTable;
    vgdtsServicos: TDataSource;
    vServSolicitado: Integer;

    { vgID_Endereco, vID_SECRETARIA: Integer; }

    tbl_servicos_solicitados: TFDMemTable;

  public
    { Public declarations }

  var
    IDRequerente: Integer;

  end;

var
  FrmCadRequerimento: TFrmCadRequerimento;

implementation

{$R *.dfm}

uses uDmPrincipal, DadosRequerente, ReqTeste;

{ TFrmCadRequerimento }

procedure TFrmCadRequerimento.actGravarExecute(Sender: TObject);
var
  DadosRequerente: TDadosRequerente;

  Nome, Cpf, Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular, Whatsapp,
    Email, Endereco, Complemento, Numero, Bairro, Cep: string;
  DtNascimento, DtAdmissao: TDateTime;

  ID_REQUERENTE, ID_Endereco, id_funcionario, id_pf, IDPf, IDFn, IDEn: Integer;

begin

  DadosRequerente := TDadosRequerente.Create(DmPrincipal.ConexaoBd);
  try
    if DadosRequerente.ConsultaReqId(IDRequerente, IDPf, IDFn, IDEn) then
    begin
      DadosRequerente.GravarRequerimento(ID_REQUERENTE, id_pf, id_funcionario,
        UltimoID_ATENDIMENTO, ID_Endereco, edtNome.Text, edtNumCPF.Text,
        edtRg.Text, cbxSexo.Text, edtCelular.Text, edtWhastApp.Text,
        edtEmail.Text, edtComplemento.Text, edtNum.Text, edtBairro.Text,
        edtCep.Text, jvDtNascimento.date, jvDtEntrada.date, edtMatricula.Text,
        edtLotacao.Text, edtLocalTrabalho.Text, edtCargo.Text,
        edtNumProtocolo.Text, tbl_servicos_solicitados);

    end;
  finally
    DadosRequerente.Free;
  end;
end;

procedure TFrmCadRequerimento.btnIncluirServicoClick(Sender: TObject);
var
  ID_Servico: Integer;
begin
  // Obtenha o ID do serviço selecionado (a partir de uma fonte externa, como um controle ListBox ou ComboBox)
  ID_Servico := StrToIntDef(edtCodServico.Text, 0);

  // Verifique se o ID do serviço é válido antes de adicioná-lo à tabela
  if ID_Servico > 0 then
  begin
    vServSolicitado := tbl_servicos_solicitados.FieldByName
      ('ID_servicos_solicitados').AsInteger + 1;
    // Inserir um novo registro na tabela de memória
    tbl_servicos_solicitados.Append;
    tbl_servicos_solicitados.FieldByName('ID_servicos_solicitados').AsInteger :=
      vServSolicitado;
    tbl_servicos_solicitados.FieldByName('ID_Atendimento').AsInteger :=
      UltimoID_ATENDIMENTO;
    tbl_servicos_solicitados.FieldByName('ID_Servico').AsInteger := ID_Servico;
    tbl_servicos_solicitados.FieldByName('Servico').AsString := edtServico.Text;

    tbl_servicos_solicitados.Post;
    edtCodServico.Text := '';
    edtServico.Text := '';
  end
  else
  begin
    ShowMessage('Selecione um serviço válido.');
  end;
end;

procedure TFrmCadRequerimento.ConfigurarColunasGrid;
begin
  // Limpe as colunas existentes (se houver)
  dbgServicos.Columns.Clear;

  // Adicione as colunas do DataSet à grade
  dbgServicos.Columns.Add; // Coluna para 'ID_Servico'
  dbgServicos.Columns[0].FieldName := 'ID_servicos_solicitados';
  dbgServicos.Columns[0].Title.Caption := 'Item';

  dbgServicos.Columns.Add; // Coluna para 'Servico'
  dbgServicos.Columns[1].FieldName := 'Servico';
  dbgServicos.Columns[1].Title.Caption := 'Descrição do Serviço';

  { dbgServicos.Columns.Add; // Coluna para 'ID_Atendimento'
    dbgServicos.Columns[2].FieldName := 'ID_Atendimento';
    dbgServicos.Columns[2].Title.Caption := 'ID do Atendimento'; }

  // Configure a largura das colunas conforme necessário
  dbgServicos.Columns[0].Width := 80;
  dbgServicos.Columns[1].Width := 250;

end;

procedure TFrmCadRequerimento.edtCodServicoDblClick(Sender: TObject);
begin
  // inherited;

  // if key = #13 then  se for precionado a tecla enter

  {
    qryPesqServico.Close;
    qryPesqServico.Open;

    qryPesqServico.ParamByName('pIDServ').AsInteger := StrToInt(edtCodServico.Text);
    edtServico.Text := qryPesqServico.FieldByName('SERVICO').AsString;
    btnIncluirServico.SetFocus; }

end;

procedure TFrmCadRequerimento.edtCodServicoEnter(Sender: TObject);
begin
  // inherited;
  // qryPesqServico.Close;
  // qryPesqServico.Open;

end;

procedure TFrmCadRequerimento.edtEnderecoChange(Sender: TObject);
{ var
  Query: TFDQuery; }
begin
  { Query := TFDQuery.Create(nil);
    try
    Query.Connection := DmPrincipal.ConexaoBd;

    // Consulta SQL para pesquisar endereços à medida que o usuário digita
    Query.SQL.Text :=
    'SELECT ID_ENDERECO, ENDERECO FROM TBL_ENDERECO WHERE ENDERECO containing :Endereco';
    Query.ParamByName('Endereco').AsString := edtEndereco.Text;

    // Abra a consulta
    Query.Open;

    lstEndereco.Visible := True;
    lstEndereco.Clear;

    // Adicione os resultados da consulta ao ListBox com o ID_ENDERECO associado
    while not Query.Eof do
    begin
    // Obtém o ID_ENDERECO da consulta
    var ID_Endereco := Query.FieldByName('ID_ENDERECO').AsInteger;

    // Adiciona o endereço ao ListBox, incluindo o ID_ENDERECO como um item
    lstEndereco.Items.Add(Format('%d - %s', [ID_Endereco, Query.FieldByName('ENDERECO').AsString]));

    Query.Next;
    end;
    finally
    Query.Free;
    end; }
end;

procedure TFrmCadRequerimento.edtNomeChange(Sender: TObject);
var
  DadosRequerente: TDadosRequerente;
  { qryRequerente: TFDQuery; }

begin
  DadosRequerente := TDadosRequerente.Create(DmPrincipal.ConexaoBd);

  DadosRequerente.ConsultarPorNome(edtNome.Text, lstRequerente);

end;

procedure TFrmCadRequerimento.FormCreate(Sender: TObject);
begin
  inherited;
  vServSolicitado := 0;
  // Crie a tabela de serviços solicitados no FormCreate
  tbl_servicos_solicitados := TFDMemTable.Create(nil);
  tbl_servicos_solicitados.FieldDefs.Add('ID_servicos_solicitados', ftInteger);
  tbl_servicos_solicitados.FieldDefs.Add('ID_Atendimento', ftInteger);
  tbl_servicos_solicitados.FieldDefs.Add('ID_Servico', ftInteger);
  tbl_servicos_solicitados.FieldDefs.Add('Servico', ftString, 255);
  tbl_servicos_solicitados.CreateDataSet;

  // Conecte o DBGrid à tabela de memória
  dtsServicos.DataSet := tbl_servicos_solicitados;
  dbgServicos.DataSource := dtsServicos;

  ConfigurarColunasGrid;
end;

procedure TFrmCadRequerimento.FormShow(Sender: TObject);
var
  NumeroProtocolo: string;
begin
  inherited;
  jvDtEntrada.date := now;
  edtNumProtocolo.Text := '00000000-0';
  vID_SECRETARIA := 3;

end;

function TFrmCadRequerimento.GerarNumeroProtocolo
  (DataEntrada: TDateTime): string;
var
  // data: TDateTime;
  vDataFormatada: string;
  vNumProtocolo: String;
begin
  // vamos formatar
  vDataFormatada := FormatDateTime('ddmmyy', DataEntrada);
  vNumProtocolo := IntToStr(UltimoID_ATENDIMENTO) + vDataFormatada + '-' +
    IntToStr(vID_SECRETARIA);

  // vamos exibir o resultado
  Result := vNumProtocolo;
end;

function TFrmCadRequerimento.GetUltimoID_ATENDIMENTO: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_ATENDIMENTO),0)AS LAST_ID FROM TBL_ATENDIMENTO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TFrmCadRequerimento.GetUltimoID_ENDERECO: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_ENDERECO),0)AS LAST_ID FROM TBL_ENDERECO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TFrmCadRequerimento.GetUltimoID_Funcionario: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_FUNCIONARIO),0)AS LAST_ID FROM TBL_FUNCIONARIO';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TFrmCadRequerimento.GetUltimoID_PF: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_PESSOA_FISICA),0)AS LAST_ID FROM TBL_PESSOA_FISICA';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

function TFrmCadRequerimento.GetUltimoID_REQUERENTE: Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'SELECT COALESCE(MAX(ID_REQUERENTE),0)AS LAST_ID FROM TBL_REQUERENTE';
    Query.Open;
    Result := Query.FieldByName('LAST_ID').AsInteger + 1;
  finally
    Query.Free;
  end;
end;

procedure TFrmCadRequerimento.GravarServicosSolicitados;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DmPrincipal.ConexaoBd;
    Query.SQL.Text :=
      'INSERT INTO TBL_servico_solicitado (ID_Atendimento, ID_Servico) VALUES (:ID_Atendimento, :ID_Servico)';
    Query.Prepare;

    tbl_servicos_solicitados.First;
    while not tbl_servicos_solicitados.EOF do
    begin
      Query.ParamByName('ID_Atendimento').AsInteger :=
        tbl_servicos_solicitados.FieldByName('ID_Atendimento').AsInteger;
      Query.ParamByName('ID_Servico').AsInteger :=
        tbl_servicos_solicitados.FieldByName('ID_Servico').AsInteger;

      Query.ExecSQL;

      tbl_servicos_solicitados.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmCadRequerimento.lstEnderecoDblClick(Sender: TObject);
var
  DadosRequerente: TDadosRequerente;
begin
  DadosRequerente := TDadosRequerente.Create(nil);

  if lstEndereco.ItemIndex <> -1 then
  begin
    // Extrai o ID_ENDERECO do item selecionado no ListBox
    var
    SelectedItem := lstEndereco.Items[lstEndereco.ItemIndex];
    DadosRequerente.vIDEndereco :=
      StrToIntDef(Copy(SelectedItem, 1, Pos('-', SelectedItem) - 2), 0);

    // vgID_Endereco := StrToIntDef(Copy(SelectedItem, 1, Pos('-', SelectedItem) - 2), 0);
    // Define o texto do componente edtEndereco com o endereço selecionado
    edtEndereco.Text := SelectedItem;

    // Use o ID_Endereco conforme necessário

    // ...
  end;
  // Oculta lstEndereco
  lstEndereco.Visible := False;
end;

procedure TFrmCadRequerimento.lstRequerenteDblClick(Sender: TObject);
var
  DadosRequerente: TDadosRequerente;
  SelectedText: string;

  // Dados Detalhado do Requerente
  Requerente, Cpf, Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular,
    Whatsapp, Email, Endereco, Complemento, Numero, Bairro, Cep: string;
  DtNascimento, DtAdmissao: TDateTime;
  vcr_IDEndereco: Integer;
  // Dados endereço
  Logradouro, Municipio, Uf: string;

begin
  DadosRequerente := TDadosRequerente.Create(DmPrincipal.ConexaoBd);

  SelectedText := lstRequerente.Items[lstRequerente.ItemIndex];

  if DadosRequerente.TextoSelecionado(SelectedText, IDRequerente,
    Requerente, Cpf) then
  Begin
    if DadosRequerente.ConsultarRequerentePorID(IDRequerente, Requerente, Cpf,
      Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular, Whatsapp, Email,
      Endereco, Complemento, Numero, Bairro, Cep, DtNascimento, DtAdmissao,
      vcr_IDEndereco) then
    begin
      edtNome.Text := Requerente;
      cbxSexo.Text := Sexo;
      edtMatricula.Text := Matricula;
      edtLotacao.Text := Lotacao;
      edtCargo.Text := Cargo;
      edtLocalTrabalho.Text := LTrabalho;
      edtNumCPF.Text := Cpf;
      edtRg.Text := Rg;
      edtCelular.Text := Celular;
      edtWhastApp.Text := Whatsapp;
      edtEmail.Text := Email;
      edtEndereco.Text := Endereco;
      edtBairro.Text := Bairro;
      edtNum.Text := Numero;
      edtComplemento.Text := Complemento;
      edtCep.Text := Cep;
      jvDtNascimento.date := DtNascimento;
      jvDtAdmisao.date := DtAdmissao;

      DadosRequerente.vIDRequerente := IDRequerente;

      if DadosRequerente.ConsultaEnderecos(vcr_IDEndereco, Logradouro, Endereco,
        Municipio, Uf) then
      begin
        edtLogradouro.Text := Logradouro;
        edtMunicipio.Text := Municipio;
        edtUF.Text := Uf;
      end;

    end
    else
    begin
      ShowMessage('Dados incorretos');
    end;

  end;

  lstRequerente.Visible := False;

end;

end.
