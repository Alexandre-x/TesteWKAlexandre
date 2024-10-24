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
begin
  showmessage('Salvando Pedido...');
end;

end.
