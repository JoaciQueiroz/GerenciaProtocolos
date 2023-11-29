inherited FrmCadRequerimento: TFrmCadRequerimento
  Caption = 'Requerimento de Atendimento'
  ClientHeight = 547
  ClientWidth = 985
  Font.Height = -13
  OnCreate = FormCreate
  ExplicitWidth = 985
  ExplicitHeight = 547
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlBaseForm: TPanel
    Width = 985
    Height = 547
    ExplicitWidth = 985
    ExplicitHeight = 547
    inherited pnlHerder: TPanel
      Width = 985
      ExplicitWidth = 985
      inherited imgClose: TImage
        Left = 951
        ExplicitLeft = 951
      end
      inherited lblTitulo: TLabel
        Width = 293
        Caption = 'Requerimento de Atendimento'
        ExplicitWidth = 293
      end
      inherited pnlLineHerderTop: TPanel
        Width = 985
        ExplicitWidth = 985
      end
      inherited pnlLineHerderButton: TPanel
        Width = 985
        ExplicitWidth = 985
      end
      inherited pnlLineHerderRigth: TPanel
        Left = 984
        ExplicitLeft = 984
      end
    end
    inherited pnlLineFormButton: TPanel
      Top = 546
      Width = 985
      ExplicitTop = 546
      ExplicitWidth = 985
    end
    inherited pnlLineFormRight: TPanel
      Left = 984
      Height = 510
      ExplicitLeft = 984
      ExplicitHeight = 510
    end
    inherited pnlLineFormLeft: TPanel
      Height = 510
      ExplicitHeight = 510
    end
    inherited pnlFundoBC: TPanel
      Width = 983
      Height = 510
      ExplicitWidth = 983
      ExplicitHeight = 510
      inherited pnlButtonBC: TPanel
        Top = 474
        Width = 983
        ExplicitTop = 474
        ExplicitWidth = 983
      end
      object pnlRequerente: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 113
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
      object pnlServicos: TPanel
        Left = 0
        Top = 304
        Width = 983
        Height = 170
        Align = alBottom
        Color = 4227327
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object pnlTopservicos: TPanel
          Left = 1
          Top = 1
          Width = 981
          Height = 48
          Align = alTop
          TabOrder = 0
          object lblCodServico: TLabel
            Left = 23
            Top = 2
            Width = 77
            Height = 16
            Caption = 'C'#243'd. Servi'#231'o:'
          end
          object lblServico: TLabel
            Left = 139
            Top = 2
            Width = 47
            Height = 16
            Caption = 'Servi'#231'o:'
          end
          object edtCodServico: TEdit
            Left = 23
            Top = 18
            Width = 110
            Height = 24
            TabOrder = 0
            OnDblClick = edtCodServicoDblClick
            OnEnter = edtCodServicoEnter
          end
          object edtServico: TEdit
            Left = 139
            Top = 18
            Width = 448
            Height = 24
            TabOrder = 1
          end
          object btnIncluirServico: TButton
            Left = 593
            Top = 17
            Width = 75
            Height = 25
            Caption = 'Incluir'
            TabOrder = 2
            OnClick = btnIncluirServicoClick
          end
        end
        object dbgServicos: TDBGrid
          Left = 1
          Top = 49
          Width = 690
          Height = 120
          Align = alLeft
          DataSource = dtsServicos
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Visible = True
            end>
        end
        object memObservacoes: TMemo
          Left = 697
          Top = 49
          Width = 285
          Height = 120
          Align = alRight
          Lines.Strings = (
            'memObservacoes')
          TabOrder = 2
        end
        object dbgPesqServico: TDBGrid
          Left = 140
          Top = 44
          Width = 448
          Height = 120
          DataSource = dtsServicos
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Visible = False
        end
      end
      object pnlEndereco: TPanel
        Left = 0
        Top = 176
        Width = 983
        Height = 128
        Align = alClient
        Color = 8454143
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        ExplicitLeft = 24
        ExplicitTop = 143
        object lblLogradouro: TLabel
          Left = 6
          Top = 4
          Width = 70
          Height = 16
          Caption = 'Logradouro:'
        end
        object lblEndereco: TLabel
          Left = 120
          Top = 6
          Width = 58
          Height = 16
          Caption = 'Endere'#231'o:'
        end
        object lblMunicipio: TLabel
          Left = 574
          Top = 4
          Width = 58
          Height = 16
          Caption = 'Municipio:'
        end
        object lblBairro: TLabel
          Left = 6
          Top = 56
          Width = 34
          Height = 16
          Caption = 'Bairro'
        end
        object lblNum: TLabel
          Left = 425
          Top = 6
          Width = 14
          Height = 16
          Caption = 'N'#186
        end
        object lblComplemento: TLabel
          Left = 229
          Top = 54
          Width = 84
          Height = 16
          Caption = 'Complemento:'
        end
        object lblUf: TLabel
          Left = 431
          Top = 56
          Width = 15
          Height = 16
          Caption = 'UF'
        end
        object lblCep: TLabel
          Left = 829
          Top = 0
          Width = 22
          Height = 16
          Caption = 'CEP'
        end
        object edtCep: TEdit
          Left = 819
          Top = 22
          Width = 130
          Height = 24
          TabOrder = 3
        end
        object edtUF: TEdit
          Left = 784
          Top = 116
          Width = 50
          Height = 24
          TabOrder = 2
        end
        object lstEndereco: TListBox
          Left = 120
          Top = 56
          Width = 278
          Height = 75
          TabOrder = 6
          Visible = False
          OnDblClick = lstEnderecoDblClick
        end
        object edtComplemento: TEdit
          Left = 229
          Top = 72
          Width = 180
          Height = 24
          TabOrder = 0
        end
        object edtBairro: TEdit
          Left = 6
          Top = 78
          Width = 200
          Height = 24
          TabOrder = 1
        end
        object edtEndereco: TEdit
          Left = 120
          Top = 26
          Width = 294
          Height = 24
          TabOrder = 4
          OnChange = edtEnderecoChange
        end
        object edtNum: TEdit
          Left = 425
          Top = 24
          Width = 90
          Height = 24
          TabOrder = 5
        end
        object edtLogradouro: TEdit
          Left = 854
          Top = 118
          Width = 81
          Height = 24
          TabOrder = 7
        end
        object edtMunicipio: TEdit
          Left = 563
          Top = 26
          Width = 241
          Height = 24
          TabOrder = 8
        end
        object cbxLogradouro: TComboBox
          Left = 6
          Top = 26
          Width = 108
          Height = 24
          TabOrder = 9
          OnClick = cbxLogradouroClick
        end
        object cbxUF: TComboBox
          Left = 431
          Top = 78
          Width = 59
          Height = 24
          TabOrder = 10
          OnClick = cbxUFClick
        end
        object lstMunicipio: TListBox
          Left = 560
          Top = 56
          Width = 253
          Height = 68
          TabOrder = 11
        end
      end
      object pnlContato: TPanel
        Left = 0
        Top = 113
        Width = 983
        Height = 63
        Align = alTop
        Color = 8453888
        ParentBackground = False
        TabOrder = 4
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
    end
  end
  inherited imltImagens: TImageList
    Left = 536
    Top = 480
  end
  inherited actAcoes: TActionList
    Left = 649
    Top = 476
  end
  inherited dtsDados: TDataSource
    Left = 705
    Top = 476
  end
  object mnTblServicos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 601
    Top = 276
  end
  object dtsServicos: TDataSource
    DataSet = mnTblServicos
    Left = 697
    Top = 284
  end
  object qryPesqServico: TFDQuery
    Connection = DmPrincipal.ConexaoBd
    SQL.Strings = (
      
        'select srv.id_servico, srv.servico from tbl_servicos SRV WHERE s' +
        'rv.servico = :servico')
    Left = 849
    Top = 284
    ParamData = <
      item
        Name = 'SERVICO'
        ParamType = ptInput
      end>
  end
end
