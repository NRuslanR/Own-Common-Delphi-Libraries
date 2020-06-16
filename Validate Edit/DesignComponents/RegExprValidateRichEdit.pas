unit RegExprValidateRichEdit;

interface

  uses Windows, Messages, StdCtrls, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ValidateRichEdit, RegExpr;

  type

    TRegExprValidateRichEdit = class(TValidateRichEdit)

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

{ TRegExpValidateMemo }

constructor TRegExprValidateRichEdit.Create(AOwner: TComponent);
begin

  inherited Create(OnValidateHandle, AOwner);

  CreateRegExprObject('.*');

end;

constructor TRegExprValidateRichEdit.Create(const ARegularExpression: String;
  const InvalidColor: TColor; AOwner: TComponent);
begin

  Create(InvalidColor, AOwner);

  RegularExpression := ARegularExpression;

end;

constructor TRegExprValidateRichEdit.Create(const ARegularExpression: String;
  AOwner: TComponent);
begin

  Create(AOwner);

  RegularExpression := ARegularExpression;

end;


constructor TRegExprValidateRichEdit.Create(const InvalidColor: TColor;
  AOwner: TComponent);
begin

  inherited Create(InvalidColor, OnValidateHandle, AOwner);

  CreateRegExprObject('.*');

end;

procedure TRegExprValidateRichEdit.CreateRegExprObject(
  const RegularExpression: String);
begin

  FRegExpr := TRegExpr.Create;
  FRegExpr.Expression := RegularExpression;

end;

function TRegExprValidateRichEdit.GetRegularExpression: String;
begin

  Result := FRegExpr.Expression;

end;

procedure TRegExprValidateRichEdit.SetRegularExpression(
  const RegularExpression: String);
begin

  FRegExpr.Expression := RegularExpression;
  
end;

procedure TRegExprValidateRichEdit.OnValidateHandle(var Text: String;
  var IsValid: Boolean);
begin

  IsValid := FRegExpr.Exec(Text);

end;

procedure Register;
begin
  RegisterComponents('Win32', [TRegExprValidateRichEdit]);
end;

end.
