unit CardFormViewModel;

interface

uses

  Disposable,
  ClonableUnit,
  CopyableUnit,
  SysUtils,
  Classes;

type

  TOnCardFormViewModelPropertyChangedEventHandler =
    procedure (
      Sender: TObject;
      const PropertyName: String;
      const PropertyValue: Variant
    ) of object;
    
  TCardFormViewModelProperty = class (TInterfacedObject, IClonable, IDisposable)

    private

      FOnCardFormViewModelPropertyChangedEventHandler:
        TOnCardFormViewModelPropertyChangedEventHandler;

      procedure RaiseOnCardFormViewModelPropertyChangedEventHandler(
        const PropertyName: String;
        const PropertyValue: Variant
      );

    protected

      FName: String;
      FIsModified: Boolean;
      FValue: Variant;

      function AreValuesEquals(
        PropertyValue, AssignableValue: Variant
      ): Boolean; virtual;

      procedure AssignOtherValue(OtherValue: Variant); virtual;
      
      procedure SetValue(const Value: Variant); virtual;
      function GetIsModified: Boolean; virtual;

      procedure CopyFrom(OtherViewModelProperty: TCardFormViewModelProperty); virtual;
      
    public

      ReadOnly: Boolean;
      Visible: Boolean;

    public

      constructor Create(const Name: String); virtual;

      property Name: String read FName;
      property Value: Variant read FValue write SetValue;
      property IsModified: Boolean read GetIsModified;

      function ToString: String;
      
      function AsInteger: Integer;
      function AsString: String;
      function AsDouble: Double;
      function AsDateTime: TDateTime;
      function AsVariant: Variant;

      function IsAssigned: Boolean;
      
      property OnCardFormViewModelPropertyChangedEventHandler:
        TOnCardFormViewModelPropertyChangedEventHandler
      read FOnCardFormViewModelPropertyChangedEventHandler
      write FOnCardFormViewModelPropertyChangedEventHandler;
      
    public

      function Clone: TObject; virtual;

      function GetSelf: TObject;

  end;

  TCardIdProperty = class (TCardFormViewModelProperty)

    private

      FIsSurrogate: Boolean;

    protected
    
      function GetIsSurrogate: Boolean;
      procedure SetIsSurrogate(const Value: Boolean);

    public

      constructor Create(const Name: String); override;
      
      property IsSurrogate: Boolean
      read GetIsSurrogate write SetIsSurrogate;
      
  end;

  TCardFormViewModelPropertyClass = class of TCardFormViewModelProperty;

  TCardFormViewModel = class abstract (TInterfacedObject, IDisposable, IClonable)

    private
          {
      type
      
        TViewModelPropertyHolder = class

          strict private

            FViewModelProperty: TCardFormViewModelProperty;
            FDisposable: IDisposable;

            procedure SetViewModelProperty(
              const Value: TCardFormViewModelProperty
            );

          public

            constructor Create(ViewModelProperty: TCardFormViewModelProperty);

            property ViewModelProperty: TCardFormViewModelProperty
            read FViewModelProperty write SetViewModelProperty;

          end;
             }
    public

      FPropertyList: TList;

    protected

      FId: TCardIdProperty;
      
      function GetId: TCardIdProperty;

      function CreateIdProperty: TCardIdProperty; virtual;

    public

      FOnCardFormViewModelPropertyChangedEventHandler:
        TOnCardFormViewModelPropertyChangedEventHandler;

      procedure RaiseOnCardFormViewModelPropertyChangedEventHandler(
        const PropertyName: String;
        const PropertyValue: Variant
      );

      procedure SetOnCardFormViewModelPropertyChangedEventHandler(
        const Value: TOnCardFormViewModelPropertyChangedEventHandler
      );
         {
      function GetViewModelPropertyHolderByIndex(const Index: Integer):
        TViewModelPropertyHolder;

      function GetViewModelPropertyHolderByPropertyName(const Name: String):
        TViewModelPropertyHolder;      }
        
    protected

      function IsPropertyExists(const Name: String): Boolean;

      function FindProperty(const Name: String): TCardFormViewModelProperty;

      function AddProperty(const Name: String): TCardFormViewModelProperty; overload;
      function AddProperty(const Name: String; const Value: Variant): TCardFormViewModelProperty; overload;
      procedure AddProperty(Prop: TCardFormViewModelProperty); overload;
      
      function AddProperty(
        const Name: String;
        const Value: Variant;
        const ReadOnly: Boolean
      ): TCardFormViewModelProperty; overload;

      function AddProperty(
        const Name: String;
        const Value: Variant;
        const ReadOnly: Boolean;
        const Visible: Boolean
      ): TCardFormViewModelProperty; overload;

      procedure Clear;

      function GetIsModified: Boolean;

      function IsPropertyModified(ViewModelProperty: TCardFormViewModelProperty): Boolean; virtual;

    public

      constructor Create; virtual;

      destructor Destroy; override;

      property IsModified: Boolean read GetIsModified;

    public

      function Clone: TObject; virtual;
      procedure CopyFrom(OtherCardFormViewModel: TCardFormViewModel); virtual;
      function GetSelf: TObject;

    published

      property Id: TCardIdProperty
      read GetId;

      property OnCardFormViewModelPropertyChangedEventHandler:
        TOnCardFormViewModelPropertyChangedEventHandler

      read FOnCardFormViewModelPropertyChangedEventHandler
      write SetOnCardFormViewModelPropertyChangedEventHandler;

  end;

  TCardFormViewModelClass = class of TCardFormViewModel;

