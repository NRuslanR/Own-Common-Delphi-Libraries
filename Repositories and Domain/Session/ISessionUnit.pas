unit ISessionUnit;

interface

uses IGetSelfUnit;

type

  ISession = interface (IGetSelf)

    procedure Start;
    procedure Commit;
    procedure Rollback;

    function GetIsStarted: Boolean;

    property IsStarted: Boolean read GetIsStarted;

  end;

implementation

end.
