program ExtratoBancario;

uses
  Vcl.Forms,
  frmPrincipal in '..\View\frmPrincipal.pas' {formPrincipal},
  uModelTransacao in '..\Model\uModelTransacao.pas',
  uIRepositoryTransacao in '..\Repository\uIRepositoryTransacao.pas',
  uRepositoryTransacao in '..\Repository\uRepositoryTransacao.pas',
  uTipoTransacaoHelper in '..\Utils\uTipoTransacaoHelper.pas',
  uServiceTransacao in '..\Service\uServiceTransacao.pas',
  uIStrategyTransacao in '..\Strategy\uIStrategyTransacao.pas',
  uStrategyCredito in '..\Strategy\uStrategyCredito.pas',
  uStrategyDebito in '..\Strategy\uStrategyDebito.pas',
  uStrategyContextTransacao in '..\Strategy\uStrategyContextTransacao.pas',
  uNoEncadeado in '..\DataStructure\uNoEncadeado.pas',
  uListaEncadeada in '..\DataStructure\uListaEncadeada.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
