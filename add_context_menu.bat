@echo off
setlocal

:: Function to check if the script is running with elevated privileges
:CheckElevation
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~0' -ArgumentList '%*' -Verb runAs"
    exit /b
)

:: Function to add registry entries
:AddRegistryEntries
set "MenuName=%~1"
set "ExecutablePath=%~2"
set "IconPath=%~3"

echo Updating context menu entry for "%MenuName%" with executable "%ExecutablePath%" and icon "%IconPath%"

:: Add to right-click menu for files
REG ADD "HKEY_CLASSES_ROOT\*\shell\%MenuName%" /v "" /t REG_SZ /d "%MenuName%" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\%MenuName%\command" /v "" /t REG_SZ /d "\"%ExecutablePath%\" \"%%1\"" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\%MenuName%" /v "Icon" /t REG_SZ /d "\"%IconPath%\"" /f

:: Add to right-click menu for folders
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\%MenuName%" /v "" /t REG_SZ /d "%MenuName%" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\%MenuName%\command" /v "" /t REG_SZ /d "\"%ExecutablePath%\" \"%%1\"" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\%MenuName%" /v "Icon" /t REG_SZ /d "\"%IconPath%\"" /f

:: Add to right-click menu for directory backgrounds
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%MenuName%" /v "" /t REG_SZ /d "%MenuName%" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%MenuName%\command" /v "" /t REG_SZ /d "\"%ExecutablePath%\" \"%%V\"" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%MenuName%" /v "Icon" /t REG_SZ /d "\"%IconPath%\"" /f

echo Context menu entry updated successfully.

endlocal
exit /b 0

:: Main script execution
if "%~1"=="" (
    echo Usage: %0 "MenuName" "PathToExecutable" "PathToIcon"
    exit /b 1
)
if "%~2"=="" (
    echo Usage: %0 "MenuName" "PathToExecutable" "PathToIcon"
    exit /b 1
)
if "%~3"=="" (
    echo Usage: %0 "MenuName" "PathToExecutable" "PathToIcon"
    exit /b 1
)

:: Ensure the script is running with elevated privileges
call :CheckElevation

:: Add the registry entries
call :AddRegistryEntries %1 %2 %3
