unit UModelPedidosVenda;

interface

uses Classes, System.SysUtils, Dialogs,
     FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
     Data.DB, FireDAC.Comp.Client;

Type
   TPedidosProdutosDTO = class
   private
   { private declarations }
    FID: Integer;
    Fnumero_pedido: Integer;
    Fcodigo_produto: Integer;
    Fquantidade: Double;
    Fvalor_unitario: Currency;
    Fvalor_total: Currency;
   published
   { published declarations }
    property ID: Integer              read FID write FID;
    property numero_pedido: Integer   read Fnumero_pedido  write Fnumero_pedido;
    property codigo_produto: Integer  read Fcodigo_produto write Fcodigo_produto;
    property quantidade: Double       read Fquantidade     write Fquantidade;
    property valor_unitario: Currency read Fvalor_unitario write Fvalor_unitario;
    property valor_total: Currency    read Fvalor_total    write Fvalor_total;
   end;
   ArrayOfPedidosProdutosDTO = array of TPedidosProdutosDTO;

   TPedidosDTO = class
   private
   { private declarations }
    Fnumero_pedido: Integer;
    Fdata_emissao: TDateTime;
    Fcodigo_cliente: Integer;
    Fvalor_total: Currency;
    FPedidosProdutos: ArrayOfPedidosProdutosDTO;

   published
   { published declarations }
    property numero_pedido:  integer   read Fnumero_pedido  write Fnumero_pedido;
    property data_emmissao:  TDateTime read Fdata_emissao   write Fdata_emissao;
    property codigo_cliente: Integer   read Fcodigo_cliente write Fcodigo_cliente;
    property valor_total:    Currency  read Fvalor_total    write Fvalor_total;
    property PedidosProdutos: ArrayOfPedidosProdutosDTO read FPedidosProdutos write FPedidosProdutos;
   end;

   IModelPedidosVenda = interface
   ['{C96E9F34-C614-47EE-8544-B49D719349A1}']
     function SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
   end;

   TModelPedidosVenda = class(TInterfacedObject, IModelPedidosVenda)
   private
     procedure InserirItemPedido(pPedidosDTO: TPedidosDto; pContProd: Integer);
     procedure AtualizarItemPedido(pPedidosDTO: TPedidosDto; pContProd: Integer);
   public
     class function New(pConexao: TFDConnection):IModelPedidosVenda;
     function SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
   end;

   var
    FConexao: TFDConnection;

implementation

class function TModelPedidosVenda.New(pConexao: TFDConnection):IModelPedidosVenda;
begin
  FConexao := pConexao;
  Result := Self.Create;
end;

function TModelPedidosVenda.SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
var
  QAux: TFDQuery;
  bExistePedido, bExisteItemPedido: Boolean;
  iContProd: Integer;
