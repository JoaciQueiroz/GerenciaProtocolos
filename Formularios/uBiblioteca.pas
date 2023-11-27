unit uBiblioteca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmFormBase, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.DBCtrls, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  FireDAC.Comp.Client, uEnum;

  procedure CriarAba (pForm: TFormClass; pPageControl: TPageControl; pIndexImage: Integer);
  function AbaExiste (pNomeAba: String; pPageControl: TPageControl):Boolean;
  Procedure FecharAba (pNomeAba: String; pPageControl: TPageControl);
  PROCEDURE DesabilitaCampos(pPanel: TPanel);
  PROCEDURE HabilitaCampos (pPanel: TPanel);
  Procedure FormatarComoMoeda( Componente : TObject; var Key: Char );
  Procedure FormatarComoMoedaEdt( Componente : TObject; var Key: Char );


implementation
//funçao para criar aba no pagecontrol e chamar o formulário
 procedure CriarAba(pForm: TFormClass; pPageControl: TPageControl;
   pIndexImage: Integer);
 var
   vTabSheet: TTabSheet;
   vForm: Tform;

 begin

   vForm := pForm.Create(nil); // cria o formulário
   If AbaExiste(vForm.Caption, pPageControl) then
   begin
     if Assigned(vForm) then
       FreeAndNil(vForm);
     exit;
   end;

   vTabSheet := TTabSheet.Create(nil);
   vTabSheet.PageControl := pPageControl;
   vTabSheet.Caption := vForm.Caption;
   vTabSheet.ImageIndex := pIndexImage;

   vForm.Align := alClient;
   vForm.BorderStyle := bsNone;
   vForm.Parent := vTabSheet;
   vForm.show;

   pPageControl.ActivePage := vTabSheet;
 End;

 //funçao para verificar a existência de aba no formulário
function AbaExiste (pNomeAba: String; pPageControl: TPageControl):Boolean;
var
I: Integer;

Begin
  Result := false;
  for I := 0 to pPageControl.PageCount -1 do
	begin
		if LowerCase(pPageControl.Pages[I].Caption) = LowerCase (pNomeAba) then
			begin
				pPageControl.ActivePage := pPageControl.Pages[I];
				pPageControl.TabIndex := I;
				Result := True;
				Break;
			end;
	end;
End;

//funçao para fechar  aba do PageControl
Procedure FecharAba (pNomeAba: String; pPageControl: TPageControl);
var
I: Integer;

Begin
  for I := 0 to pPageControl.PageCount -1 do
	begin
		if LowerCase(pPageControl.Pages[I].Caption) = LowerCase (pNomeAba) then
			begin
				pPageControl.Pages[I].Destroy;
				pPageControl.ActivePageIndex := 0;
				Break;
			end;
	end;
End;

PROCEDURE DesabilitaCampos(pPanel: TPanel);
var
I: Integer;
BEGIN

 	for i := 0 to pPanel.ControlCount -1 do
	begin
		if pPanel.Controls[i] is TCustomEdit then
			(pPanel.Controls[i] as TCustomEdit).Enabled := FALSE;

    if pPanel.Controls[i] is TDBComboBox then
			(pPanel.Controls[i] as TDBComboBox).Enabled := FALSE;

	 	if pPanel.Controls[i] is TDBLookupComboBox then
			(pPanel.Controls[i] as TDBLookupComboBox).Enabled := FALSE;

		if pPanel.Controls[i] is TComboBox then
			(pPanel.Controls[i] as TComboBox).Enabled := FALSE;

		if pPanel.Controls[i] is TDbCheckBox then
			(pPanel.Controls[i] as TDbCheckBox).Enabled := FALSE;

		if pPanel.Controls[i] is TGroupBox then
			(pPanel.Controls[i] as TGroupBox).Enabled := FALSE;

		if pPanel.Controls[i] is TDBRadioGroup then
			(pPanel.Controls[i] as TDBRadioGroup).Enabled := FALSE;

		end;

End;