implementation

uses

  Variants,
  AuxDebugFunctionsUnit,
  AuxCollectionFunctionsUnit;

{ TCardFormViewModel }

function TCardFormViewModel.AddProperty(const Name: String;
  const Value: Variant): TCardFormViewModelProperty;
begin

  Result := AddProperty(Name);

  Result.Value := Value;

end;

function TCardFormViewModel.AddProperty(const Name: String;
  const Value: Variant; const ReadOnly,
  Visible: Boolean): TCardFormViewModelProperty;
begin

  Result := AddProperty(Name, Value, ReadOnly);

  Result.Visible := Visible;

end;

procedure TCardFormViewModel.AddProperty(Prop: TCardFormViewModelProperty);
begin

  FPropertyList.Add({TViewModelPropertyHolder.Create(}Prop{)});
  
end;

procedure TCardFormViewModel.Clear;
begin

  FreeListItems(FPropertyList);

end;

function TCardFormViewModel.Clone: TObject;
var// I: Integer;
    ClonedViewModel: TCardFormViewModel;
  {  ViewModelPropertyHolder: TViewModelPropertyHolder;
    ViewModelProperty: TCardFormViewModelProperty;
    ClonedViewModelProperty: TCardFormViewModelProperty;
    Free: IDisposable;   }
begin

  Result := TCardFormViewModelClass(ClassType).Create;

  ClonedViewModel := Result as TCardFormViewModel;

  try

    ClonedViewModel.CopyFrom(Self);
                 {
    for I := 0 to FPropertyList.Count - 1 do begin

      ViewModelPropertyHolder := GetViewModelPropertyHolderByIndex(I);

      ViewModelProperty := ViewModelPropertyHolder.ViewModelProperty;

      ClonedViewModelProperty :=
        TCardFormViewModelProperty(ViewModelProperty.Clone);

      Free := ClonedViewModelProperty;
        
      if ClonedViewModel.IsPropertyExists(ClonedViewModelProperty.Name)
      then begin

        ClonedViewModel
          .GetViewModelPropertyHolderByPropertyName(
            ClonedViewModelProperty.Name
          )
            .ViewModelProperty := ClonedViewModelProperty;

      end

      else ClonedViewModel.AddProperty(ClonedViewModelProperty);

    end;       }

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

procedure TCardFormViewModel.CopyFrom(
  OtherCardFormViewModel: TCardFormViewModel);
var I: Integer;
    //ViewModelPropertyHolder: TViewModelPropertyHolder;
    ViewModelProperty: TCardFormViewModelProperty;
begin

  for I := 0 to OtherCardFormViewModel.FPropertyList.Count - 1 do begin
     {
    ViewModelPropertyHolder :=
      TViewModelPropertyHolder(OtherCardFormViewModel.FPropertyList[I]);  }

    ViewModelProperty := TCardFormViewModelProperty(FPropertyList[I]); //ViewModelPropertyHolder.ViewModelProperty;
    
    if IsPropertyExists(ViewModelProperty.Name)
    then begin
      FindProperty(ViewModelProperty.Name).CopyFrom(ViewModelProperty);
                           {

      GetViewModelPropertyHolderByPropertyName(
        ViewModelProperty.Name
      )
        .ViewModelProperty := ViewModelProperty;    }
        
    end

    else AddProperty(ViewModelProperty.Clone as TCardFormViewModelProperty);

  end;

end;

constructor TCardFormViewModel.Create;
begin

  inherited;

  FPropertyList := TList.Create;

  FId := CreateIdProperty;

  AddProperty(FId);
  
end;

function TCardFormViewModel.CreateIdProperty: TCardIdProperty;
begin

  Result := TCardIdProperty.Create('Id');

  try

    Result.Value := Null;
    Result.IsSurrogate := True;
    Result.Visible := False;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TCardFormViewModel.AddProperty(
  const Name: String): TCardFormViewModelProperty;
