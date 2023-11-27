inherited frmBaseCadastro: TfrmBaseCadastro
  Left = 500
  Top = 230
  Caption = 'Cadastro Padr'#227'o de Cadastro'
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBaseForm: TPanel
    Font.Height = -15
    ParentBackground = False
    ParentFont = False
    inherited pnlHerder: TPanel
      inherited imgClose: TImage
        ExplicitLeft = 679
      end
      inherited pnlLineHerderTop: TPanel
        Caption = ''
      end
      inherited pnlLineHerderLeft: TPanel
        Caption = ''
      end
      inherited pnlLineHerderButton: TPanel
        Caption = ''
      end
      inherited pnlLineHerderRigth: TPanel
        Caption = ''
      end
    end
    inherited pnlLineFormRight: TPanel
      Caption = ''
    end
    object pnlFundoBC: TPanel
      Left = 1
      Top = 36
      Width = 838
      Height = 413
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      object pnlButtonBC: TPanel
        Left = 0
        Top = 377
        Width = 838
        Height = 36
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object jvibtGravar: TJvImgBtn
          Left = 20
          Top = 0
          Width = 100
          Height = 36
          Action = actGravar
          Align = alLeft
          ImageIndex = 10
          Images = imltImagens
          TabOrder = 0
          OnEnter = jvibtGravarMouseEnter
          OnExit = jvibtGravarMouseLeave
          OnMouseEnter = jvibtGravarMouseEnter
          OnMouseLeave = jvibtGravarMouseLeave
        end
        object jvibtCancelar: TJvImgBtn
          Left = 140
          Top = 0
          Width = 100
          Height = 36
          Action = actCancelar
          Align = alLeft
          ImageIndex = 4
          Images = imltImagens
          TabOrder = 1
          OnEnter = jvibtCancelarMouseEnter
          OnExit = jvibtCancelarMouseLeave
          OnMouseEnter = jvibtCancelarMouseEnter
          OnMouseLeave = jvibtCancelarMouseLeave
        end
        object jvibtEcluir: TJvImgBtn
          Left = 270
          Top = 0
          Width = 100
          Height = 36
          Action = actExcluir
          Align = alLeft
          ImageIndex = 1
          Images = imltImagens
          TabOrder = 2
          OnEnter = jvibtCancelarMouseEnter
          OnExit = jvibtCancelarMouseLeave
          OnMouseEnter = jvibtEcluirMouseEnter
          OnMouseLeave = jvibtEcluirMouseLeave
        end
        object pnlEsp1: TPanel
          Left = 120
          Top = 0
          Width = 20
          Height = 36
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 3
        end
        object pnlEsp2: TPanel
          Left = 240
          Top = 0
          Width = 20
          Height = 36
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 4
        end
        object pnlEsp3: TPanel
          Left = 260
          Top = 0
          Width = 10
          Height = 36
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 5
        end
        object pnlEsp4: TPanel
          Left = 370
          Top = 0
          Width = 20
          Height = 36
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 6
        end
        object pnlEsp5: TPanel
          Left = 0
          Top = 0
          Width = 20
          Height = 36
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 7
        end
      end
    end
  end
  inherited imltImagens: TImageList
    Left = 304
    Top = 80
  end
  object actAcoes: TActionList
    Images = imltImagens
    Left = 409
    Top = 116
    object actGravar: TAction
      Category = 'Botoes'
      ImageIndex = 10
      OnExecute = actGravarExecute
    end
    object actCancelar: TAction
      Category = 'Botoes'
      ImageIndex = 4
      OnExecute = actCancelarExecute
    end
    object actExcluir: TAction
      Category = 'Botoes'
      ImageIndex = 1
      OnExecute = actExcluirExecute
    end
  end
  object dtsDados: TDataSource
    Left = 553
    Top = 108
  end
end
