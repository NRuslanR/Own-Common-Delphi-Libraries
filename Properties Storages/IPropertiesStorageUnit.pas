unit IPropertiesStorageUnit;

interface

uses IGetSelfUnit;

type

  IPropertiesStorage = interface (IGetSelf)
    ['{7D1F9179-9880-4BD8-B6CF-1906DBDDE78E}']

    procedure GoToSection(const SectionId: Variant);

    function GetCurrentSection: String;

    procedure WriteValueForProperty(
      const PropertyName: String;
      const Value: Variant
    );

    function ReadValueForProperty(
      const PropertyName: String;
      const ValueType: TVarType;
      const DefaultValue: Variant
    ): Variant;

    procedure ClearAllSettings;
    
    procedure Commit;
    procedure Rollback;

    property CurrentSection: String read GetCurrentSection;

  end;

implementation

end.
