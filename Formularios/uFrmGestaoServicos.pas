unit uFrmGestaoServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseListagem, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  JvDBControls, Vcl.StdCtrls, Vcl.ExtCtrls, JvExStdCtrls, JvButton, JvCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmListaServicos = class(TfrmBaseListagem)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaServicos: TfrmListaServicos;

implementation

{$R *.dfm}

end.
