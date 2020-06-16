unit FileSearcherExtUnit;

interface
uses Classes, SysUtils, StrUtils, FileSearcherUnit;

type
  TFileSearcherExt = class(TFileSearcher)

    strict protected

      // допустимые расширения, которые могут иметь искомые файлы
      FExtensions: TStrings;

      // Проверяет, является ли расширение Ext файла допустимым
      function IsExtensionValid(const FileExt: string): Boolean;

      function AllowToGetFileInfoIfExtensionIsValid(
        const FileName: String;
        var AllowToGetFileInfo: Boolean
      ): Boolean;

      function ProcessFileInfo(
        const DirPathOfFile: String;
        const FileInfo: TSearchRec;
        var AllowToGetFileInfo: Boolean
      ): Pointer; override;

    public

      constructor Create(BeginDirectory: string);
      destructor Destroy; override;

      // Поиск с учётом расширений файлов (например, .pdf, .txt, .doc и т.д.)
      procedure AddExtension(const FileExt: string);
      procedure AddExtensions(const FileExts: array of string); overload;
      procedure AddExtensions(const FileExts: TStrings); overload;

      procedure ClearExtensions;
      procedure RemoveExtension(const FileExt: string);
      procedure RemoveExtensions(const FileExts: TStrings); overload;
      procedure RemoveExtensions(const FileExts: array of String); overload;

  end;

implementation

{ TFileSearcher }


{ TFileSearcherExt }

procedure TFileSearcherExt.AddExtension(const FileExt: string);
var LowerFileExt: String;
begin

  LowerFileExt := AnsiLowerCase(FileExt);

  if FExtensions.IndexOf(LowerFileExt) < 0 then
    FExtensions.Add(LowerFileExt);

end;

procedure TFileSearcherExt.AddExtensions(const FileExts: array of string);
var CurrFileExt: String;
begin

  for CurrFileExt in FileExts do
    AddExtension(CurrFileExt);
    
end;

procedure TFileSearcherExt.AddExtensions(const FileExts: TStrings);
var CurrFileExt: string;
begin

  for CurrFileExt in FileExts do
    AddExtension(CurrFileExt);

end;

function TFileSearcherExt.AllowToGetFileInfoIfExtensionIsValid(
  const FileName: String; var AllowToGetFileInfo: Boolean): Boolean;
begin

  AllowToGetFileInfo := IsExtensionValid(ExtractFileExt(FileName));
  Result := AllowToGetFileInfo;

end;

procedure TFileSearcherExt.ClearExtensions;
begin

  FExtensions.Clear;

end;

constructor TFileSearcherExt.Create(BeginDirectory: string);
begin

  inherited;

  FExtensions := TStringList.Create;

end;

destructor TFileSearcherExt.Destroy;
begin

  FreeAndNil(FExtensions);

  inherited;

end;

function TFileSearcherExt.IsExtensionValid(const FileExt: string): Boolean;
begin

  Result := FExtensions.IndexOf(AnsiLowerCase(PChar(FileExt))) >= 0;
    
end;

function TFileSearcherExt.ProcessFileInfo(const DirPathOfFile: String;
  const FileInfo: TSearchRec; var AllowToGetFileInfo: Boolean): Pointer;
begin

  if AllowToGetFileInfoIfExtensionIsValid(
    FileInfo.Name,
    AllowToGetFileInfo
  ) then

  Result := inherited ProcessFileInfo(DirPathOfFile, FileInfo, AllowToGetFileInfo);

end;

procedure TFileSearcherExt.RemoveExtension(const FileExt: string);
var RemovedFileExtIndex: Integer;
begin

  RemovedFileExtIndex := FExtensions.IndexOf(FileExt);

  if RemovedFileExtIndex >= 0 then
    FExtensions.Delete(RemovedFileExtIndex);
  
end;

procedure TFileSearcherExt.RemoveExtensions(const FileExts: TStrings);
var CurrFileExt: string;
begin

  for CurrFileExt in FileExts do
    RemoveExtension(CurrFileExt);

end;

procedure TFileSearcherExt.RemoveExtensions(const FileExts: array of String);
var CurrFileExt: String;
begin

  for CurrFileExt in FileExts do
    RemoveExtension(CurrFileExt);

end;

end.
