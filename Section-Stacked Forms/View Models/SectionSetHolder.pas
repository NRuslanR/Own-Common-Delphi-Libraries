unit SectionSetHolder;

interface

uses

  AbstractDataSetHolder,
  SysUtils,
  Classes;

type

  TSectionSetFieldDefs = class (TAbstractDataSetFieldDefs)

    private

      function GetSectionIdFieldName: String;
      procedure SetSectionIdFieldName(const Value: String);
      
    public

      ParentIdSectionFieldName: String;
      SectionNameFieldName: String;

      property SectionIdFieldName: String
      read GetSectionIdFieldName write SetSectionIdFieldName;

  end;

  TSectionSetFieldDefsClass = class of TSectionSetFieldDefs;

  TSectionSetHolder = class (TAbstractDataSetHolder)

    private

      function GetParentIdSectionFieldName: String;
      function GetSectionIdFieldName: String;
      function GetSectionNameFieldName: String;
      function GetSectionSetFieldDefs: TSectionSetFieldDefs;

      procedure SetParentIdSectionFieldName(const Value: String);
      procedure SetSectionIdFieldName(const Value: String);
      procedure SetSectionNameFieldName(const Value: String);
      procedure SetSectionSetFieldDefs(const Value: TSectionSetFieldDefs);

      function GetParentIdSectionFieldValue: Variant;
      function GetSectionIdFieldValue: Variant;
      function GetSectionNameFieldValue: String;

      procedure SetParentIdSectionFieldValue(const Value: Variant);
      procedure SetSectionIdFieldValue(const Value: Variant);
      procedure SetSectionNameFieldValue(const Value: String);

    protected

    
    public

      property SectionIdFieldName: String
      read GetSectionIdFieldName write SetSectionIdFieldName;

      property ParentIdSectionFieldName: String
      read GetParentIdSectionFieldName write SetParentIdSectionFieldName;
      
      property SectionNameFieldName: String
      read GetSectionNameFieldName write SetSectionNameFieldName;

    public

      property SectionIdFieldValue: Variant
      read GetSectionIdFieldValue write SetSectionIdFieldValue;
      
      property ParentIdSectionFieldValue: Variant
      read GetParentIdSectionFieldValue write SetParentIdSectionFieldValue;
      
      property SectionNameFieldValue: String
      read GetSectionNameFieldValue write SetSectionNameFieldValue;

    public

      property FieldDefs: TSectionSetFieldDefs
      read GetSectionSetFieldDefs write SetSectionSetFieldDefs;

    
  end;

  TSectionSetHolderClass = class of TSectionSetHolder;

implementation

uses

  Variants;
  
{ TSectionSetHolder }

function TSectionSetHolder.GetParentIdSectionFieldName: String;
begin

  Result := FieldDefs.ParentIdSectionFieldName;
  
end;

function TSectionSetHolder.GetParentIdSectionFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(ParentIdSectionFieldName, Null);
  
end;

function TSectionSetHolder.GetSectionIdFieldName: String;
begin

  Result := FieldDefs.SectionIdFieldName;
  
end;

function TSectionSetHolder.GetSectionIdFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(SectionIdFieldName, Null);
  
end;

function TSectionSetHolder.GetSectionNameFieldName: String;
begin

  Result := FieldDefs.SectionNameFieldName;
  
end;

function TSectionSetHolder.GetSectionNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(SectionNameFieldName, '');
  
end;

function TSectionSetHolder.GetSectionSetFieldDefs: TSectionSetFieldDefs;
begin

  Result := TSectionSetFieldDefs(FFieldDefs);
  
end;

procedure TSectionSetHolder.SetParentIdSectionFieldName(const Value: String);
begin

  FieldDefs.ParentIdSectionFieldName := Value;
  
end;

procedure TSectionSetHolder.SetParentIdSectionFieldValue(const Value: Variant);
begin

  SetDataSetFieldValue(ParentIdSectionFieldName, Value);
  
end;

procedure TSectionSetHolder.SetSectionIdFieldName(const Value: String);
begin

  FieldDefs.SectionIdFieldName := Value;
  
end;

procedure TSectionSetHolder.SetSectionIdFieldValue(const Value: Variant);
begin

  SetDataSetFieldValue(SectionIdFieldName, Value);
  
end;

procedure TSectionSetHolder.SetSectionNameFieldName(const Value: String);
begin

  FieldDefs.SectionNameFieldName := Value;
  
end;

procedure TSectionSetHolder.SetSectionNameFieldValue(const Value: String);
begin

  SetDataSetFieldValue(SectionNameFieldName, Value);
  
end;

procedure TSectionSetHolder.SetSectionSetFieldDefs(
  const Value: TSectionSetFieldDefs);
begin

  SetFieldDefs(Value);
  
end;

{ TSectionSetFieldDefs }

function TSectionSetFieldDefs.GetSectionIdFieldName: String;
begin

  Result := RecordIdFieldName;
  
end;

procedure TSectionSetFieldDefs.SetSectionIdFieldName(const Value: String);
begin

  RecordIdFieldName := Value;
  
end;

end.
