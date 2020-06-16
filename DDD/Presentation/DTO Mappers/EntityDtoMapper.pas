unit EntityDtoMapper;

interface

uses

  CardFormViewModel,
  EntityDto,
  SysUtils,
  Classes;

type

  TEntityDtoMapper = class abstract

    protected

      function GetEntityDtoClass: TEntityDtoClass; virtual; abstract;
      
    public

      function MapEntityDtoFrom(
        CardFormViewModel: TCardFormViewModel
      ): TEntityDto; virtual;

      procedure FillEntityDtoFrom(
        EntityDto: TEntityDto;
        CardFormViewModel: TCardFormViewModel
      ); virtual;

  end;

implementation

{ TEntityDtoMapper }

procedure TEntityDtoMapper.FillEntityDtoFrom(EntityDto: TEntityDto;
  CardFormViewModel: TCardFormViewModel);
begin

  EntityDto.Id := CardFormViewModel.Id.Value;
  
end;

function TEntityDtoMapper.MapEntityDtoFrom(
  CardFormViewModel: TCardFormViewModel): TEntityDto;
begin

  Result := GetEntityDtoClass.Create;

  try

    FillEntityDtoFrom(Result, CardFormViewModel);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
