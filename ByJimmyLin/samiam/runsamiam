#!/bin/sh
# Script to run SamIam
# by Keith Cascio

# Explanation of command-line flags:
#
# -Xruncalljvmti: Run the virtual machine profiler (libcalljvmti.*).
#
# -Xms8m: Specify the initial size, in bytes, of the memory allocation pool = 8 Megs.
#
# -Xmx512m: Specify the maximum size, in bytes, of the memory allocation pool = 512 Megs.

javalauncher='java'

SAMIAMHOME=${0%/*}
[ "${SAMIAMHOME}" ] && SAMIAMHOME="${SAMIAMHOME}/"
vmargs="-Xms8m -Xmx512m -classpath ${SAMIAMHOME}samiam.jar:${SAMIAMHOME}inflib.jar edu.ucla.belief.ui.UI"





      vmargssafe="${vmargs}"
          STATUS="${SAMIAMHOME}.samiamexitstatus"
          ERRORS="${SAMIAMHOME}.samiamerrors"
        SUPPRESS="${SAMIAMHOME}.suppress_calljvmti"
[ -e "${SUPPRESS}" ] || vmargs="-Xruncalljvmti ${vmargs}"

 LD_LIBRARY_PATH="${SAMIAMHOME}${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH:-}"; export LD_LIBRARY_PATH

type "${javalauncher}" >/dev/null 2>&1 && {
  execcmd=`type "${javalauncher}" 2>&1 | sed -ne 's#^[^/]*\([^)]*\).*$#\1#;\#'"${javalauncher}"'#p'`
  {
    ${execcmd} ${vmargs} -launchcommand "${execcmd} ${vmargs} $*" -launchscript "$0" $*
    echo $?   >"${STATUS}" 2>/dev/null
  } 2>&1 | tee "${ERRORS}"
  [   -e       "${STATUS}" ] && exitstatus=`cat "${STATUS}"` || exitstatus=0
  [ "${exitstatus}" = 0    ] || {
    msg='Java exited with an error code ['"${exitstatus}"'].'
    [ -e       "${ERRORS}" ] && grep -qF 'calljvmti' "${ERRORS}" >/dev/null 2>&1 && {
      touch    "${SUPPRESS}" >/dev/null 2>&1
      ${execcmd} ${vmargssafe} -launchcommand "${execcmd} ${vmargs} $*" -launchscript "$0" $*
      msg=
    }
    [ "${msg}" ] && echo "${msg}" 1>&2
  }
  {
    [ -e       "${ERRORS}" ] && rm -f "${ERRORS}"
    [ -e       "${STATUS}" ] && rm -f "${STATUS}"
  }    >/dev/null 2>&1
  echo >/dev/null 2>&1
} || {
  exitstatus=$?
  echo 'Cannot find the Java launcher program "'"${javalauncher}"'" in your path. Please make sure a java runtime environment is installed on your system and mentioned in the path environment variable.'
  echo
  echo 'Your current path is "'"${PATH}"'"'
}

exit $exitstatus

