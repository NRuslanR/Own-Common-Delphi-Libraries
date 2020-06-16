program PropertiesStorages;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  TestPropertiesForm in 'TestPropertiesForm.pas' {Form5},
  IPropertiesStorageUnit in 'IPropertiesStorageUnit.pas',
  TPropertiesIniFileUnit in 'TPropertiesIniFileUnit.pas',
  TApplicationSettingsUnit in 'TApplicationSettingsUnit.pas',
  IGetSelfUnit in '..\Misceleneous\Interfaces\IGetSelfUnit.pas',
  IObjectPropertiesStorageUnit in 'IObjectPropertiesStorageUnit.pas',
  IObjectPropertiesStorageRegistryUnit in 'IObjectPropertiesStorageRegistryUnit.pas',
  ObjectPropertiesStorageRegistry in 'ObjectPropertiesStorageRegistry.pas',
  AuxCollectionFunctionsUnit in '..\AuxCollectionFunctions\AuxCollectionFunctionsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
