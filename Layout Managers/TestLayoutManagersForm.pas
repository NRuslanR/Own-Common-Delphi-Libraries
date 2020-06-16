unit TestLayoutManagersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm9 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Edit5: TEdit;
    ComboBox1: TComboBox;
    Button4: TButton;
    Label6: TLabel;
    CheckBox2: TCheckBox;
    RadioButton1: TRadioButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses

  LayoutManager,
  BoxLayoutManager,
  HorizontalBoxLayoutManager,
  VerticalBoxLayoutManager,
  ColumnarCellAlignedLayoutManager;

{$R *.dfm}

procedure TForm9.Button2Click(Sender: TObject);
var LayoutManager: TLayoutManager;
begin


  LayoutManager :=

    TVerticalBoxLayoutManagerBuilder.Create.AddLayoutManagers(
      [
        THorizontalBoxLayoutManagerBuilder.Create.AddLayoutManagers(
          [
            TColumnarCellAlignedLayoutManagerBuilder.Create.AddLayoutManagers(
              [
                TVerticalBoxLayoutManagerBuilder.Create.AddControls(
                  [Label3, Label4, Label5]
                ).BuildAndDestroy,
                
                TVerticalBoxLayoutManagerBuilder.Create.AddLayoutManagers(
                  [
                    THorizontalBoxLayoutManagerBuilder.Create.AddControls(
                      [Label1, Edit1, Button1, Label2, Edit2],
                      [5, 5, 10, 10, 50]
                    ).BuildAndDestroy,

                    THorizontalBoxLayoutManagerBuilder.Create.AddControls(
                      [Edit3, CheckBox1], []
                    ).BuildAndDestroy,

                    THorizontalBoxLayoutManagerBuilder.Create.AddControl(
                      Edit4
                    ).BuildAndDestroy,

                    TVerticalBoxLayoutManagerBuilder.Create.AddLayoutManager(

                      THorizontalBoxLayoutManagerBuilder.Create.AddControls(
                        [Label6, Edit5]
                      ).BuildAndDestroy

                    ).AddControls([ComboBox1, Button4]).BuildAndDestroy
                  ],
                  [100, 20, 50]
                ).BuildAndDestroy

              ],
              [50]
            ).BuildAndDestroy,

            TVerticalBoxLayoutManagerBuilder.Create.AddControls(
              [Memo1, Button3]
            ).BuildAndDestroy
          ],
          [50]
        ).BuildAndDestroy,

        THorizontalBoxLayoutManagerBuilder.Create.AddControls(
          [CheckBox2, RadioButton1]
        ).BuildAndDestroy
      ],
      [20]
    
    ).BuildAndDestroy;
                  
  LayoutManager.ApplyLayout;

  LayoutManager.Left := 5;
  LayoutManager.Top := 5;

  LayoutManager.Free;

end;

end.
