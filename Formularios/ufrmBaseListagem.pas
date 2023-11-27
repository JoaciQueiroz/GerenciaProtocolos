unit ufrmBaseListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmFormBase, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.DBCtrls, JvDBControls, System.ImageList, Vcl.ImgList, JvExStdCtrls,
  JvButton, JvCtrls, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, uEnum, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, ufrmBaseCadastro, uBiblioteca;

type
  TfrmBaseListagem = class(TfrmFormBase)
    pnlFundoBL: TPanel;
    pnlTopBL: TPanel;
    pnlButtonBL: TPanel;
    pnlFGTop: TPanel;
    pnlFLButtom: TPanel;
    jvibtNovo: TJvImgBtn;
    jvibtEditar: TJvImgBtn;
    jvibtExcluir: TJvImgBtn;
    jvdNavegador: TJvDBNavigator;
    jvibtFechar: TJvImgBtn;
    btePesquisar: TButtonedEdit;
    lblLocalizar: TLabel;
    imglistaPesq: TImageList;
    dtsListaDados: TDataSource;
    grdDados: TDBGrid;
    pnlEsp1: TPanel;
    pnlEspaco: TPanel;
    pnlEsp2: TPanel;
    pnlEsp3: TPanel;
    pnlEsp5: TPanel;
    pnlEsp4: TPanel;
    Panel5: TPanel;
    procedure jvibtNovoMouseEnter(Sender: TObject);
    procedure jvibtNovoMouseLeave(Sender: TObject);
    procedure jvibtExcluirMouseEnter(Sender: TObject);
    procedure jvibtExcluirMouseLeave(Sender: TObject);
    procedure jvibtEditarMouseEnter(Sender: TObject);
    procedure jvibtEditarMouseLeave(Sender: TObject);
    procedure jvibtFecharMouseEnter(Sender: TObject);
    procedure jvibtFecharMouseLeave(Sender: TObject);
    procedure jvibtFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btePesquisarLeftButtonClick(Sender: TObject);
    procedure btePesquisarRightButtonClick(Sender: TObject);
    procedure grdDadosTitleClick(Column: TColumn);


  private
    { Private declarations }

  Protected
    //Seção que pode ser vista pelos hedeiros

   var
  //Objeto utilizado na rotina de filtro
    FieldFilter :TField;

  public
    { Public declarations }

  end;

var
  frmBaseListagem: TfrmBaseListagem;

implementation

{$R *.dfm}

uses  ufrmPrincipal;


procedure TfrmBaseListagem.btePesquisarLeftButtonClick(Sender: TObject);
begin
  inherited;
  btePesquisar.Clear;
  dtsListaDados.DataSet.Filtered := false;
  dtsListaDados.DataSet.Refresh;
end;

procedure TfrmBaseListagem.btePesquisarRightButtonClick(Sender: TObject);
var
  Filter: String;
begin
  inherited;
  if Assigned(FieldFilter) then
  begin
    case FieldFilter.DataType of
      ftUnknown:
        ;
      ftBoolean:
        ;
      ftString, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo, ftMemo:
        Filter := 'upper(' + FieldFilter.FieldName + ') like ' + QuotedStr(UpperCase('%' + btePesquisar.Text + '%'));

      ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint,
        ftBytes, ftByte:
        Filter := FieldFilter.FieldName + ' = ' + IntToStr(StrToIntDef(btePesquisar.Text, 0));

      ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftExtended, ftSingle:
        Filter := FieldFilter.FieldName + ' = ' + FloatToStr(StrToFloatDef(btePesquisar.Text, 0));

      ftDate, ftTime, ftDateTime:
        Filter := FieldFilter.FieldName + ' = ' + btePesquisar.Text;
    end;
    dtsListaDados.DataSet.Filter := Filter;
    dtsListaDados.DataSet.Filtered := True;

    dtsListaDados.DataSet.close;
    dtsListaDados.DataSet.open;

  end;
end;

procedure TfrmBaseListagem.grdDadosTitleClick(Column: TColumn);
var
sEspaco: Integer;
sleft: Integer;
sWidth: Integer;

begin
  inherited;

  if Column.Field.FieldKind = fkdata then
  begin
    FieldFilter := Column.Field;
    btePesquisar.Clear;
    lblLocalizar.Caption := 'Pesquisar por '+Column.Title.Caption;
    btePesquisar.TextHint := 'Digite para pesquisar em '+Column.Title.Caption;

    sleft := lblLocalizar.Left;
    sWidth :=  lblLocalizar.Width;
    sEspaco := sLeft + sWidth + 15;
    btePesquisar.Top := 6;
    btePesquisar.Left := sEspaco;
   end;
end;

procedure TfrmBaseListagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FecharAba(Self.Caption,frmPrincipal.pgctPrincipal);
end;

procedure TfrmBaseListagem.jvibtEditarMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 12);
end;

procedure TfrmBaseListagem.jvibtEditarMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 13);
end;

procedure TfrmBaseListagem.jvibtExcluirMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 0);
end;

procedure TfrmBaseListagem.jvibtExcluirMouseLeave(Sender: TObject);
begin
  inherited;
 ButtomMouseLeave(Sender, 1);
end;

procedure TfrmBaseListagem.jvibtFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaseListagem.jvibtFecharMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 6);
end;

procedure TfrmBaseListagem.jvibtFecharMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(sender, 7);
end;

procedure TfrmBaseListagem.jvibtNovoMouseEnter(Sender: TObject);
begin
  inherited;
  ButtomMouseEnter(Sender, 15);
end;

procedure TfrmBaseListagem.jvibtNovoMouseLeave(Sender: TObject);
begin
  inherited;
  ButtomMouseLeave(Sender, 16);
end;

end.
