program TesteWKAlexandre;

uses
  Vcl.Forms,
  UPedidosVenda in 'View\UPedidosVenda.pas' {FormPedidosVenda},
  UControllerPedidosVenda in 'Controller\UControllerPedidosVenda.pas',
  UModelPedidosVenda in 'Model\UModelPedidosVenda.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPedidosVenda, FormPedidosVenda);
  Application.Run;
end.
