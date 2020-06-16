unit SystemAdministrationFormViewModelMapperInterface;

interface

uses

  SystemAdministrationPrivileges,
  SystemAdministrationFormViewModel;

type

  ISystemAdministrationFormViewModelMapper = interface

    function MapSystemAdministrationFormViewModelFrom(
      SystemAdministrationPrivileges: TSystemAdministrationPrivileges
    ): TSystemAdministrationFormViewModel;
    
  end;
  
implementation

end.
