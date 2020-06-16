unit AutoScrollableMemo;

interface

uses

  Windows,
  Messages,
  StdCtrls,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs;

type

  TAutoScrollableMemo = class (TMemo)

    private

      FAutoScrollable: Boolean;
      
      procedure OnWinCommandReceived(var Message: TWMCommand); message WM_COMMAND;

    protected

      procedure UpdateScrollBarsVisibility;
      procedure SetAutoScrollable(const AutoScrollable: Boolean);
      procedure SetScrollBars(Value: TScrollStyle);

    published

      property AutoScrollable: Boolean
      read FAutoScrollable write SetAutoScrollable;
      
  end;

procedure Register;

implementation

uses

  AuxWindowsFunctionsUnit;

{ TAutoScrollableMemo }

procedure TAutoScrollableMemo.OnWinCommandReceived(var Message: TWMCommand);
begin

  if
      (Message.Ctl = Handle)
       and (Message.NotifyCode = EN_UPDATE)
       and FAutoScrollable

  then begin

    UpdateScrollBarsVisibility;

  end;

  inherited;
  
end;

procedure TAutoScrollableMemo.SetAutoScrollable(const AutoScrollable: Boolean);
begin

  FAutoScrollable := AutoScrollable;

  UpdateScrollBarsVisibility;
  
end;

procedure TAutoScrollableMemo.SetScrollBars(Value: TScrollStyle);
begin

  if not FAutoScrollable then inherited;

end;

procedure TAutoScrollableMemo.UpdateScrollBarsVisibility;
var TextLength: Integer;
begin

  TextLength := CalculateTextLength;

  Pare

end;

end.
