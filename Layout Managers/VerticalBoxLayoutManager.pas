unit VerticalBoxLayoutManager;

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

  TVerticalBoxLayoutManager = class (TBoxLayoutManager)

    protected

      function GetWidth: Integer; override;

      procedure SetLeft(const Value: Integer); override;
      procedure SetTop(const Value: Integer); override;

      procedure ArrangeOneLayoutItemAfterOther(
        PrecedingLayoutItem, SucceedingLayoutItem: TLayoutItem;
        const Gap: Integer
      ); override;

  end;

  TVerticalBoxLayoutManagerBuilder = class (TBoxLayoutManagerBuilder)

    protected

      function CreateLayoutManager: TLayoutManager; override;

    public

      constructor Create; override;

  end;

implementation

uses

  ControlLayoutItem,
  AuxDebugFunctionsUnit;
  
{ TVerticalBoxLayoutManager }

procedure TVerticalBoxLayoutManager.ArrangeOneLayoutItemAfterOther(
  PrecedingLayoutItem, SucceedingLayoutItem: TLayoutItem; const Gap: Integer);
begin

  SucceedingLayoutItem.Top := PrecedingLayoutItem.Bottom + Gap;
  SucceedingLayoutItem.Left := PrecedingLayoutItem.Left;
  
end;

function TVerticalBoxLayoutManager.GetWidth: Integer;
var LayoutItemVisualSettingsHolder: TLayoutItemVisualSettingsHolder;
    LayoutItem: TLayoutItem;
    CurrentWidth: Integer;
begin

  Result := 0;
  
  for  

      LayoutItemVisualSettingsHolder in
      LayoutItemVisualSettingsHolders

  do begin

    LayoutItem := LayoutItemVisualSettingsHolder.LayoutItem;

    CurrentWidth := LayoutItem.Width;
    
    if (Result = 0) or (Result < CurrentWidth) then
      Result := CurrentWidth;
    
  end;
  
end;

procedure TVerticalBoxLayoutManager.SetLeft(const Value: Integer);
var LayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
begin

  for

      LayoutItemVisualSettingsHolder in
      LayoutItemVisualSettingsHolders

  do LayoutItemVisualSettingsHolder.LayoutItem.Left := Value;

end;

{ One SetTop with the accounting of the LayoutItems' current top and
  Other SetTop without it. Similiarly for SetLeft too }
procedure TVerticalBoxLayoutManager.SetTop(const Value: Integer);
var FirstLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
    NextLayoutItemVisualSettingsHolder: TBoxedLayoutItemVisualSettingsHolder;
    I: Integer;
    NextLayoutItemTop: Integer;
    LayoutItem: TLayoutItem;
    DifferenceBetweenOldAndNewTop: Integer;
begin

  FirstLayoutItemVisualSettingsHolder :=
    LayoutItemVisualSettingsHolders[0];

  if not Assigned(FirstLayoutItemVisualSettingsHolder) then Exit;

  DifferenceBetweenOldAndNewTop :=
    Value - FirstLayoutItemVisualSettingsHolder.LayoutItem.Top;
    
  FirstLayoutItemVisualSettingsHolder.LayoutItem.Top := Value;

  {
  NextLayoutItemTop :=
    Value +
    FirstLayoutItemVisualSettingsHolder.LayoutItem.Height +
    FirstLayoutItemVisualSettingsHolder.Gap;}

  for I := 1 to LayoutItemVisualSettingsHolders.Count - 1 do begin

    NextLayoutItemVisualSettingsHolder := LayoutItemVisualSettingsHolders[I];

    //NextLayoutItemVisualSettingsHolder.LayoutItem.Top := NextLayoutItemTop;

    LayoutItem := NextLayoutItemVisualSettingsHolder.LayoutItem;

    LayoutItem.Top := LayoutItem.Top + DifferenceBetweenOldAndNewTop;
    
    {
    NextLayoutItemTop :=
      NextLayoutItemTop +
      NextLayoutItemVisualSettingsHolder.LayoutItem.Height +
      NextLayoutItemVisualSettingsHolder.Gap;}
      
  end;

end;

{ TVerticalBoxLayoutManagerBuilder }

constructor TVerticalBoxLayoutManagerBuilder.Create;
begin
  inherited;

end;

function TVerticalBoxLayoutManagerBuilder.CreateLayoutManager: TLayoutManager;
begin

  Result := TVerticalBoxLayoutManager.Create;
  
end;

end.
