unit AbstractDomainService;

interface

uses

  DomainService;

type

  TAbstractDomainService = class abstract (TInterfacedObject, IDomainService)

    public

      function GetSelf: TObject;
      
  end;

  TAbstractStandardDomainService =
    class abstract (
      TAbstractDomainService,
      IStandardDomainService
    )

    end;

implementation

{ TAbstractDomainService }

function TAbstractDomainService.GetSelf: TObject;
begin

  Result := Self;
  
end;

end.
