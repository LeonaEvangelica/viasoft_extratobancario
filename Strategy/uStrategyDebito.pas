unit uStrategyDebito;

interface

uses
  uIStrategyTransacao,
  System.SysUtils;

type
  TStrategyDebito = class(TInterfacedObject, IStrategyTransacao)
    function CalcularSaldo(ASaldoAtual, AValor: Currency): Currency;
  end;

implementation

function TStrategyDebito.CalcularSaldo(ASaldoAtual, AValor: Currency): Currency;
begin
  if AValor > ASaldoAtual then
    raise Exception.Create('Saldo insuficiente para débito.');

  Result := ASaldoAtual - AValor;
end;

end.

