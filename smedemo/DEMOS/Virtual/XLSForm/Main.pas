unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SMEEngine, ExportDS, SME2Cell, SME2XLS, DB
  {$IFDEF VER140} , Variants {$ENDIF};

type
  TfrmMain = class(TForm)
    SMExportToXLS1: TSMExportToXLS;
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    btnExport: TButton;
    memoNote: TMemo;
    btnAbout: TButton;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    procedure btnExportClick(Sender: TObject);
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
    procedure SMEVirtualDataEngine1First(Sender: TObject);
    procedure SMEVirtualDataEngine1Next(Sender: TObject;
      var Abort: Boolean);
    procedure SMEVirtualDataEngine1GetValue(Sender: TObject;
      Column: TSMEColumn; var Value: Variant);
    procedure SMEVirtualDataEngine1FillColumns(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure SMEWizardDlg1GetCellParams(Sender: TObject; Field: TField;
      var Text: String; AFont: TFont; var Alignment: TAlignment;
      var Background: TColor; var CellType: TCellType);
  private
    { Private declarations }
    intCurInMemo: Integer;
    intCurInCombobox: Integer;
    intCurInListbox: Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  SMExportToXLS1.Execute;
end;

procedure TfrmMain.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  {we must say how many rows we want to export
  In my example is a max from memoNote.Lines.Count and ListBox1.Items.Count+ComboBox1.Items.Count}
  Count := ListBox1.Items.Count+ComboBox1.Items.Count + 2;
  if memoNote.Lines.Count > Count then
    Count := memoNote.Lines.Count
end;

procedure TfrmMain.SMEVirtualDataEngine1First(Sender: TObject);
begin
  {here we must initialize some our internal structures.
  For example, retrive some data}
  intCurInMemo := 0;
  intCurInCombobox := 0;
  intCurInListbox := 0;
end;

procedure TfrmMain.SMEVirtualDataEngine1Next(Sender: TObject;
  var Abort: Boolean);
begin
  {here we must prepare a next "row"
  In my sample - to initialize variable with current position within every exported control}
  Inc(intCurInMemo);
  Inc(intCurInCombobox);
  Inc(intCurInListbox);
end;

procedure TfrmMain.SMEVirtualDataEngine1FillColumns(Sender: TObject);
begin
  {we must define columns which will be exported.
  As alternative you can define a same Columns directly in TSMExportToXLS.Columns

  IMPORTANT:
  Must be defined at least one column}

  SMExportToXLS1.Columns.Clear;

  {add first virtual column}
  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Data from Memo';
    Width := 60
  end;

  {add second virtual column}
  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Combobox data';
    Width := 20
  end;

  {add third virtual column}
  with SMExportToXLS1.Columns.Add do
  begin
    FieldName := 'Listbox data';
    Width := 30
  end;
end;

procedure TfrmMain.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
begin
  Value := '';

  {here we must return a value for current row for Column}
  if Assigned(Column) then
  begin
    if (Column.FieldName = 'Data from Memo') then
    begin
      if (intCurInMemo < memoNote.Lines.Count) then
        Value := memoNote.Lines[intCurInMemo];
    end
    else
    if (Column.FieldName = 'Combobox data') then
    begin
      if (intCurInCombobox < ComboBox1.Items.Count) then
        Value := ComboBox1.Items[intCurInCombobox];
    end
    else
    if (Column.FieldName = 'Listbox data') then
    begin
      if (intCurInListbox < ListBox1.Items.Count) then
        Value := ListBox1.Items[intCurInListbox];
    end
  end;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  SMExportToXLS1.AboutSME
end;

procedure TfrmMain.SMEWizardDlg1GetCellParams(Sender: TObject;
  Field: TField; var Text: String; AFont: TFont; var Alignment: TAlignment;
  var Background: TColor; var CellType: TCellType);
begin
  BackGround := clWhite
end;

end.
