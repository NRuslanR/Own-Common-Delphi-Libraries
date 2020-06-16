unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SMEEngine, ExportDS, SMEWiz;

type
  TfrmMain = class(TForm)
    SMEWizardDlg1: TSMEWizardDlg;
    SMEVirtualDataEngine1: TSMEVirtualDataEngine;
    Button1: TButton;
    lblScalabium: TLabel;
    lblNote: TLabel;
    procedure SMEVirtualDataEngine1Count(Sender: TObject;
      var Count: Integer);
    procedure SMEVirtualDataEngine1GetValue(Sender: TObject;
      Column: TSMEColumn; var Value: Variant);
    procedure SMEVirtualDataEngine1FillColumns(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lblScalabiumClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses ShellAPI;

{$R *.DFM}

procedure TfrmMain.SMEVirtualDataEngine1Count(Sender: TObject;
  var Count: Integer);
begin
  Count := 10
end;

procedure TfrmMain.SMEVirtualDataEngine1GetValue(Sender: TObject;
  Column: TSMEColumn; var Value: Variant);
begin
  Value := IntToStr(Column.Index+1) + ':' + IntToStr(Random(1000))
end;

procedure TfrmMain.SMEVirtualDataEngine1FillColumns(Sender: TObject);
begin
  with SMEWizardDlg1.Columns.Add do
  begin
    FieldName := 'first';
    Title.Caption := 'first column';
    Color := clWhite
  end;

  with SMEWizardDlg1.Columns.Add do
  begin
    FieldName := 'second';
    Title.Caption := 'second column';
    Color := clWhite
  end;

  with SMEWizardDlg1.Columns.Add do
  begin
    FieldName := 'third';
    Title.Caption := 'third column';
    Color := clWhite
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  SMEWizardDlg1.FileName := ExtractFilePath(Application.ExeName) + 'SMExport.TXT';
  SMEWizardDlg1.Execute;
end;

procedure TfrmMain.lblScalabiumClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar((Sender as TLabel).Caption), nil, nil, SW_SHOWNORMAL);
end;

end.
