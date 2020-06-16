unit UMZEmployeeUnit;

interface

uses DomainObjectUnit, UMZDepartmentUnit;

type

  TUMZEmployee = class(TDomainObject)

    protected

      FPersonnelNumber: String;
      FName: String;
      FFamily: String;
      FPatronymic: String;
      FBirthDate: TDateTime;
      FBirthPlace: String;
      FJob: String;
      FIsDismissed: Boolean;
      FTelephoneNumber: String;
      FDepartment: TUMZDepartment;

      function GetFullName: String;
      function GetShortFullName: String;

      procedure SetUMZDepartment(UMZDepartment: TUMZDepartment);

    public

      destructor Destroy; override;
      constructor Create; overload; override;
      constructor Create(
        const AID: Variant;
        const APersonnelNumber, AName, AFamily, APatronymic: String;
        const ABirthDate: TDateTime;
        const ABirthPlace, AJob: String;
        const AIsDismissed: Boolean;
        ADepartament: TUMZDepartment
      ); overload;

      procedure CopyFrom(Copyable: TObject);
      procedure DeepCopyFrom(Copyable: TObject);
      function Equals(Equatable: TObject): Boolean;
      function Clone: TObject;

    published
    
      property FullName: String read GetFullName;
      property ShortFullName: String read GetShortFullName;
      property PersonnelNumber: String read FPersonnelNumber write FPersonnelNumber;
      property Name: String read FName write FName;
      property Family: String read FFamily write FFamily;
      property Patronymic: String read FPatronymic write FPatronymic;
      property BirthDate: TDateTime read FBirthDate write FBirthDate;
      property BirthPlace: String read FBirthPlace write FBirthPlace;
      property Job: String read FJob write FJob;
      property IsDismissed: Boolean read FIsDismissed write FIsDismissed;
      property Department: TUMZDepartment
      read FDepartment write SetUMZDepartment;
      property TelephoneNumber: String
      read FTelephoneNumber write FTelephoneNumber;

  end;

implementation

uses SysUtils, WIndows;

{ TUMZEmployee }

constructor TUMZEmployee.Create;
begin

  inherited;

  FBirthDate := Now;
  FDepartment := TUMZDepartment.Create;

end;

function TUMZEmployee.Clone: TObject;
var Clonee: TUMZEmployee;
begin

  Result := inherited Clone;
  
end;

constructor TUMZEmployee.Create(const AID: Variant; const APersonnelNumber,
  AName, AFamily, APatronymic: String; const ABirthDate: TDateTime;
  const ABirthPlace, AJob: String; const AIsDismissed: Boolean;
  ADepartament: TUMZDepartment);
begin

  inherited Create(AID);

  FPersonnelNumber := APersonnelNumber;
  FName := AName;
  FFamily := AFamily;
  FPatronymic := APatronymic;
  FBirthDate := ABirthDate;
  FBirthPlace := ABirthPlace;
  FJob := AJob;
  FIsDismissed := AIsDismissed;
  FDepartment := ADepartament;
  
end;

procedure TUMZEmployee.DeepCopyFrom(Copyable: TObject);
var Other: TUMZEmployee;
begin

  inherited;

end;

procedure TUMZEmployee.CopyFrom(Copyable: TObject);
var Other: TUMZEmployee;
begin

  inherited;

end;

destructor TUMZEmployee.Destroy;
begin

  inherited;

end;

function TUMZEmployee.Equals(Equatable: TObject): Boolean;
var Other: TUMZEmployee;
begin

  Result := inherited Equals(Equatable);
            
end;

function TUMZEmployee.GetFullName: String;
begin

  Result := Family + ' ' + Name + ' ' + Patronymic;

end;

function TUMZEmployee.GetShortFullName: String;
begin

  if (Family = '') or (Name = '') or (Patronymic = '') then
    Result := ''

  else
    Result := AnsiStrUpper(PChar(Family[1] + '')) +
              String(AnsiStrLower(PChar(Copy(Family, 2, Length(Family)))))
              + ' ' + Name[1] + '. ' + Patronymic[1] + '.';

end;

procedure TUMZEmployee.SetUMZDepartment(UMZDepartment: TUMZDepartment);
begin

  FreeNestedDomainObject(FDepartment);

  FDepartment := UMZDepartment;

end;

end.
