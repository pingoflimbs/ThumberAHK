@echo off
setlocal

set PRJ_NAME=ThumberBasic

:: 파일 및 폴더 설정
set AHK_FILE=%PRJ_NAME%.ahk
set EXE_NAME=%PRJ_NAME%.exe
set SHORTCUT_NAME=%PRJ_NAME%.lnk
set IMG_NAME=%PRJ_NAME%.png
set OFF_AHK_FILE=%PRJ_NAME%_Off.ahk
set OFF_EXE_NAME=%PRJ_NAME%_Off.exe

:: 경로 설정
set AHK2EXE="%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe"
set SCRIPT_DIR=%~dp0
set TARGET_DIR=%APPDATA%\ThumberAHK\%PRJ_NAME%
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set STARTUP_FOLDER_COMMON=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

:: 대상 폴더 생성
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)

:: AHK 컴파일
%AHK2EXE% /in "%SCRIPT_DIR%%AHK_FILE%" /out "%SCRIPT_DIR%%EXE_NAME%"
if not exist "%SCRIPT_DIR%%EXE_NAME%" (
    echo 컴파일 실패. 경로를 확인하세요.
    pause        
)
:: OFF AHK 컴파일
%AHK2EXE% /in "%SCRIPT_DIR%%OFF_AHK_FILE%" /out "%SCRIPT_DIR%%OFF_EXE_NAME%"
if not exist "%SCRIPT_DIR%%OFF_EXE_NAME%" (
    echo 컴파일 실패. 경로를 확인하세요.
    pause
)

:: AHK 강제종료
taskkill /f /im %EXE_NAME% /t >nul 2>&1

:: APPDATA\Thumber\Thumber 로 복사 EXE,OFF,IMG
del /Y "%TARGET_DIR%\%EXE_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%EXE_NAME%" "%TARGET_DIR%\%EXE_NAME%"

del /Y "%TARGET_DIR%\%OFF_EXE_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%OFF_EXE_NAME%" "%TARGET_DIR%\%OFF_EXE_NAME%"

del /Y "%TARGET_DIR%\%IMG_NAME%" >nul 2>&1
copy /Y "%SCRIPT_DIR%%IMG_NAME%" "%TARGET_DIR%\%IMG_NAME%"


:: 바로가기 생성 (복사된 파일 기준)
powershell -noprofile -command ^
  "$s = (New-Object -COM WScript.Shell).CreateShortcut('%TARGET_DIR%\%SHORTCUT_NAME%');" ^
  "$s.TargetPath = '%TARGET_DIR%\%EXE_NAME%';" ^
  "$s.WorkingDirectory = '%TARGET_DIR%';" ^
  "$s.Save()"

:: 시작프로그램 폴더에 바로가기 복사
:: del /Y "%STARTUP_FOLDER_COMMON%\%SHORTCUT_NAME%" >nul 2>&1
:: copy /Y "%TARGET_DIR%\%SHORTCUT_NAME%" "%STARTUP_FOLDER_COMMON%\%SHORTCUT_NAME%"
:: del /Y "%TARGET_DIR%\%SHORTCUT_NAME%" >nul 2>&1

:: 프로그램 실행  
start "" "%TARGET_DIR%\%EXE_NAME%"
echo.
echo.
exit 0