/****************************************************************************
 * Copyright � 2003-2015 Dorian C. Arnold, Philip C. Roth, Barton P. Miller *
 *                  Detailed MRNet usage rights in "LICENSE" file.          *
 ****************************************************************************/

#if !defined(mult_thd_streams_h )
#define mult_thd_streams_h 1

#include "mrnet/Types.h"
#include <bitset>
#include <cstring>

#define fr_range_max 1000
#define fr_bins 20
#if defined(os_windows)
# define srandom(x) srand(x)
# define random rand
# define sleep(x) Sleep(1000*(DWORD)x)
# define PTS_API __declspec(dllexport)
#else
# define PTS_API
#endif

typedef std::bitset<fr_bins> fr_bin_set;

typedef enum { PROT_EXIT=FirstApplicationTag, 
               PROT_START,
               PROT_REG_STRM,
               PROT_REG_MIN,
               PROT_REG_MAX,
               PROT_REG_PCT,
               PROT_WAVE,
               PROT_CHECK_MIN,
               PROT_CHECK_MAX,
               PROT_CHECK_PCT,
               PROT_WAVE_CHECK
             } Protocol;

#endif /* mult_thd_streams_h */
