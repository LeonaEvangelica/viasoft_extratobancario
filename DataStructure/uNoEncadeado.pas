unit uNoEncadeado;

interface

type
  TNoEncadeado<T> = class
  private
    FValor: T;
    FProximo: TNoEncadeado<T>;
  public
    constructor Create(AValor: T);
    property Valor: T read FValor write FValor;
    property Proximo: TNoEncadeado<T> read FProximo write FProximo;
  end;

implementation

{ TNoEncadeado<T> }

constructor TNoEncadeado<T>.Create(AValor: T);
begin
  FValor := AValor;
  FProximo := nil;
end;

end.

