unit AuxiliaryStringFunctions;

interface
uses Classes, SysUtils, StrUtils, RegExpr, VariantListUnit;

function CreateStringFromStringList(const Strings: TStrings; const Separator: string = ', '): string;
function CreateStringFromVariantList(const VariantList: TVariantList; const Separator: string = ', '): string;

function TrimBy(const Str, TrimmedLeft, TrimmedRight: string): string;

// ��������� ���������, ����������� ����� �����
// ��������� �����������
function ExtractString(
  const ATargetString: String;
  const ALeftBound, ARightBound: String
): String;

// ��������� ���������, ����������� ����� �����
// ��������� �����������, ����������������
// ��������������� ���������� ����������
function ExtractStringByRegExpr(
  const ATargetString: String;
  const ALeftBound, ARightBound: String
): String;

function SplitStringByDelimiter(
  const TargetString: String;
  const Delimiter: Char
): TStrings;

function EscapeFilePathSpecChars(
  const FilePath: String
): String;

implementation

uses

  Variants;

function SplitStringByDelimiter(
  const TargetString: String;
  const Delimiter: Char
): TStrings;
begin

  Result := TStringList.Create;

  Result.StrictDelimiter := True;
  Result.Delimiter := Delimiter;
  Result.DelimitedText := TargetString;

end;

function CreateStringFromStringList(const Strings: TStrings; const Separator: string = ', '): string;
var str: string;
begin

  Result := '';

  for str in Strings do
    Result := IfThen(Result = '', str, Result + Separator + str);

end;

// unfinished
function TrimBy(const Str, TrimmedLeft, TrimmedRight: string): string;
var trimmedLen, strLen, idx: integer;
begin

  Result := Str;

  if Pos(TrimmedLeft, Result) = 1 then
    Delete(Result, 1, Length(TrimmedLeft));

  trimmedLen := Length(TrimmedRight);
  idx := Length(Result) - trimmedLen + 1;

  if Pos(TrimmedRight, Result) = idx then
    Delete(Result, idx, trimmedLen);
  
end;

function ExtractString(
  const ATargetString: String;
  const ALeftBound, ARightBound: String
): String;
var LeftBoundLastCharIndex, RightBoundFirstCharIndex: Integer;
    TargetStringLength: Integer;
    TargetWithoutLeftBound: String;
begin

  Result := '';

  LeftBoundLastCharIndex := Pos(ALeftBound, ATargetString);

  if LeftBoundLastCharIndex = 0 then Exit;

  TargetStringLength := Length(ATargetString);

  TargetWithoutLeftBound :=
  
  Copy(ATargetString,
       LeftBoundLastCharIndex + 1,
       TargetStringLength - LeftBoundLastCharIndex
  );

  RightBoundFirstCharIndex := Pos(ARightBound, TargetWithoutLeftBound);

  if RightBoundFirstCharIndex > 0 then
    Result := Copy(TargetWithoutLeftBound,
                   1,
                   RightBoundFirstCharIndex - 1
                  );

end;

function ExtractStringByRegExpr(
  const ATargetString: String;
  const ALeftBound, ARightBound: String
): String;
begin

  // Not implemented
  
end;

function EscapeFilePathSpecChars(
  const FilePath: String
): String;
begin

  Result := ReplaceStr(FilePath, PathDelim, PathDelim + PathDelim);
  
end;

function CreateStringFromVariantList(
  const VariantList: TVariantList;
  const Separator: string = ', '
): string;
var VariantItem: Variant;
begin

  Result := '';

  for VariantItem in VariantList do begin

    if Result = '' then
      Result := VarToStr(VariantItem)

    else
      Result := Result + Separator + VarToStr(VariantItem)

  end;
  
end;

end.
