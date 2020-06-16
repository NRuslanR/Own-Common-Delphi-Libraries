unit ValidateRichEdit;

interface

uses
  Windows, Messages, StdCtrls, ComCtrls, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

const
  INVALID_COLOR_DEFAULT = $00A087FF;

type

  TValidateRichEdit = class(TRichEdit)

  published

    type TOnValidateEvent = procedure(var Text: string; var IsValid: Boolean) of object;

    strict protected
    { Private declarations }

      FOnValidate: TOnValidateEvent;
      FInvalidColor: TColor;
      FValidColor: TColor;
      FInvalidHint: String;
      FIsValid: Boolean;

      procedure Init(
        const AInvalidColor: TColor = INVALID_COLOR_DEFAULT;
        AOnValidate: TOnValidateEvent = nil;
        const AInvalidHint: String = ''
      );

      procedure OnChangeHandle(Sender: TObject);
      procedure SetOnValidate(AOnValidate: TOnValidateEvent);
      procedure UpdateValidationProperties;
      
      function GetIsValid: Boolean;

      procedure SetLines(Value: TStrings);

  public

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOnValidate: TOnValidateEvent; AOwner: TComponent); overload;
    constructor Create(const AInvalidColor: TColor; AOwner: TComponent); overload;
    constructor Create(const AInvalidColor: TColor; AOnValidate: TOnValidateEvent; AOwner: TComponent); overload;

    procedure CheckValidAndUpdateView;
    
    property IsValid: Boolean read GetIsValid;

  published

    property InvalidHint: String read FInvalidHint write FInvalidHint;
    property InvalidColor: TColor read FInvalidColor write FInvalidColor;
    property OnValidate: TOnValidateEvent read FOnValidate write SetOnValidate;
    
  end;

procedure Register;

implementation

{ TValidateRichEdit }

constructor TValidateRichEdit.Create(AOwner: TComponent);
begin

  inherited;
  Init;

end;

constructor TValidateRichEdit.Create(const AInvalidColor: TColor;
  AOwner: TComponent);
begin

  inherited Create(AOwner);

  Init(AInvalidColor);

end;

constructor TValidateRichEdit.Create(AOnValidate: TOnValidateEvent;
  AOwner: TComponent);
begin

  inherited Create(AOwner);

  Init(INVALID_COLOR_DEFAULT, AOnValidate);

end;

procedure TValidateRichEdit.CheckValidAndUpdateView;
var CurrentText: String;
begin

  CurrentText := Self.Text;

  FOnValidate(CurrentText, FIsValid);

  Self.Text := CurrentText;

  UpdateValidationProperties;

end;

constructor TValidateRichEdit.Create(
  const AInvalidColor: TColor;
  AOnValidate: TOnValidateEvent;
  AOwner: TComponent
);
begin

  inherited Create(AOwner);

  Init(AInvalidColor, AOnValidate);

end;

function TValidateRichEdit.GetIsValid: Boolean;
begin

  if FIsValid then
    CheckValidAndUpdateView;

  Result := FIsValid;
  
end;

procedure TValidateRichEdit.Init(
  const AInvalidColor: TColor;
  AOnValidate: TOnValidateEvent;
  const AInvalidHint: String
);
begin

  FInvalidColor := AInvalidColor;
  FValidColor := Self.Color;
  Self.OnChange := OnChangeHandle;
  FIsValid := True;
  FInvalidHint := AInvalidHint;
  FOnValidate := AOnValidate;
  Self.ShowHint := False;


end;

procedure TValidateRichEdit.OnChangeHandle(Sender: TObject);
var CurrentText: String;
begin

  inherited;
  
  if not Assigned(FOnValidate) then Exit;

  CheckValidAndUpdateView;

end;

procedure TValidateRichEdit.UpdateValidationProperties;
begin

  if not FIsValid then begin

    Self.Hint := FInvalidHint;
    Self.ShowHint := True;
    Self.Color := FInvalidColor;

  end

  else begin

    Self.Hint := '';
    Self.ShowHint := False;
    Self.Color := FValidColor;

  end;

end;

procedure TValidateRichEdit.SetLines(Value: TStrings);
begin

  inherited;

  IsValid;
  
end;

procedure TValidateRichEdit.SetOnValidate(AOnValidate: TOnValidateEvent);
begin

  FOnValidate := AOnValidate;

  if not Assigned(FOnValidate) then begin

    FIsValid := True;
    UpdateValidationProperties;

  end;
  
end;

procedure Register;
begin

  RegisterComponents('Win32', [TValidateRichEdit]);

end;

end.
