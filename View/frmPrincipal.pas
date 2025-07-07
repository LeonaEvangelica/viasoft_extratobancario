unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  uModelTransacao, uServiceTransacao, uRepositoryTransacao,
  System.Generics.Collections, uIRepositoryTransacao, Vcl.Mask, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls, uTipoTransacaoHelper;

type
  TformPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnSalvar: TButton;
    pnlCampos: TPanel;
    strGridTransacao: TStringGrid;
    lblDataTransacao: TLabel;
    edtClienteOrigem: TEdit;
    edtDataTransacao: TDateTimePicker;
    lblClienteOrigem: TLabel;
    lblClienteDestino: TLabel;
    edtClienteDestino: TEdit;
    lblDescricao: TLabel;
    edtDescricaoTransacao: TEdit;
    lblValor: TLabel;
    lblTipoTransacao: TLabel;
    lblSaldo: TLabel;
    lblDescSaldo: TLabel;
    edtValor: TMaskEdit;
    cbxTipoTransacao: TComboBox;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    FService: TServiceTransacao;
    FConnection: TFDConnection;
    FTransacaoEmEdicao: TModelTransacao;

    procedure CarregarComboTipo;
    procedure PreencherGrid;
    procedure LimparCampos;
    function TipoFromStr(const Texto: string): TTipoTransacao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPrincipal: TformPrincipal;

implementation

{$R *.dfm}

procedure TformPrincipal.btnAlterarClick(Sender: TObject);
var
  Lista: TArray<TModelTransacao>;
  Index: Integer;
begin
  Index := strGridTransacao.Row - 1;
  Lista := FService.Listar;

  if (Index < 0) or (Index >= Length(Lista)) then
  begin
    ShowMessage('Selecione uma transação para alterar.');
    Exit;
  end;

  FTransacaoEmEdicao := Lista[Index];
  pnlCampos.Enabled := True;

  edtDataTransacao.Date := FTransacaoEmEdicao.DataTransacao;
  edtClienteOrigem.Text := FTransacaoEmEdicao.NomeOrigem;
  edtClienteDestino.Text := FTransacaoEmEdicao.NomeDestino;
  edtDescricaoTransacao.Text := FTransacaoEmEdicao.Descricao;
  edtValor.Text := FormatFloat('0.00', FTransacaoEmEdicao.Valor);
  cbxTipoTransacao.Text := FTransacaoEmEdicao.Tipo.ToStr;
  lblSaldo.Caption := FormatFloat('0.00', FTransacaoEmEdicao.Saldo);

  // Desabilitar campos que não podem ser alterados
  edtDataTransacao.Enabled := False;
  edtValor.Enabled := False;
  cbxTipoTransacao.Enabled := False;
end;

procedure TformPrincipal.btnExcluirClick(Sender: TObject);
var
  Lista: TArray<TModelTransacao>;
  Index: Integer;
  T: TModelTransacao;
