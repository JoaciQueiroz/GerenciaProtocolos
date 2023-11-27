unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.jpeg, JvExStdCtrls, JvButton, JvCtrls, JvExControls, JvStaticText,
  JvComponentBase, JvCaptionButton, JvColorBox, JvColorButton;

type
  TfrmPrincipal = class(TForm)
    pnlMenuEsq: TPanel;
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    lblTituloSistema: TLabel;
    pnlcentro: TPanel;
    pnlMenuPrincipal: TPanel;
    pgctPrincipal: TPageControl;
    imgLogo: TImage;
    tbsMenu: TTabSheet;
    imgPagInicial: TImage;
    pnlCadastro: TPanel;
    lblCadastro: TLabel;
    pnlBaseBarraMenu: TPanel;
    pnlMenu: TPanel;
    pnlConsulta: TPanel;
    lblConsulta: TLabel;
    pnlMovimentacao: TPanel;
    lblMovimentacao: TLabel;
    pnlBalanco: TPanel;
    lblBalanco: TLabel;
    pnlRelatorios: TPanel;
    lblRelatorios: TLabel;
    btnProtocolosMes: TButton;
    pnlLogo: TPanel;
    pnlMnMovimentacao: TPanel;
    pnlMnBalanco: TPanel;
    pnlMnRelatorio: TPanel;
    pnlMnCadastro: TPanel;
    btnGestaoRequerimento: TButton;
    btnGestaoServicos: TButton;
    btnGestaoAdministrativo: TButton;
    btnGestaoSecretaria: TButton;
    btnGestaoRequerido: TButton;
    btnProcoloRequerente: TButton;
    btnProtocoloRequerido: TButton;
    btnNovoRequerimento: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnGestaoServicosClick(Sender: TObject);
  //  procedure btnGestaoRequerimentoClick(Sender: TObject);
    procedure lblCadastroClick(Sender: TObject);
    procedure lblCadastroMouseEnter(Sender: TObject);
    procedure lblCadastroMouseLeave(Sender: TObject);
    procedure lblConsultaMouseEnter(Sender: TObject);
    procedure lblConsultaMouseLeave(Sender: TObject);
    procedure lblMovimentacaoMouseEnter(Sender: TObject);
    procedure lblMovimentacaoMouseLeave(Sender: TObject);
    procedure lblRelatoriosMouseEnter(Sender: TObject);
    procedure lblRelatoriosMouseLeave(Sender: TObject);

    procedure lblBalancoMouseEnter(Sender: TObject);
    procedure lblBalancoMouseLeave(Sender: TObject);
    procedure lblConsultaClick(Sender: TObject);
    procedure lblMovimentacaoClick(Sender: TObject);
    procedure lblBalancoClick(Sender: TObject);
    procedure lblRelatoriosClick(Sender: TObject);
    procedure btnGestaoAdministrativoClick(Sender: TObject);
    procedure btnIncluiProdContratoClick(Sender: TObject);
    procedure btnProtocolosMesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGestaoSecretariaClick(Sender: TObject);
    procedure btnNovoRequerimentoClick(Sender: TObject);
    procedure btnGestaoRequerimentoClick(Sender: TObject);
    procedure pnlMenuClick(Sender: TObject);
 //   procedure pgctPrincipalChange(Sender: TObject);

  private
    { Private declarations }

  protected
  procedure DesabilitaBotoes;
  procedure MenuCadastro;
  procedure MenuMovimentacao;
  procedure MenuConsulta;
  procedure MenuBalanco;
  procedure Menurelatorio;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses ufrmSplash, uBiblioteca, uEnum, ufrmFormBase, uFrmGestaoServicos,
uFrmListaRequerimentos, uFrmCadRequerimento, uFrmTesteCadastros;


procedure TfrmPrincipal.btnGestaoServicosClick(Sender: TObject);
begin
  CriarAba(TfrmListaServicos, pgctPrincipal, -1);
