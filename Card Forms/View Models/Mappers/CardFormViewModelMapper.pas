unit CardFormViewModelMapper;

interface

uses

  ReferenceFormRecordViewModel,
  CardFormViewModel;

type

  ICardFormViewModelMapper = interface

    function CreateEmptyCardFormViewModel: TCardFormViewModel;
    
    function MapCardFormViewModelFrom(
      ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
    ): TCardFormViewModel;

    procedure FillCardFormViewModelFrom(
      CardFormViewModel: TCardFormViewModel;
      ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
    );

  end;

implementation

end.
