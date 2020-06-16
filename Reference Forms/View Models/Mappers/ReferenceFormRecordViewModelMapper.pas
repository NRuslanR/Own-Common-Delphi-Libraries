unit ReferenceFormRecordViewModelMapper;

interface

uses

  CardFormViewModel,
  ReferenceFormRecordViewModel;

type

  IReferenceFormRecordViewModelMapper = interface

    function MapReferenceFormRecordViewModelFrom(
      CardFormViewModel: TCardFormViewModel;
      const CanBeChanged: Boolean = True;
      const CanBeRemoved: Boolean = True
    ): TReferenceFormRecordViewModel; 
      
  end;

implementation

end.
