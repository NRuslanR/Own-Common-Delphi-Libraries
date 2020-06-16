unit InputMemoFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, StdCtrls,
  cxButtons;

const

  DEFAULT_OK_BUTTON_CAPTION = 'ОК';
  DEFAULT_CANCEL_BUTTON_CAPTION = 'Отмена';
  
type
  TInputMemoForm = class(TForm)
    InputMemo: TMemo;
    OKButton: TcxButton;
    CancelButton: TcxButton;

    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);

  private

    function GetCancelButtonCaption: String;
    function GetOKButtonCaption: String;

    procedure SetCancelButtonCaption(const Value: String);
    procedure SetOKButtonCaption(const Value: String);

    function GetInputText: String;
    procedure SetInputText(const Value: String);

    procedure CloseForm;

    { Private declarations }

  protected

    procedure Initialize; virtual;
    
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(
      Owner: TComponent;
      const Caption: String = '';
      const OKButtonCaption: String = '';
      const CancelButtonCaption: String = ''
    ); overload;

    property OKButtonCaption: String
    read GetOKButtonCaption write SetOKButtonCaption;

    property CancelButtonCaption: String
    read GetCancelButtonCaption write SetCancelButtonCaption;

    property InputText: String
    read GetInputText write SetInputText;

  end;

var
  InputMemoForm: TInputMemoForm;

implementation

{$R *.dfm}

{ TInputMemoForm }

procedure TInputMemoForm.CancelButtonClick(Sender: TObject);
begin

  ModalResult := mrCancel;

  CloseForm;
  
end;

procedure TInputMemoForm.CloseForm;
begin

  if fsModal in FFormState then
    CloseModal

  else Close;
  
end;

constructor TInputMemoForm.Create(AOwner: TComponent);
begin

  inherited;

  Initialize;

end;

constructor TInputMemoForm.Create(
  Owner: TComponent; const Caption,
  OKButtonCaption, CancelButtonCaption: String);
begin

  inherited Create(Owner);

  Self.Caption := Caption;
  Self.OKButtonCaption := OKButtonCaption;
  Self.CancelButtonCaption := CancelButtonCaption;

  Initialize;
  
end;

function TInputMemoForm.GetCancelButtonCaption: String;
begin

  Result := CancelButton.Caption;

end;

function TInputMemoForm.GetInputText: String;
begin

  Result := InputMemo.Text;

end;

function TInputMemoForm.GetOKButtonCaption: String;
begin

  Result := OKButton.Caption;

end;

procedure TInputMemoForm.Initialize;
begin

end;

procedure TInputMemoForm.OKButtonClick(Sender: TObject);
begin

  ModalResult := mrOk;

  CloseForm;

end;

procedure TInputMemoForm.SetCancelButtonCaption(const Value: String);
begin

  if Value = '' then
    CancelButton.Caption := DEFAULT_CANCEL_BUTTON_CAPTION

  else CancelButton.Caption := Value;

end;

procedure TInputMemoForm.SetInputText(const Value: String);
begin

  InputMemo.Text := Value;
  
end;

procedure TInputMemoForm.SetOKButtonCaption(const Value: String);
begin

  if Value = '' then
    OKButton.Caption := DEFAULT_OK_BUTTON_CAPTION

  else OKButton.Caption := Value;

end;

end.
