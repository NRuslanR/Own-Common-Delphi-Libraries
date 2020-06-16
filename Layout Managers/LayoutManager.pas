unit LayoutManager;

interface

uses

  Windows,
  LayoutItem,
  Controls,
  SysUtils,
  Classes;

type

  TLayoutItemVisualSettingsHolder = class

    protected

      FLayoutItem: TLayoutItem;

    public

      destructor Destroy; override;
      constructor Create;

    published

      property LayoutItem: TLayoutItem read FLayoutItem write FLayoutItem;
      
  end;

  TLayoutItemVisualSettingsHolders = class;

  TLayoutItemVisualSettingsHoldersEnumerator = class (TListEnumerator)

    protected

      function GetCurrentLayoutItemVisualSettingsHolder:
        TLayoutItemVisualSettingsHolder;

    public

      constructor Create(
        LayoutItemVisualSettingsHolders: TLayoutItemVisualSettingsHolders
      );

      property Current: TLayoutItemVisualSettingsHolder
      read GetCurrentLayoutItemVisualSettingsHolder;

  end;

  TLayoutItemVisualSettingsHolders = class (TList)

    protected

      function GetLayoutItemVisualSettingsHolderByIndex(
        Index: Integer
      ): TLayoutItemVisualSettingsHolder;

      procedure SetLayoutItemVisualSettingsHolderByIndex(
        Index: Integer;
        Value: TLayoutItemVisualSettingsHolder
      );

      procedure Notify(Ptr: Pointer; Action: TListNotification); override;

    public

      function IndexOfByLayoutItem(LayoutItem: TLayoutItem): Integer;
      function FindByLayoutItem(LayoutItem: TLayoutItem): TLayoutItemVisualSettingsHolder;

      procedure RemoveByLayoutItem(LayoutItem: TLayoutItem);
      procedure RemoveByLayoutItemForControl(Control: TControl);
      
      function GetEnumerator: TLayoutItemVisualSettingsHoldersEnumerator;

      property Items[Index: Integer]: TLayoutItemVisualSettingsHolder
      read GetLayoutItemVisualSettingsHolderByIndex
      write SetLayoutItemVisualSettingsHolderByIndex; default;

  end;
  
  TLayoutManager = class abstract (TLayoutItem)

    protected

      FLayoutItemVisualSettingsHolders: TLayoutItemVisualSettingsHolders;

      function CreateLayoutItemVisualSettingsHolder(
        LayoutItem: TLayoutItem
      ): TLayoutItemVisualSettingsHolder; virtual; abstract;

      function CreateLayoutItemVisualSettingsHolderList:
        TLayoutItemVisualSettingsHolders; virtual;
        
      procedure ApplyVisualSettingsForLayoutItem(
        LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
      ); virtual; abstract;
      
      function CreateAndAddVisualSettingsHolderFor(LayoutItem: TLayoutItem): TLayoutItemVisualSettingsHolder; overload;
      function CreateAndAddVisualSettingsHolderFor(Control: TControl): TLayoutItemVisualSettingsHolder; overload;
      function CreateAndAddVisualSettingsHolderFor(LayoutManager: TLayoutManager): TLayoutItemVisualSettingsHolder; overload;

      function GetIndexOfLayoutItemVisualSettingsHolder(
        LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
      ): Integer;

      function CreateLayoutItemFor(Control: TControl): TLayoutItem;

      function GetLayoutItemCount: Integer;
      
      procedure Initialize;

    public

      destructor Destroy; override;
      constructor Create;

      function AddLayoutItem(LayoutItem: TLayoutItem): Integer; 
      function AddControl(Control: TControl): Integer; 
      function AddLayoutManager(LayoutManager: TLayoutManager): Integer;

      procedure RemoveLayoutItem(LayoutItem: TLayoutItem);
      procedure RemoveLayoutItemByIndex(const Index: Integer);
      procedure RemoveControl(Control: TControl);
      procedure RemoveLayoutManager(LayoutManager: TLayoutManager);

      function GetLayoutItemByIndex(Index: Integer): TLayoutItem;

      function FindVisualSettingsHolderFor(LayoutItem: TLayoutItem): TLayoutItemVisualSettingsHolder;
      
      procedure ApplyLayout; virtual;
    
      property LayoutItemCount: Integer read GetLayoutItemCount;

      property LayoutItems[Index: Integer]: TLayoutItem
      read GetLayoutItemByIndex; default;

  end;

  TLayoutManagerBuilder = class abstract

    protected

      FLayoutManager: TLayoutManager;

      function CreateLayoutManager: TLayoutManager; virtual; abstract;

    public

      constructor Create; virtual;

      destructor Destroy; override;

      function AddControl(Control: TControl): TLayoutManagerBuilder; overload;
      function AddControls(Controls: array of TControl): TLayoutManagerBuilder; overload;

      function AddLayoutManager(LayoutManager: TLayoutManager): TLayoutManagerBuilder; overload;
      function AddLayoutManagers(LayoutManagers: array of TLayoutManager): TLayoutManagerBuilder; overload;

      function Build: TLayoutManager;
      function BuildAndDestroy: TLayoutManager;

  end;

