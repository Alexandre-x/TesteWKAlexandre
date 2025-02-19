object FormPedidosVenda: TFormPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos  de Venda'
  ClientHeight = 386
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnLocalizarPedido: TButton
      Left = 4
      Top = 6
      Width = 105
      Height = 27
      Caption = 'Localizar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnLocalizarPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 115
      Top = 6
      Width = 105
      Height = 27
      Caption = 'Cancelar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarPedidoClick
    end
  end
  object DBGridPedProdutos: TDBGrid
    Left = 0
    Top = 201
    Width = 766
    Height = 144
    Align = alClient
    DataSource = dsPedidosProdutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGridPedProdutosKeyDown
    OnKeyPress = DBGridPedProdutosKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Caption = 'C'#243'digo do Produto'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao_produto'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o do Produto'
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
    Top = 345
    Width = 766
    Height = 41
    Align = alBottom
    TabOrder = 2
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
      Width = 133
      Height = 27
      Caption = 'Gravar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarPedidoClick
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
    object btnDescartarAlteracoes: TButton
      Left = 143
      Top = 6
      Width = 133
      Height = 27
      Caption = 'Descartar Altera'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnDescartarAlteracoesClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 766
    Height = 160
    Align = alTop
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 9
      Width = 84
      Height = 13
      Caption = 'C'#243'digo do Cliente'
    end
    object Label3: TLabel
      Left = 8
      Top = 33
      Width = 87
      Height = 13
      Caption = 'N'#250'mero do Pedido'
    end
    object Label4: TLabel
      Left = 8
      Top = 58
      Width = 79
      Height = 13
      Caption = 'Data de Emiss'#227'o'
    end
    object btnConfirmarItem: TButton
      Left = 641
      Top = 125
      Width = 119
      Height = 27
      Caption = 'Confirmar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnConfirmarItemClick
    end
    object EdtDataEmissao: TDateTimePicker
      Left = 115
      Top = 54
      Width = 102
      Height = 21
      Date = 45590.000000000000000000
      Time = 0.098030092594854070
      TabOrder = 2
      OnKeyPress = EdtCodigoClienteKeyPress
    end
    object EdtCodigoCliente: TEdit
      Left = 115
      Top = 6
      Width = 89
      Height = 21
      AutoSize = False
      NumbersOnly = True
      TabOrder = 0
      OnChange = EdtCodigoClienteChange
      OnKeyPress = EdtCodigoClienteKeyPress
    end
    object EdtNumeroPedido: TEdit
      Left = 115
      Top = 30
      Width = 89
      Height = 21
      AutoSize = False
      NumbersOnly = True
      TabOrder = 1
      OnKeyPress = EdtCodigoClienteKeyPress
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 81
      Width = 628
      Height = 72
      Caption = 'Itens do pedido'
      TabOrder = 3
      object Label5: TLabel
        Left = 11
        Top = 26
        Width = 89
        Height = 13
        Caption = 'C'#243'digo do Produto'
      end
      object Label6: TLabel
        Left = 108
        Top = 26
        Width = 102
        Height = 13
        Caption = 'Descri'#231#227'o do Produto'
      end
      object Label7: TLabel
        Left = 383
        Top = 26
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label8: TLabel
        Left = 453
        Top = 26
        Width = 56
        Height = 13
        Caption = 'Vlr. Unit'#225'rio'
      end
      object Label9: TLabel
        Left = 555
        Top = 26
        Width = 43
        Height = 13
        Caption = 'Vlr. Total'
      end
      object EdtCodigoProduto: TEdit
        Left = 11
        Top = 43
        Width = 91
        Height = 21
        AutoSize = False
        NumbersOnly = True
        TabOrder = 0
        OnChange = EdtCodigoProdutoChange
        OnKeyPress = EdtCodigoClienteKeyPress
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 108
        Top = 43
        Width = 261
        Height = 21
        KeyField = 'codigo'
        ListField = 'descricao'
        ListSource = dsProdutos
        TabOrder = 1
        TabStop = False
        OnCloseUp = DBLookupComboBox1CloseUp
      end
      object EdtQuantidade: TEdit
        Left = 375
        Top = 43
        Width = 64
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        NumbersOnly = True
        TabOrder = 2
        OnChange = EdtValorUnitarioChange
        OnKeyPress = EdtCodigoClienteKeyPress
      end
      object EdtValorUnitario: TEdit
        Left = 445
        Top = 43
        Width = 64
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        NumbersOnly = True
        TabOrder = 3
        OnChange = EdtValorUnitarioChange
        OnKeyPress = EdtValorUnitarioKeyPress
      end
      object EdtValorTotal: TEdit
        Left = 514
        Top = 43
        Width = 84
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        AutoSize = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 4
      end
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 209
      Top = 6
      Width = 261
      Height = 21
      KeyField = 'codigo'
      ListField = 'nome'
      ListSource = dsClientes
      TabOrder = 5
      TabStop = False
      OnCloseUp = DBLookupComboBox2CloseUp
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=dbwktechZZZ'
      'User_Name=root'
      'Password=Wk#102423#1a'
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
      ReadOnly = True
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
    Left = 558
    Top = 226
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
    AfterDelete = MTPedidosProdutosAfterDelete
    OnCalcFields = MTPedidosProdutosCalcFields
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
    Left = 639
    Top = 226
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
      ReadOnly = True
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
    Left = 558
    Top = 274
  end
  object dsPedidosProdutos: TDataSource
    AutoEdit = False
    DataSet = MTPedidosProdutos
    Left = 638
    Top = 274
  end
  object TimerCheckDB: TTimer
    Enabled = False
    OnTimer = TimerCheckDBTimer
    Left = 696
    Top = 24
  end
  object QueryAux: TFDQuery
    Connection = FDConnection1
    Left = 392
    Top = 73
  end
  object QPedidosProdutos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select pp.* from pedidos_produtos pp'
      'where pp.numero_pedido = :numero_pedido')
    Left = 424
    Top = 225
    ParamData = <
      item
        Name = 'NUMERO_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QPedidosProdutosID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QPedidosProdutosnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
      Required = True
    end
    object QPedidosProdutoscodigo_produto: TIntegerField
      FieldName = 'codigo_produto'
      Origin = 'codigo_produto'
      Required = True
    end
    object QPedidosProdutosquantidade: TBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
      Precision = 11
    end
    object QPedidosProdutosvalor_unitario: TBCDField
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      Required = True
      Precision = 11
      Size = 2
    end
    object QPedidosProdutosvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 11
      Size = 2
    end
  end
end
