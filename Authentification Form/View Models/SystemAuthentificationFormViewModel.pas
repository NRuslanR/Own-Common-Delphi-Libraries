unit SystemAuthentificationFormViewModel;

interface

uses

  SysUtils,
  Classes;

type

  TSystemAuthentificationFormViewModel = class;

  TOnSystemAuthentificationFormViewModelUpdatedEventHandler =
    procedure (
      ViewModel: TSystemAuthentificationFormViewModel
    ) of object;

  TSystemAuthentificationFormViewModel = class

    private

      FClientLogin: String;
      FClientPassword: String;

    private

      FOnUpdatedEventHandler: TOnSystemAuthentificationFormViewModelUpdatedEventHandler;

    public

      property ClientLogin: String read FClientLogin write FClientLogin;
      property ClientPassword: String read FClientPassword write FClientPassword;

    public

      procedure OnUpdated;
      
      property OnUpdatedEventHandler: TOnSystemAuthentificationFormViewModelUpdatedEventHandler
      read FOnUpdatedEventHandler write FOnUpdatedEventHandler;
      
  end;

  TSystemAuthentificationFormViewModelClass =
    class of TSystemAuthentificationFormViewModel;

implementation

{ TSystemAuthentificationFormViewModel }

procedure TSystemAuthentificationFormViewModel.OnUpdated;
begin

  if Assigned(FOnUpdatedEventHandler) then
    FOnUpdatedEventHandler(Self);  

end;

end.
