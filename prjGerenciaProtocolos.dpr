program prjGerenciaProtocolos;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uBiblioteca in 'Formularios\uBiblioteca.pas',
  uEnum in 'Formularios\uEnum.pas',
  ufrmFormBase in 'Formularios\ufrmFormBase.pas' {frmFormBase},
  ufrmSplash in 'Formularios\ufrmSplash.pas' {frmSplash},
  ufrmBaseCadastro in 'Formularios\ufrmBaseCadastro.pas' {frmBaseCadastro},
  ufrmBaseListagem in 'Formularios\ufrmBaseListagem.pas' {frmBaseListagem},
  uFrmBasePesquisa in 'Formularios\uFrmBasePesquisa.pas' {frmBasePesquisa},
  uDmPrincipal in 'Formularios\uDmPrincipal.pas' {DmPrincipal: TDataModule},
  uFrmGestaoServicos in 'Formularios\uFrmGestaoServicos.pas' {frmListaServicos},
  uFrmListaRequerimentos in 'Formularios\uFrmListaRequerimentos.pas' {frmListaRequerimentos},
  uFrmCadRequerimento in 'Formularios\uFrmCadRequerimento.pas' {FrmCadRequerimento},
  RequerimentoManager in 'Imagens\RequerimentoManager.pas',
  DadosRequerente in 'Formularios\DadosRequerente.pas',
  ReqTeste in 'Formularios\ReqTeste.pas',
  uFrmTesteCadastros in 'Formularios\uFrmTesteCadastros.pas' {frmTesteCadastros};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmPrincipal, DmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