implementation

uses

  ControlLayoutItem;

{ TLayoutItemVisualSettingsHolder }

constructor TLayoutItemVisualSettingsHolder.Create;
begin

  inherited;
  
end;

destructor TLayoutItemVisualSettingsHolder.Destroy;
begin

  FreeAndNil(FLayoutItem);
  inherited;

end;

{ TLayoutItemVisualSettingsHoldersEnumerator }

constructor TLayoutItemVisualSettingsHoldersEnumerator.Create(
  LayoutItemVisualSettingsHolders: TLayoutItemVisualSettingsHolders);
begin

  inherited Create(LayoutItemVisualSettingsHolders);
  
end;

function TLayoutItemVisualSettingsHoldersEnumerator.GetCurrentLayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
begin
                    
  Result := TLayoutItemVisualSettingsHolder(GetCurrent);
  
end;

{ TLayoutItemVisualSettingsHolders }

function TLayoutItemVisualSettingsHolders.FindByLayoutItem(
  LayoutItem: TLayoutItem
): TLayoutItemVisualSettingsHolder;
var SearchLayoutItemVisualSettingsHolderIndex: Integer;
begin

  SearchLayoutItemVisualSettingsHolderIndex := IndexOfByLayoutItem(LayoutItem);

  if SearchLayoutItemVisualSettingsHolderIndex >= 0 then
    Result := Self[SearchLayoutItemVisualSettingsHolderIndex]

  else Result := nil;

end;

function TLayoutItemVisualSettingsHolders.GetEnumerator: TLayoutItemVisualSettingsHoldersEnumerator;
begin

  Result := TLayoutItemVisualSettingsHoldersEnumerator.Create(Self);
  
end;

function TLayoutItemVisualSettingsHolders.
  GetLayoutItemVisualSettingsHolderByIndex(
    Index: Integer
  ): TLayoutItemVisualSettingsHolder;
begin

  Result := TLayoutItemVisualSettingsHolder(Get(Index));
  
end;

function TLayoutItemVisualSettingsHolders.IndexOfByLayoutItem(
  LayoutItem: TLayoutItem): Integer;
begin

  for Result := 0 to Count - 1 do
    if Self[Result].LayoutItem = LayoutItem then
      Exit;

  Result := -1;
  
end;

procedure TLayoutItemVisualSettingsHolders.Notify(Ptr: Pointer;
  Action: TListNotification);
begin

  if (Action = lnDeleted) and Assigned(Ptr) then
    TLayoutItemVisualSettingsHolder(Ptr).Free;

end;

procedure TLayoutItemVisualSettingsHolders.RemoveByLayoutItem(
  LayoutItem: TLayoutItem
);
var I: Integer;
begin

  for I := 0 to Count - 1 do
    if Self[I].LayoutItem = LayoutItem then begin
    
      Delete(I);
      Exit;
      
    end;
    
end;

procedure TLayoutItemVisualSettingsHolders.RemoveByLayoutItemForControl(
  Control: TControl
);
var I: Integer;
begin

  for I := 0 to Count - 1 do
    if 

       (Self[I].LayoutItem is TControlLayoutItem) and
       ((Self[I].LayoutItem as TControlLayoutItem).Control = Control)

    then begin
    
      Delete(I);
      Exit;
      
    end;
        
end;

procedure TLayoutItemVisualSettingsHolders.
  SetLayoutItemVisualSettingsHolderByIndex(
    Index: Integer;
    Value: TLayoutItemVisualSettingsHolder
  );
begin

  Put(Index, Value);
  
end;

{ TLayoutManager }

function TLayoutManager.AddControl(Control: TControl): Integer;
begin

  Result := AddLayoutItem(CreateLayoutItemFor(Control));

end;

function TLayoutManager.AddLayoutItem(LayoutItem: TLayoutItem): Integer;
begin

  Result :=

    GetIndexOfLayoutItemVisualSettingsHolder(
      CreateAndAddVisualSettingsHolderFor(LayoutItem)
    );
    
end;

function TLayoutManager.AddLayoutManager(
  LayoutManager: TLayoutManager): Integer;
begin

  Result := AddLayoutItem(LayoutManager as TLayoutItem);

end;

procedure TLayoutManager.ApplyLayout;
var LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
begin

  for 

      LayoutItemVisualSettingsHolder in
      FLayoutItemVisualSettingsHolders

  do begin
  
    if LayoutItemVisualSettingsHolder.LayoutItem is TLayoutManager then
      TLayoutManager(LayoutItemVisualSettingsHolder.LayoutItem).ApplyLayout;

    ApplyVisualSettingsForLayoutItem(LayoutItemVisualSettingsHolder);
    
  end;
    
end;

constructor TLayoutManager.Create;
begin

  inherited;

  Initialize;
    
end;

