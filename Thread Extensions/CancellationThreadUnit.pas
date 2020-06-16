unit CancellationThreadUnit;

interface

  uses Windows, SysUtils, Classes;


type

  TOnCancellationEventHandler = procedure(Sender: TObject) of object;

  TCancellationThread = class(TThread)

    strict protected

      FOnCancellationEventHandler: TOnCancellationEventHandler;

      function GetIsCancelled: Boolean; virtual;
      procedure SetIsCancelled(const AIsCancelled: Boolean); virtual;

      procedure RaiseOnCancellationEventHandler;
      function RaiseOnCancellationEventHandlerIf: Boolean;

    public

      constructor Create(const CreateSuspended: Boolean = False);
      
      property IsCancelled: Boolean read GetIsCancelled write SetIsCancelled;
      property OnCancellationEventHandler: TOnCancellationEventHandler
      read FOnCancellationEventHandler write FOnCancellationEventHandler;
      
  end;

implementation

{ TCancellationThread }

constructor TCancellationThread.Create(const CreateSuspended: Boolean);
begin

  inherited Create(CreateSuspended);

end;

function TCancellationThread.GetIsCancelled: Boolean;
begin

  Result := Terminated;

end;

procedure TCancellationThread.RaiseOnCancellationEventHandler;
begin

  if Assigned(FOnCancellationEventHandler) then
    FOnCancellationEventHandler(Self);

end;

function TCancellationThread.RaiseOnCancellationEventHandlerIf: Boolean;
begin

  Result := IsCancelled;

  if Result and Assigned(FOnCancellationEventHandler) then
    Synchronize(RaiseOnCancellationEventHandler);

end;

procedure TCancellationThread.SetIsCancelled(const AIsCancelled: Boolean);
var IsCancelledInteger: Integer;
begin

  try

  Terminate;

  except
  OutputDebugString('SetIsCancelled exception');
  end;

end;

end.
