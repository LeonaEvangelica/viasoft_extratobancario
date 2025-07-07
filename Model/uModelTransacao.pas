unit uModelTransacao;

interface

uses
  uTipoTransacaoHelper;

type

  TModelTransacao = class
  private
    FId: Integer;
    FDataTransacao: TDateTime;
    FNomeOrigem: string;
    FNomeDestino: string;
    FDescricao: string;
    FValor: Currency;
    FTipo: TTipoTransacao;
    FSaldo: Currency;
  public
    property Id: Integer read FId write FId;
    property DataTransacao: TDateTime read FDataTransacao write FDataTransacao;
    property NomeOrigem: string read FNomeOrigem write FNomeOrigem;
    property NomeDestino: string read FNomeDestino write FNomeDestino;
    property Descricao: string read FDescricao write FDescricao;
    property Valor: Currency read FValor write FValor;
    property Tipo: TTipoTransacao read FTipo write FTipo;
    property Saldo: Currency read FSaldo write FSaldo;
  end;

implementation

end.

