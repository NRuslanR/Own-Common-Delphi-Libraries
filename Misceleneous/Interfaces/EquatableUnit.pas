unit EquatableUnit;

interface

uses SysUtils, IGetSelfUnit;

type

  IEquatable = interface (IGetSelf)
  ['{B34933B9-AB87-4DF9-9C9C-34F7E5A944FE}']
  
    function Equals(Equatable: TObject): Boolean;

  end;

implementation

end.
