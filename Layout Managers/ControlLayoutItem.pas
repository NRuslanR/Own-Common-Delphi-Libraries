unit ControlLayoutItem;

interface

uses

  Windows,
  LayoutItem,
  Controls,
  StdCtrls,
  SysUtils,
  Classes;

type

  TControlLayoutItem = class (TLayoutItem)

    protected

      FControl: TControl;

      function GetLeft: Integer; override;
      function GetTop: Integer; override;
      function GetHeight: Integer; override;
      function GetWidth: Integer; override;

      procedure SetLeft(const Value: Integer); override;
      procedure SetTop(const Value: Integer); override;
      procedure SetHeight(const Value: Integer); override;
      procedure SetWidth(const Value: Integer); override;

      procedure AdjustControlSizeIfItIsCheckBox;
      
    public

      constructor Create; overload;
      constructor Create(Control: TControl); overload;

    published

      property Control: TControl read FControl write FControl;
      
  end;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{ TControlLayoutItem }

procedure TControlLayoutItem.AdjustControlSizeIfItIsCheckBox;
begin

  if not (FControl is TCheckBox) then Exit;

  AdjustCheckBoxSize(FControl as TCheckBox);
  
end;

constructor TControlLayoutItem.Create(Control: TControl);
begin

  inherited Create;

  Self.Control := Control;
  
end;

constructor TControlLayoutItem.Create;
begin

  inherited;

end;

function TControlLayoutItem.GetHeight: Integer;
begin

  AdjustControlSizeIfItIsCheckBox;
  
  Result := Control.Height;
  
end;

function TControlLayoutItem.GetLeft: Integer;
begin
  
  Result := Control.Left;
  
end;

function TControlLayoutItem.GetTop: Integer;
begin

  Result := Control.Top;

end;

function TControlLayoutItem.GetWidth: Integer;
begin

  AdjustControlSizeIfItIsCheckBox;
  
  Result := Control.Width;
  
end;


procedure TControlLayoutItem.SetHeight(const Value: Integer);
begin

  Control.Height := Value;

end;

procedure TControlLayoutItem.SetLeft(const Value: Integer);
begin

  Control.Left := Value;

end;

procedure TControlLayoutItem.SetTop(const Value: Integer);
begin

  Control.Top := Value;

end;

procedure TControlLayoutItem.SetWidth(const Value: Integer);
begin

  Control.Width := Value;

end;

end.
