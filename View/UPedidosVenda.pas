unit UPedidosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormPedidosVenda = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Panel1: TPanel;
    btnConfirmar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPedidosVenda: TFormPedidosVenda;

implementation

{$R *.dfm}

end.
