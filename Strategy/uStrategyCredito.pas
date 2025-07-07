unit uStrategyCredito;

interface

uses
  uIStrategyTransacao;

type
  TStrategyCredito = class(TInterfacedObject, IStrategyTransacao)
    function CalcularSaldo(ASaldoAtual, AValor: Currency): Currency;
  end;

implementation

function TStrategyCredito.CalcularSaldo(ASaldoAtual, AValor: Currency): Currency;
begin
  Result := ASaldoAtual + AValor;
end;

end.

