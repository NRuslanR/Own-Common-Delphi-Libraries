unit DialogFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MinMaxFormUnit, StdCtrls, ComCtrls, ExtCtrls, CheckLst, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters;

type

  TInteractMode = (imView, imEditing);

  TBlockingPanel = class(TPanel)

    private

      constructor Create(AOwner: TComponent);

  end;

  TDialogForm = class(TMinMaxForm)
    btnOK: TcxButton;
    btnCancel: TcxButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    { Private declarations }

    procedure SetEnabledChildEditControlsByInteractMode(
      ParentControl: TWinControl
    ); overload;
    procedure SetEnabledBlockedControlsByInteractMode;
    procedure SetEnabledBlockedControlByInteractMode(
      Control: TControl
    );

    function GetCancelButtonCaption: String;
    function GetOKButtonCaption: String;

    procedure SetCancelButtonCaption(const Value: String);
    procedure SetOKButtonCaption(const Value: String);
    function GetCancelButtonVisible: Boolean;
    procedure SetCancelButtonVisible(const Value: Boolean);

  protected

    FHorzDistanceBetweenOKAndCancelButton: Integer;
    FInteractMode: TInteractMode;
    FBlockingControlList: TList;

    procedure Init(const ACaption: String = '';
      const AInteractMode: TInteractMode = imEditing);

    procedure DefaultOKButtonClickedHandle; virtual;
    procedure OnOKButtonClicked; virtual;
    procedure OnCancelButtonClicked; virtual;
    procedure SetEnabledChildEditControlsByInteractMode; overload; virtual;
    procedure SetEnabledChildEditControlByInteractMode(
      Control: TControl); virtual;

    procedure InitMinMaxSize; virtual;

    procedure SetInteractMode(const AInteractMode: TInteractMode);

    procedure OnComboBoxInput(Sender: TObject; var Key: Char);

  public
    { Public declarations }

    destructor Destroy; override;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; const ACaption: String); overload;
    constructor Create(AOwner: TComponent; const AInteractMode: TInteractMode;
      const ACaption: String = ''); overload;

  published

    property OKButtonCaption: String
    read GetOKButtonCaption write SetOKButtonCaption;

    property CancelButtonVisible: Boolean
    read GetCancelButtonVisible write SetCancelButtonVisible;
    
    property CancelButtonCaption: String
    read GetCancelButtonCaption write SetCancelButtonCaption;

    property InteractMode: TInteractMode read FInteractMode
    write SetInteractMode;

  end;

var
  DialogForm: TDialogForm;

implementation

uses
  AuxCollectionFunctionsUnit;

{$R *.dfm}

{ TDialogForm }

constructor TDialogForm.Create(AOwner: TComponent; const ACaption: String);
begin

  FBlockingControlList := TList.Create;
  
  inherited Create(AOwner);

  Init(ACaption);

end;

constructor TDialogForm.Create(AOwner: TComponent;
  const AInteractMode: TInteractMode; const ACaption: String);
begin

  FBlockingControlList := TList.Create;

  inherited Create(AOwner);

  Init(ACaption, AInteractMode);

end;

constructor TDialogForm.Create(AOwner: TComponent);
begin

  FBlockingControlList := TList.Create;

  inherited;

  Init;

end;

procedure TDialogForm.btnCancelClick(Sender: TObject);
begin

  OnCancelButtonClicked;

end;

procedure TDialogForm.btnOKClick(Sender: TObject);
begin

  if FInteractMode <> imView then
    OnOKButtonClicked

  else DefaultOKButtonClickedHandle;

end;

procedure TDialogForm.DefaultOKButtonClickedHandle;
begin

  ModalResult := mrOK;

  if fsModal in Self.FormState then
    CloseModal

  else Close;
  
end;

destructor TDialogForm.Destroy;
begin

  FreeAndNil(FBlockingControlList);
  inherited;

end;

function TDialogForm.GetCancelButtonCaption: String;
begin

  Result := btnCancel.Caption;

end;

function TDialogForm.GetCancelButtonVisible: Boolean;
begin

  Result := btnCancel.Visible;
  
end;

function TDialogForm.GetOKButtonCaption: String;
begin

  Result := btnOK.Caption;

end;

procedure TDialogForm.Init(const ACaption: String;
  const AInteractMode: TInteractMode);
begin

  Caption := ACaption;
  FHorzDistanceBetweenOKAndCancelButton :=
    btnCancel.Left - btnOK.Left - btnOK.Width;

  InitMinMaxSize;
  
  InteractMode := AInteractMode;

end;

procedure TDialogForm.InitMinMaxSize;
begin

  FMinWidth := Width;
  FMinHeight := Height;

end;

procedure TDialogForm.OnCancelButtonClicked;
begin

  ModalResult := mrCancel;
  Close;

end;

