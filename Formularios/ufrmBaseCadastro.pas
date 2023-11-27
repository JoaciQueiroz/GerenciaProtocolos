unit ufrmBaseCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmFormBase, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, frxClass,
  frxExportBaseDialog, frxExportImage, JvExStdCtrls, JvButton, JvCtrls,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.Actions, Vcl.ActnList, Vcl.Bind.Navigator, Data.DB, uEnum,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes;
type
  TfrmBaseCadastro = class(TfrmFormBase)
    pnlFundoBC: TPanel;
    pnlButtonBC: TPanel;
    jvibtGravar: TJvImgBtn;
    jvibtCancelar: TJvImgBtn;
    jvibtEcluir: TJvImgBtn;
    actAcoes: TActionList;
    dtsDados: TDataSource;
    actGravar: TAction;
    actCancelar: TAction;
    actExcluir: TAction;
    pnlEsp1: TPanel;
    pnlEsp2: TPanel;
    pnlEsp3: TPanel;
    pnlEsp4: TPanel;
    pnlEsp5: TPanel;
    procedure jvibtGravarMouseEnter(Sender: TObject);
    procedure jvibtGravarMouseLeave(Sender: TObject);
    procedure jvibtCancelarMouseEnter(Sender: TObject);
    procedure jvibtCancelarMouseLeave(Sender: TObject);
    procedure jvibtEcluirMouseEnter(Sender: TObject);
    procedure jvibtEcluirMouseLeave(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure jvibtNovoMouseEnter(Sender: TObject);
    procedure jvibtNovoMouseLeave(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }


 protected

  procedure ConfimaGravar;
  procedure CancelandoAviso;

  public
    { Public declarations }
  vEstadoDoCadastro:TEstadoDoCadastro;
  end;

var
  frmBaseCadastro: TfrmBaseCadastro;

implementation

{$R *.dfm}

uses uBiblioteca, ufrmPrincipal;

procedure TfrmBaseCadastro.actCancelarExecute(Sender: TObject);
begin
   //dtsDados.DataSet.Cancel;
end;

procedure TfrmBaseCadastro.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja Excluir o registro?',mtConfirmation,mbYesNo,0) = mryes then
    begin
       dtsDados.DataSet.Delete;
    end
     else
    begin
     exit;
    end;
      dtsDados.DataSet.Refresh;
      dtsDados.DataSet.Close;
      Close;
end;

procedure TfrmBaseCadastro.actGravarExecute(Sender: TObject);
begin
  inherited;
  dtsDados.DataSet.Post; {
  if EstadoDoCadastro = ecNovo then
    if MessageDlg('Deseja Incluir outro registro?', mtConfirmation, mbYesNo, 0)
      = mryes then
    begin
      dtsDados.DataSet.Close;
      dtsDados.DataSet.Open;
      dtsDados.DataSet.Append;
    end
    else
    begin
      close;
    end;}
 // dtsDados.DataSet.Refresh;
//  close;
end;

procedure TfrmBaseCadastro.actNovoExecute(Sender: TObject);
begin
//  inherited;
//  dtsDados.DataSet.append;
end;

procedure TfrmBaseCadastro.CancelandoAviso;
begin
    if vEstadoDoCadastro = ecNovo then
  begin
    ShowMessage('Cancelamento de Inclusão de registro');
  end
  else if vEstadoDoCadastro = ecModificar then
  begin
    ShowMessage('Cancelamento de Edição de registro');
  end;
end;

procedure TfrmBaseCadastro.ConfimaGravar;
begin
   if vEstadoDoCadastro = ecNovo then
  begin
    ShowMessage('Registro gravado com sucesso');
  end
  else if vEstadoDoCadastro = ecModificar then
  begin
    ShowMessage('Registro alterado com sucesso');
  end;
end;

procedure TfrmBaseCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FecharAba(Self.Caption,frmPrincipal.pgctPrincipal);
end;

procedure TfrmBaseCadastro.FormShow(Sender: TObject);
begin
  inherited;

if (vEstadoDoCadastro = ecNovo) or (vEstadoDoCadastro = ecModificar) then
 begin
   HabilitaCampos(pnlFundoBC);
 end
 else
 begin
   DesabilitaCampos(pnlFundoBC);
 end;

end;

procedure TfrmBaseCadastro.jvibtCancelarMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 3);
end;

procedure TfrmBaseCadastro.jvibtCancelarMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 4);
end;

procedure TfrmBaseCadastro.jvibtEcluirMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 0);
end;

procedure TfrmBaseCadastro.jvibtEcluirMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 1);
end;

procedure TfrmBaseCadastro.jvibtGravarMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 9);
end;

procedure TfrmBaseCadastro.jvibtGravarMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 10);
end;

procedure TfrmBaseCadastro.jvibtNovoMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 15);
end;

procedure TfrmBaseCadastro.jvibtNovoMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 16);
end;

end.
