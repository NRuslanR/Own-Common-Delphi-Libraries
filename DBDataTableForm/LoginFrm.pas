unit LoginFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, comobj, Buttons,  ComCtrls,  IniFiles,
  WideStrings,ZConnection, pngimage,   ZDbcIntfs, xpman, ZDataset,
  Mask, DBCtrlsEh, SHFolder;

const
  CNT_LAYOUT = 2; // количество известных раскладок
  FONT_SECTION_NAME = 'FONT';
  ENGLISH = '00000409';
  RUSSIAN = '00000419';
  FORM_CAPTION = 'Вход в систему';

  TKbdValue : array [1..CNT_LAYOUT] of string =
                ( ENGLISH,
                  RUSSIAN
                );
  TKbdDisplayNames : array [1..CNT_LAYOUT] of string =
                ('EN',
                 'RU'
                );

type
  TLoginForm = class(TForm)
    Timer1: TTimer;
    Panel3: TPanel;
    Label3: TLabel;
    pnlMain: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    imgKey: TImage;
    imgHeader: TImage;
    Bevel2: TBevel;
    imgLogo: TImage;
    imgUser: TImage;
    edtPassword: TEdit;
    edtUser: TEdit;
    pnlCfg: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    cbHostName: TComboBox;
    cbDatabase: TComboBox;
    pnlFooter: TPanel;
    Bevel1: TBevel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    spdbtnCfg: TBitBtn;
    pnlKbdLayout: TPanel;
    Label6: TLabel;
    edtPort: TDBNumberEditEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edtUserKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUserChange(Sender: TObject);
    procedure edtPasswordChange(Sender: TObject);
    procedure SetMargin(edt : TEdit; img: TImage);
    procedure cbDatabaseClick(Sender: TObject);
    procedure cbDatabaseChange(Sender: TObject);
    procedure edtUserEnter(Sender: TObject);
    procedure edtPasswordEnter(Sender: TObject);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spdbtnCfgClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure pnlKbdLayoutClick(Sender: TObject);
  private
    FOK: boolean;
    isDroppedCfg : boolean;
    FSender:TObject;
    isCloseAppIfCancel : boolean;
    isUserDefineDatabase : Boolean; // Если база данных задана пользователем явно
    isUserDefinePort     : Boolean; // Если порт задан пользователем явно
    FApplicationName : String;
    FConnection : TZConnection;
    CurProtocol : String;
    ConfigFileName : String;
    //zConnect: TZConnection;
    { Private declarations }
    procedure ReadConfigFile();
    procedure WriteConfigFile();
    procedure SetClientEncoding(ClientEncoding : String = 'UTF8');
  public
    { Public declarations }
    function GetTempDirPath: string;
    procedure SaveFontSettings(Font: TFont);
    procedure GetFontSettings(Font : TFont);
    function GetConfigFileName() : String;
    function GetDefaultConfigFileName() : String;
    class procedure SaveFont(Font: TFont);
    class procedure GetFont(Font : TFont);
    class function GetConfigDirPath() : String;
    function Connected() : boolean;
    property ApplicationName : String  read FApplicationName write FApplicationName;
    property Connection : TZConnection  read FConnection write FConnection;
  protected
    function GetNameKeyboardLayout() : string;
    function GetNamePrevKeyboardLayout() : string;
    procedure SetKbdLayout(kbLayout : string);
    procedure AppMsg(var Msg: TMsg; var Handled: Boolean);
    function GetUseDefaultConnectParamsConfFileName() : string;
    procedure SetDefaultConnectParams(ConfFileName : string);
  end;
function GetConnected(Sender:TObject; const UserName:string='';
                  const HostName:string=''; const DataBase:string='';
                  CloseAppIfCancel : boolean = true; Port : Integer = 5432):boolean;

function GetCmdConnected(Sender:TObject):boolean;
function TranslitRus2Lat(const s: string): string;
implementation

function GetCmdConnected(Sender:TObject):boolean;
//15.02.2018 Бочкарёв Н., Петрова Е.
// Позволяет запускать модуль из cmd по параметрам
var i,k: integer;
    foo:string;
