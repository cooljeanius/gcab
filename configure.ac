dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([gcab],[0.4],[marcandre.lureau@gmail.com])
AC_CONFIG_SRCDIR([gcab.c])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
  ## need to leave prev. line blank after macro ends for intltoolize
AM_INIT_AUTOMAKE([1.11 dist-xz no-dist-gzip tar-ustar foreign -Wall subdir-objects -Wno-portability])
AC_CONFIG_HEADERS([config.h])
AM_MAINTAINER_MODE([disable])
AM_SILENT_RULES([yes])dnl

# Checks for programs.
AC_PROG_CXX
if test "x${AWK}" = "x"; then
  test -z "${AWK}" || unset AWK
  AC_PROG_AWK
fi
AC_PROG_CPP
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
if test "x${CC}" = "x"; then
  test -z "${CC}" || unset CC
  AC_PROG_CC
else
  test -n "${CC}" && export CC
fi
AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PATH_PROGS([LD_PATH],
              [ld gld gold mold sold lld ld.bfd ld.gold])
AC_LIB_PROG_LD_GNU
AC_LIB_PREFIX
AC_LIB_LINKFLAGS
if test "x${AR}" = "x"; then
  test -z "${AR}" || unset AR
  AC_CHECK_TOOLS([AR],[ar gar])dnl
  ## might want to switch around these checks...
  if test "x${ac_cv_prog_AR}" = "x"; then
    test -z "${ac_cv_prog_AR}" || unset ac_cv_prog_AR
    m4_ifdef([AC_PROG_AR],[
      AC_PROG_AR
    ],[
      test -x "`which ar`" && echo "first ar in path is `which ar`"
    ])
  fi
else
  test -n "${AR}" && export AR
fi
LT_INIT([win32-dll disable-fast-install])dnl

# AX_* macros are from autoconf-archive
AX_DLL_STRING
AX_SAVE_FLAGS
AX_RPM_INIT
AX_WITH_BUILD_PATH
AX_APPEND_LINK_FLAGS([--version-script=./libgcab.syms])dnl

GTK_DOC_CHECK([1.14],[--flavour no-tmpl])
AC_DEFUN([AC_REQUIRE_PKG_CONFIG],[
  AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
])dnl
AC_REQUIRE_PKG_CONFIG
GOBJECT_INTROSPECTION_CHECK([0.9.4])
AM_CONDITIONAL([GIR],[test "x${INTROSPECTION_MAKEFILE}" != "x"])dnl

IT_PROG_INTLTOOL([0.40.0])
GETTEXT_PACKAGE=AC_PACKAGE_NAME
AC_SUBST([GETTEXT_PACKAGE])dnl
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE],["${GETTEXT_PACKAGE}"],
                   [The name of the gettext domain])
AM_GLIB_GNU_GETTEXT
AM_GNU_GETTEXT([external])dnl

# Checks for libraries.
AC_CHECK_LIB([z],[gzread])dnl

AM_PATH_GLIB_2_0([2.22.0],[],[AC_MSG_ERROR([glib required])],[gio])
AM_PROG_VALAC([0.14])
AC_PATH_PROG([VAPIGEN],[vapigen],[no])
AC_SUBST([VAPIGEN])dnl
AM_CONDITIONAL([VAPI],[test "x${VAPIGEN}" != "xno"])
AC_CHECK_HEADERS([zlib.h],[],[AC_MSG_ERROR([zlib required])])dnl

gl_MANYWARN_ALL_GCC([warnings])
nw=""
nw="${nw} -W"                     # redundant with -Wextra
nw="${nw} -Wcomments"       # redundant synonym for the un-pluralized -Wcomment
nw="${nw} -Wmudflap"              # no longer supported
nw="${nw} -Wsystem-headers"       # Do not let system headers trigger warnings
nw="${nw} -Wundef"               # All compiler preprocessors support #if UNDEF
nw="${nw} -Wtraditional"          # All compilers nowadays support ANSI C
nw="${nw} -Wconversion"       # These warnings usually do no point to mistakes.
nw="${nw} -Wsign-conversion"      # Likewise.
nw="${nw} -Wunused-parameter"     # Likewise.
nw="${nw} -Wunused-local-typedefs" # Likewise.
nw="${nw} -Wunsafe-loop-optimizations" # Likewise.
# Enable all GCC warnings not in this list.
gl_MANYWARN_COMPLEMENT([warnings],[${warnings}],[${nw}])
for w in ${warnings}; do
  gl_WARN_ADD([${w}])
done
gl_WARN_ADD([-Wno-sign-compare])
gl_WARN_ADD([-Wno-unused-parameter])dnl

# Checks for header files.
AC_DEFUN([AC_REQUIRE_HEADER_STDC],[
  m4_ifdef([AC_HEADER_STDC],[
    AC_REQUIRE([AC_HEADER_STDC])dnl
  ],[
    AC_REQUIRE([AC_CHECK_INCLUDES_DEFAULT])dnl
  ])dnl
])dnl
AC_REQUIRE_HEADER_STDC
AC_CHECK_HEADERS([dirent.h])dnl

if test "x${ac_cv_header_libintl_h}" = "x"; then
  test -z "${ac_cv_header_libintl_h}" || unset ac_cv_header_libintl_h
  AC_CHECK_HEADERS([libintl.h]) # (keep autoscan happy)
fi
if test "x${ac_cv_header_unistd_h}" = "x"; then
  test -z "${ac_cv_header_unistd_h}" || unset ac_cv_header_unistd_h
  AC_CHECK_HEADERS([unistd.h]) # (keep autoscan happy)
fi

# Checks for typedefs, structures, and compiler characteristics.
AC_C_INLINE
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset setlocale])dnl

# Testsuite.
AM_MISSING_PROG([AUTOM4TE],[autom4te])
AC_CONFIG_TESTDIR([.])
AC_CONFIG_FILES([atlocal])
AC_CONFIG_FILES([tests/package.m4.tmp:tests/package.m4.in],
                [${srcdir}/build-aux/move-if-change tests/package.m4.tmp ${srcdir}/tests/package.m4
                 cp ${srcdir}/tests/package.m4 tests/package.m4.tmp])dnl

# Output.
AC_CONFIG_FILES([
  Makefile
  Makefile_orig
  docs/Makefile
  docs/reference/Makefile
  docs/reference/gcab-docs.sgml
  gcab.1
  libgcab-1.0.pc
  libgcab/Makefile
  po/Makefile.in
])
AC_OUTPUT

AC_MSG_NOTICE([
        gcab ${VERSION}
        ============

        prefix:                   ${prefix}
        c compiler:               ${CC}
])dnl
