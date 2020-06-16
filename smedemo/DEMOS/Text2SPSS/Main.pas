unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SMIBase, SMI2TXT, DB, DBClient, StdCtrls, ExportDS, SME2Cell,
  SME2SPSS;

type
  TfrmMain = class(TForm)
    btnRead: TButton;
    btnWrite: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    tbl1: TClientDataSet;
    SMImportFromText1: TSMImportFromText;
    SMExportToSPSS1: TSMExportToSPSS;
    lblWWW: TLabel;
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnReadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    SMImportFromText1.SourceFileName := OpenDialog1.FileName;

    {skip first row}
    SMImportFromText1.RowFirst := 2;

    {fill a correspondence between fields in dataset and columns in text file}
    SMImportFromText1.Mappings.Clear;
    SMImportFromText1.Mappings.Add('Email=Field1');
    SMImportFromText1.Mappings.Add('Question 1=Field2');
    SMImportFromText1.Mappings.Add('Question 2=Field3');
    SMImportFromText1.Mappings.Add('Question 3=Field4');
    SMImportFromText1.Mappings.Add('Question 4=Field5');
    SMImportFromText1.Mappings.Add('Question 5=Field6');
    SMImportFromText1.Mappings.Add('Question 6=Field7');
    SMImportFromText1.Mappings.Add('Question 7=Field8');
    SMImportFromText1.Mappings.Add('Question 8=Field9');

    {load text file}
    SMImportFromText1.Execute
  end
end;

procedure TfrmMain.btnWriteClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SMExportToSPSS1.FileName := SaveDialog1.FileName;
    SMExportToSPSS1.Execute
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {create a temporary dataset for txt loading}
  tbl1.FieldDefs.Add('Email', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 1', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 2', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 3', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 4', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 5', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 6', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 7', ftString, 50, False);
  tbl1.FieldDefs.Add('Question 8', ftString, 50, False);
  tbl1.CreateDataSet;
  tbl1.Open;
end;

end.
