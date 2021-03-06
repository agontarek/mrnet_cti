/****************************************************************************
 * Copyright � 2003-2012 Dorian C. Arnold, Philip C. Roth, Barton P. Miller *
 *                  Detailed MRNet usage rights in "LICENSE" file.          *
 ****************************************************************************/

// $Id: Once-win.h,v 1.3 2007/01/24 19:34:16 darnold Exp $
#ifndef XPLAT_WINONCE_H
#define XPLAT_WINONCE_H

#include <windows.h>
#include "xplat/Once.h"

namespace XPlat
{

class WinOnceData : public Once::Data
{
private:
    LONG latch;
    bool done;

public:
    WinOnceData( void )
      : latch( 0 ),
        done( false )
    { }
    virtual int DoOnce( void (*func)( void ) );
};

} // namespace XPlat

#endif // XPLAT_WINONCE_H
