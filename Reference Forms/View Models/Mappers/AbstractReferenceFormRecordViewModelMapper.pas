unit AbstractReferenceFormRecordViewModelMapper;

interface

uses

  CardFormViewModel,
  ReferenceFormRecordViewModelMapper,
  ReferenceFormRecordViewModel,
  SysUtils,
  Classes;

type

  TAbstractReferenceFormRecordViewModelMapper =
    class abstract (TInterfacedObject, IReferenceFormRecordViewModelMapper)

      protected

        function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; virtual; abstract;

        procedure FillReferenceFormRecordViewModelFrom(
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
          CardFormViewModel: TCardFormViewModel;
          const CanBeChanged: Boolean = True;
          const CanBeRemoved: Boolean = True
        ); virtual;

      public

        function MapReferenceFormRecordViewModelFrom(
          CardFormViewModel: TCardFormViewModel;
          const CanBeChanged: Boolean = True;
          const CanBeRemoved: Boolean = True
        ): TReferenceFormRecordViewModel; virtual;

    end;

implementation

{ TAbstractReferenceFormRecordViewModelMapper }

procedure TAbstractReferenceFormRecordViewModelMapper.
  FillReferenceFormRecordViewModelFrom(
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
    CardFormViewModel: TCardFormViewModel;
    const CanBeChanged: Boolean = True;
    const CanBeRemoved: Boolean = True
  );
begin

  ReferenceFormRecordViewModel.Id := CardFormViewModel.Id.Value;
  
  ReferenceFormRecordViewModel.CanBeChanged := CanBeChanged;
  ReferenceFormRecordViewModel.CanBeRemoved := CanBeRemoved;

end;

function TAbstractReferenceFormRecordViewModelMapper.MapReferenceFormRecordViewModelFrom(
  CardFormViewModel: TCardFormViewModel;
  const CanBeChanged: Boolean;
  const CanBeRemoved: Boolean
): TReferenceFormRecordViewModel;
begin

  Result := GetReferenceFormRecordViewModelClass.Create;

  try

    FillReferenceFormRecordViewModelFrom(Result, CardFormViewModel);
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
