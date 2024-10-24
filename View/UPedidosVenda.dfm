object FormPedidosVenda: TFormPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos  de Venda'
  ClientHeight = 392
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 201
    Align = alTop
    TabOrder = 0
    ExplicitTop = -6
    object btnConfirmar: TButton
      Left = 4
      Top = 168
      Width = 105
      Height = 27
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 16
      Top = 16
      Width = 320
      Height = 120
      DataSource = dsClientes
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 346
      Top = 48
      Width = 320
      Height = 120
      DataSource = dsProdutos
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object DBGridPedProdutos: TDBGrid
    Left = 0
    Top = 201
    Width = 766
    Height = 150
    Align = alClient
    DataSource = dsPedidosProdutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Caption = 'C'#243'digo Produto'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao_produto'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o Produto'
        Width = 288
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_unitario'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 96
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 351
    Width = 766
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 224
    ExplicitTop = 360
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 496
      Top = 12
      Width = 122
      Height = 13
      Caption = 'Valor Total do Pedido:'
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGravarPedido: TButton
      Left = 4
      Top = 6
      Width = 105
      Height = 27
      Caption = 'Gravar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 624
      Top = 9
      Width = 134
      Height = 21
      TabStop = False
      DataField = 'valor_total'
      DataSource = dsPedidos
      ReadOnly = True
      TabOrder = 1
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server='
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 608
    Top = 40
  end
  object QClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from clientes')
    Left = 456
    Top = 16
    object QClientescodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QClientesnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 45
    end
    object QClientescidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 40
    end
    object QClientesuf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      Size = 2
    end
  end
  object MTPedidos: TFDMemTable
    FieldDefs = <
      item
        Name = 'numero_pedido'
        DataType = ftInteger
      end
      item
        Name = 'data_emissao'
        DataType = ftDateTime
      end
      item
        Name = 'codigo_cliente'
        DataType = ftInteger
      end
      item
        Name = 'valor_total'
        DataType = ftCurrency
        Precision = 19
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 598
    Top = 98
    object MTPedidosnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
    end
    object MTPedidosdata_emissao: TDateTimeField
      FieldName = 'data_emissao'
    end
    object MTPedidoscodigo_cliente: TIntegerField
      FieldName = 'codigo_cliente'
    end
    object MTPedidosvalor_total: TCurrencyField
      FieldName = 'valor_total'
    end
  end
  object dsClientes: TDataSource
    AutoEdit = False
    DataSet = QClientes
    Left = 456
    Top = 69
  end
  object MTPedidosProdutos: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 679
    Top = 98
    object MTPedidosProdutosID: TIntegerField
      FieldName = 'ID'
    end
    object MTPedidosProdutosnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
    end
    object MTPedidosProdutoscodigo_produto: TIntegerField
      FieldName = 'codigo_produto'
    end
    object MTPedidosProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object MTPedidosProdutosvalor_unitario: TCurrencyField
      FieldName = 'valor_unitario'
    end
    object MTPedidosProdutosvalor_total: TCurrencyField
      FieldName = 'valor_total'
    end
    object MTPedidosProdutosdescricao_produto: TStringField
      FieldKind = fkCalculated
      FieldName = 'descricao_produto'
      Size = 45
      Calculated = True
    end
  end
  object QProdutos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produtos'
      'order by descricao')
    Left = 527
    Top = 16
    object QProdutoscodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 45
    end
    object QProdutospreco_venda: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
      Precision = 11
      Size = 2
    end
  end
  object dsProdutos: TDataSource
    AutoEdit = False
    DataSet = QProdutos
    Left = 527
    Top = 69
  end
  object dsPedidos: TDataSource
    AutoEdit = False
    DataSet = MTPedidos
    Left = 598
    Top = 146
  end
  object dsPedidosProdutos: TDataSource
    AutoEdit = False
    DataSet = MTPedidosProdutos
    Left = 678
    Top = 146
  end
  object TimerCheckDB: TTimer
    Enabled = False
    OnTimer = TimerCheckDBTimer
    Left = 696
    Top = 24
  end
end
