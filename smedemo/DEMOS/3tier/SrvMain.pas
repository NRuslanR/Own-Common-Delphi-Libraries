unit SrvMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ScktComp, StdCtrls, SME2XML, ExportDS, SME2Cell, SME2HTML;

type
  TfrmSrvMain = class(TForm)
    qryExample1: TQuery;
    dSrc: TDataSource;
    ServerSocket1: TServerSocket;
    lblStatus: TLabel;
    SMExportToHTML1: TSMExportToHTML;
    SMExportToXML1: TSMExportToXML;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSrvMain: TfrmSrvMain;

implementation

{$R *.DFM}

procedure TfrmSrvMain.FormCreate(Sender: TObject);
begin
  {disable visual animated dialog and any messages for end-user.
  IMPORTANT: in most server side applications the any visual iteractions must be disabled}
  SMExportToHTML1.AnimatedStatus := False;
  SMExportToHTML1.Options := SMExportToHTML1.Options - [soShowMessage, soWaitCursor];
  SMExportToXML1.AnimatedStatus := False;
  SMExportToXML1.Options := SMExportToHTML1.Options - [soShowMessage, soWaitCursor];

  {activate server socket listener}
  ServerSocket1.Open;
end;

procedure TfrmSrvMain.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  str: string;
  strm: TMemoryStream;
begin
  lblStatus.Caption := 'Client requested some info';

  str := Socket.ReceiveText;

  {if client requested the dataset}
  if (Pos('%GET DATA%', str) > 0) then
  begin
    {open dataset (source for export)}
    qryExample1.Open;

    {send the exported dataset to stream}
    strm := TMemoryStream.Create;
    try
      if (Pos('%HTML%', str) > 0) then
        SMExportToHTML1.SaveToStream(strm)
      else
        SMExportToXML1.SaveToStream(strm);

      strm.Seek(0, soFromBeginning);
      Socket.SendStreamThenDrop(strm)
    finally
    end;

    lblStatus.Caption := 'Sent the dataset to client';
  end
end;

procedure TfrmSrvMain.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  lblStatus.Caption := 'Client connected'
end;

procedure TfrmSrvMain.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  lblStatus.Caption := 'Client disconnected'
end;

procedure TfrmSrvMain.FormDestroy(Sender: TObject);
begin
  ServerSocket1.Close
end;

end.
