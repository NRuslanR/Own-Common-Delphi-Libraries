program MessagingServiceTestProject;

uses
  Forms,
  TestMessagingServiceFormUnit in 'TestMessagingServiceFormUnit.pas' {Form5},
  MessagingServiceUnit in 'MessagingServiceUnit.pas',
  AbstractEmailMessagingServiceUnit in 'Email\AbstractEmailMessagingServiceUnit.pas',
  SynapseEmailMessagingServiceUnit in 'Email\SynapseEmailMessagingServiceUnit.pas',
  IGetSelfUnit in '..\Misceleneous\Interfaces\IGetSelfUnit.pas',
  AuxDebugFunctionsUnit in '..\AuxDebugFunctions\AuxDebugFunctionsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
