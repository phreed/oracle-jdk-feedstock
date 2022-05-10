

@echo off

SetLocal EnableExtensions EnableDelayedExpansion

set "MY_SELF=%~f0
(
    echo Starting %MY_SELF%
    echo Activating in %CONDA_PREFIX%
    echo    CONDA_ROOT   : %CONDA_ROOT%
    echo    CONDA_QUIET  : %CONDA_QUIET%
    echo    CONDA_PREFIX : %CONDA_PREFIX%
    echo    PKG_NAME     : %PKG_NAME%
    echo    PKG_VERSION  : %PKG_VERSION%
    echo    PKG_BUILDNUM : %PKG_BUILDNUM%

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
set "CONDA_MESO=%CONDA_PREFIX%\conda-meso\%PKG_UUID%"
if not exist "%CONDA_MESO%" mkdir "%CONDA_MESO%"

set "DISCOVER_SCRIPT=%CONDA_MESO%\discovery.bat"
if exist "%DISCOVER_SCRIPT%" call "%DISCOVER_SCRIPT%"

set "DEACTIVATE_SCRIPT=%CONDA_MESO%\deactivate-aux.bat"
echo @echo off > "%DEACTIVATE_SCRIPT%"
echo Writing revert-script to %DEACTIVATE_SCRIPT%


echo rem "JDK8_HOME=%ORACLE_JDK_DIR%" >> "%DEACTIVATE_SCRIPT%"
echo set "JDK8_HOME=%JDK8_HOME%" >> "%DEACTIVATE_SCRIPT%"
set "JDK8_HOME=%ORACLE_JDK_DIR%"

echo rem "JAVA_HOME=%ORACLE_JDK_DIR%" >> "%DEACTIVATE_SCRIPT%"
echo set "JAVA_HOME=%JAVA_HOME%" >> "%DEACTIVATE_SCRIPT%"
set "JAVA_HOME=%ORACLE_JDK_DIR%"

exit /B 0