unit UControllerPedidosVenda;

interface

uses UModelPedidosVenda,
     Classes, System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
     Data.DB, FireDAC.Comp.Client;

Type
   IControllerPedidosVenda = interface

     function SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
   end;

   TControllerPedidosVenda = class(TInterfacedObject, IControllerPedidosVenda)
   private

   public
     class function New(pConexao: TFDConnection):IControllerPedidosVenda;
     function SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
   end;

   var
    FConexao: TFDConnection;

implementation

class function TControllerPedidosVenda.New(pConexao: TFDConnection):IModelPedidosVenda;
begin
  FConexao := pConexao;
  Result := Self.Create;
end;

function TControllerPedidosVenda.SalvarPedido(pPedidosDTO: TPedidosDto): Boolean;
begin
   TModelPedidosVenda.New(FConexao).SalvarPedido(pPedidosDTO);
end;

end.

