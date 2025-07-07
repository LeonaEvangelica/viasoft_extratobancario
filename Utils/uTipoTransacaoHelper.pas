unit uTipoTransacaoHelper;

interface

type
  TTipoTransacao = (ttCredito, ttDebito);

type
  TTipoTransacaoHelper = record helper for TTipoTransacao
    function ToStr: string;
  end;

function TipoToChar(Tipo: TTipoTransacao): Char;
function CharToTipo(const C: Char): TTipoTransacao;

implementation

uses
  System.SysUtils;

function TipoToChar(Tipo: TTipoTransacao): Char;
begin
  case Tipo of
    ttCredito: Result := 'C';
    ttDebito:  Result := 'D';
  else
    raise Exception.Create('Tipo de transação inválido.');
  end;
end;

function CharToTipo(const C: Char): TTipoTransacao;
begin
  case UpCase(C) of
    'C': Result := ttCredito;
    'D': Result := ttDebito;
  else
    raise Exception.CreateFmt('Tipo de transação desconhecido: %s', [C]);
  end;
end;

{ TTipoTransacaoHelper }

function TTipoTransacaoHelper.ToStr: string;
begin
  case Self of
    ttCredito: Result := 'Crédito';
    ttDebito:  Result := 'Débito';
  else
    Result := 'Desconhecido';
  end;
end;

end.
