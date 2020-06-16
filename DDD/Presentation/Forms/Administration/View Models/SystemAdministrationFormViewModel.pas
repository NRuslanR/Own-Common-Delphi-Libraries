unit SystemAdministrationFormViewModel;

interface

uses

  SectionStackedFormViewModel,
  SectionRecordViewModel,
  SystemAdministrationPrivilegeViewModel,
  SystemAdministrationPrivilegeSetHolder,
  SysUtils,
  Classes;

type

  TSystemAdministrationFormViewModel = class (TSectionStackedFormViewModel)

    private

      function GetSystemAdministrationPrivilegeSetHolder: TSystemAdministrationPrivilegeSetHolder;

      procedure SetSystemAdministrationPrivilegeSetHolder(
        const Value: TSystemAdministrationPrivilegeSetHolder
      );
      
    protected

      function GetSectionRecordViewModelClass: TSectionRecordViewModelClass; override;

    public

      property SystemAdministrationPrivilegeSetHolder: TSystemAdministrationPrivilegeSetHolder
      read GetSystemAdministrationPrivilegeSetHolder
      write SetSystemAdministrationPrivilegeSetHolder;
      
  end;

  TSystemAdministrationFormViewModelClass = class of TSystemAdministrationFormViewModel;
  
implementation

{ TSystemAdministrationFormViewModel }

function TSystemAdministrationFormViewModel.GetSectionRecordViewModelClass: TSectionRecordViewModelClass;
begin

  Result := TSystemAdministrationPrivilegeViewModel;
  
end;

function TSystemAdministrationFormViewModel.GetSystemAdministrationPrivilegeSetHolder: TSystemAdministrationPrivilegeSetHolder;
begin

  Result := TSystemAdministrationPrivilegeSetHolder(SectionSetHolder);
  
end;

procedure TSystemAdministrationFormViewModel.SetSystemAdministrationPrivilegeSetHolder(
  const Value: TSystemAdministrationPrivilegeSetHolder);
begin

  SectionSetHolder := Value;
  
end;

end.
