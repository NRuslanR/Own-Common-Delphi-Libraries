unit IGetSelfUnit;

interface

type

  IGetSelf = interface

    function GetSelf: TObject;

    property Self: TObject read GetSelf;
    
  end;
  
implementation

end.
