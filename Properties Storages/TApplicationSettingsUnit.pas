unit TApplicationSettingsUnit;

interface

uses IApplicationSettingsStorageUnit;

type

  TApplicationSettings = class 

    protected

      class var FStorage: IApplicationSettingsStorage;

      class function GetStorage: IApplicationSettingsStorage; static;
      class procedure SetStorage(
        ApplicationSettingsStorage: IApplicationSettingsStorage
      ); static;

      constructor Create;

    public

      class property Storage: IApplicationSettingsStorage
      read GetStorage write SetStorage;
      
  end;

implementation

uses SysUtils, TApplicationSettingsIniFileUnit;

{ TApplicationSettings }

constructor TApplicationSettings.Create;
begin

  inherited;
  
end;


class function TApplicationSettings.GetStorage: IApplicationSettingsStorage;
begin

  Result := FStorage;

end;

class procedure TApplicationSettings.SetStorage(
  ApplicationSettingsStorage: IApplicationSettingsStorage);
begin

  FStorage := ApplicationSettingsStorage;
  
end;

end.