begin
  k:=0;
  Result:=false;
  if (ParamCount >= 5) and ((Sender is TZConnection)) then
  with TZConnection(Sender) do
  begin
    for i := 0 to ParamCount do
    begin
      foo := lowercase(paramstr(i));
      if (foo = '--database') OR (foo = '-l') then
      begin
        Database := ParamStr(i+1);
        Inc(k);
      end;

      if (foo = '--user') OR (foo = '-u') then
      begin
        User := ParamStr(i+1);
        Inc(k);
      end;

      if (foo = '--host') OR (foo = '-h') then
      begin
        HostName := ParamStr(i+1);
        Inc(k);
      end;

      if (foo = '--password') OR (foo = '-w') then
      begin
        Password := ParamStr(i+1);
        Inc(k);
      end;

      if (foo = '--port') OR (foo = '-p') then
      begin
        Port := StrToInt(ParamStr(i+1));
        Inc(k);
      end;
    end;
    if (k=5) then
    begin
      if Protocol='' then
      begin
        Protocol:='postgresql';
      end;
      try
        Connect;
      except
        on E:EZSQLException do
          application.MessageBox(PChar(Utf8ToAnsi(E.Message)),
           'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION);
      end;
      Result:=Connected;
    end
    else Result:=false;
  end;
end;

function TranslitRus2Lat(const s: string): string;
const
  RArrayL ='абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
  RArrayU ='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
  colChar=33;
  arr: array [1..2,1..colChar] of string =
  (('a','b','v','g','d','e','e','zh','z','i','j','k','l','m','n','o','p',
    'r','s','t','u','f','h','c','ch','sh','sch','','y','','e','yu','ya'),
   ('A','B','V','G','D','E','E','Zh','Z','I','J','K','L','M','N','O','P',
    'R','S','T','U','F','H','C','Ch','Sh','Sch','','Y','','E','Yu','Ya'));
var i, LenS, p: Integer;
    d: Byte;
begin
  Result:='';
  LenS:=Length(s);
  for i := 1 to LenS do
  begin
    d:=1;
    p:=Pos(s[i],RArrayL);
    if p=0 then
    begin
      p:=Pos(s[i],RArrayU);
      d:=2;
    end;
    if p<>0 then
      Result:=Result+arr[d,p]
    else
      Result:=Result+s[i];  //если не русская буква, то берём исходный символ
  end;  
end;

{$R LoginForm.res}
function TLoginForm.GetTempDirPath: string;
var
  Buffer: array[0..1023] of Char;
begin
  SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
end;


function TLoginForm.GetUseDefaultConnectParamsConfFileName: string;
var
  ini : TIniFile;
  DefaultConfig : String;
begin
  DefaultConfig := GetDefaultConfigFileName();

  if not FileExists(DefaultConfig) then
  begin
    Result := '';
    exit;
  end;

  ini := TIniFile.Create(DefaultConfig);
  try
    try
      Result := ini.ReadString('use_connect_params', 'confname', '');
    except
      Result := '';
      exit;
    end;
  finally
    FreeAndNil(ini);
  end;
end;


procedure TLoginForm.pnlKbdLayoutClick(Sender: TObject);
begin
  pnlKbdLayout.Caption := GetNamePrevKeyboardLayout();
  if GetNamePrevKeyboardLayout()='RU' then
    SetKbdLayout(RUSSIAN)
  else
    SetKbdLayout(ENGLISH);
end;

procedure FileCopy(const SourceFileName, TargetFileName: string);
var
  S, T : TFileStream;
begin
  S := TFileStream.Create(sourcefilename, fmOpenRead );
  try
    T := TFileStream.Create(targetfilename, fmOpenWrite or fmCreate);
    try
      T.CopyFrom(S, S.Size ) ;
      FileSetDate(T.Handle, FileGetDate(S.Handle));
    finally
      T.Free;
    end;
  finally
    S.Free;
  end;
end;

function GetSpecialFolderPath(folder : integer) : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0])) then
    Result := path
  else
    Result := '';
