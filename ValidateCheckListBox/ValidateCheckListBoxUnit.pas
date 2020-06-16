unit ValidateCheckListBoxUnit;

interface

uses

  Windows, SysUtils, Classes, CheckLst, Graphics;

const

  DEFAULT_INVALID_COLOR = $00A087FF;
  DEFAULT_INVALID_HINT = '';
  
type

  TOnCheckListBoxValidateEvent =
    procedure(Sender: TObject; var IsValid: Boolean) of object;
    
  TValidateCheckListBox = class(TCheckListBox)

    strict protected

      FInvalidColor: TColor;
      FInvalidHint: String;

      procedure Init(
        const AInvalidHint: String = DEFAULT_INVALID_HINT;
        const AInvalidColor: TColor = DEFAULT_INVALID_COLOR
      );

      function AreSelectedItemsExists: Boolean;

      procedure OnClickCheckHandle(Sender: TObject);
      procedure UpdateInvalidProperties(const AIsValid: Boolean);

    public

      constructor Create(AOwner: TComponent); overload; override;

      constructor Create(
        const AInvalidColor: TColor;
        AOwner: TComponent
      ); overload;

      constructor Create(
        const AInvalidHint: String;
        const AInvalidColor: TColor;
        AOwner: TComponent
      ); overload;

      function IsValid: Boolean;
      procedure ResetInvalid;

    published

      property InvalidColor: TColor read FInvalidColor write FInvalidColor;
      property InvalidHint: String read FInvalidHint write FInvalidHint;

  end;

procedure Register;

implementation

{ TValidateCheckListBox }

constructor TValidateCheckListBox.Create(AOwner: TComponent);
begin

  inherited;
  Init;
  
end;

constructor TValidateCheckListBox.Create(const AInvalidColor: TColor;
  AOwner: TComponent);
begin

  inherited Create(AOwner);
  Init(DEFAULT_INVALID_HINT);

end;

function TValidateCheckListBox.AreSelectedItemsExists: Boolean;
var I: Integer;
begin

  for I := 0 to Count - 1 do
    if Checked[I] then begin

      Result := True;
      Exit;

    end;

  Result := False;
  
end;

constructor TValidateCheckListBox.Create(const AInvalidHint: String;
  const AInvalidColor: TColor; AOwner: TComponent);
begin

  inherited Create(AOwner);
  Init(DEFAULT_INVALID_HINT);
  
end;

procedure TValidateCheckListBox.Init(const AInvalidHint: String;
  const AInvalidColor: TColor);
begin

  FInvalidColor := AInvalidColor;
  FInvalidHint := AInvalidHint;
  OnClickCheck := OnClickCheckHandle;

end;

function TValidateCheckListBox.IsValid: Boolean;
begin

  Result := AreSelectedItemsExists;

  UpdateInvalidProperties(Result);

end;

procedure TValidateCheckListBox.OnClickCheckHandle(Sender: TObject);
begin

  IsValid;

end;

procedure TValidateCheckListBox.ResetInvalid;
begin

  UpdateInvalidProperties(True);

end;

procedure TValidateCheckListBox.UpdateInvalidProperties(
  const AIsValid: Boolean);
begin

  if AIsValid then begin

    Color := clWindow;
    Hint := '';
    ShowHint := False;

  end

  else begin

    Color := FInvalidColor;
    Hint := FInvalidHint;
    ShowHint := True;
    
  end;

end;

procedure Register;
begin

  RegisterComponents('Additional', [TValidateCheckListBox]);
  
end;

end.