begin
  Index := strGridTransacao.Row - 1; // Ignora o cabeçalho

  Lista := FService.Listar;

  if (Index < 0) or (Index >= Length(Lista)) then
  begin
    ShowMessage('Nenhuma transação selecionada.');
    Exit;
  end;

  T := Lista[Index];

  if MessageDlg('Deseja excluir a transação selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      FService.Remover(T.Id);
      PreencherGrid;
    except
      on E: Exception do
        ShowMessage('Erro ao excluir: ' + E.Message);
    end;
  end;
end;

procedure TformPrincipal.btnIncluirClick(Sender: TObject);
begin
  pnlCampos.Enabled := True;
  edtDataTransacao.Date := Date;
  LimparCampos;
  edtClienteOrigem.SetFocus;
end;

procedure TformPrincipal.btnSalvarClick(Sender: TObject);
begin
  try
    if Assigned(FTransacaoEmEdicao) then
    begin
      // Edição
      FTransacaoEmEdicao.NomeOrigem := edtClienteOrigem.Text;
      FTransacaoEmEdicao.NomeDestino := edtClienteDestino.Text;
      FTransacaoEmEdicao.Descricao := edtDescricaoTransacao.Text;

      FService.Editar(FTransacaoEmEdicao);
      FTransacaoEmEdicao := nil;
    end
    else
    begin
      // Inclusão
      var T := TModelTransacao.Create;
      T.DataTransacao := edtDataTransacao.Date;
      T.NomeOrigem := edtClienteOrigem.Text;
      T.NomeDestino := edtClienteDestino.Text;
      T.Descricao := edtDescricaoTransacao.Text;
      T.Valor := StrToCurr(edtValor.Text);
      T.Tipo := TipoFromStr(cbxTipoTransacao.Text);

      FService.Adicionar(T);
      lblSaldo.Caption := FormatFloat('0.00', T.Saldo);
    end;

    PreencherGrid;
    LimparCampos;
    pnlCampos.Enabled := False;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TformPrincipal.CarregarComboTipo;
begin
  cbxTipoTransacao.Items.Clear;
  cbxTipoTransacao.Items.Add('Crédito');
  cbxTipoTransacao.Items.Add('Débito');
  cbxTipoTransacao.ItemIndex := 0;
end;


procedure TformPrincipal.FormCreate(Sender: TObject);
var
  Repo: IRepositoryTransacao;
begin
  // Configurar conexão com o banco (você pode externalizar isso)
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'FB';
  FConnection.Params.Database := ExtractFilePath(Application.ExeName) + '\EXTRATOBANCARIO.FDB' ;
  FConnection.Params.UserName := 'SYSDBA';
  FConnection.Params.Password := 'masterkey';
  FConnection.Params.Values['Server'] := 'localhost';
  FConnection.LoginPrompt := False;
  FConnection.Connected := True;

  Repo := TTransacaoRepository.Create(FConnection);
  FService := TServiceTransacao.Create(Repo);

  CarregarComboTipo;
  PreencherGrid;
  pnlCampos.Enabled := False;
end;

procedure TformPrincipal.LimparCampos;
begin
  FTransacaoEmEdicao := nil;
  edtDataTransacao.Date := Date;
  edtClienteOrigem.Clear;
  edtClienteDestino.Clear;
  edtDescricaoTransacao.Clear;
  edtValor.Clear;
  cbxTipoTransacao.ItemIndex := 0;
  lblSaldo.Caption := '';
end;

procedure TformPrincipal.PreencherGrid;
var
  Lista: TArray<TModelTransacao>;
  I: Integer;
  T: TModelTransacao;
begin
  Lista := FService.Listar;

  strGridTransacao.ColCount := 6;
  strGridTransacao.RowCount := Length(Lista) + 1;

  // Cabeçalhos
  strGridTransacao.Cells[0, 0] := 'Data';
  strGridTransacao.Cells[1, 0] := 'Origem';
  strGridTransacao.Cells[2, 0] := 'Destino';
  strGridTransacao.Cells[3, 0] := 'Valor';
  strGridTransacao.Cells[4, 0] := 'Tipo';
  strGridTransacao.Cells[5, 0] := 'Saldo';

  // Preenchimento das linhas
  for I := 0 to High(Lista) do
  begin
    T := Lista[I];
    strGridTransacao.Cells[0, I + 1] := DateToStr(T.DataTransacao);
    strGridTransacao.Cells[1, I + 1] := T.NomeOrigem;
    strGridTransacao.Cells[2, I + 1] := T.NomeDestino;
    strGridTransacao.Cells[3, I + 1] := FormatFloat('0.00', T.Valor);
    strGridTransacao.Cells[4, I + 1] := T.Tipo.ToStr;
    strGridTransacao.Cells[5, I + 1] := FormatFloat('0.00', T.Saldo);
  end;
end;

function TformPrincipal.TipoFromStr(const Texto: string): TTipoTransacao;
begin
  if SameText(Texto, 'Crédito') then
    Result := ttCredito
  else if SameText(Texto, 'Débito') then
    Result := ttDebito
  else
    raise Exception.CreateFmt('Tipo de transação inválido: "%s"', [Texto]);
end;

end.