end;


procedure TLoginForm.ReadConfigFile;
var
  ini : TIniFile;
  LastHost : String;
  LastUser : String;
  foo : String;
  LastDB : String;
  Port  : Integer;
  i : integer;
  DefaultConfig : String;
  DefaultConnectConfFileName : String;
begin

  cbDatabase.ItemIndex := -1;
  cbHostName.ItemIndex := -1;


  DefaultConfig := GetDefaultConfigFileName();
  //showmessage(DefaultConfig);
  //showmessage(ConfigFileName);
  if (not FileExists(ConfigFileName) AND FileExists(DefaultConfig))
  then
  begin
    ini := TIniFile.Create(DefaultConfig);
  end
  else
    ini := TIniFile.Create(ConfigFileName);

  if not assigned(ini) then
  begin
      showmessage('Конфигурационный файл не найден. Невозможно создать новый конфигурационный файл.');
  end;

  try
    foo := ini.ReadString(CurProtocol, 'hostname', '');
    cbHostName.Items.CommaText := foo;

    foo := ini.ReadString(CurProtocol, 'dbname', '');
    cbDatabase.Items.CommaText := foo;
    LastHost := ini.ReadString(CurProtocol, 'last_hostname', '');
    LastDB := ini.ReadString(CurProtocol, 'last_dbname', '');
    LastUser := ini.ReadString(CurProtocol, 'last_user', '');


    edtUser.Text  := Trim(LastUser);

    if not isUserDefinePort then
    begin
      Port     := ini.ReadInteger(CurProtocol, 'port', -1);
      if Port = -1 then
        edtPort.Value := 5432
      else
        edtPort.Value := Port;
    end;

    cbDatabase.ItemIndex := cbDatabase.Items.IndexOf(LastDB);
    cbHostName.ItemIndex := cbHostName.Items.IndexOf(LastHost);

    if (not FileExists(ConfigFileName) AND FileExists(DefaultConfig))
    then
    begin
      cbDatabase.ItemIndex := 0;
      cbHostName.ItemIndex := 0;
    end;

    DefaultConnectConfFileName := GetUseDefaultConnectParamsConfFileName();
    if DefaultConnectConfFileName <> '' then
      SetDefaultConnectParams(DefaultConnectConfFileName);
  finally
    FreeAndNil(ini);
  end;

end;


// обработчик событий
procedure TLoginForm.AppMsg(var Msg: TMsg; var Handled: Boolean);
begin
  // Обрабатываем событие смены раскладки
  if (Msg.message = WM_INPUTLANGCHANGEREQUEST) then
  begin
    pnlKbdLayout.Caption := GetNamePrevKeyboardLayout();
  end;

end;


class function TLoginForm.GetConfigDirPath: String;
begin
  result := GetSpecialFolderPath(CSIDL_LOCAL_APPDATA);
end;

function TLoginForm.GetConfigFileName: String;
var
  ConfFileName : String;
begin
  ConfFileName := ExtractFileName(ChangeFileExt(Application.ExeName,'.ini'));

  // (%User%/Application Data)
  result := GetConfigDirPath()+ PathDelim + ConfFileName;
end;

function TLoginForm.GetDefaultConfigFileName: String;
begin
  //result :=  GetCurrentDir + PathDelim +  'default.ini';

  result :=  ExtractFileDir(ParamStr(0)) + PathDelim +  'default.ini';
end;

class procedure TLoginForm.GetFont(Font : TFont);
var
  LgnFrm: TLoginForm;
begin
 LgnFrm := TLoginForm.Create(nil);
 try
   LgnFrm.GetFontSettings(Font);
 finally
   LgnFrm.Free;
 end;
end;

procedure TLoginForm.GetFontSettings(Font : TFont);
var
  ini : TIniFile;
  FontStyleInt: byte;   
  FS: TFontStyles;

