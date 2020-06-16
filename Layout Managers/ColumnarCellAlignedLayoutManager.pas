unit ColumnarCellAlignedLayoutManager;

interface

uses

  BoxLayoutManager,
  HorizontalBoxLayoutManager,
  Windows,
  LayoutManager,
  LayoutItem,
  Controls,
  SysUtils,
  Classes,
  VariantListUnit;

type

  { Refactor }
  TColumnarCellAlignedLayoutManager = class (THorizontalBoxLayoutManager)

    protected

      FInternalElementHeightsOfLayoutItems: TVariantList;
      FCurrentElementsIndexOfLayoutItems: Integer;
      
      procedure AlignElementsOfLayoutItemsByVertically;
      
      function GetNextElementHeightsOfLayoutItems(
        var ElementHeightsOfLayoutItems: TVariantList
      ): Boolean;

      function GetMaxLayoutItemElementHeight(
        ElementHeightsOfLayoutItems: TVariantList
      ): Integer;

      procedure SetTopsToElementsOfLayoutItems(
        TopsOfLayoutItemElements: TVariantList
      );
      
    public

      destructor Destroy; override;
      
      procedure ApplyLayout; override;

  end;

  TColumnarCellAlignedLayoutManagerBuilder = class (THorizontalBoxLayoutManagerBuilder)

    protected

      function CreateLayoutManager: TLayoutManager; override;

    public

      constructor Create; override;

  end;

implementation

uses

  AuxDebugFunctionsUnit,
  ControlLayoutItem,
  VerticalBoxLayoutManager;
  
{ TColumnarCellAlignedLayoutManager }

procedure TColumnarCellAlignedLayoutManager.AlignElementsOfLayoutItemsByVertically;
var CurrentLayoutItemElementsTop: Integer;
    ElementHeightsOfLayoutItems: TVariantList;
    TopsOfLayoutItemElements: TVariantList;
    MaxLayoutItemElementHeight: Integer;
begin

  CurrentLayoutItemElementsTop := 0;
  TopsOfLayoutItemElements := nil;

  try

    while GetNextElementHeightsOfLayoutItems(ElementHeightsOfLayoutItems)
    do begin

      MaxLayoutItemElementHeight :=
        GetMaxLayoutItemElementHeight(ElementHeightsOfLayoutItems);

      if not Assigned(TopsOfLayoutItemElements) then
        TopsOfLayoutItemElements := TVariantList.Create;

      if CurrentLayoutItemElementsTop = 0 then begin

        CurrentLayoutItemElementsTop := Self[0].Top;
        
        TopsOfLayoutItemElements.Add(CurrentLayoutItemElementsTop);

      end;

      CurrentLayoutItemElementsTop :=
        CurrentLayoutItemElementsTop + MaxLayoutItemElementHeight;

      TopsOfLayoutItemElements.Add(CurrentLayoutItemElementsTop);

    end;

    if Assigned(TopsOfLayoutItemElements) then
      SetTopsToElementsOfLayoutItems(TopsOfLayoutItemElements);

  finally

    FCurrentElementsIndexOfLayoutItems := 0;
    
    FreeAndNil(TopsOfLayoutItemElements);
    FreeAndNil(FInternalElementHeightsOfLayoutItems);

  end;
  
end;

procedure TColumnarCellAlignedLayoutManager.ApplyLayout;
begin

  inherited;

  AlignElementsOfLayoutItemsByVertically;

end;

destructor TColumnarCellAlignedLayoutManager.Destroy;
begin

  FreeAndNil(FInternalElementHeightsOfLayoutItems);
  inherited;

end;

function TColumnarCellAlignedLayoutManager.GetMaxLayoutItemElementHeight(
  ElementHeightsOfLayoutItems: TVariantList
): Integer;
var CurrentElementHeight: Integer;
begin

  Result := 0;

  for CurrentElementHeight in ElementHeightsOfLayoutItems do
    if Result < CurrentElementHeight then
      Result := CurrentElementHeight;

end;

function TColumnarCellAlignedLayoutManager.GetNextElementHeightsOfLayoutItems(
  var ElementHeightsOfLayoutItems: TVariantList
): Boolean;
var LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
    LayoutItem: TLayoutItem;
    VerticalBoxLayoutManager: TVerticalBoxLayoutManager;
    LayoutManagerItem: TLayoutItem;
    LayoutItemElementHeight: Integer;
    LayoutManagerItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;

    function IsAnyNonZeroElementHeightExists(
      TargetElementHeightsOfLayoutItems: TVariantList
    ): Boolean;
    var ElementHeight: Integer;
    begin

      for ElementHeight in TargetElementHeightsOfLayoutItems do
        if ElementHeight > 0 then begin

          Result := True;
          Exit;

        end;

      Result := False;

    end;
    
