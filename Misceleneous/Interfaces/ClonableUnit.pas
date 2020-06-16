unit ClonableUnit;

interface

uses SysUtils, IGetSelfUnit;

type

  IClonable = interface (IGetSelf)
  ['{E584BDDC-2AD8-456B-B6A2-6AB4A39FBDC4}']
  
    function Clone: TObject;

  end;

implementation

end.
