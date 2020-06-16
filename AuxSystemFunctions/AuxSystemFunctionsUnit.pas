unit AuxSystemFunctionsUnit;

interface

uses SysUtils, Variants, Classes, DB, Controls;

type

  TAppLocalDataFolderPathSearchOptions =
    (
      CreateFolderIfNotExists,
      GetPathOfExistingFolder
    );

function GetFileSize(const FilePath: String): Int64;

procedure OpenDocument(const Name: string);

procedure OpenDocumentFromDataSetField(
const FileName: String;
const DataSet: TDataSet;
const FieldName: String
);

procedure OpenDirectory(const DirPath: string);

procedure OpenDocumentDirectoryAndHighlight(const FilePath: String);

function BrowseForFolder(
  const browseTitle: String;
  const initialFolder: String = '';
  mayCreateNewFolder: Boolean = False
): String;

function GetAppLocalDataFolderPath(
  const FolderName: String = '';
  const Options: TAppLocalDataFolderPathSearchOptions = GetPathOfExistingFolder
): String;

function GetApplicationExeNameWithoutExtension: String;

{Function Wow64DisableWow64FsRedirection(Var Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
External 'Kernel32.dll' Name 'Wow64DisableWow64FsRedirection';

Function Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
External 'Kernel32.dll' Name 'Wow64EnableWow64FsRedirection';
 }

procedure ShowVirtualKeyboardFor(Control: TWinControl);

var ActivateVirtualKeyboardUsing: Boolean = False;

function GetUserTemporaryFolderPath: String;

implementation

uses Forms, Graphics,
     Dialogs, StdCtrls, Grids, Printers, ShellApi,
     Windows, Messages, shlobj, SHFolder;

var
  lg_StartFolder: String;

procedure OpenDocumentFromDataSetField(
const FileName: String;
const DataSet: TDataSet;
const FieldName: String);
var FileDataBlobStream, fs: TStream;
    field: TBlobField;
    ms: TMemoryStream;
begin
  FileDataBlobStream := nil;

  with TFileStream.Create(FileName, fmCreate) do begin
    try
      field := DataSet.FieldByName(FieldName) as TBlobField;

      FileDataBlobStream := DataSet.CreateBlobStream(
        DataSet.FieldByName(FieldName), bmRead);

      FileDataBlobStream.Position := 0;

      CopyFrom(FileDataBlobStream, FileDataBlobStream.Size);
    finally
      Free;
      FreeAndNil(FileDataBlobStream);
    end;
  end;

  //TBlobField(DataSet.FieldByName('file_data')).SaveToFile(FileName);

  OpenDocument(FileName);
end;

procedure OpenDocument(const Name: string);
var errCode: cardinal;
    errString: string;
begin
  if (Name = '') then exit;

  errCode := ShellExecute(Application.Handle, 'open', PChar(Name), nil, nil, SW_SHOWNORMAL);

  case errCode of
    ERROR_FILE_NOT_FOUND: errString := 'Файл не найден !';
    ERROR_PATH_NOT_FOUND: errString := 'Директория не найдена !';
    SE_ERR_ACCESSDENIED: errString := 'Отказано в доступе !';
    else begin
      if errCode <= 32 then errString := 'Не удалось открыть файл !'
      else errString := '';
    end;
  end;

  if errString <> '' then
    MessageBox(0, PChar(errString), 'Ошибка', MB_ICONERROR);
end;

procedure OpenDirectory(const DirPath: String);
var params: string;
    errCode: cardinal;
    errString: string;
begin

  errCode := ShellExecute(Application.Handle, nil, PChar(DirPath), nil, nil, SW_SHOWNORMAL);

  case errCode of
    ERROR_FILE_NOT_FOUND: errString := 'Директория не найдена !';
    ERROR_PATH_NOT_FOUND: errString := 'Директория не найдена !';
    else begin
      if errCode <= 32 then errString := 'Не удалось открыть директорию !'
      else errString := '';
    end;
  end;

  if errString <> '' then
    MessageBox(0, PChar(errString), 'Ошибка', MB_ICONERROR);
end;

procedure OpenDocumentDirectoryAndHighlight(const FilePath: String);
var params: string;
    errCode: cardinal;
    errString: string;
begin
  if FilePath <> '' then
    params := '/select,"' + FilePath + '"'
  else params := '';

  errCode := ShellExecute(Application.Handle, 'open', 'explorer.exe', PChar(params), nil, SW_SHOWNORMAL);

  case errCode of
    ERROR_FILE_NOT_FOUND: errString := 'Файл не найден !';
    ERROR_PATH_NOT_FOUND: errString := 'Директория не найдена !';
    else begin
      if errCode <= 32 then errString := 'Не удалось открыть файл !'
      else errString := '';
    end;
  end;

  if errString <> '' then
    MessageBox(0, PChar(errString), 'Ошибка', MB_ICONERROR);
end;

function BrowseForFolderCallBack(Wnd: HWND; uMsg: UINT; lParam,
lpData: LPARAM): Integer stdcall;
begin
  if uMsg = BFFM_INITIALIZED then
    SendMessage(Wnd,BFFM_SETSELECTION, 1, Integer(@lg_StartFolder[1]));
  result := 0;
end;

function BrowseForFolder(const browseTitle: String;
  const initialFolder: String ='';
  mayCreateNewFolder: Boolean = False): String;
var
  browse_info: TBrowseInfo;
  folder: array[0..MAX_PATH] of char;
  find_context: PItemIDList;
begin

  FillChar(browse_info,SizeOf(browse_info),#0);
  lg_StartFolder := initialFolder;
  browse_info.pszDisplayName := @folder[0];
  browse_info.lpszTitle := PChar(browseTitle);
  browse_info.ulFlags := BIF_RETURNONLYFSDIRS or BIF_NEWDIALOGSTYLE;
  if not mayCreateNewFolder then
    browse_info.ulFlags := browse_info.ulFlags or BIF_NONEWFOLDERBUTTON;

  browse_info.hwndOwner := Application.Handle;
  if initialFolder <> '' then
    browse_info.lpfn := BrowseForFolderCallBack;
  find_context := SHBrowseForFolder(browse_info);
  if Assigned(find_context) then
  begin
    if SHGetPathFromIDList(find_context,folder) then
      result := folder
    else
      result := '';
    GlobalFreePtr(find_context);
  end
  else
    result := '';
end;

function GetAppLocalDataFolderPath(
  const FolderName: String = '';
  const Options: TAppLocalDataFolderPathSearchOptions = GetPathOfExistingFolder
): String;
var LocalAppDataPath: array[0..MAX_PATH] of Char;
begin

  if SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, LocalAppDataPath) = S_OK
  then begin

    Result := IncludeTrailingPathDelimiter(LocalAppDataPath) + FolderName;

    if not (DirectoryExists(Result) or CreateDir(Result)) then
      Result := '';

  end

  else Result := '';

end;

function GetApplicationExeNameWithoutExtension: String;
begin

  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '');
  
end;

procedure ShowVirtualKeyboardFor(Control: TWinControl);
begin

  if not ActivateVirtualKeyboardUsing then Exit;

  try

      //Wow64DisableWow64FsRedirection(Wow64FsEnableRedirection);
      ShellExecute(0, nil, 'C:\Windows\System32\osk.exe','','', SW_SHOW);
      //Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection);

      Control.SetFocus;

  finally

  end;

end;

function GetUserTemporaryFolderPath: String;
var PathBuffer: array [0..MAX_PATH] of Char;
begin

  if GetTempPath(MAX_PATH, PathBuffer) <> 0 then
    Result := PathBuffer

  else Result := '';
  
end;

function GetFileSize(const FilePath: String): Int64;
begin

  with TFileStream.Create(FilePath, fmOpenRead) do begin

    try

      Result := Size;
    
    finally

      Free;
      
    end;

  end;
end;

end.
