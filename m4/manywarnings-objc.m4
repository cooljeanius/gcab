# manywarnings-objc.m4 serial 1
dnl Copyright (C) 2008-2018 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

# Implementation of the specialization of gl_MANYWARN_ALL_GCC
# for _AC_LANG = Objective C.
AC_DEFUN([gl_MANYWARN_ALL_GCC_OBJC_IMPL],
[
  AC_LANG_PUSH([Objective C])

  dnl First, check for some issues that only occur when combining multiple
  dnl gcc warning categories.
  AC_REQUIRE([AC_PROG_OBJC])
  if test -n "$GOBJC"; then

    dnl Check if -W -Werror -Wno-missing-field-initializers is supported
    dnl with the current $OBJC $OBJCFLAGS $CPPFLAGS.
    AC_MSG_CHECKING([whether -Wno-missing-field-initializers is supported])
    AC_CACHE_VAL([gl_cv_objc_nomfi_supported], [
      gl_save_OBJCFLAGS="$OBJCFLAGS"
      OBJCFLAGS="$OBJCFLAGS -W -Werror -Wno-missing-field-initializers"
      AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([[]], [[]])],
        [gl_cv_objc_nomfi_supported=yes],
        [gl_cv_objc_nomfi_supported=no])
      OBJCFLAGS="$gl_save_OBJCFLAGS"])
    AC_MSG_RESULT([$gl_cv_objc_nomfi_supported])

    if test "$gl_cv_objc_nomfi_supported" = yes; then
      dnl Now check whether -Wno-missing-field-initializers is needed
      dnl for the { 0, } construct.
      AC_MSG_CHECKING([whether -Wno-missing-field-initializers is needed])
      AC_CACHE_VAL([gl_cv_objc_nomfi_needed], [
        gl_save_OBJCFLAGS="$OBJCFLAGS"
        OBJCFLAGS="$OBJCFLAGS -W -Werror"
        AC_COMPILE_IFELSE(
          [AC_LANG_PROGRAM(
             [[int f (void)
               {
                 typedef struct { int a; int b; } s_t;
                 s_t s1 = { 0, };
                 return s1.b;
               }
             ]],
             [[]])],
          [gl_cv_objc_nomfi_needed=no],
          [gl_cv_objc_nomfi_needed=yes])
        OBJCFLAGS="$gl_save_OBJCFLAGS"
      ])
      AC_MSG_RESULT([$gl_cv_objc_nomfi_needed])
    fi

    dnl Next, check if -Werror -Wuninitialized is useful with the
    dnl user's choice of $OBJCFLAGS; some versions of gcc warn that it
    dnl has no effect if -O is not also used
    AC_MSG_CHECKING([whether -Wuninitialized is supported])
    AC_CACHE_VAL([gl_cv_objc_uninitialized_supported], [
      gl_save_OBJCFLAGS="$OBJCFLAGS"
      OBJCFLAGS="$OBJCFLAGS -Werror -Wuninitialized"
      AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([[]], [[]])],
        [gl_cv_objc_uninitialized_supported=yes],
        [gl_cv_objc_uninitialized_supported=no])
      OBJCFLAGS="$gl_save_OBJCFLAGS"])
    AC_MSG_RESULT([$gl_cv_objc_uninitialized_supported])

  fi

  # List all gcc warning categories.
  # To compare this list to your installed GCC's, run this Bash command:
  #
  # comm -3 \
  #  <(sed -n 's/^  *\(-[^ ]*\) .*/\1/p' manywarnings-objc.m4 | sort) \
  #  <(gcc --help=warnings | sed -n 's/^  \(-[^ ]*\) .*/\1/p' | sort |
  #      grep -v -x -f <(
  #         awk '/^[^#]/ {print $1}' ../build-aux/gobjc-warning.spec))

  gl_manywarn_set=
  for gl_manywarn_item in -fno-common \
    -W \
    -Wabi \
    -Waddress \
    -Waggressive-loop-optimizations \
    -Wall \
    -Wassign-intercept \
    -Wattributes \
    -Wbad-function-cast \
    -Wbool-compare \
    -Wbool-operation \
    -Wbuiltin-declaration-mismatch \
    -Wbuiltin-macro-redefined \
    -Wcast-align \
    -Wchar-subscripts \
    -Wchkp \
    -Wclobbered \
    -Wcomment \
    -Wcomments \
    -Wcoverage-mismatch \
    -Wcpp \
    -Wdangling-else \
    -Wdate-time \
    -Wdeprecated \
    -Wdeprecated-declarations \
    -Wdesignated-init \
    -Wdisabled-optimization \
    -Wdiscarded-array-qualifiers \
    -Wdiscarded-qualifiers \
    -Wdiv-by-zero \
    -Wdouble-promotion \
    -Wduplicated-branches \
    -Wduplicated-cond \
    -Wduplicate-decl-specifier \
    -Wempty-body \
    -Wendif-labels \
    -Wenum-compare \
    -Wexpansion-to-defined \
    -Wextra \
    -Wformat-contains-nul \
    -Wformat-extra-args \
    -Wformat-nonliteral \
    -Wformat-security \
    -Wformat-signedness \
    -Wformat-y2k \
    -Wformat-zero-length \
    -Wframe-address \
    -Wfree-nonheap-object \
    -Whsa \
    -Wignored-attributes \
    -Wignored-qualifiers \
    -Wimplicit \
    -Wimplicit-function-declaration \
    -Wimplicit-int \
    -Wincompatible-pointer-types \
    -Winit-self \
    -Winline \
    -Wint-conversion \
    -Wint-in-bool-context \
    -Wint-to-pointer-cast \
    -Winvalid-memory-model \
    -Winvalid-pch \
    -Wjump-misses-init \
    -Wlogical-not-parentheses \
    -Wlogical-op \
    -Wmain \
    -Wmaybe-uninitialized \
    -Wmemset-elt-size \
    -Wmemset-transposed-args \
    -Wmisleading-indentation \
    -Wmissing-braces \
    -Wmissing-declarations \
    -Wmissing-field-initializers \
    -Wmissing-include-dirs \
    -Wmissing-parameter-type \
    -Wmissing-prototypes \
    -Wmultichar \
    -Wnarrowing \
    -Wnested-externs \
    -Wnonnull \
    -Wnonnull-compare \
    -Wnonportable-cfstrings \
    -Wnull-dereference \
    -Wodr \
    -Wold-style-declaration \
    -Wold-style-definition \
    -Wopenmp-simd \
    -Woverflow \
    -Woverlength-strings \
    -Woverride-init \
    -Wpacked \
    -Wpacked-bitfield-compat \
    -Wparentheses \
    -Wpointer-arith \
    -Wpointer-compare \
    -Wpointer-sign \
    -Wpointer-to-int-cast \
    -Wpragmas \
    -Wproperty-assign-default \
    -Wprotocol \
    -Wpsabi \
    -Wrestrict \
    -Wreturn-local-addr \
    -Wreturn-type \
    -Wscalar-storage-order \
    -Wsequence-point \
    -Wshadow \
    -Wshadow-ivar \
    -Wshift-count-negative \
    -Wshift-count-overflow \
    -Wshift-negative-value \
    -Wsizeof-array-argument \
    -Wsizeof-pointer-memaccess \
    -Wstack-protector \
    -Wstrict-aliasing \
    -Wstrict-overflow \
    -Wstrict-prototypes \
    -Wsuggest-attribute=const \
    -Wsuggest-attribute=format \
    -Wsuggest-attribute=noreturn \
    -Wsuggest-attribute=pure \
    -Wsuggest-final-methods \
    -Wsuggest-final-types \
    -Wswitch \
    -Wswitch-bool \
    -Wswitch-default \
    -Wswitch-unreachable \
    -Wsync-nand \
    -Wsystem-headers \
    -Wtautological-compare \
    -Wtrampolines \
    -Wtrigraphs \
    -Wtype-limits \
    -Wundeclared-selector \
    -Wuninitialized \
    -Wunknown-pragmas \
    -Wunsafe-loop-optimizations \
    -Wunused \
    -Wunused-but-set-parameter \
    -Wunused-but-set-variable \
    -Wunused-function \
    -Wunused-label \
    -Wunused-local-typedefs \
    -Wunused-macros \
    -Wunused-parameter \
    -Wunused-result \
    -Wunused-value \
    -Wunused-variable \
    -Wvarargs \
    -Wvariadic-macros \
    -Wvector-operation-performance \
    -Wvla \
    -Wvolatile-register-var \
    -Wwrite-strings \
    \
    ; do
    gl_manywarn_set="$gl_manywarn_set $gl_manywarn_item"
  done

  # gcc --help=warnings outputs an unusual form for these options; list
  # them here so that the above 'comm' command doesn't report a false match.
  gl_manywarn_set="$gl_manywarn_set -Warray-bounds=2"
  gl_manywarn_set="$gl_manywarn_set -Wnormalized=nfc"
  gl_manywarn_set="$gl_manywarn_set -Wshift-overflow=2"
  gl_manywarn_set="$gl_manywarn_set -Wunused-const-variable=2"

  # These are needed for older GCC versions.
  if test -n "$GOBJC"; then
    case `($OBJC --version) 2>/dev/null` in
      'g++ (GCC) '[[0-3]].* | \
      'g++ (GCC) '4.[[0-7]].*)
        gl_manywarn_set="$gl_manywarn_set -fdiagnostics-show-option"
        gl_manywarn_set="$gl_manywarn_set -funit-at-a-time"
          ;;
    esac
  fi

  # Disable specific options as needed.
  if test "$gl_cv_objc_nomfi_needed" = yes; then
    gl_manywarn_set="$gl_manywarn_set -Wno-missing-field-initializers"
  fi

  if test "$gl_cv_objc_uninitialized_supported" = no; then
    gl_manywarn_set="$gl_manywarn_set -Wno-uninitialized"
  fi

  $1=$gl_manywarn_set

  AC_LANG_POP([Objective C])
])
