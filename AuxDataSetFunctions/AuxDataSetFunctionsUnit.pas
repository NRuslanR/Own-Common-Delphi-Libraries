unit AuxDataSetFunctionsUnit;

interface

uses SysUtils, Classes, DB;

// DataSet is located at first record
function IsDataSetAtFirstRecord(ADataSet: TDataSet): Boolean;

// DataSet is located at last record
function IsDataSetAtLastRecord(ADataSet: TDataSet): Boolean;

procedure SetFieldsToDataSetFromOther(
  DestDataSet, SourceDataSet: TDataSet
);

procedure CreateFieldInDataSet(
  DataSet: TDataSet;
  const FieldName: String;
  const FieldType: TFieldType;
  const Size: Integer = 0
);

implementation

function IsDataSetAtFirstRecord(ADataSet: TDataSet): Boolean;
begin

  Result := ADataSet.Bof and (not ADataSet.IsEmpty);

end;

function IsDataSetAtLastRecord(ADataSet: TDataSet): Boolean;
begin

  Result := ADataSet.Eof and (not ADataSet.IsEmpty);

end;

procedure SetFieldsToDataSetFromOther(
  DestDataSet, SourceDataSet: TDataSet
);
var SourceField: TField;
    DestFieldDef: TFieldDef;
begin

   for SourceField in SourceDataSet.Fields do begin

      CreateFieldInDataSet(
        DestDataSet,
        SourceField.FieldName,
        SourceField.DataType,
        SourceField.Size
      );

   end;

end;

procedure CreateFieldInDataSet(
  DataSet: TDataSet;
  const FieldName: String;
  const FieldType: TFieldType;
  const Size: Integer = 0
);
var FieldDef: TFieldDef;
begin

  FieldDef := DataSet.FieldDefs.AddFieldDef;

  FieldDef.Name := FieldName;
  FieldDef.DataType := FieldType;
  FieldDef.Size := Size;
  
  FieldDef.CreateField(DataSet);

end;

end.