begin
  ini := TIniFile.Create(ConfigFileName);
  try
    Font.Name    := ini.ReadString (FONT_SECTION_NAME, 'Name',    'Tahoma');
    Font.Color   := ini.ReadInteger(FONT_SECTION_NAME, 'Color',   0);
    Font.Charset := ini.ReadInteger(FONT_SECTION_NAME, 'CharSet', 204);
    Font.Size    := ini.ReadInteger(FONT_SECTION_NAME, 'Size',    8);
    FontStyleInt   := ini.ReadInteger(FONT_SECTION_NAME, 'Style',   0);

    Move(FontStyleInt, FS, 1);
    Font.Style := FS;
  finally
    FreeAndNil(ini);

  end;
end;

// получаем название раскладки
function TLoginForm.GetNameKeyboardLayout() : string;
var
  s: string;
  Lang: Array[0..$FFF] of Char;
begin
  Result := '';
  GetKeyboardLayoutName(Lang) ;
  s := StrPas(Lang);
  if s = '00000419' then
    Result := TKbdDisplayNames[2]
  else
    if s = '00000409' then
      Result := TKbdDisplayNames[1]
    else
      Result := '?';
end;

// получаем предыдущее название раскладки
function TLoginForm.GetNamePrevKeyboardLayout() : string;
var
  s: string;
  Lang: Array[0..$FFF] of Char;
begin
  Result := '';
  GetKeyboardLayoutName(Lang) ;
  s := StrPas(Lang);
  if s = '00000419' then
    Result := TKbdDisplayNames[1]
  else
    if s = '00000409' then
      Result := TKbdDisplayNames[2]
    else
      Result := '?';
end;


class procedure TLoginForm.SaveFont(Font: TFont);
var
  LgnFrm: TLoginForm;
begin
 LgnFrm := TLoginForm.Create(nil);
 try
   LgnFrm.SaveFontSettings(Font);
 finally
   LgnFrm.Free;
 end;
end;

procedure TLoginForm.SaveFontSettings(Font: TFont);
var
   ini : TIniFile;
   foo : String;
   FontStyleInt: byte;
   FS: TFontStyles;
begin
    try
      ini := TIniFile.Create(ConfigFileName);
      try
        FS := Font.Style;
        Move(FS, FontStyleInt, 1);

        ini.WriteString(FONT_SECTION_NAME,  'Name', Font.Name);
        ini.WriteInteger(FONT_SECTION_NAME, 'Color', Font.Color);
        ini.WriteInteger(FONT_SECTION_NAME, 'CharSet', Font.Charset);
        ini.WriteInteger(FONT_SECTION_NAME, 'Size', Font.Size);
        ini.WriteInteger(FONT_SECTION_NAME, 'Style', FontStyleInt);
      except
          //
      end;
    finally
      ini.Free;
    end;
end;

procedure TLoginForm.SetClientEncoding(ClientEncoding: String);
var
  ZQuery : TZQuery;
begin
  ZQuery := TZQuery.Create(self);

  try
    try
      ZQuery.Connection := TZConnection(FSender);
      ZQuery.SQL.Text := 'SET CLIENT_ENCODING TO :encoding;';
      ZQuery.ParamByName('encoding').AsString := ClientEncoding;
      ZQuery.ExecSQL;
    except

    end;
  finally
    FreeAndNil(ZQuery);
  end;

end;


procedure TLoginForm.SetDefaultConnectParams(ConfFileName: string);
var
  ini : TIniFile;
  param_database : string;
  param_host : string;
  param_port : integer;
begin
  ini := TIniFile.Create(ConfFileName);
  try
    try
      param_database  := ini.ReadString('connect_params', 'database', '');
      param_host      := ini.ReadString('connect_params', 'host', '');
      param_port      := ini.ReadInteger('connect_params', 'port', 5432);

      edtPort.Value := param_port;

      if cbDatabase.Items.IndexOf(param_database) = -1 then
        cbDatabase.Items.Add(param_database);
      cbDatabase.ItemIndex := cbDatabase.Items.IndexOf(param_database);

      if cbHostName.Items.IndexOf(param_host) = -1 then
        cbHostName.Items.Add(param_host);
      cbHostName.ItemIndex := cbHostName.Items.IndexOf(param_host);
    except
      exit;
    end;
  finally
    FreeAndNil(ini);
  end;
