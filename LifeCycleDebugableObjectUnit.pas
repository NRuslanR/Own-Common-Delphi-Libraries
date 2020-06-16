unit LifeCycleDebugableObjectUnit;

interface

uses SysUtils, Windows;

type

  TLifeCycleDebugableObject = class

    public

      destructor Destroy; override;
      constructor Create;

  end;

implementation

{ TLifeCycleDebugableObject }

constructor TLifeCycleDebugableObject.Create;
begin

  inherited;

  OutputDebugString(
    PChar(
      Format(
        '%s is constructed',
        [ClassName]
      )
    )
  );

end;

destructor TLifeCycleDebugableObject.Destroy;
begin

  OutputDebugString(
    PChar(
      Format(
        '%s is destroyed',
        [ClassName]
      )
    )
  );

  inherited;

end;

end.
