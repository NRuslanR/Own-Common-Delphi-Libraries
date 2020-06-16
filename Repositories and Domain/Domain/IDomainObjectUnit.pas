unit IDomainObjectUnit;

interface

uses IDomainObjectBaseUnit;

type

  IDomainObject = interface (IDomainObjectBase)

    function GetIdentity: Variant;
    procedure SetIdentity(Identity: Variant);

    property Identity: Variant read GetIdentity write SetIdentity;

  end;
  
implementation

end.
