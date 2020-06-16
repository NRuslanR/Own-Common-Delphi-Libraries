unit FileSearcherUnit;

interface
uses Classes, SysUtils, StrUtils;

type
  TFileSearcher = class

    strict protected

      FBeginDirectory: string; // ��������� ���������� ������ ������

      // ��������� ���������� � ������, ������� � ���������� Path,
      // � ������ FilesInfo ���������� (Recursive = True) ��� �� ����������
      // (Recursive = False)
      procedure ReadDirectory(const Path: string; FilesInfo: TList; const Recursive: Boolean);

      // ��������� ������������ ��������� ��������� � ����� ����������
      // � ��������� ������, � ����������.
      // �� ��������� �������� �������� ������ (��� string), ����������
      // ������ �������� �����. ����������� ������ ����� �������������
      // ���� ����� ��� �������� �������� ��������� �����
      function ProcessFileInfo(
        const DirPathOfFile: String;
        const FileInfo: TSearchRec;
        var AllowToGetFileInfo: Boolean
      ): Pointer; virtual;

    public

      property BeginDirectory : string read FBeginDirectory write FBeginDirectory;

      constructor Create(BeginDirectory: string);
      destructor Destroy; override;

      // �������� ������ ������ � ��������� ������
      // ���� Recursive ��������� �� ������������� ���
      // ���������� ������������� ������������ ����� ���������� � ������
      function GetFilesInfo(const Recursive: Boolean = False): TList; // ���������� ������ ���� TList,
      // ���������� �������� �������� ������� �����, ������������ �� �������
      // ProcessFileInfo. �� ��������� ������������ ������� ���� string,
      // ���������� ������ �������� ��������� ������. ����������� ������
      // ����� �������������� ��� ���������, ��������� ������ �������������
      // ����, ������������ � ���� Pointer
  end;

implementation

uses
  StringRefUnit;

{ TFileSearcher }

constructor TFileSearcher.Create(BeginDirectory: string);
begin

  inherited Create;

  FBeginDirectory := BeginDirectory;

end;


destructor TFileSearcher.Destroy;
begin

  inherited;

end;

function TFileSearcher.GetFilesInfo(const Recursive: Boolean): TList;
begin

  Result := TList.Create;

  ReadDirectory(FBeginDirectory, Result, Recursive);

end;


function TFileSearcher.ProcessFileInfo(
  const DirPathOfFile:  String;
  const FileInfo: TSearchRec;
  var AllowToGetFileInfo: Boolean
  ): Pointer;

begin

  Result := Pointer(
    TStringRef.Create(DirPathOfFile + PathDelim + FileInfo.Name)
  );

end;

procedure TFileSearcher.ReadDirectory(
  const Path: string;
  FilesInfo: TList;
  const Recursive: Boolean

);
var FileInfo: TSearchRec;
    AllowToGetFileInfo: Boolean;
    ProcessedFileInfo: Pointer;
                   S: String;
begin

  if FindFirst(Path + PathDelim + '*', faAnyFile, FileInfo) <> 0 then Exit;

  repeat

    if FileInfo.Name[1] = '.' then Continue;

    if FileInfo.Attr = faDirectory then begin

      if Recursive then
        ReadDirectory(Path + PathDelim + FileInfo.Name, FilesInfo, Recursive);

      Continue;

    end;

    AllowToGetFileInfo := True;

    ProcessedFileInfo := ProcessFileInfo(Path, FileInfo, AllowToGetFileInfo);

    if AllowToGetFileInfo then
      FilesInfo.Add(ProcessedFileInfo);

  until FindNext(FileInfo) <> 0;

  FindClose(FileInfo);

end;

end.
