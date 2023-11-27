object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  Height = 243
  Width = 286
  object ConexaoBd: TFDConnection
    Params.Strings = (
      'Database=C:\GerenciaProtocolos\Database\GerenciaProtocolo.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3060'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object DriverFB: TFDPhysFBDriverLink
    VendorLib = 'C:\GerenciaProtocolos\Bin\fbclient.dll'
    Left = 192
    Top = 16
  end
  object Cursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 80
  end
  object Transacao: TFDTransaction
    Connection = ConexaoBd
    Left = 40
    Top = 104
  end
end
