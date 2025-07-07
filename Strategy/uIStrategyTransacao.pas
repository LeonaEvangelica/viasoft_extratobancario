unit uIStrategyTransacao;

interface

type
  IStrategyTransacao = interface
    ['{85ED35F3-4A60-4F60-8C91-6F4CC4701AC6}']
    function CalcularSaldo(SaldoAtual, Valor: Currency): Currency;
  end;

implementation

end.

