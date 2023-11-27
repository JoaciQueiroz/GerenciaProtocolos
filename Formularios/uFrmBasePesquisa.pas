unit uFrmBasePesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmFormBase, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmBasePesquisa = class(TfrmFormBase)
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    dbgDados: TDBGrid;
    edtPesquisar: TEdit;
    btnPesquisar: TButton;
    lblPesquisar: TLabel;
    qryDadosPesq: TFDQuery;
    btnSelecionar: TButton;
    btnCancelar: TButton;
    dtsDados: TDataSource;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasePesquisa: TfrmBasePesquisa;

implementation

{$R *.dfm}

uses uDmPrincipal;

procedure TfrmBasePesquisa.btnPesquisarClick(Sender: TObject);
begin
  inherited;
   qryDadosPesq.Close;
   qryDadosPesq.Params[0].AsString := edtPesquisar.Text ;
   qryDadosPesq.Open();

   dbgDados.SetFocus;
end;

procedure TfrmBasePesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  Self.ModalResult := mrOk;
end;

procedure TfrmBasePesquisa.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisar.SetFocus;
end;

end.
