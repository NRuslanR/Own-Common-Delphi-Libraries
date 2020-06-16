program ValidateCheckListBoxProject;

uses
  Forms,
  TestFormUnit in 'TestFormUnit.pas' {Form15},
  ValidateCheckListBoxUnit in 'ValidateCheckListBoxUnit.pas',
  ValidateBaseInterfaceUnit in '..\Validate Controls\ValidateBaseInterfaceUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