begin
  QAux := TFDQuery.Create(nil);
  QAux.Close;
  QAux.Connection := FConexao;
  QAux.SQL.Clear;
  QAux.SQL.Add('select numero_pedido from pedidos ');
  QAux.SQL.Add(' where numero_pedido = ' + floattostr(pPedidosDTO.numero_pedido));
  QAux.Active := True;
  if not(QAux.IsEmpty) and
     (QAux.FieldByName('numero_pedido').AsString <> EmptyStr) then
  begin
    bExistePedido := True;
  end
  else
  begin
    bExistePedido := False;
  end;

  if not(bExistePedido) then
  begin
    //Inserindo Pedido
    QAux.Close;
    QAux.Connection := FConexao;
    QAux.SQL.Clear;
    QAux.SQL.Add('insert into pedidos( ');
    QAux.SQL.Add('numero_pedido, ');
    QAux.SQL.Add('data_emissao, ');
    QAux.SQL.Add('codigo_cliente, ');
    QAux.SQL.Add('valor_total) ');
    QAux.SQL.Add('values(');
    QAux.SQL.Add(floattostr(pPedidosDTO.numero_pedido) + ', ');
    QAux.SQL.Add(QuotedStr(formatdatetime('yyyy/mm/dd', pPedidosDTO.data_emmissao)) + ', ');
    QAux.SQL.Add(floattostr(pPedidosDTO.codigo_cliente) + ', ');
    QAux.SQL.Add(floattostr(pPedidosDTO.valor_total) + ') ');
    try
      FConexao.StartTransaction;
      QAux.ExecSQL;
      FConexao.Commit;
      QAux.Close;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        showmessage(format('Falha ao salvar pedido !%s%s', [#13, E.Message]));
        Exit;
      end;
    end;

    //Inserindo os itens do pedido
    if (length(pPedidosDTO.PedidosProdutos) > 0) then
    begin
      for iContProd := 0 to length(pPedidosDTO.PedidosProdutos) - 1 do
      begin
        InserirItemPedido(pPedidosDTO, iContProd);
      end;
    end;
  end
  else
  begin
    //Atualizar Pedido
    QAux.Close;
    QAux.Connection := FConexao;
    QAux.SQL.Clear;
    QAux.SQL.Add('update pedidos ');
    QAux.SQL.Add('set  ');
    QAux.SQL.Add('data_emissao = ');
    QAux.SQL.Add(QuotedStr(formatdatetime('yyyy/mm/dd', pPedidosDTO.data_emmissao)) + ', ');
    QAux.SQL.Add('codigo_cliente = ');
    QAux.SQL.Add(floattostr(pPedidosDTO.codigo_cliente) + ', ');
    QAux.SQL.Add('valor_total = ');
    QAux.SQL.Add(floattostr(pPedidosDTO.valor_total));
    QAux.SQL.Add('where numero_pedido = ');
    QAux.SQL.Add(floattostr(pPedidosDTO.numero_pedido));
    try
      FConexao.StartTransaction;
      QAux.ExecSQL;
      FConexao.Commit;
      QAux.Close;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        showmessage(format('Falha ao salvar pedido !%s%s', [#13, E.Message]));
        Exit;
      end;
    end;

    //Inserir ou Atualizar Itens do Pedido
    if (length(pPedidosDTO.PedidosProdutos) > 0) then
    begin
      for iContProd := 0 to length(pPedidosDTO.PedidosProdutos) - 1 do
      begin
        QAux.Close;
        QAux.Connection := FConexao;
        QAux.SQL.Clear;
        QAux.SQL.Add('select numero_pedido from pedidos_produtos ');
        QAux.SQL.Add(' where numero_pedido = ' + floattostr(pPedidosDTO.PedidosProdutos[iContProd].numero_pedido));
        QAux.SQL.Add(' and codigo_produto = ' + floattostr(pPedidosDTO.PedidosProdutos[iContProd].codigo_produto));
        QAux.Active := True;
        if not(QAux.IsEmpty) and
           (QAux.FieldByName('numero_pedido').AsString <> EmptyStr) then
        begin
          bExisteItemPedido := True;
        end
        else
        begin
          bExisteItemPedido := False;
        end;
        QAux.Close;

        if not(bExisteItemPedido) then
        begin
          InserirItemPedido(pPedidosDTO, iContProd);
        end
        else
        begin
          AtualizarItemPedido(pPedidosDTO, iContProd);
        end;
      end;
    end;
  end;

  if Assigned(QAux) then
  begin
    QAux.Close;
    QAux.Free;
    QAux := nil;
  end;
end;

procedure TModelPedidosVenda.InserirItemPedido(pPedidosDTO: TPedidosDto; pContProd: Integer);
var
  QAux: TFDQuery;
begin
  QAux := TFDQuery.Create(nil);
  QAux.Close;
  QAux.Connection := FConexao;
  QAux.SQL.Clear;
  QAux.SQL.Add('insert into pedidos_produtos( ');
  QAux.SQL.Add('numero_pedido, ');
  QAux.SQL.Add('codigo_produto, ');
  QAux.SQL.Add('quantidade, ');
  QAux.SQL.Add('valor_unitario, ');
  QAux.SQL.Add('valor_total) ');
  QAux.SQL.Add('values(');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].numero_pedido) + ', ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].codigo_produto) + ', ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].quantidade) + ', ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].valor_unitario) + ', ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].valor_total) + ') ');
  try
    FConexao.StartTransaction;
    QAux.ExecSQL;
    FConexao.Commit;
    QAux.Close;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      showmessage(format('Falha ao inserir itens do pedido !%s%s', [#13, E.Message]));
      Exit;
    end;
  end;
end;

procedure TModelPedidosVenda.AtualizarItemPedido(pPedidosDTO: TPedidosDto; pContProd: Integer);
var
  QAux: TFDQuery;
begin
  QAux := TFDQuery.Create(nil);
  QAux.Close;
  QAux.Connection := FConexao;
  QAux.SQL.Clear;
  QAux.SQL.Add('update pedidos_produtos ');
  QAux.SQL.Add('set ');
  QAux.SQL.Add('numero_pedido = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].numero_pedido) + ', ');
  QAux.SQL.Add('codigo_produto = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].codigo_produto) + ', ');
  QAux.SQL.Add('quantidade = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].quantidade) + ', ');
  QAux.SQL.Add('valor_unitario = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].valor_unitario) + ', ');
  QAux.SQL.Add('valor_total = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].valor_total));
  QAux.SQL.Add(' where numero_pedido = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].numero_pedido));
  QAux.SQL.Add(' and codigo_produto = ');
  QAux.SQL.Add(floattostr(pPedidosDTO.PedidosProdutos[pContProd].codigo_produto));
  try
    FConexao.StartTransaction;
    QAux.ExecSQL;
    FConexao.Commit;
    QAux.Close;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      showmessage(format('Falha ao atualizar itens do pedido !%s%s', [#13, E.Message]));
      Exit;
    end;
  end;
end;

end.
