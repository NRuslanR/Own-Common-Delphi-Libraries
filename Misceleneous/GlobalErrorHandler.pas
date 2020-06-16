unit GlobalErrorHandler;

interface

uses

  Forms,
  SysUtils,
  Classes;

type

  TGlobalErrorHandler = class sealed

    private

      class var FInstance: TGlobalErrorHandler;

      class function GetInstance: TGlobalErrorHandler; static;

    private

      FPreviousOnExceptionEventHandler: TExceptionEvent;

      procedure OnExceptionEventHandler(Sender: TObject; E: Exception);
      
    public

      procedure Activate;
      procedure Deactivate;

      procedure HandleException(E: Exception);

      class property Current: TGlobalErrorHandler read GetInstance;

  end;

implementation

uses

  AuxWindowsFunctionsUnit,
  ApplicationService,
  DomainException;
  
{ TGlobalErrorHandler }

procedure TGlobalErrorHandler.Activate;
begin

  FPreviousOnExceptionEventHandler := Application.OnException;
  
  Application.OnException := OnExceptionEventHandler;

end;

procedure TGlobalErrorHandler.Deactivate;
begin

  Application.OnException := FPreviousOnExceptionEventHandler;

end;

class function TGlobalErrorHandler.GetInstance: TGlobalErrorHandler;
begin

  if not Assigned(FInstance) then
    FInstance := TGlobalErrorHandler.Create;

  Result := FInstance;
  
end;

procedure TGlobalErrorHandler.HandleException(E: Exception);
begin

  OnExceptionEventHandler(nil, E);
  
end;

procedure TGlobalErrorHandler.OnExceptionEventHandler(Sender: TObject; E: Exception);
begin

  if E is TDomainException then
    ShowWarningMessage(Application.Handle, E.Message, 'Сообщение')

  else ShowErrorMessage(Application.Handle, E.Message, 'Сообщение');
  
end;

end.
