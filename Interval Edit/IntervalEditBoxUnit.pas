unit IntervalEditBoxUnit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, ComCtrls, Spin,
  Types, Math;

type

  TIntervalEditBox = class(TGroupBox)
  strict private
    { Private declarations }
  strict protected

    FYearsCheckBox: TCheckBox;
    FMonthsCheckBox: TCheckBox;
    FDaysCheckBox: TCheckBox;
    FTimeCheckBox: TCheckBox;

    FYearsLabel: TLabel;
    FMonthsLabel: TLabel;
    FDaysLabel: TLabel;
    FTimeLabel: TLabel;

    FYearsSpinEdit: TSpinEdit;
    FMonthsSpinEdit: TSpinEdit;
    FDaysSpinEdit: TSpinEdit;
    FTimePicker: TDateTimePicker;

    procedure InitGroupBox;
    procedure InitCheckBoxes;
    procedure InitLabels;
    procedure InitIntervalControls;
    procedure UpdateSize;
    procedure SetAnchorsToIntervalControls(const Anchors: TAnchors);

    function CreateCheckBox(ParentControl: TControl;
      const Left, Top, Width, Height: Integer; const Tag: Integer; const Checked: Boolean): TCheckBox;

    function CreateLabel(ParentControl: TControl;
      const Left, Top, Width, Height: Integer;
      const Caption: String; const WordWrap: Boolean = True): TLabel;

    function SetIntervalComponentLabelCaption(
      IntervalComponentLabel: TLabel; const Caption: String): TSize;
    procedure AdjustPosToControls(const DeltaLeft, DeltaTop: Integer; const Controls: array of TControl);
    procedure AdjustClientSize(const DeltaWidth, DeltaHeight: Integer);
  
    procedure AlignIntervalComponentControls;

    function GetRightBound: Integer;

    function GetYearsCaption: String;
    procedure SetYearsCaption(const YearsCaption: String);

    function GetMonthsCaption: String;
    procedure SetMonthsCaption(const MonthsCaption: String);

    function GetDaysCaption: String;
    procedure SetDaysCaption(const DaysCaption: String);

    function GetTimeCaption: String;
    procedure SetTimeCaption(const TimeCaption: String);

    procedure OnIntervalComponentSelected(Sender: TObject);
    procedure SetIntervalComponentCheckBoxesHandler;

  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;

  published

    property YearsLabel: TLabel read FYearsLabel write FYearsLabel;
    property MonthsLabel: TLabel read FMonthsLabel write FMonthsLabel;
    property DaysLabel: TLabel read FDaysLabel write FDaysLabel;
    property TimeLabel: TLabel read FTimeLabel write FTimeLabel;

    property YearsCheckBox: TCheckBox read FYearsCheckBox write FYearsCheckBox;
    property MonthsCheckBox: TCheckBox read FMonthsCheckBox write FMonthsCheckBox;
    property DaysCheckBox: TCheckBox read FDaysCheckBox write FDaysCheckBox;
    property TimeCheckBox: TCheckBox read FTimeCheckBox write FTimeCheckBox;

    property YearsSpinEdit: TSpinEdit read FYearsSpinEdit write FYearsSpinEdit;
    property MonthsSpinEdit: TSpinEdit read FMonthsSpinEdit write FMonthsSpinEdit;
    property DaysSpinEdit: TSpinEdit read FDaysSpinEdit write FDaysSpinEdit;
    property TimePicker: TDateTimePicker read FTimePicker write FTimePicker;

    property YearsCaption: String read GetYearsCaption write SetYearsCaption;
    property MonthsCaption: String read GetMonthsCaption write SetMonthsCaption;
    property DaysCaption: String read GetDaysCaption write SetDaysCaption;
    property TimeCaption: String read GetTimeCaption write SetTimeCaption;
    
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TIntervalEditBox]);
end;

{ TIntervalEditBox }

constructor TIntervalEditBox.Create(AOwner: TComponent);
begin

  inherited;

  InitCheckBoxes;
  InitLabels;
  InitIntervalControls;

end;

procedure TIntervalEditBox.CreateWindowHandle(const Params: TCreateParams);
begin

  inherited;

  InitGroupBox;
  SetAnchorsToIntervalControls([akLeft, akTop, akRight]);

end;

function TIntervalEditBox.CreateCheckBox(ParentControl: TControl; const Left,
  Top, Width, Height: Integer; const Tag: Integer; const Checked: Boolean): TCheckBox;
begin

  Result := TCheckBox.Create(Self);
  Result.Parent := Self;
  Result.Checked := Checked;
  Result.Tag := Tag;

  Result.SetBounds(Left, Top, Width, Height);

end;

function TIntervalEditBox.CreateLabel(ParentControl: TControl; const Left, Top,
  Width, Height: Integer; const Caption: String; const WordWrap: Boolean): TLabel;
begin

  Result := TLabel.Create(ParentControl);
  Result.Parent := Self;
  Result.Caption := Caption;
  Result.WordWrap := WordWrap;

  Result.SetBounds(Left, Top, Width, Height);

