unit uServiceTransacao;

interface

uses
  uModelTransacao,
  uIRepositoryTransacao,
  uTipoTransacaoHelper,
  uStrategyContextTransacao,
  uIStrategyTransacao;

type
  TServiceTransacao = class
  private
    FRepository: IRepositoryTransacao;
    function CalcularSaldoPara(ATransacao: TModelTransacao): Currency;

    procedure ValidarTransacao(ATransacao: TModelTransacao);
  public
    constructor Create(ARepository: IRepositoryTransacao);

    procedure Adicionar(ATransacao: TModelTransacao);
    procedure Editar(ATransacao: TModelTransacao);
    procedure Remover(AId: Integer);
    function Listar: TArray<TModelTransacao>;
    function ObterPorId(AId: Integer): TModelTransacao;
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections;

{ TServiceTransacao }

procedure TServiceTransacao.Adicionar(ATransacao: TModelTransacao);
begin
  ValidarTransacao(ATransacao);
  ATransacao.Saldo := CalcularSaldoPara(ATransacao);
  FRepository.Adicionar(ATransacao);
end;

function TServiceTransacao.CalcularSaldoPara(
  ATransacao: TModelTransacao): Currency;
var
  Lista: TArray<TModelTransacao>;
  Ultima: TModelTransacao;
  Context: IStrategyTransacao;
begin
  Lista := FRepository.Listar.ToArray;
  if Length(Lista) = 0 then
    Result := 0
  else
  begin
    Ultima := Lista[High(Lista)];

    // Obtém a strategy baseada no tipo (sem criar context instance)
    try
      Context := TStrategyContextTransacao.ObterStrategy(ATransacao.Tipo);
      Result := Context.CalcularSaldo(Ultima.Saldo, ATransacao.Valor);
    except
      raise Exception.Create('Tipo de transação inválido.');
    end;
  end;
end;

constructor TServiceTransacao.Create(ARepository: IRepositoryTransacao);
begin
  FRepository := ARepository;
end;

procedure TServiceTransacao.Editar(ATransacao: TModelTransacao);
var
  Original: TModelTransacao;
begin
  // Recupera transação existente para impedir alteração de Valor ou Tipo
  Original := FRepository.ObterPorId(ATransacao.Id);

  if Original = nil then
    raise Exception.Create('Transação não encontrada.');

  // Garante que tipo e valor não sejam alterados
  ATransacao.Valor := Original.Valor;
  ATransacao.Tipo := Original.Tipo;
  ATransacao.Saldo := Original.Saldo;

  ValidarTransacao(ATransacao);

  FRepository.Editar(ATransacao);
end;

function TServiceTransacao.Listar: TArray<TModelTransacao>;
var
  Lista: TObjectList<TModelTransacao>;
begin
  Lista := FRepository.Listar;
  Result := Lista.ToArray;
end;

function TServiceTransacao.ObterPorId(AId: Integer): TModelTransacao;
begin
  Result := FRepository.ObterPorId(AId);
end;

procedure TServiceTransacao.Remover(AId: Integer);
begin
  FRepository.Remover(AId);
end;


procedure TServiceTransacao.ValidarTransacao(ATransacao: TModelTransacao);
begin
  if ATransacao = nil then
    raise Exception.Create('Transação inválida.');

  if ATransacao.Valor <= 0 then
    raise Exception.Create('O valor da transação deve ser maior que zero.');

  if ATransacao.NomeOrigem.Trim = '' then
    raise Exception.Create('O nome do cliente de origem é obrigatório.');

  if ATransacao.NomeDestino.Trim = '' then
    raise Exception.Create('O nome do cliente de destino é obrigatório.');

  if not (ATransacao.Tipo in [ttCredito, ttDebito]) then
    raise Exception.Create('Tipo de transação inválido.');
end;

end.

