unit DatabaseAuthentificationFormViewModelPropertiesINIFile;

interface

uses

  DatabaseAuthentificationFormViewModel,
  SystemAuthentificationFormViewModelPropertiesINIFile,
  SystemAuthentificationFormViewModel,
  SysUtils,
  Classes;

const

  DATABASE_NAMES_SECTION = 'DatabaseNamesSection';
  CURRENT_DATABASE_NAME_PROPERTY_NAME = 'CurrentDatabaseName';
  USED_DATABASE_NAMES_PROPERTY_NAME = 'UsedDatabaseNames';

type

  TDatabaseAuthentificationFormViewModelPropertiesINIFile =
    class (TSystemAuthentificationFormViewModelPropertiesINIFile)

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

{ TDatabaseAuthentificationFormViewModelPropertiesINIFile }

function TDatabaseAuthentificationFormViewModelPropertiesINIFile.
  GetValidSystemAuthentificationFormViewModelClass:
    TSystemAuthentificationFormViewModelClass;
begin

  Result := TDatabaseAuthentificationFormViewModel;
  
end;

procedure TDatabaseAuthentificationFormViewModelPropertiesINIFile.
  RestoreSystemAuthentificationFormViewModelProperties(
    ViewModel: TSystemAuthentificationFormViewModel
  );
var UsedDatabaseNames: TStrings;
begin

  inherited;

  FPropertiesINIFile.GoToSection(DATABASE_NAMES_SECTION);
  
  with ViewModel as TDatabaseAuthentificationFormViewModel do begin

    CurrentDatabaseName :=
      FPropertiesINIFile.ReadValueForProperty(
        CURRENT_DATABASE_NAME_PROPERTY_NAME, varString, ''
      );

    UsedDatabaseNames := TStringList.Create;

    try

      UsedDatabaseNames.CommaText :=
        FPropertiesINIFile.ReadValueForProperty(
          USED_DATABASE_NAMES_PROPERTY_NAME, varString, ''
        );

      DatabaseNames := UsedDatabaseNames;
      
    except

      on e: Exception do begin

        FreeAndNil(UsedDatabaseNames);

        raise;
        
      end;

    end;
    
  end;

end;

procedure TDatabaseAuthentificationFormViewModelPropertiesINIFile.
  SaveSystemAuthentificationFormViewModelProperties(
    ViewModel: TSystemAuthentificationFormViewModel
  );
begin

  inherited;

  FPropertiesINIFile.GoToSection(DATABASE_NAMES_SECTION);

  with ViewModel as TDatabaseAuthentificationFormViewModel do begin

    FPropertiesINIFile.WriteValueForProperty(
      CURRENT_DATABASE_NAME_PROPERTY_NAME, CurrentDatabaseName
    );

    if DatabaseNames.Count = 0 then begin

      FPropertiesINIFile.WriteValueForProperty(
        USED_DATABASE_NAMES_PROPERTY_NAME, CurrentDatabaseName
      );

    end

    else begin

      FPropertiesINIFile.WriteValueForProperty(
        USED_DATABASE_NAMES_PROPERTY_NAME, DatabaseNames.CommaText
      );

    end;

  end;

end;

end.
