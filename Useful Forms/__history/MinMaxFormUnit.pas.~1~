unit MinMaxFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TMinMaxForm = class(TForm)
  private
    { Private declarations }

  protected

    FMinWidth, FMinHeight: Integer;
    FMaxWidth, FMaxHeight: Integer;

    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;

  public
    { Public declarations }

  published

    property MinWidth: Integer read FMinWidth write FMinWidth;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property MinHeight: Integer read FMinHeight write FMinHeight;
    property MaxHeight: Integer read FMaxHeight write FMaxHeight;

  end;

var
  MinMaxForm: TMinMaxForm;

implementation

{$R *.dfm}

{ TMinMaxForm }

procedure TMinMaxForm.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin

  if FMinWidth > 0 then
    Msg.MinMaxInfo.ptMinTrackSize.X := FMinWidth;

  if FMinHeight > 0 then
    Msg.MinMaxInfo.ptMinTrackSize.Y := FMinHeight;

  if FMaxWidth > 0 then
    Msg.MinMaxInfo.ptMaxTrackSize.X := FMaxWidth;

  if FMaxHeight > 0 then
    Msg.MinMaxInfo.ptMaxTrackSize.Y := FMaxHeight;

end;

end.
