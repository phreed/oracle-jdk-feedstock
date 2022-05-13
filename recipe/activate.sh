# header is written by build.sh or bld.bat

PKG_UUID="${PKG_NAME}-${PKG_VERSION}_${PKG_BUILDNUM}"
CONDA_MESO="${CONDA_PREFIX}/conda-meso/${PKG_UUID}"

MY_SELF="$@"
cat - << SHOW_IMPORTANT_ENV_VARIABLES
Starting ${MY_SELF}
Activating in ${CONDA_PREFIX}
   CONDA_ROOT   : ${CONDA_ROOT}
   CONDA_QUIET  : ${CONDA_QUIET}
   PKG_NAME     : ${PKG_NAME}
   PKG_VERSION  : ${PKG_VERSION}
   PKG_BUILDNUM : ${PKG_BUILDNUM}
   PKG_UUID     : ${PKG_UUID}

   CONDA_JSON   : ${CONDA_JSON}
   CONDA_EXE    : ${CONDA_EXE}
   CONDA_EXES   : ${CONDA_EXES}
   CONDA_MESO   : ${CONDA_MESO}

   CONDA_PREFIX          : ${CONDA_PREFIX}
   CONDA_PREFIX_1        : ${CONDA_PREFIX_1}

   CONDA_DEFAULT_ENV     : ${CONDA_DEFAULT_ENV}
   CONDA_PROMPT_MODIFIER : ${CONDA_PROMPT_MODIFIER}
   CONDA_PYTHON_EXE      : ${CONDA_PYTHON_EXE}
   CONDA_SHLVL           : ${CONDA_SHLVL}

   CONDA_ALLOW_SOFTLINKS : ${CONDA_ALLOW_SOFTLINKS}
   CONDA_PATH_CONFLICT   : ${CONDA_PATH_CONFLICT}
SHOW_IMPORTANT_ENV_VARIABLES

[ -d "${CONDA_MESO}" ] || mkdir -p "${CONDA_MESO}"

# Discovery
WIP=0
for gx in /usr/java/jdk1.8.0_*; do
  BASE_NAME=$(basename -- "${gx}")
  BACK=${BASE_NAME##jdk1.8.0_}
  REVISION=${BACK%-*}
  if [ "$REVISION" -gt "$WIP" ]; then
    WIP=$REVISION
    export ORACLE_JDK_DIR="$gx"
  fi
done

echo "Oracle JDK directory = ${ORACLE_JDK_DIR}"
if [ ! -d "${ORACLE_JDK_DIR}" ]; then
  {
    echo "The target JDK version has not been installed. ${ORACLE_JDK_DIR}";
    case "$OSTYPE" in
      darwin*)
        echo "see https://www.oracle.com/java/technologies/downloads/#java8-mac"
        echo " jdk-8u333-macosx-x64.dmg"
        ;;
      linux*)
        echo "see https://www.oracle.com/java/technologies/downloads/#java8-linux"
        echo " jdk-8u333-linux-x64.rpm"
        ;;
      msys*)
        echo "see https://www.oracle.com/java/technologies/downloads/#java8-windows"
        echo " "
        ;;
      *) echo "unknown $OSTYPE" ;;
    esac
  }
  return 0 2> /dev/null | exit 0
fi

DEACTIVATE_SCRIPT="${CONDA_MESO}/deactivate.sh"
echo "Writing revert-script to ${DEACTIVATE_SCRIPT}"
cat - << END_OF_DEACTIVATE_SCRIPT > "${DEACTIVATE_SCRIPT}"
#/bin/bash -euo
export ORACLE_JDK_DIR="${ORACLE_JDK_DIR}"
export JDK8_HOME="${JDK8_HOME}"
export JAVA_HOME="${JAVA_HOME}"
END_OF_DEACTIVATE_SCRIPT

export JDK8_HOME="${ORACLE_JDK_DIR}"
export JAVA_HOME="${JDK8_HOME}"

SRC_BIN="${ORACLE_JDK_DIR}/bin"
TGT_BIN="${CONDA_PREFIX}/bin"

echo "Preparing to link *.exe files, from ${ORACLE_JDK_DIR}."

[ -d "${TGT_BIN}" ] || mkdir -p "${TGT_BIN}"
for ix in "${SRC_BIN}"/*; do
  BASE_NAME=$(basename -- "${ix}")
  jx="${TGT_BIN}/${BASE_NAME}"
  if [ -f  "$jx" ] ; then
    rm "$jx"
    echo "link ${jx} is being overwritten"
  fi
  ln "${ix}" "${jx}" || echo "failed creating link ${jx} to ${ix}"
  echo "# ln \"${ix}\" \"${jx}\"" >> "${DEACTIVATE_SCRIPT}"
  echo "rm \"${jx}\"" >> "${DEACTIVATE_SCRIPT}"
done


[ -d "${CONDA_PREFIX}/Library/bin" ] || mkdir -p "${CONDA_PREFIX}/Library/bin"
DUMMY_CONF="${CONDA_PREFIX}/Library/bin/oracle-jdk-dummy.conf"
echo "Writing oracle-jdk-dummy.conf to ${DUMMY_CONF}"
cat - <<EOF_DUMMY_CONF > "${DUMMY_CONF}"
[Paths]
Prefix = ${CONDA_PREFIX}/Library
Binaries = ${CONDA_PREFIX}/Library/bin
Libraries = ${CONDA_PREFIX}/Library/lib
Headers = ${CONDA_PREFIX}/Library/include
TargetSpec = linux64
HostSpec = linux64
EOF_DUMMY_CONF

cp "${DUMMY_CONF}" "${CONDA_PREFIX}/oracle-jdk-dummy.conf"
echo "Activation complete"

return 0 2> /dev/null | exit 0
