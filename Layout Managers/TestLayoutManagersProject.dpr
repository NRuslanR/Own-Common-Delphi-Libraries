program TestLayoutManagersProject;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  TestLayoutManagersForm in 'TestLayoutManagersForm.pas' {Form9},
  BoxLayoutManager in 'BoxLayoutManager.pas',
  ControlLayoutItem in 'ControlLayoutItem.pas',
  HorizontalBoxLayoutManager in 'HorizontalBoxLayoutManager.pas',
  LayoutItem in 'LayoutItem.pas',
  LayoutManager in 'LayoutManager.pas',
  VerticalBoxLayoutManager in 'VerticalBoxLayoutManager.pas',
  AuxDebugFunctionsUnit in '..\AuxDebugFunctions\AuxDebugFunctionsUnit.pas',
  ColumnarCellAlignedLayoutManager in 'ColumnarCellAlignedLayoutManager.pas',
  VariantListUnit in '..\Variant List\VariantListUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
