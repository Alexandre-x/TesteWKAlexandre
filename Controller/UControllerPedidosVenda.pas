unit UControllerPedidosVenda;

interface

uses UModelPedidosVenda,
     Classes, System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
     Data.DB, FireDAC.Comp.Client;

Type
   TControllerPedidosVenda = class
   private
   { private declarations }

   published
   { published declarations }
   function SalvarPedido(pConexao: TFDConnection; pPedidosDTO: TPedidosDto): Boolean;

   end;

   var
    FConexao: TFDConnection;

implementation

function TControllerPedidosVenda.SalvarPedido(pConexao: TFDConnection; pPedidosDTO: TPedidosDto): Boolean;
begin
   FConexao := pConexao;
   TModelPedidosVenda.New(FConexao).SalvarPedido(pPedidosDTO);
end;

end.

