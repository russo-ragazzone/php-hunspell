dnl $Id$
dnl config.m4 for extension hunspell

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

PHP_ARG_WITH(hunspell, for hunspell support,
[  --with-hunspell             Include hunspell support])

if test "$PHP_HUNSPELL" != "no"; then
  dnl Write more examples of tests here...

  SEARCH_PATH="/usr/local /usr"     # you might want to change this
  SEARCH_FOR="/include/hunspell/hunspell.h"  # you most likely want to change this
  if test -r $PHP_HUNSPELL/$SEARCH_FOR; then # path given as parameter
    HUNSPELL_DIR=$PHP_HUNSPELL
  else # search default path list
    AC_MSG_CHECKING([for hunspell files in default path])
    for i in $SEARCH_PATH ; do
      if test -r $i/$SEARCH_FOR; then
        HUNSPELL_DIR=$i
        AC_MSG_RESULT(found in $i)
      fi
    done
  fi

  if test -z "$HUNSPELL_DIR"; then
    AC_MSG_RESULT([not found])
    AC_MSG_ERROR([Please reinstall the hunspell distribution])
  fi

  dnl # --with-hunspell -> add include path
  PHP_ADD_INCLUDE($HUNSPELL_DIR/include)

  dnl # --with-hunspell -> check for lib and symbol presence
  LIBNAME=hunspell # you may want to change this
  LIBSYMBOL=libhunspell # you most likely want to change this 

    PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $HUNSPELL_DIR/lib, HUNSPELL_SHARED_LIBADD)
    AC_DEFINE(HAVE_HUNSPELLLIB,1,[ ])


#  PHP_CHECK_LIBRARY($LIBNAME,$LIBSYMBOL,
 # [
#    PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $HUNSPELL_DIR/lib, HUNSPELL_SHARED_LIBADD)
x    AC_DEFINE(HAVE_HUNSPELLLIB,1,[ ])
 # ],[
#    AC_MSG_ERROR([wrong hunspell lib version or lib not found])
 # ],[
#    -L$HUNSPELL_DIR/lib -lm -ldl
 # ])

  PHP_SUBST(HUNSPELL_SHARED_LIBADD)
  PHP_NEW_EXTENSION(hunspell, hunspell.c, $ext_shared)
fi
