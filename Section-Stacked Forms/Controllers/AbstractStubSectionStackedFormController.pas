unit AbstractStubSectionStackedFormController;

interface

uses

  AbstractSectionStackedFormController,
  unSectionStackedForm,
  SectionStackedFormViewModel,
  SectionRecordViewModel,
  SectionSetHolder,
  AbstractFormController,
  FormEvents,
  Forms,
  DB,
  Controls,
  SysUtils,
  Classes;

type

  TAbstractStubSectionStackedFormController = class (TAbstractSectionStackedFormController)

    protected

      procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
      
    protected

    protected

      function CreateTestViewModel: TSectionStackedFormViewModel; virtual;

      procedure CreateSectionSetFieldDefs(
        SectionSet: TDataSet;
        SectionSetFieldDefs: TSectionSetFieldDefs
      ); virtual;

      procedure InitializeSectionSetFieldDefs(SectionSetFieldDefs: TSectionSetFieldDefs); virtual; abstract;
      procedure FillViewModel(ViewModel: TSectionStackedFormViewModel); virtual; abstract;
      
  end;
  

implementation

uses

  AuxDataSetFunctionsUnit,
  unStubSectionStackedFormDataModule,
  StdCtrls,
  ComCtrls;
  
{ TAbstractStubSectionStackedFormController }

procedure TAbstractStubSectionStackedFormController.CreateSectionSetFieldDefs(
  SectionSet: TDataSet; SectionSetFieldDefs: TSectionSetFieldDefs);
begin

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.SectionIdFieldName, ftInteger
  );

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.ParentIdSectionFieldName, ftInteger
  );

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.SectionNameFieldName, ftString, 200
  );
  
end;

function TAbstractStubSectionStackedFormController.CreateTestViewModel: TSectionStackedFormViewModel;
begin

  Result := TSectionStackedFormViewModel.Create;

  Result.SectionSetHolder :=
    TSectionSetHolder.CreateFrom(
      TStubSectionStackedFormDataModule.Create(Application).TestSectionMemData
    );

  Result.SectionSetHolder.FieldDefs := TSectionSetFieldDefs.Create;

  InitializeSectionSetFieldDefs(Result.SectionSetHolder.FieldDefs);
  
  CreateSectionSetFieldDefs(
    Result.SectionSetHolder.DataSet, Result.SectionSetHolder.FieldDefs
  );
  
  FillViewModel(Result);
  
end;

procedure TAbstractStubSectionStackedFormController.CustomizeForm(
  Form: TForm;
  FormData: TFormData
);
var SectionStackedForm: TSectionStackedForm;
begin

  inherited;

  SectionStackedForm := Form as TSectionStackedForm;

  SectionStackedForm.ViewModel := CreateTestViewModel;

end;

end.
