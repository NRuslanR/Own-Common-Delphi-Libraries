unit ColoredPageControlUnit;

interface

uses

  ComCtrls, Graphics, Classes, Windows;

type

  TColoredPageControl = class (TPageControl)

    private

      FActivePageColor: TColor;
      FPagesColor: TColor;
      FColor: TColor;

      procedure OnDrawTabHandle(
        Control: TCustomTabControl;
        TabIndex: Integer;
        const Rect: TRect;
        Active: Boolean
      );

      procedure SetColor(const Color: TColor);
      
    public

      constructor Create(AOwner: TComponent); override;

    published

      property ActivePageColor: TColor
      read FActivePageColor write FActivePageColor;

      property PagesColor: TColor read FPagesColor write FPagesColor;
      property Color: TColor read FColor write SetColor;

  end;

procedure Register;

implementation

procedure Register;
begin

  RegisterComponents('Win32', [TColoredPageControl]);
  
end;

{ TColoredPageControl }

constructor TColoredPageControl.Create(AOwner: TComponent);
begin

  inherited;

  OwnerDraw := True;
  OnDrawTab := OnDrawTabHandle;

  FActivePageColor := Brush.Color;
  FPagesColor := Brush.Color;
  FColor := Brush.Color;
  
end;

procedure TColoredPageControl.OnDrawTabHandle(
  Control: TCustomTabControl;
  TabIndex: Integer;
  const Rect: TRect;
  Active: Boolean
);
var TabCaptionX, TabCaptionY: Integer;
    TabCaption: String;
begin

  if Active then
    Canvas.Brush.Color := FActivePageColor

  else Canvas.Brush.Color := FPagesColor;

  Canvas.FillRect(Rect);

  TabCaption := Pages[TabIndex].Caption;

  TabCaptionX := (Rect.Right - Rect.Left - Canvas.TextWidth(TabCaption)) div 2;
  TabCaptionY := (Rect.Bottom - Rect.Top - Canvas.TextHeight(TabCaption)) div 2;

  Canvas.TextRect(
    Rect, Rect.Left + TabCaptionX, Rect.Top + TabCaptionY, TabCaption
  );

end;

procedure TColoredPageControl.SetColor(const Color: TColor);
begin

  FColor := Color;

  Brush.Color := FColor;
  
end;

end.
