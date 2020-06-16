unit ExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile;

interface

uses

  DatabaseAuthentificationFormViewModelPropertiesINIFile,
  ExtendedDatabaseAuthentificationFormViewModel,
  SystemAuthentificationFormViewModel,
  unExtendedDatabaseAuthentificationForm,
  SysUtils,
  Classes;

const

  SERVER_ADDRESSES_SECTION = 'ServerAddressesSection';
  CURRENT_SERVER_ADDRESS_PROPERTY_NAME = 'CurrentServerAddress';
  CURRENT_SERVER_PORT_PROPERTY_NAME = 'CurrentServerPort';
  USED_SERVER_ADDRESSES_PROPERTY_NAME = 'UsedServerAddresses';

type

  TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile =
    class (TDatabaseAuthentificationFormViewModelPropertiesINIFile)

      protected

        function GetValidSystemAuthentificationFormViewModelClass:
          TSystemAuthentificationFormViewModelClass; override;
          
      protected

        procedure SaveSystemAuthentificationFormViewModelProperties(
          ViewModel: TSystemAuthentificationFormViewModel
        ); override;

        procedure RestoreSystemAuthentificationFormViewModelProperties(
          ViewModel: TSystemAuthentificationFormViewModel
        ); override;
        
    end;
    
implementation

{ TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile }

function TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.
  GetValidSystemAuthentificationFormViewModelClass:
    TSystemAuthentificationFormViewModelClass;
begin

  Result := TExtendedDatabaseAuthentificationFormViewModel;
  
end;

procedure TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.
  RestoreSystemAuthentificationFormViewModelProperties(
    ViewModel: TSystemAuthentificationFormViewModel
  );
var UsedServerAddresses: TStrings;
begin

  inherited;

  FPropertiesINIFile.GoToSection(SERVER_ADDRESSES_SECTION);

  with ViewModel as TExtendedDatabaseAuthentificationFormViewModel do begin

    CurrentHost :=
      FPropertiesINIFile.ReadValueForProperty(
        CURRENT_SERVER_ADDRESS_PROPERTY_NAME, varString, ''
      );

    Port :=
      FPropertiesINIFile.ReadValueForProperty(
        CURRENT_SERVER_PORT_PROPERTY_NAME, varInteger, 0
      );
      
    UsedServerAddresses := TStringList.Create;

    try

      UsedServerAddresses.CommaText :=
        FPropertiesINIFile.ReadValueForProperty(
          USED_SERVER_ADDRESSES_PROPERTY_NAME, varString, ''
        );

      Hosts := UsedServerAddresses;
      
    except

      on e: Exception do begin

        FreeAndNil(UsedServerAddresses);

        raise;

      end;

    end;

  end;

end;

procedure TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.
  SaveSystemAuthentificationFormViewModelProperties(
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

  inherited;

  FPropertiesINIFile.GoToSection(SERVER_ADDRESSES_SECTION);

  with ViewModel as TExtendedDatabaseAuthentificationFormViewModel
  do begin

    FPropertiesINIFile.WriteValueForProperty(
      CURRENT_SERVER_ADDRESS_PROPERTY_NAME, CurrentHost
    );

    FPropertiesINIFile.WriteValueForProperty(
      CURRENT_SERVER_PORT_PROPERTY_NAME, Port
    );

    if Hosts.Count = 0 then begin

      FPropertiesINIFile.WriteValueForProperty(
        USED_SERVER_ADDRESSES_PROPERTY_NAME, CurrentHost
      );
      
    end

    else begin

      FPropertiesINIFile.WriteValueForProperty(
        USED_SERVER_ADDRESSES_PROPERTY_NAME, Hosts.CommaText
      );

    end;
    
  end;

end;

end.