function TLayoutManager.CreateAndAddVisualSettingsHolderFor(
  LayoutItem: TLayoutItem
): TLayoutItemVisualSettingsHolder;
begin

  Result := CreateLayoutItemVisualSettingsHolder(LayoutItem);

  Result.LayoutItem := LayoutItem;
  
  FLayoutItemVisualSettingsHolders.Add(Result);
  
end;

function TLayoutManager.CreateAndAddVisualSettingsHolderFor(
  Control: TControl): TLayoutItemVisualSettingsHolder;
begin

  Result := CreateAndAddVisualSettingsHolderFor(TControlLayoutItem.Create(Control));
  
end;

function TLayoutManager.CreateAndAddVisualSettingsHolderFor(
  LayoutManager: TLayoutManager): TLayoutItemVisualSettingsHolder;
begin

  Result := CreateAndAddVisualSettingsHolderFor(LayoutManager as TLayoutItem);
  
end;

function TLayoutManager.CreateLayoutItemFor(Control: TControl): TLayoutItem;
begin

  Result := TControlLayoutItem.Create(Control);
  
end;

function TLayoutManager.CreateLayoutItemVisualSettingsHolderList: TLayoutItemVisualSettingsHolders;
begin

  Result := TLayoutItemVisualSettingsHolders.Create;
  
end;

destructor TLayoutManager.Destroy;
begin

  FreeAndNil(FLayoutItemVisualSettingsHolders);
  inherited;

end;

function TLayoutManager.FindVisualSettingsHolderFor(
  LayoutItem: TLayoutItem
): TLayoutItemVisualSettingsHolder;
begin

  Result := FLayoutItemVisualSettingsHolders.FindByLayoutItem(LayoutItem);

end;

function TLayoutManager.GetLayoutItemByIndex(
  Index: Integer
): TLayoutItem;
begin

  if (Index < 0) or (Index >= FLayoutItemVisualSettingsHolders.Count) then
    Result := nil

  else Result := FLayoutItemVisualSettingsHolders[Index].LayoutItem;

end;

function TLayoutManager.GetLayoutItemCount: Integer;
begin

  Result := FLayoutItemVisualSettingsHolders.Count;
  
end;

function TLayoutManager.GetIndexOfLayoutItemVisualSettingsHolder(
  LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder
): Integer;
begin

  Result :=
    FLayoutItemVisualSettingsHolders.IndexOf(
      LayoutItemVisualSettingsHolder
    );

end;

procedure TLayoutManager.Initialize;
begin

  FLayoutItemVisualSettingsHolders := 
    CreateLayoutItemVisualSettingsHolderList;
  
end;

procedure TLayoutManager.RemoveControl(Control: TControl);
begin

  FLayoutItemVisualSettingsHolders.RemoveByLayoutItemForControl(Control);
  
end;

procedure TLayoutManager.RemoveLayoutItem(LayoutItem: TLayoutItem);
begin

  FLayoutItemVisualSettingsHolders.RemoveByLayoutItem(LayoutItem);
  
end;

procedure TLayoutManager.RemoveLayoutItemByIndex(const Index: Integer);
begin

  FLayoutItemVisualSettingsHolders.Delete(Index);
  
end;

procedure TLayoutManager.RemoveLayoutManager(LayoutManager: TLayoutManager);
begin

  FLayoutItemVisualSettingsHolders.RemoveByLayoutItem(LayoutManager);
  
end;

{ TLayoutManagerBuilder }

function TLayoutManagerBuilder.AddControls(
  Controls: array of TControl
): TLayoutManagerBuilder;
var Control: TControl;
begin

  for Control in Controls do
    FLayoutManager.AddControl(Control);

  Result := Self;
    
end;

function TLayoutManagerBuilder.AddControl(Control: TControl): TLayoutManagerBuilder;
begin

  FLayoutManager.AddControl(Control);

  Result := Self;
  
end;

function TLayoutManagerBuilder.AddLayoutManagers(
  LayoutManagers: array of TLayoutManager
): TLayoutManagerBuilder;
var LayoutManager: TLayoutManager;
begin

  for LayoutManager in LayoutManagers do
    FLayoutManager.AddLayoutManager(LayoutManager);

  Result := Self;
    
end;

function TLayoutManagerBuilder.AddLayoutManager(
  LayoutManager: TLayoutManager
): TLayoutManagerBuilder;
begin

  FLayoutManager.AddLayoutManager(LayoutManager);

  Result := Self;
  
end;

function TLayoutManagerBuilder.Build: TLayoutManager;
begin

  Result := FLayoutManager;
  
end;

function TLayoutManagerBuilder.BuildAndDestroy: TLayoutManager;
begin

  Result := Build;

  FLayoutManager := nil;
  
  Destroy;
  
end;

constructor TLayoutManagerBuilder.Create;
begin

  inherited;

  FLayoutManager := CreateLayoutManager;
  
end;

destructor TLayoutManagerBuilder.Destroy;
begin

  inherited;

end;

end.
