unit unStubSectionStackedFormDataModule;

interface

uses
  SysUtils, Classes, DB, dxmdaset;

type
  TStubSectionStackedFormDataModule = class(TDataModule)
    TestSectionMemData: TdxMemData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StubSectionStackedFormDataModule: TStubSectionStackedFormDataModule;

implementation

{$R *.dfm}

end.
