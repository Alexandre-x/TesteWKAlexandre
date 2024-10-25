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
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, INIFiles;

type
  TFormPedidosVenda = class(TForm)
    FDConnection1: TFDConnection;
    QClientes: TFDQuery;
    Panel1: TPanel;
    btnLocalizarPed: TButton;
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
    btnCancelarPed: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerCheckDBTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bDbPronto: Boolean;
  end;

var
  FormPedidosVenda: TFormPedidosVenda;

implementation

{$R *.dfm}

Uses UControllerPedidosVenda, UModelPedidosVenda;


procedure TFormPedidosVenda.FormCreate(Sender: TObject);
var
  sArqIni: String;
begin
  bDbPronto := True;
  sArqINI := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'TesteWKAlexandre.ini';
  if not(FileExists(sArqIni)) then
  begin
    Application.MessageBox('Arquivo INI para acessar banco de dados, não foi encontrado.', 'Atenção', mb_ok+mb_iconwarning);
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
        Application.MessageBox(pchar(format('Falha ao acessar banco de dados !%s%s', [#13, E.Message])), 'Atenção', mb_ok+mb_iconwarning);
        bDbPronto := False;
      end;
    end;
  end;
end;

procedure TFormPedidosVenda.FormShow(Sender: TObject);
begin
  if not(FDConnection1.Connected) or not(bDbPronto) then
  begin
    Application.MessageBox('Não foi possível conectar-se ao banco de dados !', 'Atenção', mb_ok+mb_iconwarning);
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