end;

procedure TfrmPrincipal.btnProtocolosMesClick(Sender: TObject);
begin
 // CriarAba(TfrmListaRelatorios, pgctPrincipal, -1);
end;


procedure TfrmPrincipal.DesabilitaBotoes;
begin
{btnListaPessoas.Visible := false;
btnListaImoveis.Visible := false;
btnRelatorios.Visible := false;
btnListaRegioes.Visible := false;
btnListaProdutos.Visible := false;}
end;

procedure TfrmPrincipal.btnIncluiProdContratoClick(Sender: TObject);
begin
  // CriarAba(TfrmListaProdContrato, pgctPrincipal, -1);
end;

procedure TfrmPrincipal.btnNovoRequerimentoClick(Sender: TObject);

begin
//  CriarAba(TfrmCadastroRequerimento, pgctPrincipal, -1);
    CriarAba(TFrmCadRequerimento, pgctPrincipal, -1);
//  CriarAba(TfrmTesteCadastros, pgctPrincipal, -1);

end;

procedure TfrmPrincipal.btnGestaoAdministrativoClick(Sender: TObject);
begin
 // CriarAba(TfrmListaProdutos, pgctPrincipal, -1);
end;

procedure TfrmPrincipal.btnGestaoRequerimentoClick(Sender: TObject);
begin
   CriarAba(TfrmListaRequerimentos, pgctPrincipal, -1);
end;

procedure TfrmPrincipal.btnGestaoSecretariaClick(Sender: TObject);
begin
//CriarAba(TfrmListaRegiao, pgctPrincipal, -1);
end;
    {
procedure TfrmPrincipal.btnGestaoRequerimentoClick(Sender: TObject);
begin
  CriarAba(TfrmCadFuncionario, pgctPrincipal, -1);
end;  }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
//  DesabilitaBotoes;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
// vou usa os splash ainda não apagar este codigo
{  frmSplash := TfrmSplash.Create(Self);
  frmSplash.Show;
 frmSplash.refresh;  }
  // Incluir outros eventos iniciais antes do sleep
  pnlCadastro.SetFocus;

 { sleep(1000);

  if Assigned(frmSplash) then
    frmSplash.Free;
  frmSplash := nil;}
end;

procedure TfrmPrincipal.lblConsultaClick(Sender: TObject);
begin
  pnlMenu.Left := pnlConsulta.Left + 5;
  pnlMenu.Width := lblconsulta.Width;
  MenuConsulta;
end;

procedure TfrmPrincipal.lblConsultaMouseEnter(Sender: TObject);
begin
  lblConsulta.Font.Color := clNavy;
  lblConsulta.Enabled := True;

end;

procedure TfrmPrincipal.lblConsultaMouseLeave(Sender: TObject);
begin
  lblConsulta.Font.Color := $00FFA8A8;
  lblConsulta.Enabled := False;
end;

procedure TfrmPrincipal.lblCadastroClick(Sender: TObject);
begin
 //codigo para movimentação da linha no menu superior
  pnlMenu.Left := pnlCadastro.Left + 5;
  pnlMenu.Width := lblCadastro.Width;

  MenuCadastro;
end;

procedure TfrmPrincipal.lblCadastroMouseEnter(Sender: TObject);
begin
  lblCadastro.Font.Color := clNavy;
  lblCadastro.Enabled := True;

end;

procedure TfrmPrincipal.lblCadastroMouseLeave(Sender: TObject);
begin
  lblCadastro.Font.Color := $00FFA8A8;
  lblCadastro.Enabled := False;
end;

procedure TfrmPrincipal.lblMovimentacaoClick(Sender: TObject);
begin
  pnlMenu.Left := pnlMovimentacao.Left + 5;
  pnlMenu.Width := lblMovimentacao.Width;

  MenuMovimentacao;
end;

