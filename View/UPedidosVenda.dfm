object FormPedidosVenda: TFormPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos  de Venda'
  ClientHeight = 368
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDConnection1: TFDConnection
    Left = 608
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 608
    Top = 120
  end
end
