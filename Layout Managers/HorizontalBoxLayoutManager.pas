unit HorizontalBoxLayoutManager;

interface

uses

  BoxLayoutManager,
  Windows,
  LayoutManager,
  LayoutItem,
  Controls,
  SysUtils,
  Classes;

type

  THorizontalBoxLayoutManager = class (TBoxLayoutManager)

    protected

      function GetHeight: Integer; override;

      procedure SetLeft(const Value: Integer); override;
      procedure SetTop(const Value: Integer); override;

      procedure ArrangeOneLayoutItemAfterOther(
        PrecedingLayoutItem, SucceedingLayoutItem: TLayoutItem;
        const Gap: Integer
      ); override;
      
  end;

  THorizontalBoxLayoutManagerBuilder = class (TBoxLayoutManagerBuilder)

    protected

      function CreateLayoutManager: TLayoutManager; override;

    public

      constructor Create; override;

  end;


implementation

uses

  AuxDebugFunctionsUnit;
  
{ THorizontalBoxLayoutManager }

procedure THorizontalBoxLayoutManager.ArrangeOneLayoutItemAfterOther(
  PrecedingLayoutItem, SucceedingLayoutItem: TLayoutItem;
  const Gap: Integer
);
begin

  if Gap < 0 then
    DebugOutput(Gap);
    
  SucceedingLayoutItem.Left := PrecedingLayoutItem.Right + Gap;
  SucceedingLayoutItem.Top := PrecedingLayoutItem.Top;

end;

function THorizontalBoxLayoutManager.GetHeight: Integer;
var LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
    LayoutItem: TLayoutItem;
    CurrentHeight: Integer;
begin

  Result := 0;
  
  for

      LayoutItemVisualSettingsHolder in
      LayoutItemVisualSettingsHolders

  do begin

    LayoutItem := LayoutItemVisualSettingsHolder.LayoutItem;

    CurrentHeight := LayoutItem.Height;
    
    if (Result = 0) or (Result < CurrentHeight) then
      Result := CurrentHeight;
    
  end;

end;

procedure THorizontalBoxLayoutManager.SetLeft(const Value: Integer);
var FirstLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
    NextLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
    I: Integer;
    NextLayoutItemLeft: Integer;
    DifferenceBetweenOldAndNewLeft: Integer;
    LayoutItem: TLayoutItem;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders[0];

  if not Assigned(FirstLayoutItemVisualSettingsHolder) then Exit;

  DifferenceBetweenOldAndNewLeft :=
    Value - FirstLayoutItemVisualSettingsHolder.LayoutItem.Left;

  FirstLayoutItemVisualSettingsHolder.LayoutItem.Left := Value;
    {FirstLayoutItemVisualSettingsHolder.LayoutItem.Width +
    FirstLayoutItemVisualSettingsHolder.Gap;}

  for I := 1 to LayoutItemVisualSettingsHolders.Count - 1 do begin

    NextLayoutItemVisualSettingsHolder :=
      LayoutItemVisualSettingsHolders[I];
      
    //NextLayoutItemVisualSettingsHolder.LayoutItem.Left := NextLayoutItemLeft;

    LayoutItem := NextLayoutItemVisualSettingsHolder.LayoutItem;

    LayoutItem.Left := LayoutItem.Left + DifferenceBetweenOldAndNewLeft;
   { NextLayoutItemLeft
    NextLayoutItemLeft :=
      NextLayoutItemLeft +
      NextLayoutItemVisualSettingsHolder.LayoutItem.Width +
      NextLayoutItemVisualSettingsHolder.Gap;  }
      
  end;

end;

procedure THorizontalBoxLayoutManager.SetTop(const Value: Integer);
var LayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  for

      LayoutItemVisualSettingsHolder in
      LayoutItemVisualSettingsHolders

  do LayoutItemVisualSettingsHolder.LayoutItem.Top := Value;

end;

{ THorizontalBoxLayoutManagerBuilder }

constructor THorizontalBoxLayoutManagerBuilder.Create;
begin
  inherited;

end;

function THorizontalBoxLayoutManagerBuilder.CreateLayoutManager: TLayoutManager;
begin

  Result := THorizontalBoxLayoutManager.Create;
  
end;

end.
