unit DBErrorsAtUserDataMapperUnit;

interface

uses SysUtils, Classes, Variants, AuxCollectionFunctionsUnit;

type

  TDBErrorsAtUserDataMapperItem = class

    private

      FDBComparisonObject: Variant;
      FRelatedErrorsUserData: TStringList;

    public

      destructor Destroy; override;
      constructor Create; overload;
      constructor Create(const ComparisonObject: Variant;
        RelatedErrorsUserData: TStringList); overload;

      property DBComparisonObject: Variant read FDBComparisonObject write FDBComparisonObject;
      property RelatedErrorsUserData: TStringList read FRelatedErrorsUserData write FRelatedErrorsUserData;
      
  end;
  
  TDBErrorsAtUserDataMapper = class abstract(TObject)

    strict protected

      FDBErrorsAtUserDataMap: TList{TStringList};

    public

      constructor Create;
      destructor Destroy; override;

      function GetUserDataByError(DBComparisonObject, Error: Variant): TObject;

      procedure SetErrorUserData(DBComparisonObject, Error: Variant; ErrorUserData: TObject);
      procedure AddErrorUserData(DBComparisonObject, Error: Variant; ErrorUserData: TObject);
      procedure DeleteErrorUserData(DBComparisonObject, Error: Variant);

      {
      function GetUniqueErrorUserData(ComparisonObject: Variant): TObject;
      procedure SetUniqueErrorUserData(ComparisonObject: Variant; ErroruserData: TObject);
      procedure ResetUniqueErrorUserData(ComparisonObject: Variant);
      }

  end;

implementation

{ TDBErrosAtStringsMapper }

constructor TDBErrorsAtUserDataMapper.Create;
begin

  inherited;
  FDBErrorsAtUserDataMap := TList.Create{TStringList.Create};

end;

destructor TDBErrorsAtUserDataMapper.Destroy;
begin

  FreeListWithItems(FDBErrorsAtUserDataMap);
  inherited;

end;

function TDBErrorsAtUserDataMapper.GetUserDataByError(DBComparisonObject, Error: Variant): TObject;
var I, J: Integer;
    CurrItem: TDBErrorsAtUserDataMapperItem;
begin

  {if FErrorsAtStringsMap.Find(VarToStr(Error), I) then
    Result := String(FErrorsAtStringsMap.Objects[I])

  else Result := '';}

  for I := 0 to FDBErrorsAtUserDataMap.Count - 1 do begin

    CurrItem := TDBErrorsAtUserDataMapperItem(FDBErrorsAtUserDataMap[I]);

    if CurrItem.DBComparisonObject = DBComparisonObject then begin

      if CurrItem.RelatedErrorsUserData.Find(VarToStr(Error), J) then
        Result := CurrItem.RelatedErrorsUserData.Objects[J]

      else Result := nil;

      Exit;

    end;

  end;

  Result := nil;

end;

procedure TDBErrorsAtUserDataMapper.SetErrorUserData(DBComparisonObject,
  Error: Variant; ErrorUserData: TObject);
var I, J: Integer;
    CurrItem: TDBErrorsAtUserDataMapperItem;
begin

  for I := 0 to FDBErrorsAtUserDataMap.Count - 1 do begin

    CurrItem := TDBErrorsAtUserDataMapperItem(FDBErrorsAtUserDataMap[I]);

    if CurrItem.DBComparisonObject = DBComparisonObject then begin

      if CurrItem.RelatedErrorsUserData.Find(Error, J) then
        CurrItem.RelatedErrorsUserData.Objects[J] := ErrorUserData;

      Exit;

    end;

  end;

end;

procedure TDBErrorsAtUserDataMapper.DeleteErrorUserData(
  DBComparisonObject, Error: Variant);
var I, J: Integer;
    CurrItem: TDBErrorsAtUserDataMapperItem;
begin

  for I := 0 to FDBErrorsAtUserDataMap.Count - 1 do begin

    CurrItem := TDBErrorsAtUserDataMapperItem(FDBErrorsAtUserDataMap[I]);

    if CurrItem.DBComparisonObject = DBComparisonObject then begin

      if CurrItem.RelatedErrorsUserData.Find(Error, J) then
        CurrItem.RelatedErrorsUserData.Delete(J);

      Exit;

    end;

  end;

end;

procedure TDBErrorsAtUserDataMapper.AddErrorUserData(
  DBComparisonObject, Error: Variant; ErrorUserData: TObject);
var I, J: Integer;
    CurrItem: TDBErrorsAtUserDataMapperItem;
    RelatedErrorsUserData: TStringList;
begin

  for I := 0 to FDBErrorsAtUserDataMap.Count - 1 do begin

    CurrItem := TDBErrorsAtUserDataMapperItem(FDBErrorsAtUserDataMap[I]);

    if CurrItem.DBComparisonObject = DBComparisonObject then begin

      if not CurrItem.RelatedErrorsUserData.Find(Error, J) then
        CurrItem.RelatedErrorsUserData.AddObject(VarToStr(Error), ErrorUserData);

      Exit;

    end;

  end;

  RelatedErrorsUserData := TStringList.Create;

  RelatedErrorsUserData.AddObject(VarToStr(Error), ErrorUserData);

  FDBErrorsAtUserDataMap.Add(
    TDBErrorsAtUserDataMapperItem.Create(
      DBComparisonObject,
      RelatedErrorsUserData
    )
  );

end;
{ TDBErrorsAtUserDataMapperItem }

constructor TDBErrorsAtUserDataMapperItem.Create;
begin

  inherited;
  
end;

constructor TDBErrorsAtUserDataMapperItem.Create(
  const ComparisonObject: Variant; RelatedErrorsUserData: TStringList);
begin

  inherited Create;

  FDBComparisonObject := ComparisonObject;
  FRelatedErrorsUserData := RelatedErrorsUserData;

end;

destructor TDBErrorsAtUserDataMapperItem.Destroy;
begin

  FreeAndNil(FRelatedErrorsUserData);
  inherited;
  
end;

end.
