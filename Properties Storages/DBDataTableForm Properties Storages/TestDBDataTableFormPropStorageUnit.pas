unit TestDBDataTableFormPropStorageUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBDataTableFormPropertiesStorage;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    PropertiesStorage: TDBDataTableFormPropertiesStorage;
    
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses

  TestDBDataTable,
  IObjectPropertiesStorageUnit,
  IObjectPropertiesStorageRegistryUnit,
  DBDataTableFormPropertiesIniFile,
  DBDataTableFilterFormStatePropertiesIniFile,
  AuxSystemFunctionsUnit;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
var DBDataTableForm: TTestDBDataTableForm;
begin

  DBDataTableForm := TTestDBDataTableForm.Create(Self);

  DBDataTableForm.ShowModal;

  PropertiesStorage.SaveObjectProperties(DBDataTableForm);
  
end;

procedure TForm6.Button2Click(Sender: TObject);
var DBDataTableForm: TTestDBDataTableForm;
begin

  DBDataTableForm := TTestDBDataTableForm.Create(Self);

  PropertiesStorage.RestorePropertiesForObject(DBDataTableForm);

  DBDataTableForm.ShowModal;
  
end;

procedure TForm6.FormCreate(Sender: TObject);
var DBDataTablePath, FilterFormPath: String;
begin

  DBDataTablePath :=
    GetAppLocalDataFolderPath('umz_doc', CreateFolderIfNotExists) +
    PathDelim + 'employees.ini';

  FilterFormPath := GetAppLocalDataFolderPath('umz_doc') + PathDelim +
    'employess_filter.ini';

  PropertiesStorage :=
    TDBDataTableFormPropertiesIniFile.Create(
      DBDataTablePath,
      TDBDataTableFilterFormStatePropertiesIniFile.Create(
        FilterFormPath
      )
    );

end;

end.
