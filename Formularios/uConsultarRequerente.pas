unit uConsultarRequerente;

interface

uses
  FireDAC.Comp.Client, Vcl.StdCtrls, System.MaskUtils;

type
  TConsultarRequerente = class
  public
    class procedure ConsultarPorNome(const Nome: string; lstRequerente: TListBox);
  end;

implementation

uses
  uDmPrincipal;

class procedure TConsultarRequerente.ConsultarPorNome(const Nome: string; lstRequerente: TListBox);
var
  qryConstNome: TFDQuery;
begin
  qryConstNome := TFDQuery.Create(nil);
  try
    qryConstNome.Connection := DmPrincipal.ConexaoBd;
    qryConstNome.Close;
    qryConstNome.SQL.Text := 'SELECT r.ID_Requerente, r.Nome, r.Data_Nascimento, r.Celular,' +
      'r.Whatsapp, r.email, r.complemento, r.numero, r.bairro, r.cep, pf.CPF, pf.rg, pf.sexo ' +
      'FROM tbl_requerente r ' +
      'LEFT JOIN tbl_pessoa_fisica pf ON r.ID_Requerente = pf.ID_Requerente ' +
      'WHERE r.Nome containing :pNome';
    qryConstNome.ParamByName('pNome').AsString := Nome;
    qryConstNome.Open;

    if not qryConstNome.IsEmpty then
    begin
      lstRequerente.Visible := True;
      lstRequerente.Width := 320;
    end
    else
    begin
      lstRequerente.Visible := False;
    end;

    lstRequerente.Clear; // Limpa o TListBox

    // Preenche o TListBox com os resultados da consulta
    while not qryConstNome.Eof do
    begin
      // Formatando o CPF com máscaras
      // Exemplo: 123.456.789-01
      var CPF := FormatMaskText('000\.000\.000\-00;0;_', qryConstNome.FieldByName('CPF').AsString);

      lstRequerente.Items.Add(
        Format(
          '%d | %s | %s',
          [qryConstNome.FieldByName('ID_Requerente').AsInteger,
           qryConstNome.FieldByName('Nome').AsString,
           CPF]
        )
      );

      qryConstNome.Next;
    end;
  finally
    qryConstNome.Free;
  end;
end;

end.

