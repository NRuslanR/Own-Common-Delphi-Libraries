unit UMZDepartmentUnit;

interface

uses DomainObjectUnit;

type

  TUMZDepartment = class(TDomainObject)

    strict private

      FCode: String;
      FShortName: String;
      FFullName: String;
      FBeginUsingDate: TDateTime;
      FEndUsingDate: TDateTime;

    public

      destructor Destroy; override;
      constructor Create; overload; override;
      constructor Create(
        const AID: Variant;
        const ACode, AShortName, AFullName: String;
        const ABeginUsingDate, AEndUsingDate: TDateTime
      ); overload;

      procedure CopyFrom(Copyable: TObject);
      procedure DeepCopyFrom(Copyable: TObject);
      function Equals(Equatable: TObject): Boolean;
      function Clone: TObject;

    published

      property Code: String read FCode write FCode;
      property ShortName: String read FShortName write FShortName;
      property FullName: String read FFullName write FFullName;

      property BeginUsingDate: TDateTime
      read FBeginUsingDate write FBeginUsingDate;

      property EndUsingDate: TDateTime
      read FEndUsingDate write FEndUsingDate;

  end;

implementation

{ TOMODepartament }

constructor TUMZDepartment.Create;
begin

  inherited;

end;

function TUMZDepartment.Clone: TObject;
var Clonee : TUMZDepartment;
begin

  Result := inherited Clone;

end;

constructor TUMZDepartment.Create(
  const AID: Variant; const ACode,
  AShortName, AFullName: String;
  const ABeginUsingDate, AEndUsingDate: TDateTime
);
begin

  inherited Create(AID);

  FCode := ACode;
  FShortName := AShortName;
  FFullName := AFullName;
  FBeginUsingDate := ABeginUsingDate;
  FEndUsingDate := AEndUsingDate;

end;

procedure TUMZDepartment.DeepCopyFrom(Copyable: TObject);
begin

  inherited;

end;

destructor TUMZDepartment.Destroy;
begin

  inherited;

end;

procedure TUMZDepartment.CopyFrom(Copyable: TObject);
var Other: TUMZDepartment;
begin

  inherited;

end;

function TUMZDepartment.Equals(Equatable: TObject): Boolean;
var Other: TUMZDepartment;
begin

  Result := inherited Equals(Equatable);

end;


end.
