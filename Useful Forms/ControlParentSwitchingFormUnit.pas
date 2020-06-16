unit ControlParentSwitchingFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DeletableOnCloseFormUnit;

type

  TControlParentSwitchingForm = class(TDeletableOnCloseForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    procedure SetInternalControl(const Value: TControl);
    { Private declarations }

  protected

    FInternalControl: TControl;
    FInternalControlAlignInParent: TAlign;
    FInternalControlParent: TWinControl;

  public
    { Public declarations }

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; InternalControl: TControl); overload;

  published

    property InternalControl: TControl
    read FInternalControl write SetInternalControl;

    property InternalControlParent: TWinControl
    read FInternalControlParent;

    property InternalControlAlignInParent: TAlign
    read FInternalControlAlignInParent;
    
  end;

implementation

{$R *.dfm}

{ TParentSwitchingForm }

constructor TControlParentSwitchingForm.Create(AOwner: TComponent);
begin

  inherited;

end;

constructor TControlParentSwitchingForm.Create(
  AOwner: TComponent;
  InternalControl: TControl
);
begin

  inherited Create(AOwner);

  Self.InternalControl := InternalControl;
    
end;

procedure TControlParentSwitchingForm.FormClose(
  Sender: TObject;
  var Action: TCloseAction
);
begin

  inherited;
  
  if Assigned(FInternalControlParent) then
  begin

    FInternalControl.Parent := FInternalControlParent;
    FInternalControl.Align := FInternalControlAlignInParent;
    
  end;

end;

procedure TControlParentSwitchingForm.SetInternalControl(const Value: TControl);
begin

  FInternalControl := Value;
  FInternalControlParent := Value.Parent;
  FInternalControlAlignInParent := Value.Align;

  InternalControl.Parent := Self;
  InternalControl.Align := alClient;

end;

end.
