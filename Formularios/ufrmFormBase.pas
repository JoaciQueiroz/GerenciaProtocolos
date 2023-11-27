unit ufrmFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, JvButton, JvCtrls;

type
  TfrmFormBase = class(TForm)
    pnlHerder: TPanel;
    pnlLineHerderTop: TPanel;
    pnlLineHerderLeft: TPanel;
    pnlLineFormButton: TPanel;
    pnlLineHerderButton: TPanel;
    pnlLineHerderRigth: TPanel;
    pnlLineFormLeft: TPanel;
    pnlLineFormRight: TPanel;
    imgClose: TImage;
    lblTitulo: TLabel;
    imltImagens: TImageList;
    pnlBaseForm: TPanel;
    procedure imgCloseClick(Sender: TObject);
    procedure pnlHerderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure ButtomMouseEnter(Sender: TObject; ImageIndex: Integer );
     procedure ButtomMouseLeave(Sender: TObject; ImageIndex: Integer );
  end;

var
  frmFormBase: TfrmFormBase;

implementation

{$R *.dfm}

procedure TfrmFormBase.ButtomMouseEnter(Sender: TObject; ImageIndex: Integer);
begin
   (Sender as TJvImgBtn).ImageIndex := ImageIndex;
   (Sender as TJvImgBtn).Cursor := crHandPoint;
end;

procedure TfrmFormBase.ButtomMouseLeave(Sender: TObject; ImageIndex: Integer);
begin
   (Sender as TJvImgBtn).ImageIndex := ImageIndex;
   (Sender as TJvImgBtn).Cursor := crDefault;
end;

procedure TfrmFormBase.FormShow(Sender: TObject);
begin
   	if Self.Caption <> EmptyStr then  //EmptyStr = Vazio sem texto
	   lblTitulo.Caption := Self.Caption;
end;

procedure TfrmFormBase.imgCloseClick(Sender: TObject);
begin
  //procedimento para fechar
    Close;
end;

procedure TfrmFormBase.pnlHerderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
SC_Dragmove = $F012;
begin
   if Button = mbleft then
   begin
		ReleaseCapture;
		Self.Perform (WM_SYSCOMMAND, SC_Dragmove, 0);
   end;
end;

end.
