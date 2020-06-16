unit ExtendedDatabaseAuthentificationFormViewModel;

interface

uses

  DatabaseAuthentificationFormViewModel,
  SysUtils,
  Classes;

type

  TExtendedDatabaseAuthentificationFormViewModel =
    class (TDatabaseAuthentificationFormViewModel)

      private

        FCurrentHost: String;
        FCurrentHosts: TStrings;
        FPort: Integer;
        
        procedure SetHosts(const Value: TStrings);

      public

        destructor Destroy; override;
        
        property CurrentHost: String read FCurrentHost write FCurrentHost;
        property Hosts: TStrings read FCurrentHosts write SetHosts;
        property Port: Integer read FPort write FPort;

    end;

implementation

{ TExtendedDatabaseAuthentificationFormViewModel }

destructor TExtendedDatabaseAuthentificationFormViewModel.Destroy;
begin

  FreeAndNil(FCurrentHosts);
  
  inherited;

end;

procedure TExtendedDatabaseAuthentificationFormViewModel.SetHosts(
  const Value: TStrings);
begin

  if FCurrentHosts = Value then
    Exit;

  FreeAndNil(FCurrentHosts);
  
  FCurrentHosts := Value;

end;

end.
