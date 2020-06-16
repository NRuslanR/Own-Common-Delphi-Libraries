unit FileSearcherUnit;

interface
uses Classes, SysUtils, StrUtils;

type
  TFileSearcher = class

    strict protected

      FBeginDirectory: string; // начальная директория поиска файлов

      // Считывает информацию о файлах, начиная с директории Path,
      // в список FilesInfo рекурсивно (Recursive = True) или не рекурсивно
      // (Recursive = False)
      procedure ReadDirectory(const Path: string; FilesInfo: TList; const Recursive: Boolean);

      // Выполняет произвольную обработку собранной о файле информации
      // и возращает объект, её содержащий.
      // По умолчанию объектом является строка (тип string), содержащая
      // полное название файла. Производные классы могут переопрделить
      // этот метод для возврата объектов требуемых типов
      function ProcessFileInfo(
        const DirPathOfFile: String;
        const FileInfo: TSearchRec;
        var AllowToGetFileInfo: Boolean
      ): Pointer; virtual;

    public

      property BeginDirectory : string read FBeginDirectory write FBeginDirectory;

      constructor Create(BeginDirectory: string);
      destructor Destroy; override;

      // Получить список данных о найденных файлах
      // Флаг Recursive указывает на необходимость или
      // отсутствие необходимости рекурсивного сбора информации о файлах
      function GetFilesInfo(const Recursive: Boolean = False): TList; // возвращает объект типа TList,
      // элементами которого являются объекты типов, возвращаемых из функции
      // ProcessFileInfo. По умолчанию возвращаются объекты типа string,
      // содержащие полные названия найденных файлов. Производные классы
      // могут переопределить это поведение, возвратив объект произвольного
      // типа, приведенного к типу Pointer
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