procedure TDialogForm.OnComboBoxInput(Sender: TObject; var Key: Char);
begin

  Key := chr(0);
  
end;

procedure TDialogForm.OnOKButtonClicked;
begin

  DefaultOKButtonClickedHandle;
  
end;

procedure TDialogForm.SetCancelButtonCaption(const Value: String);
begin

  btnCancel.Caption := Value;

end;

procedure TDialogForm.SetCancelButtonVisible(const Value: Boolean);
begin

  btnCancel.Visible := Value;

  if Value then
    btnOK.Left := btnCancel.Left - 12 - btnOK.Width

  else btnOK.Left := btnCancel.Left;
  
end;

procedure TDialogForm.SetEnabledBlockedControlByInteractMode(
  Control: TControl);
var BlockingPanel: TPanel;
begin

  if Control is TBlockingPanel then begin

    BlockingPanel := Control as TBlockingPanel;

    BlockingPanel.Controls[0].Parent := BlockingPanel.Parent;
    BlockingPanel.Controls[0].Left := BlockingPanel.Left;
    BlockingPanel.Controls[0].Top := BlockingPanel.Top;

    FreeAndNil(BlockingPanel);

    Exit;
    
  end;

  with TControl(Control) do begin

    if FInteractMode = imView then begin

      BlockingPanel := TBlockingPanel.Create(Control.Parent);
      BlockingPanel.Parent := Control.Parent;

      BlockingPanel.SetBounds(Left, Top, Width, Height);
      BlockingPanel.BevelOuter := bvNone;
      BlockingPanel.Anchors := Anchors;

      Control.Left := 0;
      Control.Top := 0;
      Control.Parent := BlockingPanel;

      BlockingPanel.Enabled := False;

    end

  end;

end;

procedure TDialogForm.SetEnabledBlockedControlsByInteractMode;
var BlockedControl: TControl;
    I: Integer;
begin

  for I := 0 to FBlockingControlList.Count - 1 do begin

    BlockedControl := TControl(FBlockingControlList[I]);

    SetEnabledBlockedControlByInteractMode(BlockedControl);

  end;

end;

procedure TDialogForm.SetEnabledChildEditControlByInteractMode(
  Control: TControl);
var LEnabled: Boolean;
    BlockingPanel: TPanel;
begin

  LEnabled := FInteractMode = imEditing;

  if Control is TCustomEdit then
      TEdit(Control).ReadOnly := not LEnabled

  else if Control is TComboBox then begin

      with TComboBox(Control) do begin

        if LEnabled then begin

          Style := csDropDownList;
          OnKeyPress := nil;

        end

        else begin

          Style := csSimple;
          OnKeyPress := OnComboBoxInput;

        end;

      end;

    end

  else if (Control is TDateTimePicker) or
          (Control is TCheckBox) or
          (Control is TCheckListBox) or
          (Control is TBlockingPanel)  then begin

      FBlockingControlList.Add(Control);

  end

  else Control.Enabled := LEnabled;

end;

procedure TDialogForm.SetEnabledChildEditControlsByInteractMode(
  ParentControl: TWinControl);
var I: Integer;
begin

  for I := 0 to ParentControl.ControlCount - 1 do begin

    if (ParentControl.Controls[I] is TLabel) or
        (ParentControl.Controls[I] = btnOK) or
          (ParentControl.Controls[I] = btnCancel) or
            ((ParentControl.Controls[I] is TBlockingPanel) and
              (FInteractMode = imEditing)) then Continue;

    if (ParentControl.Controls[I] is TGroupBox) or
        (ParentControl.Controls[I] is TPanel) then begin

          SetEnabledChildEditControlsByInteractMode(
            ParentControl.Controls[I] as TWinControl
          );

    end

    else
      SetEnabledChildEditControlByInteractMode(ParentControl.Controls[I]);

  end;

end;

procedure TDialogForm.SetEnabledChildEditControlsByInteractMode;
begin
  
  SetEnabledChildEditControlsByInteractMode(Self);
  SetEnabledBlockedControlsByInteractMode;
  FBlockingControlList.Clear;

  if FInteractMode = imView then
  begin

    btnOK.Left := btnCancel.Left + (btnCancel.Width - btnOK.Width);
    btnCancel.Visible := False;

  end

  else begin

    btnOK.Left := btnCancel.Left - btnOK.Width - FHorzDistanceBetweenOKAndCancelButton;
    btnCancel.Visible := True;
    
  end;

end;

procedure TDialogForm.SetInteractMode(const AInteractMode: TInteractMode);
begin

  FInteractMode := AInteractMode;
  SetEnabledChildEditControlsByInteractMode;

end;

procedure TDialogForm.SetOKButtonCaption(const Value: String);
begin

  btnOK.Caption := Value;

end;

{ TBlockingPanel }

constructor TBlockingPanel.Create(AOwner: TComponent);
begin

  inherited;
  
end;

end.