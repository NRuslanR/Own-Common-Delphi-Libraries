unit AbstractReferenceFormControllerEvents;

interface

uses

  Event,
  SysUtils,
  ReferenceFormRecordViewModel,
  Classes;
  
type

  TReferenceRecordChooseRequestedEvent = class (TEvent)

    protected

      FSelectedRecordId: Variant;

    public

      constructor Create(const SelectedRecordId: Variant);

      property SelectedRecordId: Variant read FSelectedRecordId;
      
  end;

  TReferenceRecordChooseRequestedEventClass =
    class of TReferenceRecordChooseRequestedEvent;
    
  TReferenceRecordChoosenEvent = class (TEvent)

    private

      FReferenceRecordViewModel: TReferenceFormRecordViewModel;

    public

      constructor Create(
        ReferenceRecordViewModel: TReferenceFormRecordViewModel
      );

      property ReferenceRecordViewModel: TReferenceFormRecordViewModel
      read FReferenceRecordViewModel;

  end;

  TReferenceRecordChoosenEventClass = class of TReferenceRecordChoosenEvent;

  TAddingReferenceRecordRequestedEvent = class (TEvent)

  end;

  TAddingReferenceRecordRequestedEventClass = class of TAddingReferenceRecordRequestedEvent;

  TChangingReferenceRecordRequestedEvent = class (TEvent)

    private

      FRecordViewModel: TReferenceFormRecordViewModel;

      procedure SetRecordViewModel(
        Value: TReferenceFormRecordViewModel
      );

    public

      constructor Create(
        RecordViewModel: TReferenceFormRecordViewModel
      );

      property RecordViewModel:TReferenceFormRecordViewModel
      read FRecordViewModel write SetRecordViewModel;

  end;

  TChangingReferenceRecordRequestedEventClass = class of TChangingReferenceRecordRequestedEvent;

  TRemovingReferenceRecordRequestedEvent = class (TEvent)

    private

      FRecordViewModel: TReferenceFormRecordViewModel;

      procedure SetRecordViewModel(
        Value: TReferenceFormRecordViewModel
      );

    public

      constructor Create(
        RecordViewModel: TReferenceFormRecordViewModel
      );

      property RecordViewModel: TReferenceFormRecordViewModel
      read FRecordViewModel write SetRecordViewModel;

  end;

  TRemovingReferenceRecordRequestedEventClass =
    class of TRemovingReferenceRecordRequestedEvent;

implementation

{ TChangingReferenceRecordRequestedEvent }

constructor TChangingReferenceRecordRequestedEvent.Create(
  RecordViewModel: TReferenceFormRecordViewModel
);
begin

  inherited Create;

  Self.RecordViewModel := RecordViewModel;

end;

procedure TChangingReferenceRecordRequestedEvent.SetRecordViewModel(
  Value: TReferenceFormRecordViewModel);
begin

  FreeAndNil(FRecordViewModel);

  FRecordViewModel := Value;

end;

{ TRemovingReferenceRecordRequestedEvent }

constructor TRemovingReferenceRecordRequestedEvent.Create(
  RecordViewModel: TReferenceFormRecordViewModel);
begin

  inherited Create;

  Self.RecordViewModel := RecordViewModel;

end;

procedure TRemovingReferenceRecordRequestedEvent.SetRecordViewModel(
  Value: TReferenceFormRecordViewModel);
begin

  FreeAndNil(FRecordViewModel);

  FRecordViewModel := Value;

end;

{ TReferenceRecordChooseRequestedEvent }

constructor TReferenceRecordChooseRequestedEvent.Create(
  const SelectedRecordId: Variant);
begin

  inherited Create;

  FSelectedRecordId := SelectedRecordId;
  
end;

{ TReferenceRecordChoosenEvent }

constructor TReferenceRecordChoosenEvent.Create(
  ReferenceRecordViewModel: TReferenceFormRecordViewModel);
begin

  inherited Create;

  FReferenceRecordViewModel := ReferenceRecordViewModel;
  
end;

end.
