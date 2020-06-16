unit LayoutItem;

interface

uses

  Windows,
  SysUtils,
  Classes;

type

  TLayoutItem = class abstract (TObject)

    protected

      function GetLeft: Integer; virtual; abstract;
      function GetTop: Integer; virtual; abstract;
      function GetRight: Integer; virtual;
      function GetBottom: Integer; virtual;
      function GetBoundsRect: TRect; virtual;
      function GetHeight: Integer; virtual; abstract;
      function GetWidth: Integer; virtual; abstract;

      procedure SetLeft(const Value: Integer); virtual; abstract;
      procedure SetTop(const Value: Integer); virtual; abstract;
      procedure SetRight(const Value: Integer); virtual;
      procedure SetBottom(const Value: Integer); virtual;
      procedure SetBoundsRect(const Value: TRect); virtual; 
      procedure SetHeight(const Value: Integer); virtual; abstract;
      procedure SetWidth(const Value: Integer); virtual; abstract;

    public

      destructor Destroy; override;
      
    published

      property Left: Integer read GetLeft write SetLeft;
      property Top: Integer read GetTop write SetTop;
      property Right: Integer read GetRight write SetRight;
      property Bottom: Integer read GetBottom write SetBottom;
      property Width: Integer read GetWidth write SetWidth;
      property Height: Integer read GetHeight write SetHeight;
      property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;

  end;

implementation

uses

  AuxDebugFunctionsUnit,
  ControlLayoutItem;
{ TLayoutItem }

destructor TLayoutItem.Destroy;
const counter: Integer = 0;
begin


  if Self is TControlLayoutItem then
    DebugOutput(TControlLayoutItem(Self).Control.Name)

  else begin
                Inc(counter);
    DebugOutput('Layout' + IntToStr(counter));

  end;
  inherited;

end;

function TLayoutItem.GetBottom: Integer;
begin

  Result := Top + Height;

end;

function TLayoutItem.GetBoundsRect: TRect;
begin

  Result := Rect(Left, Top, Right, Bottom);
  
end;

function TLayoutItem.GetRight: Integer;
begin

  Result := Left + Width;

end;

procedure TLayoutItem.SetBottom(const Value: Integer);
begin

  Top := Value - Height;
  
end;

procedure TLayoutItem.SetBoundsRect(const Value: TRect);
begin

  Left := Value.Left;
  Top := Value.Top;
  Width := Value.Right - Value.Left;
  Height := Value.Bottom - Value.Top;

end;

procedure TLayoutItem.SetRight(const Value: Integer);
begin

  Left := Value - Width;
  
end;

end.
