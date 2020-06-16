program DBTableFormTest;

uses
  Forms,
  Unit5 in 'Unit5.pas' {Form5},
  VariantTypeUnit in 'VariantTypeUnit.pas',
  DBDataTableFormUnit in 'DBDataTableFormUnit.pas' {DBDataTableForm},
  TableViewFilterFormFilterBuilderUnit in 'TableViewFilterFormFilterBuilderUnit.pas',
  TableViewFilterFormUnit in 'TableViewFilterFormUnit.pas' {TableViewFilterForm},
  AuxCollectionFunctionsUnit in '..\AuxCollectionFunctions\AuxCollectionFunctionsUnit.pas',
  AuxSystemFunctionsUnit in '..\AuxSystemFunctions\AuxSystemFunctionsUnit.pas',
  AuxZeosFunctions in '..\AuxZeosFunctions\AuxZeosFunctions.pas',
  VariantListUnit in '..\Variant List\VariantListUnit.pas',
  Unit6 in 'Unit6.pas' {DBDataTableForm6},
  AuxWindowsFunctionsUnit in '..\AuxWindowsFunctions\AuxWindowsFunctionsUnit.pas',
  StackedControlUnit in '..\Stacked Control\StackedControlUnit.pas',
  AuxiliaryStringFunctions in '..\AuxStringFunctions\AuxiliaryStringFunctions.pas',
  AuxDebugFunctionsUnit in '..\AuxDebugFunctions\AuxDebugFunctionsUnit.pas',
  Cloneable in '..\Misceleneous\Cloneable.pas',
  SimpleDateRangePanelUnit in '..\SimpleDateRangePanelUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDBDataTableForm6, DBDataTableForm6);
  Application.Run;
end.