end;

procedure TIntervalEditBox.DestroyWindowHandle;
begin

  inherited;

end;

function TIntervalEditBox.GetDaysCaption: String;
begin

  Result := FDaysLabel.Caption;

end;


function TIntervalEditBox.GetMonthsCaption: String;
begin

  Result := FMonthsLabel.Caption;

end;

function TIntervalEditBox.GetRightBound: Integer;
begin

  Result := Max(FYearsSpinEdit.Left + FYearsSpinEdit.Width,
              Max(FMonthsSpinEdit.Left + FMonthsSpinEdit.Width,
                Max(FDaysSpinEdit.Left + FDaysSpinEdit.Width,
                      FTimePicker.Left + FTimePicker.Width
                )
              )
            ) + 16;
end;

function TIntervalEditBox.GetTimeCaption: String;
begin

  Result := FTimeLabel.Caption;

end;

function TIntervalEditBox.GetYearsCaption: String;
begin

  Result := FYearsLabel.Caption;
  
end;


procedure TIntervalEditBox.SetMonthsCaption(const MonthsCaption: String);
var LabelSizeDiff: TSize;
begin

  LabelSizeDiff := SetIntervalComponentLabelCaption(FMonthsLabel, MonthsCaption);

  SetAnchorsToIntervalControls([akLeft, akTop]);

  AdjustPosToControls(LabelSizeDiff.cx, 0, [FMonthsSpinEdit]);
  AdjustPosToControls(0, LabelSizeDiff.cy,
    [FDaysCheckBox, FDaysLabel, FDaysSpinEdit,
     FTimeCheckBox, FTimeLabel, FTimePicker]);

  AlignIntervalComponentControls;
  AdjustClientSize(LabelSizeDiff.cx, LabelSizeDiff.cy);
  SetAnchorsToIntervalControls([akLeft, akTop, akRight]);

end;

procedure TIntervalEditBox.SetTimeCaption(const TimeCaption: String);
var LabelSizeDiff: TSize;
begin

  LabelSizeDiff := SetIntervalComponentLabelCaption(FTimeLabel, TimeCaption);

  SetAnchorsToIntervalControls([akLeft, akTop]);
  AdjustPosToControls(LabelSizeDiff.cx, 0, [FTimePicker]);
  AlignIntervalComponentControls;
  AdjustClientSize(LabelSizeDiff.cx, LabelSizeDiff.cy);
  SetAnchorsToIntervalControls([akLeft, akTop, akRight]);

end;

procedure TIntervalEditBox.SetYearsCaption(const YearsCaption: String);
var LabelSizeDiff: TSize;
begin

  LabelSizeDiff := SetIntervalComponentLabelCaption(FYearsLabel, YearsCaption);

  SetAnchorsToIntervalControls([akLeft, akTop]);

  AdjustPosToControls(LabelSizeDiff.cx, 0, [FYearsSpinEdit]);
  AdjustPosToControls(0, LabelSizeDiff.cy,
    [FMonthsCheckBox, FMonthsLabel, FMonthsSpinEdit,
     FDaysCheckBox, FDaysLabel, FDaysSpinEdit,
     FTimeCheckBox, FTimeLabel, FTimePicker]);

  AlignIntervalComponentControls;
  AdjustClientSize(LabelSizeDiff.cx, LabelSizeDiff.cy);
  SetAnchorsToIntervalControls([akLeft, akTop, akRight]);
  
end;

procedure TIntervalEditBox.SetDaysCaption(const DaysCaption: String);
var LabelSizeDiff: TSize;
begin

  LabelSizeDiff := SetIntervalComponentLabelCaption(FDaysLabel, DaysCaption);

  SetAnchorsToIntervalControls([akLeft, akTop]);

  AdjustClientSize(LabelSizeDiff.cx, LabelSizeDiff.cy);

  AdjustPosToControls(LabelSizeDiff.cx, 0, [FDaysSpinEdit]);
  AdjustPosToControls(0, LabelSizeDiff.cy, [FTimeCheckBox, FTimeLabel, FTimePicker]);

  AlignIntervalComponentControls;
  SetAnchorsToIntervalControls([akLeft, akTop, akRight]);

end;

procedure TIntervalEditBox.InitCheckBoxes;
begin

  FYearsCheckBox := CreateCheckBox(Self, 16, 26, 17, 17, 0, True);
  FMonthsCheckBox := CreateCheckBox(Self, 16, 63, 17, 17, 1, True);
  FDaysCheckBox := CreateCheckBox(Self, 16, 100, 17, 17, 2, True);
  FTimeCheckBox := CreateCheckBox(Self, 16, 136, 17, 17, 3, True);

  SetIntervalComponentCheckBoxesHandler;

end;

procedure TIntervalEditBox.InitGroupBox;
begin

  Caption := 'Interval';
  UpdateSize;

end;