end;

// установить раскладку в своей программе
procedure TLoginForm.SetKbdLayout(kbLayout : string);
var
  Layout: HKL;
  L: array[0.. KL_NAMELENGTH] of char;
begin
  // Получить ссылку на раскладку
  Layout := LoadKeyboardLayout(StrCopy(L, PChar(kbLayout)),0);
  // Переключить раскладку
  ActivateKeyboardLayout(Layout,KLF_ACTIVATE);
  Application.ProcessMessages;
end;

//------------------------
function GetConnected(Sender:TObject; const UserName:string='';
                  const HostName:string=''; const DataBase:string='';
                   CloseAppIfCancel : boolean = true; Port : integer = 5432):boolean;
var
  LgnFrm: TLoginForm;
  FApplicationName : String;
begin
  Result := false;
  if (GetCmdConnected(Sender)=false) or (CloseAppIfCancel=false) then
  begin
    LgnFrm := TLoginForm.Create(nil);
    try
     LgnFrm.FSender := Sender;
     LgnFrm.isCloseAppIfCancel := CloseAppIfCancel;

     if Trim(UserName) <> '' then
       LgnFrm.edtUser.Text := UserName;

     if Trim(DataBase) <> '' then
       LgnFrm.isUserDefineDatabase := true;

     if (LgnFrm.cbDatabase.Items.Count = 0) OR (LgnFrm.isUserDefineDatabase) then
      LgnFrm.cbDatabase.Text := DataBase;

     if (LgnFrm.cbHostName.Items.Count = 0) OR (Trim(HostName) <> '') then
      LgnFrm.cbHostName.Text := HostName;

     if Port <> 5432 then
       LgnFrm.isUserDefinePort := true;

     LgnFrm.edtPort.Value := Port;
   
    with TZConnection(Sender) do
    begin
     if Protocol='' then
     begin
      Protocol:='postgresql';
     end;
      LgnFrm.CurProtocol := Protocol;
    end;

     LgnFrm.ReadConfigFile();
     LgnFrm.ShowModal;
    finally
      Result := LgnFrm.FOK;

      LgnFrm.Free;
    end;

  end
  else
  begin
    // В версии 9.0 появилась возможность задать имя приложения
    if (Sender is TZConnection) then
    with TZConnection(Sender) do
    if (ServerVersion >= 9000000) then
    begin
      FApplicationName:='';
      if (trim(FApplicationName) = '') then
        FApplicationName := Format('UMP_p - %s (%s)',
                            [TranslitRus2Lat(Application.Title),
                             ExtractFileName(Application.ExeName)] );
      ExecuteDirect('SET application_name=''' + FApplicationName + '''');
    end;
    Result:=true;

  end;

end;
//-----------------------


{$R *.DFM}

procedure TLoginForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not CloseQuery then
    exit;
    
  // Переключаемся на русскую раскладку
  SetKbdLayout(RUSSIAN);
  Application.OnMessage:= nil;
  Action := cafree;
  if FOK = true then  Action:=caHide
  else if isCloseAppIfCancel then 
    Application.Terminate;

end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  Application.OnMessage:=AppMsg;
  SetKbdLayout(ENGLISH);

  GetFontSettings(Font);
  Self.Caption := FORM_CAPTION + ' (БД: '+ cbDatabase.Text+')';
  SetMargin(edtUser, imgUser);
  SetMargin(edtPassword, imgKey);

  pnlKbdLayout.Caption := GetNameKeyboardLayout();
  if edtPassword.Text = '' then
    btnOk.Enabled := false;

  if edtUser.Text = '' then begin
    edtUser.SetFocus;
    edtUser.Text := 'u_имя пользователя';
    edtUser.SelStart:=2;
    edtUser.SelLength:=16;
  end
  else
  if edtPassword.Text = '' then
    edtPassword.SetFocus;


end;

procedure TLoginForm.Timer1Timer(Sender: TObject);
var
  Layout: array[0.. KL_NAMELENGTH] of char;
  isConnected : boolean;
begin
 isConnected := false;
 Timer1.Enabled:=false;
 screen.Cursor := crSQLWait;
 if  (FSender is TZConnection)  then begin

 with TZConnection(FSender) do  begin

      {$IFDEF UNICODE}
          Properties.Add('CODEPAGE=UTF8');
      {$ELSE UNICODE}
          Properties.Add('CODEPAGE=WIN1251');
      {$ENDIF UNICODE}

  LoginPrompt:=false;
    try
     if Protocol='' then
     begin
      Protocol:='postgresql';
     end;
    CurProtocol := Protocol;
    if connected then
    begin
      Disconnect;
      //Close;
    end;

    Database := cbDatabase.Text;
    HostName := cbHostName.Text;
    User := edtUser.Text;
    Password := edtPassword.Text;
    Port     := edtPort.Value;

    if (trim(Database) = '') OR (trim(HostName) = '') then
    begin
      if trim(Database) = '' then
        application.MessageBox('Введите имя базы данных.',
               'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION)
      else
      if trim(HostName) = '' then
        application.MessageBox('Введите имя сервера.',
               'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION)
    end
    else
    begin
      Connected := true;

      isConnected := Connected;
      FOK := isConnected;
    end;
    except
      on E:EZSQLException do
      begin
        if pos('Unknown host', e.message) <> 0 then
          application.MessageBox('Не удалось установить подключение к серверу.'
              +#13#10+'Сервер недоступен. Проверьте правильность имени сервера.',
           PChar('Установка связи с '+cbDatabase.Text+'...'),mb_OK+mb_IconEXCLAMATION)
        else
        if pos('password authentication failed', e.message) <> 0 then
          application.MessageBox('Неправильное имя пользователя или пароль. Доступ запрещен.'
              +#13#10+'Попробуйте еще раз.',
           'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION)
        else
        if pos('server closed the connection unexpectedly', e.message) <> 0 then
          application.MessageBox('Сервер неожиданно закрыл соединение.'
          +#13#10+'Скорее всего это означает, что сервер завершил работу со сбоем'
          +#13#10+'до или в процессе выполнения запроса.'
              +#13#10+#13#10+'Попробуйте еще раз.',
           'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION)
        else
        if pos('не существует', e.message) <> 0 then
          application.MessageBox(pChar('База данных "' + Database + '" не существует.'
              +#13#10+#13#10+'Проверьте правильность имени базы данных.'),
           'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION)
        else
          application.MessageBox(PChar(Utf8ToAnsi(E.Message)),
           'Проверка имени и пароля',mb_OK+mb_IconEXCLAMATION);
        pnlKbdLayout.Caption := GetNameKeyboardLayout();
      end;
    end;


  end;
  end;



  if isConnected then
  begin
    // В версии 9.0 появилась возможность задать имя приложения
    if (TZConnection(FSender).ServerVersion >= 9000000) then
    begin
      if (trim(FApplicationName) = '') then
        FApplicationName := Format('UMP - %s (%s)',
                          [TranslitRus2Lat(Application.Title),
                           ExtractFileName(Application.ExeName)] );
      TZConnection(FSender).ExecuteDirect('SET application_name=''' + FApplicationName + '''');
    end;
    Close;
  end;
  Screen.Cursor:=crDefault;
  panel3.visible:=false;
  edtPassword.Text:='';
  pnlMain.Show;
        Self.Caption := FORM_CAPTION + ' (БД: '+ cbDatabase.Text+')';
        if edtUser.Text = '' then
          edtUser.SetFocus
        else
        if edtPassword.Text = '' then
          edtPassword.SetFocus;

  if isConnected then
  begin
    //LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
    WriteConfigFile();
  end;

end;

procedure TLoginForm.WriteConfigFile;
  // Проверяет входимость строки "value" в список строк "List",
  // элементы которого должны быть разделены запятыми
  function IsValueExistsInList(value : String; List : String) : boolean;
  var
     foo_list : TStringList;
     i : Integer;
  begin
    result := false;
    try
      foo_list := TStringList.Create();
      foo_list.CommaText := List;
      for i := 0 to foo_list.Count - 1 do
      begin
        if foo_list[i] = value then
          result := true;
      end;
    finally
      FreeAndNil(foo_list);
    end;
  end;
var
   ini : TIniFile;
   foo : String;
begin
  if not isUserDefineDatabase then
  begin
    try
      ini := TIniFile.Create(ConfigFileName);
      try
        foo := ini.ReadString(CurProtocol, 'hostname', '');

        if (length(trim(foo)) = 0) then
          ini.WriteString(CurProtocol, 'hostname', cbHostName.Text)
        else if not IsValueExistsInList(cbHostName.Text, foo) then
          ini.WriteString(CurProtocol, 'hostname', foo + ', '+cbHostName.Text);

        foo := ini.ReadString(CurProtocol, 'dbname', '');
        if (length(trim(foo)) = 0) then
          ini.WriteString(CurProtocol, 'dbname', cbDatabase.Text)
        else if not IsValueExistsInList(cbDatabase.Text, foo) then
          ini.WriteString(CurProtocol, 'dbname', foo + ', '+cbDatabase.Text);


        ini.WriteString(CurProtocol, 'last_hostname', cbHostName.Text);
        ini.WriteString(CurProtocol, 'last_dbname', cbDatabase.Text);
        ini.WriteString(CurProtocol, 'last_user', edtUser.Text);
        ini.WriteString(CurProtocol, 'port', edtPort.Value);

        except
          //
        end;
      finally
        ini.Free;
      end;
    end;
end;

procedure TLoginForm.edtUserKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then edtPassword.SetFocus;
end;

procedure TLoginForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Escape then BtnCancelClick(Sender);
  if ((Key=VK_SHIFT) and ((Shift=[ssAlt]) or (Shift=[ssCtrl]))) or
  ((Key=VK_MENU)and (Shift=[ssShift])) then
  begin
    pnlKbdLayout.Caption := GetNamePrevKeyboardLayout();
    if GetNamePrevKeyboardLayout()='RU' then
      SetKbdLayout(RUSSIAN)
    else
      SetKbdLayout(ENGLISH);
  end;
end;

procedure TLoginForm.btnOkClick(Sender: TObject);
var
  user : string;
  pswd : string;
begin
  user := Trim(edtUser.Text);
  pswd := Trim(edtPassword.Text);

  if user = '' then
  begin
    application.MessageBox('Введите имя пользователя.',
      'Авторизация пользователя', MB_OK + MB_ICONEXCLAMATION);
    exit;
  end
  else if pswd = '' then
    begin
      application.MessageBox('Не введен пароль пользователя.'
      +#13#10+'Пожалуйста ведите пароль.',
      'Авторизация пользователя', MB_OK + MB_ICONEXCLAMATION);
      exit;
    end;

  // Скрываем все элементы
  pnlMain.Hide;

  // Показываем процесс соединения
  Caption:='Идет соединение ...';
  Panel3.Align := alClient;
  Panel3.Visible:=true;


  Timer1.Enabled:=true;
end;



procedure TLoginForm.btn1Click(Sender: TObject);
begin
  Showmessage(FApplicationName);
end;

procedure TLoginForm.btnCancelClick(Sender: TObject);
begin
  edtPassword.Text:='';
  Close();
end;

procedure TLoginForm.SetMargin(edt : TEdit; img: TImage);
begin
  try
     // Проверяем состояние
     if img.Picture.Graphic = nil then
        // Убираем отступ
        edt.Perform(EM_SETMARGINS, EC_LEFTMARGIN, MakeLong(0, 0))
     else
        // Устанавливаем размер отступа слева
        edt.Perform(EM_SETMARGINS, EC_LEFTMARGIN, MakeLong(img.Width+4, 0));
  finally
     // Изменяем позицию изображения
     img.SetBounds(0, 0, img.Width, img.Height);
  end;
end;


procedure TLoginForm.spdbtnCfgClick(Sender: TObject);
begin
  isDroppedCfg := not isDroppedCfg;
  if isDroppedCfg then
  begin
    spdbtnCfg.Glyph.LoadFromResourceName(HInstance, 'BMP_TRIANGLE_RIGHT');
    self.Height := 298;
    pnlCfg.Show;
  end
  else
  begin
    spdbtnCfg.Glyph.LoadFromResourceName(HInstance, 'BMP_TRIANGLE_DOWN');

    self.Height := 221;
    pnlCfg.hide;
  end;

end;

procedure TLoginForm.FormCreate(Sender: TObject);
var
  MyPNG : TPNGObject;

begin
  CurProtocol := 'postgresql';
  isCloseAppIfCancel := false;
  isUserDefineDatabase := false;
  // Переключаемся на английскую раскладку
  //LoadKeyboardLayout('00000409',KLF_ACTIVATE);
  isUserDefinePort := false;




  isDroppedCfg := false;

  // Загрузка ресурсов
  MyPNG := TPNGObject.Create;

  // Устанавливаем в качестве символа пароля жирную точку
  edtPassword.Font.Charset := 2;  //SYMBOL_CHARSET
  edtPassword.PasswordChar := 'l'; //ascii = 108

  ConfigFileName := GetConfigFileName();//GetTempDirPath()+ExtractFileName(ChangeFileExt(Application.ExeName,'.init'));

  try

    MyPNG.LoadFromResourceName(HInstance, 'PNG_LOGO');
    imgLogo.Picture.Assign(MyPNG);

    MyPNG.LoadFromResourceName(HInstance, 'PNG_SPLASHSCRN');
    imgHeader.Picture.Assign(MyPNG);
    //MyBMP.LoadFromResourceName(HInstance, 'BMP_LOGO');
    //imgHeader.Picture.Assign(MyBMP);
    MyPNG.LoadFromResourceName(HInstance, 'PNG_USER');
    imgUser.Picture.Assign(MyPNG);
    MyPNG.LoadFromResourceName(HInstance, 'PNG_KEY');
    imgKey.Picture.Assign(MyPNG);
    


    spdbtnCfg.Glyph.LoadFromResourceName(HInstance, 'BMP_TRIANGLE_DOWN');
  finally
    MyPNG.Free;
  end;



  // Помещаем иконки в поля ввода
  imgUser.Parent:=edtUser;
  imgUser.SetBounds(0, 0, 16, 16);
  imgKey.Parent:=edtPassword;
  imgKey.SetBounds(0, 0, 16, 16);

  self.Height := 221;
  pnlCfg.hide;

end;

procedure TLoginForm.edtUserChange(Sender: TObject);
begin
  SetMargin(edtUser, imgUser);
end;

procedure TLoginForm.edtPasswordChange(Sender: TObject);
begin
  SetMargin(edtPassword, imgKey);
  if edtPassword.Text <> '' then
    btnOk.Enabled := true
  else
    btnOk.Enabled := false;
end;

procedure TLoginForm.cbDatabaseClick(Sender: TObject);
begin
  SetMargin(edtUser, imgUser);
end;

function TLoginForm.Connected: boolean;
begin
   FSender := FConnection;
   Result := false;
   ReadConfigFile();
   ShowModal();
   Result := FOK;
end;


procedure TLoginForm.cbDatabaseChange(Sender: TObject);
begin
  Self.Caption := FORM_CAPTION + ' (БД: '+ cbDatabase.Text+')';
  SetMargin(edtUser, imgUser);
end;

procedure TLoginForm.edtUserEnter(Sender: TObject);
begin
  SetMargin(edtUser, imgUser);
end;

procedure TLoginForm.edtPasswordEnter(Sender: TObject);
begin
  SetMargin(edtPassword, imgKey);
end;



procedure TLoginForm.edtPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key=13 then BtnOkClick(Sender);
end;

end.
