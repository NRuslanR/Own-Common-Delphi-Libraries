program Domain;

uses
  Forms,
  TestFormUnit in 'TestFormUnit.pas' {Form17},
  DomainObjectListUnit in 'DomainObjectListUnit.pas',
  DomainObjectUnit in 'DomainObjectUnit.pas',
  DomainObjectValueUnit in 'DomainObjectValueUnit.pas',
  IDomainObjectUnit in 'IDomainObjectUnit.pas',
  ClonableUnit in '..\..\Misceleneous\Interfaces\ClonableUnit.pas',
  CopyableUnit in '..\..\Misceleneous\Interfaces\CopyableUnit.pas',
  EquatableUnit in '..\..\Misceleneous\Interfaces\EquatableUnit.pas',
  IDomainObjectValueUnit in 'IDomainObjectValueUnit.pas',
  IDomainObjectBaseUnit in 'IDomainObjectBaseUnit.pas',
  DomainObjectBaseUnit in 'DomainObjectBaseUnit.pas',
  MeasurementMeanTypeUnit in 'C:\Documents and Settings\59968\Мои документы\Borland Studio Projects\MetrologicalSupportDepartmentIS\OMODomain\Domain Items\Entities\MeasurementMeanTypeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm17, Form17);
  Application.Run;
end.