begin

  if Trim(Name) = '' then
    raise Exception.Create('Property''s name must not be empty !');

  if IsPropertyExists(Name) then begin

    raise Exception.CreateFmt(
      'Property "%s" is already exists !',
      [Name]
    );

  end;

  Result := TCardFormViewModelProperty.Create(Name);

  try

    Result.OnCardFormViewModelPropertyChangedEventHandler :=
      FOnCardFormViewModelPropertyChangedEventHandler;
    
    AddProperty(Result);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

function TCardFormViewModel.AddProperty(const Name: String;
  const Value: Variant; const ReadOnly: Boolean): TCardFormViewModelProperty;
begin

  Result := AddProperty(Name, Value);

  Result.ReadOnly := ReadOnly;

end;

destructor TCardFormViewModel.Destroy;
begin

  FreeListWithItems(FPropertyList);

  inherited;

end;

function TCardFormViewModel.FindProperty(
  const Name: String): TCardFormViewModelProperty;
var //Holder: TViewModelPropertyHolder;
    I: Integer;
    ViewModelProperty: TCardFormViewModelProperty;
begin

  {Holder := GetViewModelPropertyHolderByPropertyName(Name);

  if Assigned(Holder) then
    Result := Holder.ViewModelProperty

  else Result := nil;       }

  for I := 0 to FPropertyList.Count - 1 do begin

    Result := TCardFormViewModelProperty(FPropertyList[I]);

    if Result.Name = Name then Exit;
    
  end;

  Result := nil;

end;

function TCardFormViewModel.GetId: TCardIdProperty;
begin

  Result := FId;
  
end;

function TCardFormViewModel.GetIsModified: Boolean;
var ViewModelProperty: TCardFormViewModelProperty;
    I: Integer;
begin

  for I := 0 to FPropertyList.Count - 1 do begin

    ViewModelProperty := TCardFormViewModelProperty(FPropertyList[I]);

    if IsPropertyModified(ViewModelProperty) then begin

      Result := True;
      Exit;

    end;

  end;

  Result := False;

end;

function TCardFormViewModel.GetSelf: TObject;
begin

  Result := Self;
  
end;
                                   {
function TCardFormViewModel.GetViewModelPropertyHolderByIndex(
  const Index: Integer): TViewModelPropertyHolder;
begin

  Result := TViewModelPropertyHolder(FPropertyList[Index]);

end;

function TCardFormViewModel.GetViewModelPropertyHolderByPropertyName(
  const Name: String): TViewModelPropertyHolder;
var I: Integer;
begin

  for I := 0 to FPropertyList.Count - 1 do begin

    Result := TViewModelPropertyHolder(FPropertyList[I]);

    if Result.ViewModelProperty.Name = Name then
      Exit;

  end;

  Result := nil;

end;                  }

function TCardFormViewModel.IsPropertyExists(const Name: String): Boolean;
begin

  Result := Assigned(FindProperty(Name));

end;

function TCardFormViewModel.IsPropertyModified(
  ViewModelProperty: TCardFormViewModelProperty): Boolean;
begin

  if ViewModelProperty <> FId then
    Result := ViewModelProperty.IsModified

  else Result := not FId.IsSurrogate;

end;

procedure TCardFormViewModel.RaiseOnCardFormViewModelPropertyChangedEventHandler(
  const PropertyName: String; const PropertyValue: Variant);
begin

  if Assigned(FOnCardFormViewModelPropertyChangedEventHandler)
  then begin

    FOnCardFormViewModelPropertyChangedEventHandler(
      Self, PropertyName, PropertyValue
    );

  end;
  
end;

procedure TCardFormViewModel.SetOnCardFormViewModelPropertyChangedEventHandler(
  const Value: TOnCardFormViewModelPropertyChangedEventHandler);
var CardFormViewModelProperty: TCardFormViewModelProperty;
    CardFormViewModelPropertyPointer: Pointer;
begin

  FOnCardFormViewModelPropertyChangedEventHandler := Value;

  for CardFormViewModelPropertyPointer in FPropertyList do begin

    CardFormViewModelProperty :=
      TCardFormViewModelProperty(CardFormViewModelPropertyPointer);

    CardFormViewModelProperty
      .OnCardFormViewModelPropertyChangedEventHandler :=
        FOnCardFormViewModelPropertyChangedEventHandler;

  end;

end;

{ TCardFormViewModelProperty }

function TCardFormViewModelProperty.AreValuesEquals(PropertyValue,
  AssignableValue: Variant): Boolean;
begin

  Result := PropertyValue = AssignableValue;
  
end;

function TCardFormViewModelProperty.AsDateTime: TDateTime;
begin

  if VarIsNull(Value) then
    Result := 0

  else if not VarIsType(Value, varDate) then begin

    raise Exception.CreateFmt(
      'Программная ошибка. ' +
      'Значение свойства "%s" ' +
      'модели представления ' +
      'не относится к типу TDateTime',
      [Name]
    );

  end;

  Result := Value;
  
