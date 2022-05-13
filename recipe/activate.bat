rem header written by bld.bat

@echo off

SetLocal EnableExtensions EnableDelayedExpansion

rem https://ss64.com/nt/syntax-args.html
set "PKG_UUID=%PKG_NAME%-%PKG_VERSION%_%PKG_BUILDNUM%"
set "CONDA_MESO=%CONDA_PREFIX%\conda-meso\%PKG_UUID%"

set "MY_SELF=%~f0
(
    echo Starting %MY_SELF%
    echo Activating in %CONDA_PREFIX%
    echo    CONDA_ROOT   : %CONDA_ROOT%
    echo    CONDA_QUIET  : %CONDA_QUIET%
    echo    PKG_NAME     : %PKG_NAME%
    echo    PKG_VERSION  : %PKG_VERSION%
    echo    PKG_BUILDNUM : %PKG_BUILDNUM%
    echo    PKG_UUID     : %PKG_UUID%

    echo    CONDA_JSON   : %CONDA_JSON%
    echo    CONDA_EXE    : %CONDA_EXE%
    echo    CONDA_EXES   : %CONDA_EXES%
    echo    CONDA_MESO   : %CONDA_MESO%

    echo    CONDA_PREFIX          : %CONDA_PREFIX%
    echo    CONDA_PREFIX_1        : %CONDA_PREFIX_1%

    echo    CONDA_DEFAULT_ENV     : %CONDA_DEFAULT_ENV%
    echo    CONDA_PROMPT_MODIFIER : %CONDA_PROMPT_MODIFIER%
    echo    CONDA_PYTHON_EXE      : %CONDA_PYTHON_EXE%
    echo    CONDA_SHLVL           : %CONDA_SHLVL%

    echo    CONDA_ALLOW_SOFTLINKS : %CONDA_ALLOW_SOFTLINKS%
    echo    CONDA_PATH_CONFLICT   : %CONDA_PATH_CONFLICT%
)
if not exist "%CONDA_MESO%" mkdir "%CONDA_MESO%"

rem https://en.wikipedia.org/wiki/Environment_variable#Windows
rem  Discovery
rem  should I be using `reg query ` to find the jdk directory path?
set "ORACLE_JDK_DIR=''"
set WIP=0
for /D %%G in ("%ProgramFiles%\Java\jdk1.8.0_*") do (
  for /F "tokens=2,3,4 delims=-._" %%H in ("%%~nxG") do (
    if %%J GTR !WIP! (
      set WIP=%%J
      set "ORACLE_JDK_DIR=%%G"
    )
  )
)

rem Oracle JDK directory = "%ORACLE_JDK_DIR%"
if not exist "%ORACLE_JDK_DIR%" (
    (
      echo The target JDK version has not been installed. %ORACLE_JDK_DIR%
      echo see https://www.oracle.com/java/technologies/downloads/#java8-windows
      echo  jdk-8u321-windows-x64.exe
    )
    exit /B 0
)

set "DEACTIVATE_SCRIPT=%CONDA_MESO%\deactivate.bat"
echo Writing revert-script to %DEACTIVATE_SCRIPT%
(
  echo @echo off
  echo set "JDK8_HOME=%JDK8_HOME%"
  echo set "JAVA_HOME=%JAVA_HOME%"
) > "%DEACTIVATE_SCRIPT%"

set "JDK8_HOME=%ORACLE_JDK_DIR%"
set "JAVA_HOME=%JDK8_HOME%"
set "SRC_BIN=%ORACLE_JDK_DIR%\bin"
set "TGT_BIN=%CONDA_PREFIX%\bin"

if not exist "%TGT_BIN%" mkdir "%TGT_BIN%"
echo rem linking from "%SRC_BIN%" >> "%DEACTIVATE_SCRIPT%"
for /R "%SRC_BIN%" %%G in (*.exe) do (
  for %%H in (%TGT_BIN%\%%~nxG) do (
      if exist "%%H" (
        del "%%H"
        echo link %%H is being overwritten
      )
      mklink /H "%%H" "%%G" || echo failed creating link "%%H" to "%%G"
      echo del "%%H" >> "%DEACTIVATE_SCRIPT%"
  )
)


set "FORWARD_SLASHED_PREFIX=%CONDA_PREFIX:\=/%"
if not exist "%CONDA_PREFIX%\Library" mkdir "%CONDA_PREFIX%\Library"
if not exist "%CONDA_PREFIX%\Library\bin" mkdir "%CONDA_PREFIX%\Library\bin"
(
    echo [Paths]
    echo Prefix = %FORWARD_SLASHED_PREFIX%/Library
    echo Binaries = %FORWARD_SLASHED_PREFIX%/Library/bin
    echo Libraries = %FORWARD_SLASHED_PREFIX%/Library/lib
    echo Headers = %FORWARD_SLASHED_PREFIX%/Library/include
    echo TargetSpec = win32-msvc
    echo HostSpec = win32-msvc
) > "%CONDA_PREFIX%\Library\bin\oracle-jdk-dummy.conf"
rem Some things go looking in the prefix root (pyqt, for example)
copy "%CONDA_PREFIX%\Library\bin\oracle-jdk-dummy.conf" "%CONDA_PREFIX%\oracle-jdk-dummy.conf"

echo Activation of %PKG_NAME% complete.

exit /B 0
