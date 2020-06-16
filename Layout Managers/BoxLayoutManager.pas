unit BoxLayoutManager;

interface

uses

  Windows,
  LayoutManager,
  LayoutItem,
  Controls,
  SysUtils,
  Classes;

type

  TBoxedLayoutItemVisualSettingsHolder = class (TLayoutItemVisualSettingsHolder)

    protected

      const DEFAULT_GAP = 5;

    protected
    
      FGap: Integer;

      function GetGap: Integer;
      procedure SetGap(const Value: Integer);

    public

      constructor Create;
      
    published

      property Gap: Integer read GetGap write SetGap;

  end;

  TBoxedLayoutItemVisualSettingsHolders = class;

  TBoxedLayoutItemVisualSettingsHoldersEnumerator =
    class (TLayoutItemVisualSettingsHoldersEnumerator)

    protected

      function GetCurrentBoxedLayoutItemVisualSettingsHolder:
        TBoxedLayoutItemVisualSettingsHolder;

    public

      constructor Create(
        BoxedLayoutItemVisualSettingsHolders:
          TBoxedLayoutItemVisualSettingsHolders
      );

      property Current: TBoxedLayoutItemVisualSettingsHolder
      read GetCurrentBoxedLayoutItemVisualSettingsHolder;

  end;
  
  TBoxedLayoutItemVisualSettingsHolders =
    class (TLayoutItemVisualSettingsHolders)

      protected

        function GetBoxedLayoutItemVisualSettingsHolderByIndex(
          Index: Integer
        ): TBoxedLayoutItemVisualSettingsHolder;

        procedure SetBoxedLayoutItemVisualSettingsHolderByIndex(
          Index: Integer;
          Value: TBoxedLayoutItemVisualSettingsHolder
        );
        
      public

        function FindBefore(
          LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
        ): TBoxedLayoutItemVisualSettingsHolder;

        function FindAfter(
          LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
        ): TBoxedLayoutItemVisualSettingsHolder;

        function FindFirst: TBoxedLayoutItemVisualSettingsHolder;
        function FindLast: TBoxedLayoutItemVisualSettingsHolder;

        function GetEnumerator: TBoxedLayoutItemVisualSettingsHoldersEnumerator;
        
        property Items[Index: Integer]: TBoxedLayoutItemVisualSettingsHolder
        read GetBoxedLayoutItemVisualSettingsHolderByIndex
        write SetBoxedLayoutItemVisualSettingsHolderByIndex; default;

    end;
    
  TBoxLayoutManager = class abstract (TLayoutManager)

    protected {own elements}

      function GetBoxedLayoutItemVisualSettingsHolders:
        TBoxedLayoutItemVisualSettingsHolders;

    protected {ancestor base elements}

      function GetLeft: Integer; override;
      function GetTop: Integer; override;
      function GetHeight: Integer; override;
      function GetWidth: Integer; override;

      { stretching policies - {uniform stretching, etc }
      procedure SetHeight(const Value: Integer); override;
      procedure SetWidth(const Value: Integer); override;

      function CreateLayoutItemVisualSettingsHolder(
        LayoutItem: TLayoutItem
      ): TLayoutItemVisualSettingsHolder; override;

      function CreateLayoutItemVisualSettingsHolderList:
        TLayoutItemVisualSettingsHolders; override;
        
      procedure ApplyVisualSettingsForLayoutItem(
        LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
      ); override;

    protected {own abstracts}

      procedure ArrangeOneLayoutItemAfterOther(
        PrecedingLayoutItem, SucceedingLayoutItem: TLayoutItem;
        const Gap: Integer
      ); virtual; abstract;

    protected {properties}

      property LayoutItemVisualSettingsHolders:
        TBoxedLayoutItemVisualSettingsHolders

      read GetBoxedLayoutItemVisualSettingsHolders;

    public

      function AddLayoutItem(
        LayoutItem: TLayoutItem;
        const Gap: Integer = -1
      ): Integer;

      function AddControl(
        Control: TControl;
        const Gap: Integer = -1
      ): Integer;
      
      function AddLayoutManager(
        LayoutManager: TLayoutManager;
        const Gap: Integer = -1
      ): Integer;
      
  end;

  TBoxLayoutManagerBuilder = class abstract (TLayoutManagerBuilder)

    protected

      function GetBoxLayoutManager: TBoxLayoutManager;

      property BoxLayoutManager: TBoxLayoutManager read GetBoxLayoutManager;

    public

      constructor Create; override;
      
      function AddControl(
        Control: TControl;
        const Gap: Integer = -1
      ): TBoxLayoutManagerBuilder; overload;

      function AddControls(
        Controls: array of TControl;
        const Gaps: array of Integer
      ): TBoxLayoutManagerBuilder; overload;

      function AddLayoutManager(
        LayoutManager: TLayoutManager;
        const Gap: Integer = -1
      ): TBoxLayoutManagerBuilder; overload;

      function AddLayoutManagers(
        LayoutManagers: array of TLayoutManager;
        const Gaps: array of Integer
      ): TBoxLayoutManagerBuilder; overload;
  
  end;
  
implementation

uses

  ControlLayoutItem,
  AuxDebugFunctionsUnit;
  
{ TBoxedLayoutItemVisualSettingsHolder }

constructor TBoxedLayoutItemVisualSettingsHolder.Create;
begin

  inherited;

  FGap := DEFAULT_GAP;
  
end;

function TBoxedLayoutItemVisualSettingsHolder.GetGap: Integer;
begin

  Result := FGap;
  
end;

procedure TBoxedLayoutItemVisualSettingsHolder.SetGap(const Value: Integer);
begin

  FGap := Value;
  
end;

{ TBoxLayoutManager }

function TBoxLayoutManager.AddControl(Control: TControl;
  const Gap: Integer
): Integer;
var LayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  Result := AddLayoutItem(CreateLayoutItemFor(Control), Gap);
  
end;

function TBoxLayoutManager.AddLayoutItem(
  LayoutItem: TLayoutItem;
  const Gap: Integer
): Integer;
var LayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  LayoutItemVisualSettingsHolder :=
    CreateAndAddVisualSettingsHolderFor(LayoutItem) as
    TBoxedLayoutItemVisualSettingsHolder;

  if Gap > -1 then
    LayoutItemVisualSettingsHolder.Gap := Gap;

  Result :=
    GetIndexOfLayoutItemVisualSettingsHolder(LayoutItemVisualSettingsHolder);

end;

function TBoxLayoutManager.AddLayoutManager(LayoutManager: TLayoutManager;
  const Gap: Integer): Integer;
begin

  Result := AddLayoutItem(LayoutManager, Gap);
  
end;

procedure TBoxLayoutManager.ApplyVisualSettingsForLayoutItem(
  LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
);
var PrecedingLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
    TargetLayoutItem: TLayoutItem;
    PrecedingLayoutItem: TLayoutItem;
begin

  PrecedingLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindBefore(LayoutItemVisualSettingsHolder);

  if not Assigned(PrecedingLayoutItemVisualSettingsHolder) then Exit;
  
  TargetLayoutItem := LayoutItemVisualSettingsHolder.LayoutItem;
  PrecedingLayoutItem := PrecedingLayoutItemVisualSettingsHolder.LayoutItem;

  ArrangeOneLayoutItemAfterOther(
    PrecedingLayoutItem,
    TargetLayoutItem,
    PrecedingLayoutItemVisualSettingsHolder.Gap
  );
    
end;

function TBoxLayoutManager.CreateLayoutItemVisualSettingsHolder(
  LayoutItem: TLayoutItem): TLayoutItemVisualSettingsHolder;
begin

  Result := TBoxedLayoutItemVisualSettingsHolder.Create;
  
end;

function TBoxLayoutManager.CreateLayoutItemVisualSettingsHolderList: TLayoutItemVisualSettingsHolders;
begin

  Result := TBoxedLayoutItemVisualSettingsHolders.Create;
  
end;

function TBoxLayoutManager.GetBoxedLayoutItemVisualSettingsHolders: TBoxedLayoutItemVisualSettingsHolders;
begin

  Result :=
    FLayoutItemVisualSettingsHolders as TBoxedLayoutItemVisualSettingsHolders;

end;

function TBoxLayoutManager.GetHeight: Integer;
var FirstLayoutItemVisualSettingsHolder,
    LastLayoutItemVisualSettingsHolder:
      TBoxedLayoutItemVisualSettingsHolder;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindFirst;

  LastLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindLast;

  Result :=
    LastLayoutItemVisualSettingsHolder.LayoutItem.Bottom -
    FirstLayoutItemVisualSettingsHolder.LayoutItem.Top;

end;

function TBoxLayoutManager.GetLeft: Integer;
var FirstLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindFirst;

  Result := FirstLayoutItemVisualSettingsHolder.LayoutItem.Left;
  
end;

function TBoxLayoutManager.GetTop: Integer;
var FirstLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindFirst;

  Result := FirstLayoutItemVisualSettingsHolder.LayoutItem.Top;

end;

function TBoxLayoutManager.GetWidth: Integer;
var FirstLayoutItemVisualSettingsHolder,
    LastLayoutItemVisualSettingsHolder:
      TBoxedLayoutItemVisualSettingsHolder;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindFirst;

  LastLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders.FindLast;

  Result :=
    LastLayoutItemVisualSettingsHolder.LayoutItem.Right -
    FirstLayoutItemVisualSettingsHolder.LayoutItem.Left;

  if LastLayoutItemVisualSettingsHolder.LayoutItem is TControlLayoutItem
  then begin

    DebugOutput('Leftttest control: ' +
    (FirstLayoutItemVisualSettingsHolder.LayoutItem as TControlLayoutItem).Control.Name +
      ', right:' +
      IntToStr(FirstLayoutItemVisualSettingsHolder.LayoutItem.Right)
    );

    DebugOutput('Righttest control: ' +
    (LastLayoutItemVisualSettingsHolder.LayoutItem as TControlLayoutItem).Control.Name +
      ', right:' +
        IntToStr(LastLayoutItemVisualSettingsHolder.LayoutItem.Right)
    );

  end;
  
end;

{ stretching policy }
procedure TBoxLayoutManager.SetHeight(const Value: Integer);
begin

  inherited;

end;

{ stretching policy }
procedure TBoxLayoutManager.SetWidth(const Value: Integer);
begin

  inherited;

end;

{ TBoxedLayoutItemVisualSettingsHolders }

function TBoxedLayoutItemVisualSettingsHolders.FindAfter(
  LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
): TBoxedLayoutItemVisualSettingsHolder;
var LayoutItemVisualSettingsHolderIndex: Integer;
begin

  LayoutItemVisualSettingsHolderIndex :=
    IndexOf(LayoutItemVisualSettingsHolder);

  if LayoutItemVisualSettingsHolderIndex = (Count - 1) then
    Result := nil

  else Result := Self[LayoutItemVisualSettingsHolderIndex + 1];

end;

function TBoxedLayoutItemVisualSettingsHolders.FindBefore(
  LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
): TBoxedLayoutItemVisualSettingsHolder;
var LayoutItemVisualSettingsHolderIndex: Integer;
begin

  LayoutItemVisualSettingsHolderIndex :=
    IndexOf(LayoutItemVisualSettingsHolder);

  if LayoutItemVisualSettingsHolderIndex = 0 then
    Result := nil

  else Result := Self[LayoutItemVisualSettingsHolderIndex - 1];
  
end;

function TBoxedLayoutItemVisualSettingsHolders.FindFirst: TBoxedLayoutItemVisualSettingsHolder;
begin

  Result := TBoxedLayoutItemVisualSettingsHolder(First);
  
end;

function TBoxedLayoutItemVisualSettingsHolders.FindLast: TBoxedLayoutItemVisualSettingsHolder;
begin

  Result := TBoxedLayoutItemVisualSettingsHolder(Last);
  
end;

function TBoxedLayoutItemVisualSettingsHolders.GetBoxedLayoutItemVisualSettingsHolderByIndex(
  Index: Integer): TBoxedLayoutItemVisualSettingsHolder;
begin

  Result :=
    GetLayoutItemVisualSettingsHolderByIndex(Index) as
    TBoxedLayoutItemVisualSettingsHolder;
    
end;

function TBoxedLayoutItemVisualSettingsHolders.GetEnumerator: TBoxedLayoutItemVisualSettingsHoldersEnumerator;
begin

  Result := TBoxedLayoutItemVisualSettingsHoldersEnumerator.Create(Self);
  
end;

procedure TBoxedLayoutItemVisualSettingsHolders.SetBoxedLayoutItemVisualSettingsHolderByIndex(
  Index: Integer; Value: TBoxedLayoutItemVisualSettingsHolder);
begin

  SetLayoutItemVisualSettingsHolderByIndex(Index, Value);
  
end;

{ TBoxedLayoutItemVisualSettingsHoldersEnumerator }

constructor TBoxedLayoutItemVisualSettingsHoldersEnumerator.Create(
  BoxedLayoutItemVisualSettingsHolders: TBoxedLayoutItemVisualSettingsHolders);
begin

  inherited Create(BoxedLayoutItemVisualSettingsHolders);
  
end;

function TBoxedLayoutItemVisualSettingsHoldersEnumerator.
  GetCurrentBoxedLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  Result :=
    GetCurrentLayoutItemVisualSettingsHolder as
    TBoxedLayoutItemVisualSettingsHolder;
    
end;

{ TBoxLayoutManagerBuilder }

function TBoxLayoutManagerBuilder.AddControls(
  Controls: array of TControl;
  const Gaps: array of Integer
): TBoxLayoutManagerBuilder;
var Gap: Integer;
    I: Integer;
begin

  for I := Low(Controls) to High(Controls) do begin

    if I > High(Gaps) then
      Gap := -1

    else Gap := Gaps[I];

    BoxLayoutManager.AddControl(Controls[I], Gap);
    
  end;

  Result := Self;

end;

function TBoxLayoutManagerBuilder.AddControl(Control: TControl;
  const Gap: Integer): TBoxLayoutManagerBuilder;
begin

  BoxLayoutManager.AddControl(Control, Gap);

  Result := Self;
  
end;

function TBoxLayoutManagerBuilder.AddLayoutManager(
  LayoutManager: TLayoutManager;
  const Gap: Integer): TBoxLayoutManagerBuilder;
begin

  BoxLayoutManager.AddLayoutManager(LayoutManager, Gap);

  Result := Self;
  
end;

function TBoxLayoutManagerBuilder.AddLayoutManagers(
  LayoutManagers: array of TLayoutManager;
  const Gaps: array of Integer): TBoxLayoutManagerBuilder;
var I: Integer;
    Gap: Integer;
begin

  for I := Low(LayoutManagers) to High(LayoutManagers) do begin

    if I > High(Gaps) then
      Gap := -1

    else Gap := Gaps[I];

    BoxLayoutManager.AddLayoutManager(LayoutManagers[I], Gap);

  end;

  Result := Self;
  
end;

constructor TBoxLayoutManagerBuilder.Create;
begin
  inherited;

end;

function TBoxLayoutManagerBuilder.GetBoxLayoutManager: TBoxLayoutManager;
const c: Integer = 0;
begin

  Result := FLayoutManager as TBoxLayoutManager;

end;

end.
