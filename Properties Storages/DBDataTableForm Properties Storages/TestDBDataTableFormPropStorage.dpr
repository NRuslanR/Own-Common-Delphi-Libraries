program TestDBDataTableFormPropStorage;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  TestDBDataTableFormPropStorageUnit in 'TestDBDataTableFormPropStorageUnit.pas' {Form6},
  TPropertiesIniFileUnit in '..\TPropertiesIniFileUnit.pas',
  IObjectPropertiesStorageRegistryUnit in '..\IObjectPropertiesStorageRegistryUnit.pas',
  IObjectPropertiesStorageUnit in '..\IObjectPropertiesStorageUnit.pas',
  IPropertiesStorageUnit in '..\IPropertiesStorageUnit.pas',
  DBDataTableFormPropertiesStorage in 'DBDataTableFormPropertiesStorage.pas',
  VariantTypeUnit in '..\..\DBDataTableForm\VariantTypeUnit.pas',
  DBDataTableFormUnit in '..\..\DBDataTableForm\DBDataTableFormUnit.pas' {DBDataTableForm},
  TableViewFilterFormFilterBuilderUnit in '..\..\DBDataTableForm\TableViewFilterFormFilterBuilderUnit.pas',
  TableViewFilterFormUnit in '..\..\DBDataTableForm\TableViewFilterFormUnit.pas' {TableViewFilterForm},
  IGetSelfUnit in '..\..\Misceleneous\Interfaces\IGetSelfUnit.pas',
  VariantListUnit in '..\..\Variant List\VariantListUnit.pas',
  StackedControlUnit in '..\..\Stacked Control\StackedControlUnit.pas',
  AuxDebugFunctionsUnit in '..\..\AuxDebugFunctions\AuxDebugFunctionsUnit.pas',
  AuxWindowsFunctionsUnit in '..\..\AuxWindowsFunctions\AuxWindowsFunctionsUnit.pas',
  AuxZeosFunctions in '..\..\AuxZeosFunctions\AuxZeosFunctions.pas',
  AuxSystemFunctionsUnit in '..\..\AuxSystemFunctions\AuxSystemFunctionsUnit.pas',
  AuxCollectionFunctionsUnit in '..\..\AuxCollectionFunctions\AuxCollectionFunctionsUnit.pas',
  DBDataTableFormPropertiesIniFile in 'DBDataTableFormPropertiesIniFile.pas',
  DBDataTableFilterFormStatePropertiesStorage in 'DBDataTableFilterFormStatePropertiesStorage.pas',
  DBDataTableFilterFormStatePropertiesIniFile in 'DBDataTableFilterFormStatePropertiesIniFile.pas',
  TestDBDataTable in 'TestDBDataTable.pas' {TestDBDataTableForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TDBDataTableForm, DBDataTableForm);
  Application.CreateForm(TTableViewFilterForm, TableViewFilterForm);
  Application.CreateForm(TTestDBDataTableForm, TestDBDataTableForm);
  Application.Run;
end.