procedure TfrmPrincipal.lblMovimentacaoMouseEnter(Sender: TObject);
begin
  lblMovimentacao.Font.Color := clNavy;
  lblMovimentacao.Enabled := True;

end;

procedure TfrmPrincipal.lblMovimentacaoMouseLeave(Sender: TObject);
begin
  lblMovimentacao.Font.Color := $00FFA8A8;
  lblMovimentacao.Enabled := False;
end;

procedure TfrmPrincipal.lblRelatoriosClick(Sender: TObject);
begin
  pnlMenu.Left := pnlRelatorios.Left + 5;
  pnlMenu.Width := lblRelatorios.Width;

  Menurelatorio;
end;

procedure TfrmPrincipal.lblRelatoriosMouseEnter(Sender: TObject);
begin
  lblRelatorios.Font.Color := clNavy;
  lblRelatorios.Enabled := True;
end;

procedure TfrmPrincipal.lblRelatoriosMouseLeave(Sender: TObject);
begin
  lblRelatorios.Font.Color := $00FFA8A8;
  lblRelatorios.Enabled := False;
end;

procedure TfrmPrincipal.MenuBalanco;
begin
   pnlMnBalanco.Enabled := true;
   pnlMnBalanco.Visible := true;
   pnlMnBalanco.Align := alClient;

  pnlMnCadastro.Visible := false;
  pnlMnMovimentacao.Visible := false;
 // pnlMnConsulta.Visible := false;
  pnlMnRelatorio.Visible := false;
end;

procedure TfrmPrincipal.MenuCadastro;
begin
  pnlMnCadastro.Enabled := true;
  pnlMnCadastro.Visible := true;
  pnlMnCadastro.Align := alClient;

  pnlMnMovimentacao.Visible := false;
  pnlMnBalanco.Visible := false;
  pnlMnRelatorio.Visible := false;
end;

procedure TfrmPrincipal.MenuConsulta;
begin
 // pnlMnConsulta.Enabled := true;
//  pnlMnConsulta.Visible := true;
//  pnlMnConsulta.Align := alClient;

  pnlMnCadastro.Visible := false;
  pnlMnMovimentacao.Visible := false;
  pnlMnBalanco.Visible := false;
  pnlMnRelatorio.Visible := false;
end;

procedure TfrmPrincipal.MenuMovimentacao;
begin
  pnlMnMovimentacao.Enabled := true;
  pnlMnMovimentacao.Visible := true;
  pnlMnMovimentacao.Align := alClient;

  pnlMnCadastro.Visible := false;
 // pnlMnConsulta.Visible := false;
  pnlMnBalanco.Visible := false;
  pnlMnRelatorio.Visible := false;
end;

procedure TfrmPrincipal.Menurelatorio;
begin
  pnlMnRelatorio.Enabled := true;
  pnlMnRelatorio.Visible := true;
  pnlMnRelatorio.Align := alClient;

  pnlMnCadastro.Visible := false;
  pnlMnMovimentacao.Visible := false;
//  pnlMnConsulta.Visible := false;
  pnlMnBalanco.Visible := false;
  pnlMnRelatorio.Visible := true;
end;
  procedure TfrmPrincipal.pnlMenuClick(Sender: TObject);
begin

end;

{
procedure TfrmPrincipal.pgctPrincipalChange(Sender: TObject);
begin

end;   }

procedure TfrmPrincipal.lblBalancoClick(Sender: TObject);
begin
  pnlMenu.Left := pnlBalanco.Left + 5;
  pnlMenu.Width := lblBalanco.Width;

  MenuBalanco;
end;

procedure TfrmPrincipal.lblBalancoMouseEnter(Sender: TObject);
begin
  lblBalanco.Font.Color := clNavy;
  lblBalanco.Enabled := True;

end;

procedure TfrmPrincipal.lblBalancoMouseLeave(Sender: TObject);
begin
  lblBalanco.Font.Color := $00FFA8A8;
  lblBalanco.Enabled := False;
end;

end.
