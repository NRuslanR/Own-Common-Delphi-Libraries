unit StubSession;

interface

uses

  ISessionUnit,
  SysUtils;

type

  TStubSession = class (TInterfacedObject, ISession)

    public

      function GetSelf: TObject;
      
      procedure Start;
      procedure Commit;
      procedure Rollback;

      function GetIsStarted: Boolean;

      property IsStarted: Boolean read GetIsStarted;

  end;
  
implementation

{ TStubSession }

procedure TStubSession.Commit;
begin


end;

function TStubSession.GetIsStarted: Boolean;
begin

  Result := True;

end;

function TStubSession.GetSelf: TObject;
begin

  Result := Self;

end;

procedure TStubSession.Rollback;
begin

end;

procedure TStubSession.Start;
begin

end;

end.
