dnl Determine the compiler type
dnl Sets: COMPILER_TYPE to "gnu", "aix-native", "forte", "pgi", "intel", or "unknown"

AC_DEFUN(PD_COMPILER_TYPE,[
  AC_MSG_CHECKING([for compiler type])

  COMPILER_TYPE="unknown"

  if test "$CXX" = "g++" ; then
    COMPILER_TYPE="gnu"
    AC_MSG_RESULT([gnu])
  elif test "$CXX" = "xlC_r" ; then
    COMPILER_TYPE="aix-native"
    AC_MSG_RESULT([aix-native])
  elif test "$CXX" = "xlC" ; then
    COMPILER_TYPE="aix-native"
    AC_MSG_RESULT([aix-native])
  elif test "$CXX" = "xlc++" ; then
    COMPILER_TYPE="aix-native"
    AC_MSG_RESULT([aix-native])
  elif test "$CXX" = "pgCC" ; then
    COMPILER_TYPE="pgi"
    AC_MSG_RESULT([pgi])
  elif test "$CXX" = "icpc" ; then
    COMPILER_TYPE="intel"
    AC_MSG_RESULT([intel])
  fi

  if test "$COMPILER_TYPE" = "unknown"; then
    $CXX --version 2> /dev/null > version.out
    $GREP "GCC" version.out > /dev/null

    if test "$?" = 0 ; then
      COMPILER_TYPE="gnu"
      AC_MSG_RESULT([gnu])
    else
      $GREP "Portland Group" version.out > /dev/null
      if test "$?" = 0; then
        COMPILER_TYPE="pgi"
        AC_MSG_RESULT([pgi])
      else
        $GREP "Intel Corporation" version.out > /dev/null
        if test "$?" = 0; then
          COMPILER_TYPE="intel"
          AC_MSG_RESULT([intel])
        fi
      fi
    fi
    $RM -f version.out
  fi
    
  if test "$COMPILER_TYPE" = "unknown"; then
    $CXX -V 2> version.out

    $GREP "Forte" version.out > /dev/null
    if test "$?" = 0 ; then
      COMPILER_TYPE="forte"
      AC_MSG_RESULT([forte])
    else
      $GREP "Sun" version.out > /dev/null
      if test "$?" = 0 ; then
        COMPILER_TYPE="forte"
        AC_MSG_RESULT([forte])
      fi
    fi
    $RM -f version.out
  fi

  if test "$COMPILER_TYPE" = "unknown"; then
    AC_MSG_RESULT([unknown])
  fi
  AC_SUBST(COMPILER_TYPE)
])dnl

AC_DEFUN(PAC_CHECK_RUSAGE,[
  AC_MSG_CHECKING([for getrusage()])
  if test -z "$RUSAGE" ; then
  AC_TRY_LINK(
[#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>],
[ int i;
  struct rusage usage;

  i = getrusage(RUSAGE_SELF, &usage);
],
    RUSAGE="HAVERUSAGE"
    AC_MSG_RESULT(yes),
    RUSAGE="NORUSAGE"
    AC_MSG_RESULT(no))
  else
    AC_MSG_RESULT([NO TEST PERFORMED: using assigned value ($RUSAGE)])
  fi
  AC_SUBST(RUSAGE)
  ])dnl

