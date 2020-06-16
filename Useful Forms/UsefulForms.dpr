program UsefulForms;

uses
  Forms,
  MinMaxFormUnit in 'MinMaxFormUnit.pas' {MinMaxForm},
  DialogFormUnit in 'DialogFormUnit.pas' {DialogForm},
  TestForm in 'TestForm.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
