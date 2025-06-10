@echo off
setlocal

:: 파일 및 폴더 설정
set AHK_FILE=Thumber.ahk
set EXE_NAME=Thumber.exe
set SHORTCUT_NAME=Thumber.lnk
set IMG_NAME=Thumber.png

:: 경로 설정
set AHK2EXE="%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe"
set SCRIPT_DIR=%~dp0
set TARGET_DIR=%APPDATA%\ThumberAHK
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set STARTUP_FOLDER_COMMON=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

:: 대상 폴더 생성
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)

:: [1/4] AHK 컴파일
:: echo [1/4] Compiling %AHK_FILE% ...
%AHK2EXE% /in "%SCRIPT_DIR%%AHK_FILE%" /out "%SCRIPT_DIR%%EXE_NAME%"
if not exist "%SCRIPT_DIR%%EXE_NAME%" (
    echo 컴파일 실패. 경로를 확인하세요.
    pause    
)

:: [1/4] AHK 강제종료
taskkill /f /im %EXE_NAME% /t >nul 2>&1

:: [2/4] %APPDATA%\Thumber\로 복사
:: echo [2/4] Copying to %TARGET_DIR% ...
del /Y "%TARGET_DIR%\%EXE_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%EXE_NAME%" "%TARGET_DIR%\%EXE_NAME%"

del /Y "%TARGET_DIR%\%IMG_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%IMG_NAME%" "%TARGET_DIR%\%IMG_NAME%"

:: [3/4] 바로가기 생성 (복사된 파일 기준)
:: echo [3/4] Creating shortcut ...
powershell -noprofile -command ^
  "$s = (New-Object -COM WScript.Shell).CreateShortcut('%SCRIPT_DIR%%SHORTCUT_NAME%');" ^
  "$s.TargetPath = '%TARGET_DIR%\%EXE_NAME%';" ^
  "$s.WorkingDirectory = '%TARGET_DIR%';" ^
  "$s.Save()"

:: [4/4] 시작프로그램 폴더에 바로가기 복사
:: echo [4/4] Registering shortcut to startup ...
copy /Y "%SCRIPT_DIR%%SHORTCUT_NAME%" "%STARTUP_FOLDER%\%SHORTCUT_NAME%"
copy /Y "%SCRIPT_DIR%%SHORTCUT_NAME%" "%STARTUP_FOLDER_COMMON%\%SHORTCUT_NAME%"
del "%SCRIPT_DIR%%SHORTCUT_NAME%" >nul 2>&1

start "" "%TARGET_DIR%\%EXE_NAME%"

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Thumber is registered as STARTUP
echo.
echo.
echo.

exit 0