begin

  if not Assigned(FInternalElementHeightsOfLayoutItems) then
      FInternalElementHeightsOfLayoutItems := TVariantList.Create

  else FInternalElementHeightsOfLayoutItems.Clear;
  
  for

      LayoutItemVisualSettingsHolder in
      LayoutItemVisualSettingsHolders

  do begin

    LayoutItem := LayoutItemVisualSettingsHolder.LayoutItem;

    if LayoutItem is TVerticalBoxLayoutManager then begin

      VerticalBoxLayoutManager := LayoutItem as TVerticalBoxLayoutManager;

      LayoutManagerItem :=
        VerticalBoxLayoutManager[FCurrentElementsIndexOfLayoutItems];

      LayoutManagerItemVisualSettingsHolder :=
      
        VerticalBoxLayoutManager.FindVisualSettingsHolderFor(
          LayoutManagerItem
        ) as TBoxedLayoutItemVisualSettingsHolder;

      if not Assigned(LayoutManagerItem) then
        LayoutItemElementHeight := 0

      else
        LayoutItemElementHeight :=
          LayoutManagerItem.Height +
          LayoutManagerItemVisualSettingsHolder.Gap;

    end

    else if FCurrentElementsIndexOfLayoutItems = 0 then
      LayoutItemElementHeight := LayoutItem.Height

    else LayoutItemElementHeight := 0;

    FInternalElementHeightsOfLayoutItems.Add(LayoutItemElementHeight);

  end;

  ElementHeightsOfLayoutItems := FInternalElementHeightsOfLayoutItems;

  Inc(FCurrentElementsIndexOfLayoutItems);
  
  Result := IsAnyNonZeroElementHeightExists(ElementHeightsOfLayoutItems);

end;

procedure TColumnarCellAlignedLayoutManager.SetTopsToElementsOfLayoutItems(
  TopsOfLayoutItemElements: TVariantList
);
var LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
    LayoutItem: TLayoutItem;
    VerticalBoxLayoutManager: TVerticalBoxLayoutManager;
    CurrentTopOfElementsOfLayoutItems: Integer;
    I: Integer;
    PrevLayoutManagerItem, LayoutManagerItem: TLayoutItem;
    PrevLayoutManagerItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  for

    LayoutItemVisualSettingsHolder in
    LayoutItemVisualSettingsHolders

  do begin

    LayoutItem := LayoutItemVisualSettingsHolder.LayoutItem;

    if LayoutItem is TVerticalBoxLayoutManager then begin

      VerticalBoxLayoutManager := LayoutItem as TVerticalBoxLayoutManager;

      for I := 0 to VerticalBoxLayoutManager.LayoutItemCount - 1 do begin

        LayoutManagerItem := VerticalBoxLayoutManager[I];

        if I >= TopsOfLayoutItemElements.Count then Break;

        if LayoutManagerItem is TControlLayoutItem then
          DebugOutput(TControlLayoutItem(LayoutManagerItem).Control.Name +
            ' top: ' + IntToStr(LayoutManagerItem.Top) +
            ', assigned top:' + IntToStr(TopsOfLayoutItemElements[I])
          )

        else DebugOutput('LayoutManager top: ' +
              IntToStr(LayoutManagerItem.Top) + ', assigned top: ' +
              IntToStr(TopsOfLayoutItemElements[I])
              );

        LayoutManagerItem.Top := TopsOfLayoutItemElements[I];
        
      end;

      while I < VerticalBoxLayoutManager.LayoutItemCount do begin

        LayoutManagerItem := VerticalBoxLayoutManager[I];
        PrevLayoutManagerItem := VerticalBoxLayoutManager[I - 1];

        { Refactor }
        PrevLayoutManagerItemVisualSettingsHolder :=

          VerticalBoxLayoutManager.FindVisualSettingsHolderFor(
            PrevLayoutManagerItem
          ) as TBoxedLayoutItemVisualSettingsHolder;

        { Refactor }
        LayoutManagerItem.Top :=
          PrevLayoutManagerItem.Bottom +
          PrevLayoutManagerItemVisualSettingsHolder.Gap;

      end;

    end

    else LayoutItem.Top := TopsOfLayoutItemElements[0];

  end;
    
end;

{ TColumnarCellAlignedLayoutManagerBuilder }

constructor TColumnarCellAlignedLayoutManagerBuilder.Create;
begin
  inherited;

end;

function TColumnarCellAlignedLayoutManagerBuilder.CreateLayoutManager: TLayoutManager;
begin

  Result := TColumnarCellAlignedLayoutManager.Create;
  
end;

end.
