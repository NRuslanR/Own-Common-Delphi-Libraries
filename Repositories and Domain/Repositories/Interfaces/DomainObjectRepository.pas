unit DomainObjectRepository;

interface

uses

  DomainObjectUnit,
  DomainObjectListUnit,
  VariantListUnit;

type

  IDomainObjectRepository = interface
    ['{7CE44677-0B89-45C1-9168-21D7B07371DE}']

    function Add(DomainObject: TDomainObject): Boolean;
    function AddDomainObjectList(DomainObjectList: TDomainObjectList): Boolean;
    function Update(DomainObject: TDomainObject): Boolean;
    function UpdateDomainObjectList(DomainObjectList: TDomainObjectList): Boolean;
    function Remove(DomainObject: TDomainObject): Boolean;
    function RemoveDomainObjectList(DomainObjectList: TDomainObjectList): Boolean;
    function FindDomainObjectByIdentity(Identity: Variant): TDomainObject;
    function FindDomainObjectsByIdentities(const Identities: TVariantList): TDomainObjectList;
    function LoadAll: TDomainObjectList;

  end;

implementation

end.
