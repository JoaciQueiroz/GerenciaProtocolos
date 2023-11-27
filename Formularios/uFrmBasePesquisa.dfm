inherited frmBasePesquisa: TfrmBasePesquisa
  Left = 700
  Top = 135
  Caption = 'frmBasePesquisa'
  ClientHeight = 558
  ClientWidth = 606
  Font.Height = -15
  KeyPreview = True
  Position = poDesigned
  OnKeyPress = FormKeyPress
  ExplicitWidth = 606
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 18
  inherited pnlBaseForm: TPanel
    Width = 606
    Height = 558
    ExplicitWidth = 606
    ExplicitHeight = 558
    inherited pnlHerder: TPanel
      Width = 606
      ExplicitWidth = 606
      inherited imgClose: TImage
        Left = 572
        ExplicitLeft = 572
      end
      inherited pnlLineHerderTop: TPanel
        Width = 606
        ExplicitWidth = 606
      end
      inherited pnlLineHerderButton: TPanel
        Width = 606
        ExplicitWidth = 606
      end
      inherited pnlLineHerderRigth: TPanel
        Left = 605
        ExplicitLeft = 605
      end
    end
    inherited pnlLineFormButton: TPanel
      Top = 557
      Width = 606
      Visible = False
      ExplicitTop = 557
      ExplicitWidth = 606
    end
    inherited pnlLineFormRight: TPanel
      Left = 605
      Top = 97
      Height = 419
      TabOrder = 3
      ExplicitLeft = 605
      ExplicitTop = 97
      ExplicitHeight = 419
    end
    inherited pnlLineFormLeft: TPanel
      Top = 97
      Height = 419
      TabOrder = 4
      ExplicitTop = 97
      ExplicitHeight = 419
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 36
      Width = 606
      Height = 61
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object lblPesquisar: TLabel
        Left = 25
        Top = 1
        Width = 92
        Height = 18
        Caption = 'Pesquisar por:'
      end
      object edtPesquisar: TEdit
        Left = 25
        Top = 27
        Width = 328
        Height = 26
        TabOrder = 0
      end
      object btnPesquisar: TButton
        Left = 376
        Top = 19
        Width = 100
        Height = 36
        Caption = 'Pesquisar'
        TabOrder = 1
        OnClick = btnPesquisarClick
      end
    end
    object pnlRodape: TPanel
      Left = 0
      Top = 516
      Width = 606
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 6
      object btnSelecionar: TButton
        Left = 56
        Top = 10
        Width = 100
        Height = 25
        Caption = 'Selecionar'
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancelar: TButton
        Left = 376
        Top = 10
        Width = 100
        Height = 25
        Caption = 'Cancelar'
        ModalResult = 2
        TabOrder = 1
      end
    end
    object dbgDados: TDBGrid
      Left = 1
      Top = 97
      Width = 604
      Height = 419
      Align = alClient
      BorderStyle = bsNone
      DataSource = dtsDados
      DrawingStyle = gdsClassic
      FixedColor = 16777130
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object qryDadosPesq: TFDQuery
    Connection = DmPrincipal.ConexaoBd
    Left = 504
    Top = 136
  end
  object dtsDados: TDataSource
    DataSet = qryDadosPesq
    Left = 296
    Top = 176
  end
end
