unit UPedidosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls,
  Vcl.StdCtrls, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, INIFiles, Vcl.ComCtrls, StrUtils;

type
  TFormPedidosVenda = class(TForm)
    FDConnection1: TFDConnection;
    QClientes: TFDQuery;
    Panel1: TPanel;
    btnLocalizarPedido: TButton;
    MTPedidos: TFDMemTable;
    DBGridPedProdutos: TDBGrid;
    dsClientes: TDataSource;
    QClientescodigo: TFDAutoIncField;
    QClientesnome: TStringField;
    QClientescidade: TStringField;
    QClientesuf: TStringField;
    MTPedidosProdutos: TFDMemTable;
    QProdutos: TFDQuery;
    QProdutoscodigo: TFDAutoIncField;
    QProdutosdescricao: TStringField;
    QProdutospreco_venda: TBCDField;
    dsProdutos: TDataSource;
    dsPedidos: TDataSource;
    dsPedidosProdutos: TDataSource;
    MTPedidosnumero_pedido: TIntegerField;
    MTPedidosdata_emissao: TDateTimeField;
    MTPedidoscodigo_cliente: TIntegerField;
    MTPedidosvalor_total: TCurrencyField;
    MTPedidosProdutosID: TIntegerField;
    MTPedidosProdutosnumero_pedido: TIntegerField;
    MTPedidosProdutoscodigo_produto: TIntegerField;
    MTPedidosProdutosquantidade: TFloatField;
    MTPedidosProdutosvalor_unitario: TCurrencyField;
    MTPedidosProdutosvalor_total: TCurrencyField;
    MTPedidosProdutosdescricao_produto: TStringField;
    Panel2: TPanel;
    btnGravarPedido: TButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    TimerCheckDB: TTimer;
    Panel3: TPanel;
    btnConfirmarItem: TButton;
    btnCancelarPedido: TButton;
    QueryAux: TFDQuery;
    EdtDataEmissao: TDateTimePicker;
    EdtCodigoCliente: TEdit;
    Label2: TLabel;
    EdtNumeroPedido: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    EdtCodigoProduto: TEdit;
    Label5: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label6: TLabel;
    Label7: TLabel;
    EdtQuantidade: TEdit;
    EdtValorUnitario: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    EdtValorTotal: TEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    QPedidosProdutos: TFDQuery;
    QPedidosProdutosID: TFDAutoIncField;
    QPedidosProdutosnumero_pedido: TIntegerField;
    QPedidosProdutoscodigo_produto: TIntegerField;
    QPedidosProdutosquantidade: TBCDField;
    QPedidosProdutosvalor_unitario: TBCDField;
    QPedidosProdutosvalor_total: TBCDField;
    btnDescartarAlteracoes: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerCheckDBTimer(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure EdtCodigoProdutoChange(Sender: TObject);
    procedure EdtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorUnitarioChange(Sender: TObject);
    procedure btnConfirmarItemClick(Sender: TObject);
    procedure MTPedidosProdutosAfterDelete(DataSet: TDataSet);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure EdtCodigoClienteChange(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure MTPedidosProdutosCalcFields(DataSet: TDataSet);
    procedure DBGridPedProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPedProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocalizarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnDescartarAlteracoesClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCamposPedido();
    procedure LimparCamposProdutoPedido();
    function  CalcularValorTotal(): Real;
    procedure SalvarPedido();
    function  CarregarDadosPedido(pnumero_pedido: Integer): boolean;
  public
    { Public declarations }
    bDbPronto: Boolean;
  end;

var
  FormPedidosVenda: TFormPedidosVenda;

implementation

{$R *.dfm}

Uses UControllerPedidosVenda, UModelPedidosVenda;

procedure TFormPedidosVenda.btnCancelarPedidoClick(Sender: TObject);
begin
  if MTPedidos.IsEmpty then
  begin
    btnLocalizarPedido.Click;
  end;

  if MTPedidos.IsEmpty then
  begin
    Application.MessageBox('Nenhum pedido informado para cancelamento!', 'Aviso', mb_ok+mb_iconinformation);
    Exit;
  end;

  if application.MessageBox('Confirma exclus�o do pedido ?', 'Excluir', mb_yesno+mb_iconquestion) = mryes then
  begin
    try
      FDConnection1.StartTransaction;
      QueryAux.Close;
      QueryAux.SQL.Clear;
      QueryAux.SQL.Add('delete from pedidos_produtos');
      QueryAux.SQL.Add(' where numero_pedido = ');
      QueryAux.SQL.Add(MTPedidosProdutosnumero_pedido.AsString);
      QueryAux.ExecSQL;
      QueryAux.Close;
      FDConnection1.Commit;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        showmessage(format('Falha ao excluir itens do pedido !%s%s', [#13, E.Message]));
        Exit;
      end;
    end;

    try
      FDConnection1.StartTransaction;
      QueryAux.Close;
      QueryAux.SQL.Clear;
      QueryAux.SQL.Add('delete from pedidos');
      QueryAux.SQL.Add(' where numero_pedido = ');
      QueryAux.SQL.Add(MTPedidosProdutosnumero_pedido.AsString);
      QueryAux.ExecSQL;
      QueryAux.Close;
      FDConnection1.Commit;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        showmessage(format('Falha ao excluir pedido !%s%s', [#13, E.Message]));
        Exit;
      end;
    end;

    EdtCodigoCliente.Text      := EmptyStr;
    edtNumeroPedido.Text       := EmptyStr;
    edtDataEmissao.DateTime    := Date;
    dblookupcombobox2.KeyValue := -1;
    MTPedidosProdutos.EmptyDataSet;
    MTPedidos.EmptyDataSet;
  end;
end;

procedure TFormPedidosVenda.btnConfirmarItemClick(Sender: TObject);
var
  iProximoPedido: Integer;
begin
  if application.MessageBox('Confirma dados do produto ?', 'Confirma', mb_yesno) <> mryes then
  begin
    exit;
  end;

  if (mtPedidos.IsEmpty) then
  begin
    QueryAux.Close;
    QueryAux.SQL.Clear;
    QueryAux.SQL.Add('select max(numero_pedido) as ultimo_pedido from pedidos');
    QueryAux.Open;
    if (QueryAux.IsEmpty) or
        (QueryAux.FieldByName('ultimo_pedido').IsNull) then
    begin
      iProximoPedido := 1;
    end
    else
    begin
      iProximoPedido := QueryAux.FieldByName('ultimo_pedido').AsInteger + 1;
    end;
    QueryAux.Close;

    mtPedidos.Insert;
    MTPedidosnumero_pedido.AsInteger  := iProximoPedido;
    MTPedidosdata_emissao.AsDateTime  := edtDataEmissao.DateTime;
    MTPedidoscodigo_cliente.AsString  := edtCodigoCliente.Text;
    MTPedidosvalor_total.AsFloat      := 0;
    MTPedidos.Post;
  end;

  if not(MTPedidosProdutos.State in dseditmodes) then
  begin
    MTPedidosProdutos.Insert;
  end;

  MTPedidosProdutosnumero_pedido.AsInteger := MTPedidosnumero_pedido.AsInteger;
  MTPedidosProdutoscodigo_produto.AsString := EdtCodigoProduto.Text;
  MTPedidosProdutosquantidade.AsFloat      := strtofloatdef(AnsiReplaceText(EdtQuantidade.Text, ',', '.'), 1);
  MTPedidosProdutosvalor_unitario.AsFloat  := strtofloatdef(AnsiReplaceText(EdtValorUnitario.Text, ',', '.'), 1);
  MTPedidosProdutosvalor_total.AsFloat     := strtofloatdef(AnsiReplaceText(EdtValorTotal.Text, ',', '.'), 1);
  MTPedidosProdutos.Post;

  MTPedidos.Edit;
  MTPedidosvalor_total.AsFloat := CalcularValorTotal();
  MTPedidos.Post;

  LimparCamposProdutoPedido();
end;

function TFormPedidosVenda.CalcularValorTotal(): Real;
var
  rValorTotal: Real;
begin
  rValorTotal := 0;
  if not(MTPedidosProdutos.IsEmpty) then
  begin
    MTPedidosProdutos.First;
    while not(MTPedidosProdutos.Eof) do
    begin
      rValorTotal := rValorTotal + MTPedidosProdutosvalor_total.AsFloat;
      MTPedidosProdutos.Next;
    end;
    MTPedidosProdutos.First;
  end;

  Result := rValorTotal;
end;

procedure TFormPedidosVenda.btnGravarPedidoClick(Sender: TObject);
begin
  if application.MessageBox('Confirma grava��o do pedido ?', 'Confirma', mb_yesno) <> mryes then
  begin
    exit;
  end;

  SalvarPedido();

  LimparCamposPedido();
end;

procedure TFormPedidosVenda.btnLocalizarPedidoClick(Sender: TObject);
var
  iNumeroPedido: Integer;
begin
  iNumeroPedido := strtointdef(inputbox('Informe o n�mero do pedido', 'N�mero do pedido', ''), -1);
  if not(CarregarDadosPedido(iNumeroPedido)) then
  begin
    application.messagebox('Pedido n�o encontrado !', 'Aten��o', mb_ok+mb_iconinformation);
    Exit;
  end;
end;

procedure TFormPedidosVenda.btnDescartarAlteracoesClick(Sender: TObject);
begin
//  if application.MessageBox('Descartar altera��es do pedido ?', 'Confirma', mb_yesno) <> mryes then
//  begin
//    exit;
//  end;

  MTPedidos.EmptyDataSet;
  MTPedidosProdutos.EmptyDataSet;

  LimparCamposPedido();
end;

function TFormPedidosVenda.CarregarDadosPedido(pnumero_pedido: Integer): boolean;
begin
  //Carregando dados do pedido
  QueryAux.Close;
  QueryAux.SQL.Clear;
  QueryAux.SQL.Add('select * from dbwktech.pedidos');
  QueryAux.SQL.Add(' where numero_pedido = ' + floattostr(pnumero_pedido));
  QueryAux.Open;
  if (QueryAux.IsEmpty) then
  begin
    Result := False;
    Exit;
  end
  else
  begin
    Result := True;
    MTPedidos.EmptyDataSet;
    MTPedidos.Insert;
    MTPedidosnumero_pedido.Value  := QueryAux.fieldbyname('numero_pedido').Value;
    MTPedidosdata_emissao.Value   := QueryAux.fieldbyname('data_emissao').Value;
    MTPedidoscodigo_cliente.Value := QueryAux.fieldbyname('codigo_cliente').Value;
    MTPedidosvalor_total.Value    := QueryAux.fieldbyname('valor_total').Value;
    MTPedidos.Post;

    EdtCodigoCliente.Text      := MTPedidoscodigo_cliente.asstring;
    edtNumeroPedido.Text       := MTPedidosnumero_pedido.AsString;
    edtDataEmissao.DateTime    := MTPedidosdata_emissao.AsDateTime;
    dblookupcombobox2.KeyValue := MTPedidoscodigo_cliente.AsInteger;
  end;

  //Carregando dados dos Itens do Pedido
  QueryAux.Close;
  QPedidosProdutos.Close;
  QPedidosProdutos.ParamByName('numero_pedido').AsFloat := pnumero_pedido;
  QPedidosProdutos.Active := True;
  if (QPedidosProdutos.IsEmpty) then
  begin
    //Result := False;
  end
  else
  begin
    Result := True;
    MTPedidosProdutos.EmptyDataSet;
    QPedidosProdutos.First;
    while not(QPedidosProdutos.Eof) do
    begin
      MTPedidosProdutos.Insert;
      MTPedidosProdutosID.value             := QPedidosProdutosID.Value;
      MTPedidosProdutosnumero_pedido.Value  := QPedidosProdutosnumero_pedido.Value;
      MTPedidosProdutoscodigo_produto.Value := QPedidosProdutoscodigo_produto.Value;
      MTPedidosProdutosquantidade.Value     := QPedidosProdutosquantidade.Value;
      MTPedidosProdutosvalor_unitario.Value := QPedidosProdutosvalor_unitario.Value;
      MTPedidosProdutosvalor_total.Value    := QPedidosProdutosvalor_total.Value;
      MTPedidosProdutos.Post;

      QPedidosProdutos.Next;
    end;
  end;

  QPedidosProdutos.Close;
end;

procedure TFormPedidosVenda.SalvarPedido();
var
  oPedidosDTO: TPedidosDTO;
  oPedidosProdutosDTO: TPedidosProdutosDTO;
  aPedidosProdutos: ArrayOfPedidosProdutosDTO;
  iContProd: Integer;
begin
  try
    oPedidosDTO         := TPedidosDTO.Create;
    oPedidosProdutosDTO := TPedidosProdutosDTO.Create;

    if (mtPedidos.IsEmpty) then
    begin
      mtPedidos.Insert;
    end
    else
    begin
      mtPedidos.Edit;
    end;

    MTPedidosnumero_pedido.AsInteger  := strtointdef(EdtNumeroPedido.Text, 0);
    MTPedidosdata_emissao.AsDateTime  := edtDataEmissao.DateTime;
    MTPedidoscodigo_cliente.AsString  := edtCodigoCliente.Text;
    MTPedidosvalor_total.AsFloat      := CalcularValorTotal();
    MTPedidos.Post;

    oPedidosDTO.numero_pedido  := MTPedidosnumero_pedido.Value;
    oPedidosDTO.data_emmissao  := MTPedidosdata_emissao.Value;
    oPedidosDTO.codigo_cliente := MTPedidoscodigo_cliente.Value;
    oPedidosDTO.valor_total    := MTPedidosvalor_total.Value;

    if not(MTPedidosProdutos.IsEmpty) then
    begin
      SetLength(aPedidosProdutos, MTPedidosProdutos.RecordCount);
      MTPedidosProdutos.First;
      iContProd := 0;
      while not(MTPedidosProdutos.Eof) do
      begin
        aPedidosProdutos[iContProd] := TPedidosProdutosDTO.Create;
        aPedidosProdutos[iContProd].numero_pedido  := MTPedidosProdutosnumero_pedido.Value;
        aPedidosProdutos[iContProd].codigo_produto := MTPedidosProdutoscodigo_produto.Value;
        aPedidosProdutos[iContProd].quantidade     := MTPedidosProdutosquantidade.Value;
        aPedidosProdutos[iContProd].valor_unitario := MTPedidosProdutosvalor_unitario.Value;
        aPedidosProdutos[iContProd].valor_total    := MTPedidosProdutosvalor_total.Value;

        inc(iContProd);
        MTPedidosProdutos.Next;
      end;
    end;

    if (length(aPedidosProdutos) > 0) then
    begin
      oPedidosDTO.PedidosProdutos := aPedidosProdutos;
    end;

    //Acionando Controller para Persistir informa��es no banco de dados.
    TControllerPedidosVenda.New(FDConnection1).SalvarPedido(oPedidosDTO);
  finally
    if Assigned(oPedidosProdutosDTO) then
    begin
      freeandnil(oPedidosProdutosDTO);
    end;

    if Assigned(oPedidosDTO) then
    begin
      freeandnil(oPedidosDTO);
    end;
  end;
end;

procedure TFormPedidosVenda.LimparCamposPedido();
begin
  EdtCodigoCliente.Text      := EmptyStr;
  EdtNumeroPedido.Text       := EmptyStr;
  dbLookupComboBox2.KeyValue := -1;

  EdtCodigoProduto.Text := EmptyStr;
  dbLookupComboBox1.KeyValue := -1;
  EdtQuantidade.Text         := EmptyStr;
  EdtValorUnitario.Text      := EmptyStr;
  EdtValorTotal.Text         := EmptyStr;

  MTPedidosProdutos.EmptyDataSet;
  MTPedidos.EmptyDataSet;
end;

procedure TFormPedidosVenda.LimparCamposProdutoPedido();
begin
  EdtCodigoProduto.Text := EmptyStr;
  dbLookupComboBox1.KeyValue := -1;
  EdtQuantidade.Text         := EmptyStr;
  EdtValorUnitario.Text      := EmptyStr;
  EdtValorTotal.Text         := EmptyStr;
end;

procedure TFormPedidosVenda.DBGridPedProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 46) then //Delete
  begin
    if (MTPedidosProdutosID.Isnull) then
    begin
      application.MessageBox('Grave o pedido primeiro !', 'Aviso', mb_ok+mb_iconinformation);
      Exit;
    end;

    if application.MessageBox('Deseja excluir este item do pedido ?', 'Excluir', mb_yesno+mb_iconquestion) = mryes then
    begin
      try
        FDConnection1.StartTransaction;
        QueryAux.Close;
        QueryAux.SQL.Clear;
        QueryAux.SQL.Add('delete from pedidos_produtos');
        QueryAux.SQL.Add(' where ID = ');
        QueryAux.SQL.Add(MTPedidosProdutosID.AsString);
        QueryAux.ExecSQL;
        QueryAux.Close;
      except
        on E: Exception do
        begin
          FConexao.Rollback;
          showmessage(format('Falha ao excluir item pedido !%s%s', [#13, E.Message]));
          Exit;
        end;
      end;

      MTPedidosProdutos.Delete;
      FDConnection1.Commit;
    end;
  end;
end;

procedure TFormPedidosVenda.DBGridPedProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13) then
  begin
    key := #0;
    EdtCodigoProduto.Text      := MTPedidosProdutoscodigo_produto.AsString;
    dbLookupComboBox1.KeyValue := MTPedidosProdutoscodigo_produto.Value;
    EdtQuantidade.Text         := MTPedidosProdutosquantidade.AsString;
    EdtValorUnitario.Text      := MTPedidosProdutosvalor_unitario.AsString;
    EdtValorTotal.Text         := MTPedidosProdutosvalor_total.AsString;
    MTPedidosProdutos.Edit;
    if (EdtQuantidade.CanFocus) then
    begin
      EdtQuantidade.SetFocus;
    end;
  end;
end;

procedure TFormPedidosVenda.DBLookupComboBox1CloseUp(Sender: TObject);
begin
  if (DBLookupComboBox1.KeyValue <> -1) then
  begin
    EdtCodigoProduto.text := floattostr(DBLookupComboBox1.KeyValue);
  end;
end;

procedure TFormPedidosVenda.DBLookupComboBox2CloseUp(Sender: TObject);
begin
  if (DBLookupComboBox2.KeyValue <> -1) then
  begin
    EdtCodigoCliente.text := floattostr(DBLookupComboBox2.KeyValue);
  end;
end;

procedure TFormPedidosVenda.EdtCodigoClienteChange(Sender: TObject);
begin
  btnLocalizarPedido.Visible := (EdtCodigoCliente.text = EmptyStr) or (EdtCodigoCliente.text = '0');
  btnCancelarPedido.Visible  := btnLocalizarPedido.Visible;

  DBLookupComboBox2.KeyValue := strtointdef(EdtCodigoCliente.text, -1);
end;

procedure TFormPedidosVenda.EdtCodigoClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13)  then
  begin
    key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TFormPedidosVenda.EdtCodigoProdutoChange(Sender: TObject);
begin
  DBLookupComboBox1.KeyValue := strtointdef(EdtCodigoProduto.text, -1);
  if (edtvalorunitario.Text = EmptyStr) then
  begin
    edtvalorunitario.Text := QProdutosPreco_Venda.AsString;
  end;
end;

procedure TFormPedidosVenda.EdtValorUnitarioChange(Sender: TObject);
begin
  edtValorTotal.Text := floattostr(strtofloatdef(AnsiReplaceText(EdtQuantidade.Text, ',', '.'), 1) * strtofloatdef(AnsiReplaceText(EdtValorUnitario.Text, ',', '.'), 1));
end;
procedure TFormPedidosVenda.EdtValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13)  then
  begin
    key := #0;
    //Perform(Wm_NextDlgCtl,0,0);
    if (btnConfirmaritem.CanFocus) then
    begin
      btnConfirmarItem.SetFocus;
    end;
  end;

end;

procedure TFormPedidosVenda.FormCreate(Sender: TObject);
var
  sArqIni: String;
begin
  bDbPronto := True;
  sArqINI := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'TesteWKAlexandre.ini';
  if not(FileExists(sArqIni)) then
  begin
    Application.MessageBox('Arquivo INI para acessar banco de dados, n�o foi encontrado.', 'Aten��o', mb_ok+mb_iconwarning);
    bDbPronto := False;
  end
  else
  begin
    FDConnection1.Params.LoadFromFile(sArqINI);
    try
      FDConnection1.Connected := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(pchar(format('Falha ao acessar banco de dados !%s%s', [#13, E.Message])), 'Aten��o', mb_ok+mb_iconwarning);
        bDbPronto := False;
      end;
    end;
  end;
end;

procedure TFormPedidosVenda.FormShow(Sender: TObject);
begin
  if not(FDConnection1.Connected) or not(bDbPronto) then
  begin
    Application.MessageBox('N�o foi poss�vel conectar-se ao banco de dados !', 'Aten��o', mb_ok+mb_iconwarning);
    bDbPronto := False;
  end;

  if not(bDbPronto) then
  begin
    TimerCheckDB.Enabled := True;
  end
  else
  begin
     QClientes.Active := True;
     QProdutos.Active := True;

     MTPedidos.Active := True;
     MTPedidos.EmptyDataSet;
     MTPedidosProdutos.Active := True;
     MTPedidosProdutos.EmptyDataSet;
  end;
end;

procedure TFormPedidosVenda.MTPedidosProdutosAfterDelete(DataSet: TDataSet);
begin
  MTPedidos.Edit;
  MTPedidosvalor_total.AsFloat := CalcularValorTotal();
  MTPedidos.Post;
end;

procedure TFormPedidosVenda.MTPedidosProdutosCalcFields(DataSet: TDataSet);
begin
  MTPedidosProdutosdescricao_produto.AsString := EmptyStr;

  if not(MTPedidosProdutoscodigo_produto.IsNull) then
  begin
    QueryAux.Close;
    QueryAux.SQL.Clear;
    QueryAux.SQL.Add('select descricao from dbwktech.produtos');
    QueryAux.SQL.Add(' where codigo = ' + MTPedidosProdutoscodigo_produto.AsString);
    QueryAux.Open;
    if (QueryAux.IsEmpty) or
        (QueryAux.FieldByName('descricao').IsNull) then
    begin
      MTPedidosProdutosdescricao_produto.AsString := EmptyStr;
    end
    else
    begin
      MTPedidosProdutosdescricao_produto.AsString := QueryAux.FieldByName('descricao').AsString;
    end;
    QueryAux.Close;
  end;
end;

procedure TFormPedidosVenda.TimerCheckDBTimer(Sender: TObject);
begin
  if not(bDbPronto) then
  begin
    FormPedidosVenda.Close;
    Application.Terminate;
  end;

  TimerCheckDB.Enabled := False;
end;

end.