procedure TIntervalEditBox.InitIntervalControls;
begin

  FYearsSpinEdit := TSpinEdit.Create(Self);
  FYearsSpinEdit.Parent := Self;

  FYearsSpinEdit.SetBounds(84, 23, 277, 22);

  FMonthsSpinEdit := TSpinEdit.Create(Self);
  FMonthsSpinEdit.Parent := Self;

  FMonthsSpinEdit.SetBounds(84, 60, 277, 22);

  FDaysSpinEdit := TSpinEdit.Create(Self);
  FDaysSpinEdit.Parent := Self;

  FDaysSpinEdit.SetBounds(84, 97, 277, 22);

  FTimePicker := TDateTimePicker.Create(Self);
  FTimePicker.Parent := Self;
  FTimePicker.Kind := dtkTime;

  FTimePicker.SetBounds(84, 132, 277, 21);

end;

procedure TIntervalEditBox.InitLabels;
begin

  FYearsLabel := CreateLabel(Self, 39, 28, 31, 13, 'Years:');
  FMonthsLabel := CreateLabel(Self, 39, 65, 39, 13, 'Months:');
  FDaysLabel := CreateLabel(Self, 39, 102, 28, 13, 'Days:');
  FTimeLabel := CreateLabel(Self, 39, 138, 26, 13, 'Time:');

end;

procedure TIntervalEditBox.OnIntervalComponentSelected(Sender: TObject);
var Enabled: Boolean;
begin

  Enabled := (Sender as TCheckBox).Checked;

  case (Sender as TCheckBox).Tag of

    0:
    begin
      FYearsLabel.Enabled := Enabled;
      FYearsSpinEdit.Enabled := Enabled;
    end;

    1:
    begin
      FMonthsLabel.Enabled := Enabled;
      FMonthsSpinEdit.Enabled := Enabled;
    end;

    2:
    begin
      FDaysLabel.Enabled := Enabled;
      FDaysSpinEdit.Enabled := Enabled;
    end;

    3:
    begin
      FTimePicker.Enabled := Enabled;
      FTimeLabel.Enabled := Enabled;
    end;

  end;
  
end;

procedure TIntervalEditBox.SetAnchorsToIntervalControls(
  const Anchors: TAnchors);
begin

  FYearsSpinEdit.Anchors := Anchors;
  FMonthsSpinEdit.Anchors := Anchors;
  FDaysSpinEdit.Anchors := Anchors;
  FTimePicker.Anchors := Anchors;

end;

procedure TIntervalEditBox.SetIntervalComponentCheckBoxesHandler;
begin

  FYearsCheckBox.OnClick := OnIntervalComponentSelected;
  FMonthsCheckBox.OnClick := OnIntervalComponentSelected;
  FDaysCheckBox.OnClick := OnIntervalComponentSelected;
  FTimeCheckBox.OnClick := OnIntervalComponentSelected;
  
end;

function TIntervalEditBox.SetIntervalComponentLabelCaption(
  IntervalComponentLabel: TLabel; const Caption: String): TSize;
var OldLabelWidth, OldLabelHeight: Integer;
begin

  OldLabelWidth := IntervalComponentLabel.Width;
  OldLabelHeight := IntervalComponentLabel.Height;

  IntervalComponentLabel.Caption := Caption;

  Result.cx := IntervalComponentLabel.Width - OldLabelWidth;
  Result.cy := IntervalComponentLabel.Height - OldLabelHeight;

end;

procedure TIntervalEditBox.AdjustClientSize(const DeltaWidth,
  DeltaHeight: Integer);
begin

  ClientWidth := GetRightBound;//Max(ClientWidth, GetRightBound{ClientWidth + DeltaWidth});
  ClientHeight := {Max(ClientHeight, }ClientHeight + DeltaHeight{)};
  
end;

procedure TIntervalEditBox.AdjustPosToControls(const DeltaLeft, DeltaTop: Integer;
  const Controls: array of TControl);
var Control: TControl;
begin

  for Control in Controls do begin

    Control.Left := Control.Left + DeltaLeft;
    Control.Top := Control.Top + DeltaTop;
    
  end;

end;


procedure TIntervalEditBox.AlignIntervalComponentControls;
var MaxLeft: Integer;
begin

  MaxLeft := Max(FYearsLabel.Left + FYearsLabel.Width,
              Max(FMonthsLabel.Left + FMonthsLabel.Width,
                Max(FDaysLabel.Left + FDaysLabel.Width, FTimeLabel.Left + FTimeLabel.Width)
              )
             ) + 6;

  FYearsSpinEdit.Left := MaxLeft;
  FMonthsSpinEdit.Left := MaxLeft;
  FDaysSpinEdit.Left := MaxLeft;
  FTimePicker.Left := MaxLeft;

end;

procedure TIntervalEditBox.UpdateSize;
begin

  Self.ClientWidth := FYearsSpinEdit.Left + FYearsSpinEdit.Width + FYearsCheckBox.Left;
  Self.ClientHeight := FTimePicker.Top + FTimePicker.Height + FYearsSpinEdit.Top;
   
end;

end.
