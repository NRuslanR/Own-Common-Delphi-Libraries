unit unSystemAuthentificationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, StdCtrls,
  cxButtons, ValidateEditUnit, RegExprValidateEditUnit, ExtCtrls,
  SystemAuthentificationFormViewModel;

type
    
  TOnSystemAuthentificationRequestedEventHandler =
    procedure (
      Sender: TObject;
      ViewModel: TSystemAuthentificationFormViewModel;
      var CloseForm: Boolean
    ) of object;
    
  TSystemAuthentificationForm = class(TForm)
    LoginLabel: TLabel;
    LoginEdit: TRegExprValidateEdit;
    PasswordLabel: TLabel;
    PasswordEdit: TRegExprValidateEdit;
    AuthentificateButton: TcxButton;
    CancelButton: TcxButton;
    UserLogOnParamsPanel: TPanel;
    FooterButtonsPanel: TPanel;
    procedure AuthentificateButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);

  private

    FNotValidInputCredentialsDataFormatMessage: String;
    
  private

    FViewModel: TSystemAuthentificationFormViewModel;

  protected
  
    procedure SetViewModel(const Value: TSystemAuthentificationFormViewModel);

    procedure OnViewModelUpdatedEventHandler(
      ViewModel: TSystemAuthentificationFormViewModel
    ); virtual;
    
  private

    FOnSystemAuthentificationRequestedEventHandler: TOnSystemAuthentificationRequestedEventHandler;

  private

    function GetLoginText: String;
    function GetPasswordText: String;

  protected

    procedure Initialize; virtual;
    
  protected

    procedure FillControlsByViewModel(ViewModel: TSystemAuthentificationFormViewModel); virtual;
    procedure FillViewModelByControls; virtual;

  protected

    function InputCredentialsDataFormatValid: Boolean; virtual;

    procedure ShowNotValidInputCredentialsDataFormatMessage; virtual;

  protected

    procedure RaiseOnSystemAuthentificationRequestedEventHandler;

  public

    property ViewModel: TSystemAuthentificationFormViewModel
    read FViewModel write SetViewModel;

    property NotValidInputCredentialsDataFormatMessage: String
    read FNotValidInputCredentialsDataFormatMessage
    write FNotValidInputCredentialsDataFormatMessage;
    
  public

    constructor Create(AOwner: TComponent); override;

    property LoginText: String read GetLoginText;
    property PasswordText: String read GetPasswordText;
    
    procedure Close;
    
  published

    property OnSystemAuthentificationRequestedEventHandler: TOnSystemAuthentificationRequestedEventHandler
    read FOnSystemAuthentificationRequestedEventHandler
    write FOnSystemAuthentificationRequestedEventHandler;
    
  end;

var
  SystemAuthentificationForm: TSystemAuthentificationForm;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{$R *.dfm}

{ TSystemAuthentificationForm }

procedure TSystemAuthentificationForm.AuthentificateButtonClick(
  Sender: TObject);
begin

  if not InputCredentialsDataFormatValid then begin

    ShowNotValidInputCredentialsDataFormatMessage;
    Exit;

  end;

  RaiseOnSystemAuthentificationRequestedEventHandler;

end;

procedure TSystemAuthentificationForm.Close;
begin

  if fsModal in FFormState then
    CloseModal

  else inherited Close;
  
end;

constructor TSystemAuthentificationForm.Create(AOwner: TComponent);
begin

  inherited;

  Initialize;
    
end;

procedure TSystemAuthentificationForm.CancelButtonClick(Sender: TObject);
begin

  ModalResult := mrCancel;
  
  Close;
  
end;

procedure TSystemAuthentificationForm.FillControlsByViewModel(
  ViewModel: TSystemAuthentificationFormViewModel);
begin

  LoginEdit.Text := ViewModel.ClientLogin;
  PasswordEdit.Text := ViewModel.ClientPassword;
  
end;

procedure TSystemAuthentificationForm.FillViewModelByControls;
begin

  FViewModel.ClientLogin := LoginEdit.Text;
  FViewModel.ClientPassword := PasswordEdit.Text;
  
end;

function TSystemAuthentificationForm.GetLoginText: String;
begin

  Result := LoginEdit.Text;

end;

function TSystemAuthentificationForm.GetPasswordText: String;
begin

  Result := PasswordEdit.Text;

end;

procedure TSystemAuthentificationForm.Initialize;
begin

  FNotValidInputCredentialsDataFormatMessage :=
    '�� ��� ���� ��������� ���������';
    
end;

function TSystemAuthentificationForm.InputCredentialsDataFormatValid: Boolean;
var IsLoginFormatValid, IsPasswordFormatValid: Boolean;
begin

  IsLoginFormatValid := LoginEdit.IsValid;
  IsPasswordFormatValid := PasswordEdit.IsValid;

  Result :=
    IsLoginFormatValid and
    IsPasswordFormatValid;
    
end;

procedure TSystemAuthentificationForm.OnViewModelUpdatedEventHandler(
  ViewModel: TSystemAuthentificationFormViewModel
);
begin

  FillControlsByViewModel(ViewModel);

end;

procedure TSystemAuthentificationForm.
  RaiseOnSystemAuthentificationRequestedEventHandler;
var CloseForm: Boolean;
begin

  if not Assigned(FOnSystemAuthentificationRequestedEventHandler) then begin

    Close;
    Exit;

  end;

  if not Assigned(FViewModel) then begin

    Close;
    Exit;

  end;

  FillViewModelByControls;

  CloseForm := True;

  FOnSystemAuthentificationRequestedEventHandler(
    Self, FViewModel, CloseForm
  );

  if CloseForm then begin

    ModalResult := mrOk;
    
    Close;

  end;

end;

procedure TSystemAuthentificationForm.SetViewModel(
  const Value: TSystemAuthentificationFormViewModel);
begin

  if FViewModel = Value then Exit;

  FreeAndNil(FViewModel);
  
  FViewModel := Value;

  FViewModel.OnUpdatedEventHandler := OnViewModelUpdatedEventHandler;

  if Assigned(FViewModel) then
    FillControlsByViewModel(FViewModel);
  
end;

procedure TSystemAuthentificationForm.ShowNotValidInputCredentialsDataFormatMessage;
begin

  ShowWarningMessage(
    Self.Handle,
    FNotValidInputCredentialsDataFormatMessage,
    '���������'
  );

end;

end.
