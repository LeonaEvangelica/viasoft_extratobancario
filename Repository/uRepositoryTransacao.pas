unit uRepositoryTransacao;

interface

uses
  uIRepositoryTransacao,
  uModelTransacao,
  System.Generics.Collections,
  uListaEncadeada,
  uNoEncadeado,
  FireDAC.Comp.Client;

type
  TTransacaoRepository = class(TInterfacedObject, IRepositoryTransacao)
  private
    FConnection: TFDConnection;
    FLista: TListaEncadeada<TModelTransacao>;

    function ListarDoBanco: TArray<TModelTransacao>;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    procedure Adicionar(ATransacao: TModelTransacao);
    procedure Editar(ATransacao: TModelTransacao);
    procedure Remover(AId: Integer);
    function Listar: TObjectList<TModelTransacao>;
    function ObterPorId(AId: Integer): TModelTransacao;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Param,
  uTipoTransacaoHelper;

{ TTransacaoRepository }

procedure TTransacaoRepository.Adicionar(ATransacao: TModelTransacao);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text :=
      'INSERT INTO TRANSACAO (DATATRANSACAO, NOMEORIGEM, NOMEDESTINO, DESCRICAO, VALOR, TIPO, SALDO) ' +
      'VALUES (:DATA, :ORIGEM, :DESTINO, :DESCRICAO, :VALOR, :TIPO, :SALDO)';
    Q.ParamByName('DATA').AsDate := ATransacao.DataTransacao;
    Q.ParamByName('ORIGEM').AsString := ATransacao.NomeOrigem;
    Q.ParamByName('DESTINO').AsString := ATransacao.NomeDestino;
    Q.ParamByName('DESCRICAO').AsString := ATransacao.Descricao;
    Q.ParamByName('VALOR').AsCurrency := ATransacao.Valor;
    Q.ParamByName('TIPO').AsString := TipoToChar(ATransacao.Tipo);
    Q.ParamByName('SALDO').AsCurrency := ATransacao.Saldo;
    Q.ExecSQL;
  finally
    Q.Free;
  end;

  FLista.Adicionar(ATransacao);
end;

constructor TTransacaoRepository.Create(AConnection: TFDConnection);
var
  transacoes: TArray<TModelTransacao>;
  t: TModelTransacao;
begin
  FConnection := AConnection;
  FLista := TListaEncadeada<TModelTransacao>.Create;

  transacoes := ListarDoBanco;
  for t in transacoes do
    FLista.Adicionar(t);
end;

destructor TTransacaoRepository.Destroy;
begin
  FLista.Free;
  inherited;
end;

procedure TTransacaoRepository.Editar(ATransacao: TModelTransacao);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text :=
      'UPDATE TRANSACAO SET ' +
        'DATATRANSACAO = :DATA,  ' +
        'NOMEORIGEM = :ORIGEM, ' +
        'NOMEDESTINO = :DESTINO, ' +
        'DESCRICAO = :DESCRICAO, ' +
        'VALOR = :VALOR, ' +
        'TIPO = :TIPO, ' +
        'SALDO = :SALDO ' +
      'WHERE ID = :ID';

    Q.ParamByName('ID').AsInteger := ATransacao.Id;
    Q.ParamByName('DATA').AsDate := ATransacao.DataTransacao;
    Q.ParamByName('ORIGEM').AsString := ATransacao.NomeOrigem;
    Q.ParamByName('DESTINO').AsString := ATransacao.NomeDestino;
    Q.ParamByName('DESCRICAO').AsString := ATransacao.Descricao;
    Q.ParamByName('VALOR').AsCurrency := ATransacao.Valor;
    Q.ParamByName('TIPO').AsString := TipoToChar(ATransacao.Tipo);
    Q.ParamByName('SALDO').AsCurrency := ATransacao.Saldo;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

function TTransacaoRepository.Listar: TObjectList<TModelTransacao>;
var
  TempList: TObjectList<TModelTransacao>;
  Arr: TArray<TModelTransacao>;
  T: TModelTransacao;
begin
  TempList := TObjectList<TModelTransacao>.Create(True);
  Arr := FLista.Listar;
  for T in Arr do
    TempList.Add(T);
  Result := TempList;
end;

function TTransacaoRepository.ListarDoBanco: TArray<TModelTransacao>;
var
  Q: TFDQuery;
  Lista: TObjectList<TModelTransacao>;
  T: TModelTransacao;
begin
  Lista := TObjectList<TModelTransacao>.Create(True);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'SELECT * FROM TRANSACAO ORDER BY DATATRANSACAO';
    Q.Open;

    while not Q.Eof do
    begin
      T := TModelTransacao.Create;
      T.Id := Q.FieldByName('ID').AsInteger;
      T.DataTransacao := Q.FieldByName('DATATRANSACAO').AsDateTime;
      T.NomeOrigem := Q.FieldByName('NOMEORIGEM').AsString;
      T.NomeDestino := Q.FieldByName('NOMEDESTINO').AsString;
      T.Descricao := Q.FieldByName('DESCRICAO').AsString;
      T.Valor := Q.FieldByName('VALOR').AsCurrency;
      T.Tipo := CharToTipo(Q.FieldByName('TIPO').AsString[1]);
      T.Saldo := Q.FieldByName('SALDO').AsCurrency;
      Lista.Add(T);
      Q.Next;
    end;
    Result := Lista.ToArray;
  finally
    Q.Free;
    Lista.Free;
  end;
end;

function TTransacaoRepository.ObterPorId(AId: Integer): TModelTransacao;
var
  Transacao: TModelTransacao;
begin
  Result := FLista.Buscar(
    function(T: TModelTransacao): Boolean
    begin
      Result := T.Id = AId;
    end
  );
end;

procedure TTransacaoRepository.Remover(AId: Integer);
var
  Q: TFDQuery;
  T: TModelTransacao;
begin
  T := ObterPorId(AId);
  if T <> nil then
    FLista.Remover(T);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'DELETE FROM TRANSACAO WHERE ID = :ID';
    Q.ParamByName('ID').AsInteger := AId;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

end.
