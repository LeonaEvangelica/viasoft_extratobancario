unit uListaEncadeada;

interface

uses
  uNoEncadeado,
  System.Generics.Collections,
  System.SysUtils;

type
  TListaEncadeada<T> = class
  private
    FCabeca: TNoEncadeado<T>;
    FCauda: TNoEncadeado<T>;
    FCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Adicionar(AValor: T);
    function Remover(AValor: T): Boolean;
    function Buscar(ACondicao: TFunc<T, Boolean>): T;
    function Listar: TArray<T>;
    property Count: Integer read FCount;
  end;

implementation

{ TListaEncadeada<T> }

constructor TListaEncadeada<T>.Create;
begin
  FCabeca := nil;
  FCauda := nil;
  FCount := 0;
end;

destructor TListaEncadeada<T>.Destroy;
var
  Atual, Proximo: TNoEncadeado<T>;
begin
  Atual := FCabeca;
  while Atual <> nil do
  begin
    Proximo := Atual.Proximo;
    Atual.Free;
    Atual := Proximo;
  end;
  inherited;
end;

procedure TListaEncadeada<T>.Adicionar(AValor: T);
var
  NovoNo: TNoEncadeado<T>;
begin
  NovoNo := TNoEncadeado<T>.Create(AValor);

  if FCabeca = nil then
  begin
    FCabeca := NovoNo;
    FCauda := NovoNo;
  end
  else
  begin
    FCauda.Proximo := NovoNo;
    FCauda := NovoNo;
  end;

  Inc(FCount);
end;

function TListaEncadeada<T>.Remover(AValor: T): Boolean;
var
  Atual, Anterior: TNoEncadeado<T>;
begin
  Result := False;
  Atual := FCabeca;
  Anterior := nil;

  while Atual <> nil do
  begin
    if Atual.Valor = AValor then
    begin
      if Anterior = nil then
        FCabeca := Atual.Proximo
      else
        Anterior.Proximo := Atual.Proximo;

      if Atual = FCauda then
        FCauda := Anterior;

      Atual.Free;
      Dec(FCount);
      Exit(True);
    end;

    Anterior := Atual;
    Atual := Atual.Proximo;
  end;
end;

function TListaEncadeada<T>.Buscar(ACondicao: TFunc<T, Boolean>): T;
var
  Atual: TNoEncadeado<T>;
begin
  Result := Default(T);
  Atual := FCabeca;

  while Atual <> nil do
  begin
    if ACondicao(Atual.Valor) then
      Exit(Atual.Valor);

    Atual := Atual.Proximo;
  end;
end;

function TListaEncadeada<T>.Listar: TArray<T>;
var
  Atual: TNoEncadeado<T>;
  Lista: TList<T>;
begin
  Lista := TList<T>.Create;
  try
    Atual := FCabeca;
    while Atual <> nil do
    begin
      Lista.Add(Atual.Valor);
      Atual := Atual.Proximo;
    end;
    Result := Lista.ToArray;
  finally
    Lista.Free;
  end;
end;

end.

