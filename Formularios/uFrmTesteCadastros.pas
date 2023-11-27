unit uFrmTesteCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseCadastro, Data.DB,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  JvExStdCtrls, JvButton, JvCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.DBCtrls, system.MaskUtils;

type
  TfrmTesteCadastros = class(TfrmBaseCadastro)
    pnlRequerente: TPanel;
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
    lblRg: TLabel;
    edtNome: TEdit;
    edtNumProtocolo: TEdit;
    edtNumCPF: TEdit;
    edtMatricula: TEdit;
    edtLotacao: TEdit;
    edtCargo: TEdit;
    edtLocalTrabalho: TEdit;
    jvDtNascimento: TJvDateEdit;
    jvDtEntrada: TJvDateEdit;
    jvDtAdmisao: TJvDateEdit;
    cbxSexo: TComboBox;
    edtRg: TEdit;
    lstRequerente: TListBox;
    pnlContato: TPanel;
    lblWhastApp: TLabel;
    lblCelular: TLabel;
    lblEmail: TLabel;
    edtWhastApp: TEdit;
    edtEmail: TEdit;
    edtCelular: TEdit;
    pnlEndereco: TPanel;
    lblLogradouro: TLabel;
    lblEndereco: TLabel;
    lblMunicipio: TLabel;
    lblBairro: TLabel;
    lblNum: TLabel;
    lblComplemento: TLabel;
    lblUf: TLabel;
    lblCep: TLabel;
    edtCep: TEdit;
    edtUF: TEdit;
    lstEndereco: TListBox;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtEndereco: TEdit;
    edtNum: TEdit;
    edtLogradouro: TEdit;
    edtMunicipio: TEdit;
    procedure edtNomeChange(Sender: TObject);
    procedure lstRequerenteDblClick(Sender: TObject);
  //  procedure lstRequerenteDblClick(Sender: TObject);

  private
    { Private declarations }
  protected

   { function ConsultarDadosRequerentePorID(const IDRequerente: integer;
      var Celular, Email: string; var DataNascimento: TDateTime): Boolean;  }
//    procedure ConsultarRequerentesPorNome(const Nome: string);
 // function ParseSelectedText(const Text: string; var ID: Integer; var Nome, CPF: string): Boolean;


  public
    { Public declarations }
    qryRetonraRequerente: TFDQuery;
    qryConsReqt, qryConstNome: TFDQuery;

  var
    vgId_Requerente: integer;
    vgRequerente, vgCpf: string;
    vgTeste: string;
  end;

var
  frmTesteCadastros: TfrmTesteCadastros;

implementation

{$R *.dfm}

uses ReqTeste, uDmPrincipal, DadosRequerente, RequerimentoManager;

procedure TfrmTesteCadastros.edtNomeChange(Sender: TObject);
var
DadosRequerente: TDadosRequerente;
RequerimentoManager: TRequerimentoManager;

begin
 DadosRequerente := TDadosRequerente.Create(DmPrincipal.ConexaoBd);
 RequerimentoManager := TRequerimentoManager.Create(DmPrincipal.ConexaoBd);

 RequerimentoManager.ConsultarPorNome(edtNome.Text, lstRequerente);

end;

procedure TfrmTesteCadastros.lstRequerenteDblClick(Sender: TObject);
var
  DadosRequerente: TDadosRequerente;
  RequerimentoManager: TRequerimentoManager;
  SelectedText: string;
  IDRequerente: Integer;

//Dados Detalhado do Requerente
  Requerente, CPF, Rg, Sexo, Matricula, Lotacao, LTrabalho, Cargo, Celular, Whatsapp,
  Email, Endereco, Complemento, Numero, Bairro, Cep: string;
  DtNascimento, DtAdmissao: TDateTime;
  IDEndereco: Integer;
//Dados endereço
  Logradouro, Municipio, Uf: string;
//  vIDEndereco: Integer;

begin
  DadosRequerente := TDadosRequerente.Create(DmPrincipal.ConexaoBd);
  RequerimentoManager := TRequerimentoManager.Create(DmPrincipal.ConexaoBd);
  SelectedText := lstRequerente.Items[lstRequerente.ItemIndex];

 if RequerimentoManager.ParseSelectedText(SelectedText, IDRequerente, Requerente, Cpf) then
 Begin

  if DadosRequerente.ConsultarRequerentePorID(IDRequerente, Requerente, Cpf, Rg, Sexo, Matricula,
  Lotacao, LTrabalho, Cargo,Celular, Whatsapp, Email, Endereco, Complemento, Numero, Bairro, Cep,
  DtNascimento, DtAdmissao, IDEndereco) then


   begin
   edtNome.Text := Requerente;
   cbxSexo.Text := sexo;
   edtMatricula.Text := Matricula;
   edtLotacao.Text := Lotacao;
   edtCargo.Text := Cargo;
   edtLocalTrabalho.Text := LTrabalho;
   edtNumCPF.Text := cpf;
   edtRg.Text := Rg;
   edtCelular.Text := celular;
   edtWhastApp.Text := Whatsapp;
   edtEmail.Text := Email;
   edtEndereco.Text := Endereco;
   edtBairro.Text := Bairro;
   edtNum.Text := Numero;
   edtComplemento.Text := Complemento;
   edtCep.Text := Cep;
   jvDtNascimento.Date := DtNascimento;
   jvDtAdmisao.Date := DtAdmissao;

   //vIDEndereco := IDEndereco;

   if DadosRequerente.ConsultaEnderecos(IDEndereco,Logradouro, Endereco, Municipio, Uf) then
   begin
    edtLogradouro.Text := Logradouro;
    edtMunicipio.Text := Municipio;
    edtUF.Text := uf;
   end;

   end
   else
   begin
     ShowMessage('Dados incorretos');
   end;

  end;

  lstRequerente.Visible := false;
end;


end.
