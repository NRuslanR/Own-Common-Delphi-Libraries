unit BoolLogicalRepositoryCriterionBindingsUnit;

interface

uses

  AbstractRepositoryCriteriaUnit, SysUtils;

const

  BOOL_AND_BINDING_DEFAULT_VALUE = 'and';
  BOOL_OR_BINDING_DEFAULT_VALUE = 'or';

type

  TBoolAndBinding = class (TAbstractRepositoryCriteriaBinding)

    protected

      function GetValue: String; override;

  end;

  TBoolAndBindingClass = class of TBoolAndBinding;

  TBoolOrBinding = class (TAbstractRepositoryCriteriaBinding)

    protected

      function GetValue: String; override;

  end;

  TBoolOrBindingClass = class of TBoolOrBinding;

implementation

{ TBoolAndBindingRepositoryBinding }

function TBoolAndBinding.GetValue: String;
begin

  Result := BOOL_AND_BINDING_DEFAULT_VALUE;

end;

{ TBoolOrBindingRepositoryBinding }

function TBoolOrBinding.GetValue: String;
begin

  Result := BOOL_OR_BINDING_DEFAULT_VALUE;
  
end;

end.
