unit RegExprValidateEditUnit;

interface

  uses Windows, Messages, StdCtrls, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ValidateEditUnit, RegExpr;

  type

    TRegExprValidateEdit = class(TValidateEdit)

      strict protected

        FRegExpr: TRegExpr;

        procedure CreateRegExprObject(const RegularExpression: String);
        procedure OnValidateHandle(var Text: String; var IsValid: Boolean);

        function GetRegularExpression: String;
        procedure SetRegularExpression(const RegularExpression: String);

      public

        constructor Create(AOwner: TComponent); overload; override;
        constructor Create(const InvalidColor: TColor; AOwner: TComponent); overload;
        constructor Create(const ARegularExpression: String; AOwner: TComponent); overload;
        constructor Create(const ARegularExpression: String; const InvalidColor: TColor; AOwner: TComponent); overload;

      published
      
        property RegularExpression: String read GetRegularExpression
        write SetRegularExpression;

    end;

procedure Register;

implementation

{ TRegExpValidateEdit }

constructor TRegExprValidateEdit.Create(AOwner: TComponent);
begin

  inherited Create(OnValidateHandle, AOwner);

  CreateRegExprObject('.*');

end;

constructor TRegExprValidateEdit.Create(const ARegularExpression: String;
  const InvalidColor: TColor; AOwner: TComponent);
begin

  Create(InvalidColor, AOwner);

  RegularExpression := ARegularExpression;

end;

constructor TRegExprValidateEdit.Create(const ARegularExpression: String;
  AOwner: TComponent);
begin

  Create(AOwner);

  RegularExpression := ARegularExpression;

end;


constructor TRegExprValidateEdit.Create(const InvalidColor: TColor;
  AOwner: TComponent);
begin

  inherited Create(InvalidColor, OnValidateHandle, AOwner);

  CreateRegExprObject('.*');

end;

procedure TRegExprValidateEdit.CreateRegExprObject(
  const RegularExpression: String);
begin

  FRegExpr := TRegExpr.Create;
  FRegExpr.Expression := RegularExpression;

end;

function TRegExprValidateEdit.GetRegularExpression: String;
begin

  Result := FRegExpr.Expression;

end;

procedure TRegExprValidateEdit.SetRegularExpression(
  const RegularExpression: String);
var InputText: String;
begin

  FRegExpr.Expression := RegularExpression;

  OnValidateHandle(InputText, FIsValid);

  Text := InputText;
  
end;

procedure TRegExprValidateEdit.OnValidateHandle(var Text: String;
  var IsValid: Boolean);
begin

  IsValid := FRegExpr.Exec(Text);

end;

procedure Register;
begin
  RegisterComponents('Standard', [TRegExprValidateEdit]);
end;

end.
