unit ReferenceFormViewModelMapper;

interface

uses

  ReferenceFormViewModel,
  EntitySetHolder;

type

  IReferenceFormViewModelMapper = interface

    function MapReferenceFormViewModelFrom(
      EntitySetHolder: TEntitySetHolder
    ): TReferenceFormViewModel;

  end;

implementation

end.