PROCEDURE HabilitaCampos (pPanel: TPanel);
var
i: INTEGER;
BEGIN

	for i:= 0 to pPanel.ControlCount -1 do
	begin
		if pPanel.Controls[i] is TCustomEdit then
			(pPanel.Controls[i] as TCustomEdit).Enabled := True;

		if pPanel.Controls[i] is TDBComboBox then
			(pPanel.Controls[i] as TDBComboBox).Enabled := True;

	 	if pPanel.Controls[i] is TDBLookupComboBox then
			(pPanel.Controls[i] as TDBLookupComboBox).Enabled := True;

		if pPanel.Controls[i] is TComboBox then
			(pPanel.Controls[i] as TComboBox).Enabled := True;

		if pPanel.Controls[i] is TDbCheckBox then
			(pPanel.Controls[i] as TDbCheckBox).Enabled := True;

		if pPanel.Controls[i] is TGroupBox then
			(pPanel.Controls[i] as TGroupBox).Enabled := True;

		if pPanel.Controls[i] is TDBRadioGroup then
			(pPanel.Controls[i] as TDBRadioGroup).Enabled := True;
	end;
end;

Procedure FormatarComoMoeda( Componente : TObject; var Key: Char );
var
   str_valor  : String;
   dbl_valor  : double;
begin

   { verificando se estamos recebendo o TDBEdit realmente }
   IF Componente is TDBEdit THEN
   BEGIN
      { se tecla pressionada e' um numero, backspace ou del deixa passar }
      IF ( Key in ['0'..'9', #8, #9] ) THEN
      BEGIN
         { guarda valor do TDBEdit com que vamos trabalhar }
         str_valor := TDBEdit( Componente ).Text ;
         { verificando se nao esta vazio }
         IF str_valor = EmptyStr THEN str_valor := '0,00' ;
         { se valor numerico ja insere na string temporaria }
         IF Key in ['0'..'9'] THEN str_valor := Concat( str_valor, Key ) ;
         { retira pontos e virgulas se tiver! }
         str_valor := Trim( StringReplace( str_valor, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         str_valor := Trim( StringReplace( str_valor, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         {inserindo 2 casas decimais}
         dbl_valor := StrToFloat( str_valor ) ;
         dbl_valor := ( dbl_valor / 100 ) ;

         {reseta posicao do TDBEdit}
         TDBEdit( Componente ).SelStart := Length( TDBEdit( Componente ).Text );
         {retornando valor tratado ao TDBEdit}
         TDBEdit( Componente ).Text := FormatFloat( '###,##0.00', dbl_valor ) ;
      END;
      {se nao e' key relevante entao reseta}
      IF NOT( Key in [#8, #9] ) THEN key := #0;
   END;

end;

Procedure FormatarComoMoedaEdt( Componente : TObject; var Key: Char );
var
   str_valor  : String;
   dbl_valor  : double;
begin

   { verificando se estamos recebendo o TEdit realmente }
   IF Componente is TEdit THEN
   BEGIN
      { se tecla pressionada e' um numero, backspace ou del deixa passar }
      IF ( Key in ['0'..'9', #8, #9] ) THEN
      BEGIN
         { guarda valor do TEdit com que vamos trabalhar }
         str_valor := TEdit( Componente ).Text ;
         { verificando se nao esta vazio }
         IF str_valor = EmptyStr THEN str_valor := '0,00' ;
         { se valor numerico ja insere na string temporaria }
         IF Key in ['0'..'9'] THEN str_valor := Concat( str_valor, Key ) ;
         { retira pontos e virgulas se tiver! }
         str_valor := Trim( StringReplace( str_valor, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         str_valor := Trim( StringReplace( str_valor, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         {inserindo 2 casas decimais}
         dbl_valor := StrToFloat( str_valor ) ;
         dbl_valor := ( dbl_valor / 100 ) ;

         {reseta posicao do tedit}
         TEdit( Componente ).SelStart := Length( TEdit( Componente ).Text );
         {retornando valor tratado ao TEdit}
         TEdit( Componente ).Text := FormatFloat( '###,##0.00', dbl_valor ) ;
      END;
      {se nao e' key relevante entao reseta}
      IF NOT( Key in [#8, #9] ) THEN key := #0;
   END;

end;

end.
