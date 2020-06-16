unit AbstractDataReader;

interface

uses

  DB,
  DataReader,
  SysUtils,
  Classes;

type

  TAbstractDataReader = class abstract (TInterfacedObject, IDataReader)

    public

      procedure Restart; virtual; abstract;
    
      function Next: Boolean; virtual; abstract;

      function GetRecordCount: Integer; virtual; abstract;
      function GetValue(const FieldName: String): Variant; virtual; abstract;
      function GetValueAsString(const FieldName: String): String; virtual; abstract;
      function GetValueAsInteger(const FieldName: String): Integer; virtual; abstract;
      function GetValueAsFloat(const FieldName: String): Double; virtual; abstract;
      function GetValueAsDateTime(const FieldName: String): TDateTime; virtual; abstract;
      function GetValueAsBoolean(const FieldName: String): Boolean; virtual; abstract;

      property Items[const FieldName: String]: Variant
      read GetValue; default;

      function ToDataSet: TDataSet; virtual; abstract;

      function GetSelf: TObject;
      
  end;
  
implementation

{ TAbstractDataReader }

function TAbstractDataReader.GetSelf: TObject;
begin

  Result := Self;
  
end;

end.
