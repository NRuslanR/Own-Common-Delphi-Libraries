// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smemime.pas' rev: 10.00

#ifndef SmemimeHPP
#define SmemimeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smemime
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString __fastcall Encode64(const AnsiString Source);
extern PACKAGE AnsiString __fastcall Decode64(const AnsiString Source);
extern PACKAGE Byte __fastcall ASCII2EBCDIC(char Asc);
extern PACKAGE char __fastcall EBCDIC2ASCII(Byte EBC);

}	/* namespace Smemime */
using namespace Smemime;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smemime