end;

function TCardFormViewModelProperty.AsDouble: Double;
begin

  if VarIsNull(Value) then
    Result := 0

  else if not VarIsType(Value, varDouble) then begin

    raise Exception.CreateFmt(
      'Программная ошибка. ' +
      'Значение свойства "%s" ' +
      'модели представления ' +
      'не относится к типу Double',
      [Name]
    );

  end;

  Result := Value;
  
end;

function TCardFormViewModelProperty.AsInteger: Integer;
begin

  if VarIsNull(Value) then
    Result := 0

  else if not VarIsType(Value, varInteger) then begin

    raise Exception.CreateFmt(
      'Программная ошибка. ' +
      'Значение свойства "%s" ' +
      'модели представления ' +
      'не относится к типу Integer',
      [Name]
    );

  end;

  Result := Value;
  
end;

procedure TCardFormViewModelProperty.AssignOtherValue(OtherValue: Variant);
begin

  FValue := OtherValue;
  
end;

function TCardFormViewModelProperty.AsString: String;
begin

  if VarIsNull(Value) then
    Result := ''

  else if not VarIsType(Value, varDate) then begin

    raise Exception.CreateFmt(
      'Программная ошибка. ' +
      'Значение свойства "%s" ' +
      'модели представления ' +
      'не относится к типу String',
      [Name]
    );

  end;

  Result := Value;
  
end;

function TCardFormViewModelProperty.AsVariant: Variant;
begin

  Result := Value;
  
end;

function TCardFormViewModelProperty.Clone: TObject;
var ClonedProperty: TCardFormViewModelProperty;
begin

  Result := TCardFormViewModelPropertyClass(ClassType).Create(Name);

  ClonedProperty := Result as TCardFormViewModelProperty;
  
  try

    ClonedProperty.CopyFrom(Self);
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TCardFormViewModelProperty.CopyFrom(
  OtherViewModelProperty: TCardFormViewModelProperty);
begin

  FName := OtherViewModelProperty.FName;
  Value := OtherViewModelProperty.Value;
  FIsModified := OtherViewModelProperty.FIsModified;
  ReadOnly := OtherViewModelProperty.ReadOnly;
  Visible := OtherViewModelProperty.Visible;
  
end;

constructor TCardFormViewModelProperty.Create(const Name: String);
begin

  inherited Create;

  FName := Name;
  FValue := Null;

  ReadOnly := False;
  Visible := True;

end;

function TCardFormViewModelProperty.GetIsModified: Boolean;
begin

  Result := FIsModified;
  
end;

function TCardFormViewModelProperty.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TCardFormViewModelProperty.IsAssigned: Boolean;
begin

  Result := not VarIsNull(Value);
  
end;

procedure TCardFormViewModelProperty.
  RaiseOnCardFormViewModelPropertyChangedEventHandler(
    const PropertyName: String;
    const PropertyValue: Variant
  );
begin

  if Assigned(FOnCardFormViewModelPropertyChangedEventHandler) then begin

    FOnCardFormViewModelPropertyChangedEventHandler(
      Self, PropertyName, PropertyValue
    );

  end;

end;

procedure TCardFormViewModelProperty.SetValue(const Value: Variant);
begin

  if not AreValuesEquals(FValue, Value)
  then begin

    AssignOtherValue(Value);

    FIsModified := True;

    RaiseOnCardFormViewModelPropertyChangedEventHandler(
      Name, FValue
    );

  end

  else FIsModified := False;

end;

function TCardFormViewModelProperty.ToString: String;
begin

  Result := VarToStr(Value);
  
end;

{ TCardIdProperty }

constructor TCardIdProperty.Create(const Name: String);
begin

  inherited;

end;

function TCardIdProperty.GetIsSurrogate: Boolean;
begin

  Result := FIsSurrogate;
  
end;

procedure TCardIdProperty.SetIsSurrogate(const Value: Boolean);
begin

  FIsSurrogate := Value;

  ReadOnly := Value;
  
end;

{ TCardFormViewModel.TViewModelPropertyHolder }
                                         {
constructor TCardFormViewModel.TViewModelPropertyHolder.Create(
  ViewModelProperty: TCardFormViewModelProperty);
begin

  inherited Create;

  Self.ViewModelProperty := ViewModelProperty;
  
end;

procedure TCardFormViewModel.TViewModelPropertyHolder.SetViewModelProperty(
  const Value: TCardFormViewModelProperty);
begin

  if FViewModelProperty = Value then
    Exit;

  FViewModelProperty := Value;
  FDisposable := FViewModelProperty;

end;                                }

end.
