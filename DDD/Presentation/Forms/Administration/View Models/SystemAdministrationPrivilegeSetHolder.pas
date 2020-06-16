unit SystemAdministrationPrivilegeSetHolder;

interface

uses

  SectionSetHolder,
  SysUtils,
  Classes;

type

  TSystemAdministrationPrivilegeSetFieldDefs = class (TSectionSetFieldDefs)

    private

      function GetPrivilegeIdFieldName: String;
      function GetPrivilegeNameFieldName: String;
      function GetTopLevelPrivilegeIdFieldName: String;
      
      procedure SetPrivilegeIdFieldName(const Value: String);
      procedure SetPrivilegeNameFieldName(const Value: String);
      procedure SetTopLevelPrivilegeIdFieldName(const Value: String);
      
    public

      property PrivilegeIdFieldName: String
      read GetPrivilegeIdFieldName write SetPrivilegeIdFieldName;

      property TopLevelPrivilegeIdFieldName: String
      read GetTopLevelPrivilegeIdFieldName write SetTopLevelPrivilegeIdFieldName;

      property PrivilegeNameFieldName: String
      read GetPrivilegeNameFieldName write SetPrivilegeNameFieldName;
      
  end;

  TSystemAdministrationPrivilegeSetFieldDefsClass = class of TSystemAdministrationPrivilegeSetFieldDefs;
  
  TSystemAdministrationPrivilegeSetHolder = class (TSectionSetHolder)

    private

      function GetPrivilegeIdFieldValue: String;
      function GetPrivilegeNameFieldValue: String;
      function GetTopLevelPrivilegeIdFieldValue: String;

      procedure SetPrivilegeIdFieldValue(const Value: String);
      procedure SetPrivilegeNameFieldValue(const Value: String);
      procedure SetTopLevelPrivilegeIdFieldValue(const Value: String);

      function GetPrivilegeIdFieldName: String;
      function GetPrivilegeNameFieldName: String;
      function GetTopLevelPrivilegeIdFieldName: String;
      
      procedure SetPrivilegeIdFieldName(const Value: String);
      procedure SetPrivilegeNameFieldName(const Value: String);
      procedure SetTopLevelPrivilegeIdFieldName(const Value: String);
      
      function GetSystemAdministrationPrivilegeSetFieldDefs: TSystemAdministrationPrivilegeSetFieldDefs;
      procedure SetSystemAdministrationPrivilegeSetFieldDefs(
        const Value: TSystemAdministrationPrivilegeSetFieldDefs);

    public

      property PrivilegeIdFieldName: String
      read GetPrivilegeIdFieldName write SetPrivilegeIdFieldName;

      property TopLevelPrivilegeIdFieldName: String
      read GetTopLevelPrivilegeIdFieldName write SetTopLevelPrivilegeIdFieldName;

      property PrivilegeNameFieldName: String
      read GetPrivilegeNameFieldName write SetPrivilegeNameFieldName;

    public

      property PrivilegeIdFieldValue: String
      read GetPrivilegeIdFieldValue write SetPrivilegeIdFieldValue;

      property TopLevelPrivilegeIdFieldValue: String
      read GetTopLevelPrivilegeIdFieldValue write SetTopLevelPrivilegeIdFieldValue;

      property PrivilegeNameFieldValue: String
      read GetPrivilegeNameFieldValue write SetPrivilegeNameFieldValue;

    public

      property FieldDefs: TSystemAdministrationPrivilegeSetFieldDefs
      read GetSystemAdministrationPrivilegeSetFieldDefs
      write SetSystemAdministrationPrivilegeSetFieldDefs;
      
  end;

  TSystemAdministrationPrivilegeSetHolderClass = class of TSystemAdministrationPrivilegeSetHolder;

implementation

{ TSystemAdministrationPrivilegeSetFieldDefs }

function TSystemAdministrationPrivilegeSetFieldDefs.GetPrivilegeIdFieldName: String;
begin

  Result := SectionIdFieldName;
  
end;

function TSystemAdministrationPrivilegeSetFieldDefs.GetPrivilegeNameFieldName: String;
begin

  Result := SectionNameFieldName;
  
end;

function TSystemAdministrationPrivilegeSetFieldDefs.GetTopLevelPrivilegeIdFieldName: String;
begin

  Result := ParentIdSectionFieldName;
  
end;

procedure TSystemAdministrationPrivilegeSetFieldDefs.SetPrivilegeIdFieldName(
  const Value: String);
begin

  SectionIdFieldName := Value;
  
end;

procedure TSystemAdministrationPrivilegeSetFieldDefs.SetPrivilegeNameFieldName(
  const Value: String);
begin

  SectionNameFieldName := Value;
  
end;

procedure TSystemAdministrationPrivilegeSetFieldDefs.SetTopLevelPrivilegeIdFieldName(
  const Value: String);
begin

  ParentIdSectionFieldName := Value;

end;

{ TSystemAdministrationPrivilegeSetHolder }

function TSystemAdministrationPrivilegeSetHolder.GetPrivilegeIdFieldName: String;
begin

  Result := SectionIdFieldName;
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetPrivilegeIdFieldValue: String;
begin

  Result := SectionIdFieldValue;
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetPrivilegeNameFieldName: String;
begin

  Result := SectionNameFieldValue;
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetPrivilegeNameFieldValue: String;
begin

  Result := SectionNameFieldValue;
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetSystemAdministrationPrivilegeSetFieldDefs: TSystemAdministrationPrivilegeSetFieldDefs;
begin

  Result := TSystemAdministrationPrivilegeSetFieldDefs(FFieldDefs);
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetTopLevelPrivilegeIdFieldName: String;
begin

  Result := ParentIdSectionFieldValue;
  
end;

function TSystemAdministrationPrivilegeSetHolder.GetTopLevelPrivilegeIdFieldValue: String;
begin

  Result := ParentIdSectionFieldValue;
  
end;

procedure TSystemAdministrationPrivilegeSetHolder.SetPrivilegeIdFieldName(
  const Value: String);
begin

  SectionIdFieldName := Value;

end;

procedure TSystemAdministrationPrivilegeSetHolder.SetPrivilegeIdFieldValue(
  const Value: String);
begin

  SectionIdFieldValue := Value;

end;

procedure TSystemAdministrationPrivilegeSetHolder.SetPrivilegeNameFieldName(
  const Value: String);
begin

  SectionNameFieldName := Value;

end;

procedure TSystemAdministrationPrivilegeSetHolder.SetPrivilegeNameFieldValue(
  const Value: String);
begin

  SectionNameFieldValue := Value;
  
end;

procedure TSystemAdministrationPrivilegeSetHolder.SetSystemAdministrationPrivilegeSetFieldDefs(
  const Value: TSystemAdministrationPrivilegeSetFieldDefs);
begin

  SetFieldDefs(Value);
  
end;

procedure TSystemAdministrationPrivilegeSetHolder.SetTopLevelPrivilegeIdFieldName(
  const Value: String);
begin

  ParentIdSectionFieldName := Value;
  
end;

procedure TSystemAdministrationPrivilegeSetHolder.SetTopLevelPrivilegeIdFieldValue(
  const Value: String);
begin

  ParentIdSectionFieldValue := Value;
  
end;

end.
