@echo off
setlocal

set PRJ_NAME=Thumber
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set AHK_FILE=%PRJ_NAME%.ahk
set EXE_NAME=%PRJ_NAME%.exe
set SHORTCUT_NAME=%PRJ_NAME%.lnk
set IMG_NAME=%PRJ_NAME%.png
set OFF_AHK_FILE=%PRJ_NAME%_Off.ahk
set OFF_EXE_NAME=%PRJ_NAME%_Off.exe
set AHK2EXE="%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe"
set SCRIPT_DIR=%~dp0
set TARGET_DIR=%APPDATA%\ThumberAHK\%PRJ_NAME%
set TMP_DIR=%APPDATA%\ThumberAHK\%PRJ_NAME%\Temp
:: set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
:: set STARTUP_FOLDER_COMMON=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp



echo --0-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo init appdata targetDir
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)


echo init appdata tmpdir
if exist "%TMP_DIR%" (    
    rmdir /s /q "%TMP_DIR%"
)
mkdir "%TMP_DIR%"



echo -1-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo AHK compile
%AHK2EXE% /in "%SCRIPT_DIR%%AHK_FILE%" /out "%TMP_DIR%\%EXE_NAME%"
if not exist "%TMP_DIR%\%EXE_NAME%" (
    echo No File Exist %EXE_NAME%
    pause
)
if errorlevel 1 (
    echo  %EXE_NAME% Build Fail !
    pause
) else (
    echo %EXE_NAME% Compile Success!
)

echo OFF AHK compile
%AHK2EXE% /in "%SCRIPT_DIR%%OFF_AHK_FILE%" /out "%TMP_DIR%\%OFF_EXE_NAME%"
if not exist "%TMP_DIR%\%EXE_NAME%" (
    echo No File Exist %OFF_EXE_NAME%
    pause
)
if errorlevel 1 (
    echo  %OFF_EXE_NAME% Build Fail !
    pause
) else (
    echo %OFF_EXE_NAME% Compile Success!
)



echo -2-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo AHK task Kill
taskkill /f /im %EXE_NAME% /t >nul 2>&1

timeout /t 2 > nul

echo TMP to TARGET copy (EXE)
del /Y "%TARGET_DIR%\%EXE_NAME%" >nul 2>&1
copy /Y "%TMP_DIR%\%EXE_NAME%" "%TARGET_DIR%\%EXE_NAME%"

echo TMP to TARGET copy (OFF)
del /Y "%TARGET_DIR%\%OFF_EXE_NAME%" >nul 2>&1
copy /Y "%TMP_DIR%\%OFF_EXE_NAME%" "%TARGET_DIR%\%OFF_EXE_NAME%"



echo -3-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo TMP to TARGET copy (IMG)
del /Y "%TARGET_DIR%\%IMG_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%IMG_NAME%" "%TARGET_DIR%\%IMG_NAME%"



echo -4-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo shortcut file create
powershell -noprofile -command ^
  "$s = (New-Object -COM WScript.Shell).CreateShortcut('%TARGET_DIR%\%SHORTCUT_NAME%');" ^
  "$s.TargetPath = '%TARGET_DIR%\%EXE_NAME%';" ^
  "$s.WorkingDirectory = '%TARGET_DIR%';" ^
  "$s.Save()"



::echo -5-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: echo shortcut file copy to startup
:: del /Y "%STARTUP_FOLDER_COMMON%\%SHORTCUT_NAME%" >nul 2>&1
:: copy /Y "%TARGET_DIR%\%SHORTCUT_NAME%" "%STARTUP_FOLDER_COMMON%\%SHORTCUT_NAME%"
:: del /Y "%TARGET_DIR%\%SHORTCUT_NAME%" >nul 2>&1


echo -6-------------------------------------------------------------------------
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo TMP clean
if exist "%TMP_DIR%" (    
    rmdir /s /q "%TMP_DIR%"
)
echo run EXE
start "" "%TARGET_DIR%\%EXE_NAME%"
echo.
echo.

::pause
timeout /t 8 > nul
exit 0