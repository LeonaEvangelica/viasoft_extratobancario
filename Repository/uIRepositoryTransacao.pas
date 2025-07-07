unit uIRepositoryTransacao;

interface

uses
  uModelTransacao,
  System.Generics.Collections;

type
  IRepositoryTransacao = interface
    ['{D3A77891-BF3A-4F42-83F6-FA4BE7D8337A}']
    procedure Adicionar(ATransacao: TModelTransacao);
    procedure Editar(ATransacao: TModelTransacao);
    procedure Remover(Id: Integer);
    function Listar: TObjectList<TModelTransacao>;
    function ObterPorId(Id: Integer): TModelTransacao;
  end;

implementation

end.
