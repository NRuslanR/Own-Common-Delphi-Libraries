unit CliMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, ComCtrls, Db, DBClient, SMI2XML, SMIBase, SMI2HTML,
  ExtCtrls, Grids, DBGrids;

type
  TfrmCliMain = class(TForm)
    ClientSocket1: TClientSocket;
    btnGetData: TButton;
    gbPreview: TGroupBox;
    StatusBar1: TStatusBar;
    ClientDataSet1: TClientDataSet;
    SMImportFromHTML1: TSMImportFromHTML;
    SMImportFromXML1: TSMImportFromXML;
    rgPackageFormat: TRadioGroup;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure btnGetDataClick(Sender: TObject);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Lookup(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Write(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SMImportFromHTML1CreateStructure(Sender: TObject;
      Columns: TSMIColumns);
    procedure SMImportFromXML1GetCellParams(Sender: TObject; Field: TField;
      var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliMain: TfrmCliMain;

implementation

{$R *.DFM}

procedure TfrmCliMain.btnGetDataClick(Sender: TObject);
const
   MAX_BUF_SIZE = $4095;
var
  count: Integer;
  buffer: array[0..MAX_BUF_SIZE] of Char;

  strm: TMemoryStream;
begin
  {1. connect to server}
  ClientSocket1.Open;

  {2. request the package with exported dataset}
  if (rgPackageFormat.ItemIndex = 1) then
    ClientSocket1.Socket.SendText('%GET DATA%HTML%')
  else
    ClientSocket1.Socket.SendText('%GET DATA%XML%');

  {3. load the package from server into stream}
  strm := TMemoryStream.Create;
  try
    repeat
      ClientSocket1.Socket.Lock;
      count := ClientSocket1.Socket.ReceiveBuf(buffer, SizeOf(buffer));
      if count > 0 then
        strm.WriteBuffer(buffer, count);
      ClientSocket1.Socket.UnLock;
    until (count <= 0);

    {4. load the stream into dataset (parse by SMImport)}
    if (strm.Size > 0) then
    begin
      strm.Seek(0, soFromBeginning);
      if (rgPackageFormat.ItemIndex = 1) then
        SMImportFromHTML1.LoadFromStream(strm)
      else
        SMImportFromXML1.LoadFromStream(strm)
    end;
  finally
    strm.Free
  end;

  {5. disconnect from server}
  ClientSocket1.Close;

  {6. to activate the preview with loaded report}
  if (rgPackageFormat.ItemIndex = 1) then
  else
end;

procedure TfrmCliMain.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  MessageDlg('Socket error:' + IntToStr(ErrorCode), mtError, [mbOk], 0);
  ErrorCode := 0;
end;

procedure TfrmCliMain.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Connected';
end;

procedure TfrmCliMain.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Connecting...';
end;

procedure TfrmCliMain.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Disconnected';
end;

procedure TfrmCliMain.ClientSocket1Lookup(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Lookup the server';
end;

procedure TfrmCliMain.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Read from server';
end;

procedure TfrmCliMain.ClientSocket1Write(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusBar1.SimpleText := 'Write to server';
end;

procedure TfrmCliMain.SMImportFromHTML1CreateStructure(Sender: TObject;
  Columns: TSMIColumns);
var
  i: Integer;
begin
  {delete all current dataset fields}
  ClientDataSet1.Close;
  ClientDataSet1.FieldDefs.Clear;

  {create a structure by parsed columns from CSV}
  for i := 0 to Columns.Count-1 do
  begin
    if Columns[i].Size = 0 then
      Columns[i].Size := 30;

//    ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftString, Columns[i].Size, False);
    case Columns[i].DataType of
      itString: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftString, Columns[i].Size, False);
      itInteger: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftInteger, 0, False);
      itFloat: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftFloat, 0, False);
      itDateTime: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftDateTime, 0, False);
      itDate: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftDate, 0, False);
      itTime: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftTime, 0, False);
      itBoolean: ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftBoolean, 0, False);
    else
      ClientDataSet1.FieldDefs.Add(Columns[i].FieldName, ftString, 10, False);
    end;
  end;
  ClientDataSet1.CreateDataset;

  {open a dataset with created fields (from text file)}
  ClientDataSet1.Active := True;

  {fill default correspondence between fields in dataset and columns in stream}
  TSMImportBaseComponent(Sender).Mappings.Clear;
  if (Sender = SMImportFromHTML1) then
  begin
    with TSMImportBaseComponent(Sender) do
      for i := 0 to ClientDataSet1.FieldCount-1 do
          Mappings.Add(ClientDataSet1.Fields[i].FieldName + '=Field' + IntToStr(i+1))
  end
  else
    TSMImportBaseComponent(Sender).Columns2Mapping;
end;

procedure TfrmCliMain.SMImportFromXML1GetCellParams(Sender: TObject;
  Field: TField; var Value: Variant);
begin
  if Assigned(Field) and (Field.FieldName = VarToStr(Value)) then
    Value := NULL
end;

end.
