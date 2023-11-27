inherited frmTesteCadastros: TfrmTesteCadastros
  Caption = 'frmTesteCadastros'
  ClientHeight = 494
  ClientWidth = 1001
  ExplicitWidth = 1001
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBaseForm: TPanel
    Width = 1001
    Height = 494
    ExplicitWidth = 1001
    ExplicitHeight = 494
    inherited pnlHerder: TPanel
      Width = 1001
      ExplicitWidth = 1001
      inherited imgClose: TImage
        Left = 967
        ExplicitLeft = 967
      end
      inherited lblTitulo: TLabel
        Width = 187
        Caption = 'Formul'#225'rio de teste'
        ExplicitWidth = 187
      end
      inherited pnlLineHerderTop: TPanel
        Width = 1001
        ExplicitWidth = 1001
      end
      inherited pnlLineHerderButton: TPanel
        Width = 1001
        ExplicitWidth = 1001
      end
      inherited pnlLineHerderRigth: TPanel
        Left = 1000
        ExplicitLeft = 1000
      end
    end
    inherited pnlLineFormButton: TPanel
      Top = 493
      Width = 1001
      ExplicitTop = 493
      ExplicitWidth = 1001
    end
    inherited pnlLineFormRight: TPanel
      Left = 1000
      Height = 457
      ExplicitLeft = 1000
      ExplicitHeight = 457
    end
    inherited pnlLineFormLeft: TPanel
      Height = 457
      ExplicitHeight = 457
    end
    inherited pnlFundoBC: TPanel
      Width = 999
      Height = 457
      ExplicitWidth = 999
      ExplicitHeight = 457
      inherited pnlButtonBC: TPanel
        Top = 421
        Width = 999
        ExplicitTop = 421
        ExplicitWidth = 999
      end
      object pnlRequerente: TPanel
        Left = 0
        Top = 0
        Width = 999
        Height = 115
        Align = alTop
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblNome: TLabel
          Left = 6
          Top = 6
          Width = 38
          Height = 16
          Caption = 'Nome:'
        end
        object lblNumProtocolo: TLabel
          Left = 563
          Top = 6
          Width = 76
          Height = 16
          Caption = 'N'#186' Protocolo:'
        end
        object lblCpf: TLabel
          Left = 6
          Top = 32
          Width = 40
          Height = 16
          Caption = 'N'#186' CPF'
        end
        object lblMatricula: TLabel
          Left = 415
          Top = 32
          Width = 70
          Height = 16
          Caption = 'N'#186' Matricula'
        end
        object lblLotacao: TLabel
          Left = 668
          Top = 32
          Width = 154
          Height = 16
          Caption = 'Lota'#231#227'o (Nome Secret'#225'ria)'
        end
        object lblCargo: TLabel
          Left = 6
          Top = 78
          Width = 34
          Height = 16
          Caption = 'Cargo'
        end
        object lblLocalTrabalho: TLabel
          Left = 397
          Top = 78
          Width = 98
          Height = 16
          Caption = 'Local de trabalho'
        end
        object lblDtNascimento: TLabel
          Left = 376
          Top = 6
          Width = 52
          Height = 16
          Caption = 'Dt. Nasc:'
        end
        object lblDtEntrada: TLabel
          Left = 784
          Top = 6
          Width = 64
          Height = 16
          Caption = 'Dt. Entrada'
        end
        object lblSexo: TLabel
          Left = 349
          Top = 32
          Width = 28
          Height = 16
          Caption = 'Sexo'
        end
        object lblDtAdmissao: TLabel
          Left = 541
          Top = 32
          Width = 75
          Height = 16
          Caption = 'Dt. Admiss'#227'o'
        end
        object lblRg: TLabel
          Left = 159
          Top = 32
          Width = 34
          Height = 16
          Caption = 'N'#176' RG'
        end
        object edtNome: TEdit
          Left = 45
          Top = 2
          Width = 300
          Height = 24
          TabOrder = 0
          OnChange = edtNomeChange
        end
        object edtNumProtocolo: TEdit
          Left = 645
          Top = 2
          Width = 121
          Height = 24
          TabOrder = 1
        end
        object edtNumCPF: TEdit
          Left = 6
          Top = 48
          Width = 147
          Height = 24
          TabOrder = 2
        end
        object edtMatricula: TEdit
          Left = 415
          Top = 48
          Width = 120
          Height = 24
          TabOrder = 3
        end
        object edtLotacao: TEdit
          Left = 667
          Top = 48
          Width = 310
          Height = 24
          TabOrder = 4
        end
        object edtCargo: TEdit
          Left = 46
          Top = 78
          Width = 307
          Height = 24
          TabOrder = 5
        end
        object edtLocalTrabalho: TEdit
          Left = 513
          Top = 78
          Width = 464
          Height = 24
          TabOrder = 6
        end
        object jvDtNascimento: TJvDateEdit
          Left = 431
          Top = 2
          Width = 120
          Height = 24
          ShowNullDate = False
          TabOrder = 7
        end
        object jvDtEntrada: TJvDateEdit
          Left = 854
          Top = 2
          Width = 120
          Height = 24
          ShowNullDate = False
          TabOrder = 8
        end
        object jvDtAdmisao: TJvDateEdit
          Left = 541
          Top = 48
          Width = 120
          Height = 24
          ShowNullDate = False
          TabOrder = 9
        end
        object cbxSexo: TComboBox
          Left = 349
          Top = 48
          Width = 60
          Height = 24
          TabOrder = 10
          Items.Strings = (
            'Masculino'
            'Femenino')
        end
        object edtRg: TEdit
          Left = 159
          Top = 48
          Width = 184
          Height = 24
          TabOrder = 11
        end
        object lstRequerente: TListBox
          Left = 45
          Top = 26
          Width = 300
          Height = 85
          TabOrder = 12
          Visible = False
          OnDblClick = lstRequerenteDblClick
        end
      end
      object pnlContato: TPanel
        Left = 0
        Top = 115
        Width = 999
        Height = 55
        Align = alTop
        Color = 8453888
        ParentBackground = False
        TabOrder = 2
        object lblWhastApp: TLabel
          Left = 132
          Top = 4
          Width = 67
          Height = 18
          Caption = 'WhastApp'
        end
        object lblCelular: TLabel
          Left = 6
          Top = 4
          Width = 42
          Height = 18
          Caption = 'Celular'
        end
        object lblEmail: TLabel
          Left = 258
          Top = 6
          Width = 38
          Height = 18
          Caption = 'e-mail'
        end
        object edtWhastApp: TEdit
          Left = 132
          Top = 24
          Width = 120
          Height = 26
          TabOrder = 0
        end
        object edtEmail: TEdit
          Left = 258
          Top = 24
          Width = 300
          Height = 26
          TabOrder = 1
        end
        object edtCelular: TEdit
          Left = 6
          Top = 24
          Width = 120
          Height = 26
          TabOrder = 2
        end
      end
      object pnlEndereco: TPanel
        Left = 0
        Top = 170
        Width = 999
        Height = 128
        Align = alTop
        Color = 8454143
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        object lblLogradouro: TLabel
          Left = 6
          Top = 4
          Width = 70
          Height = 16
          Caption = 'Logradouro:'
        end
        object lblEndereco: TLabel
          Left = 157
          Top = 4
          Width = 58
          Height = 16
          Caption = 'Endere'#231'o:'
        end
        object lblMunicipio: TLabel
          Left = 6
          Top = 64
          Width = 58
          Height = 16
          Caption = 'Municipio:'
        end
        object lblBairro: TLabel
          Left = 795
          Top = 6
          Width = 34
          Height = 16
          Caption = 'Bairro'
        end
        object lblNum: TLabel
          Left = 513
          Top = 6
          Width = 14
          Height = 16
          Caption = 'N'#186
        end
        object lblComplemento: TLabel
          Left = 609
          Top = 6
          Width = 84
          Height = 16
          Caption = 'Complemento:'
        end
        object lblUf: TLabel
          Left = 157
          Top = 64
          Width = 15
          Height = 16
          Caption = 'UF'
        end
        object lblCep: TLabel
          Left = 213
          Top = 64
          Width = 22
          Height = 16
          Caption = 'CEP'
        end
        object edtCep: TEdit
          Left = 213
          Top = 86
          Width = 130
          Height = 24
          TabOrder = 3
        end
        object edtUF: TEdit
          Left = 157
          Top = 86
          Width = 50
          Height = 24
          TabOrder = 2
        end
        object lstEndereco: TListBox
          Left = 157
          Top = 48
          Width = 350
          Height = 75
          TabOrder = 6
          Visible = False
        end
        object edtComplemento: TEdit
          Left = 609
          Top = 24
          Width = 180
          Height = 24
          TabOrder = 0
        end
        object edtBairro: TEdit
          Left = 795
          Top = 24
          Width = 200
          Height = 24
          TabOrder = 1
        end
        object edtEndereco: TEdit
          Left = 157
          Top = 24
          Width = 350
          Height = 24
          TabOrder = 4
        end
        object edtNum: TEdit
          Left = 513
          Top = 24
          Width = 90
          Height = 24
          TabOrder = 5
        end
        object edtLogradouro: TEdit
          Left = 8
          Top = 24
          Width = 121
          Height = 24
          TabOrder = 7
        end
        object edtMunicipio: TEdit
          Left = 6
          Top = 86
          Width = 121
          Height = 24
          TabOrder = 8
        end
      end
    end
  end
  inherited imltImagens: TImageList
    Left = 776
    Top = 144
  end
  inherited actAcoes: TActionList
    Left = 945
    Top = 156
  end
  inherited dtsDados: TDataSource
    Left = 865
    Top = 148
  end
end
