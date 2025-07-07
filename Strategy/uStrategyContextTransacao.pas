unit uStrategyContextTransacao;

interface

uses
  uModelTransacao,
  uIStrategyTransacao,
  uTipoTransacaoHelper,
  System.SysUtils;

type
  TStrategyContextTransacao = class
    class function ObterStrategy(Tipo: TTipoTransacao): IStrategyTransacao;
  end;

implementation

uses
  uStrategyCredito,
  uStrategyDebito;

class function TStrategyContextTransacao.ObterStrategy(Tipo: TTipoTransacao): IStrategyTransacao;
begin
  case Tipo of
    ttCredito: Result := TStrategyCredito.Create;
    ttDebito: Result := TStrategyDebito.Create;
  else
    raise Exception.Create('Tipo de transação inválido.');
  end;
end;

end.

