@echo off
setlocal

:: 경로 설정
set AHK_FILE=ThumberBasic.ahk
set EXE_FILE=ThumberBasic.exe
set SHORTCUT_NAME=ThumberBasic.lnk
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

:: AHK 컴파일러 경로 (AutoHotkey v1 기준)
set AHK2EXE="%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe"

:: 현재 스크립트 위치
set SCRIPT_DIR=%~dp0

:: Thumber.exe 생성
echo [1/3] Compiling %AHK_FILE% ...
%AHK2EXE% /in "%SCRIPT_DIR%%AHK_FILE%" /out "%SCRIPT_DIR%%EXE_FILE%"
if not exist "%SCRIPT_DIR%%EXE_FILE%" (
    echo 컴파일 실패. 경로를 확인하세요.
    pause
    exit /b 1
)

:: 바로가기 생성 (PowerShell 사용)
echo [2/3] Creating shortcut ...
powershell -noprofile -command "$s = (New-Object -COM WScript.Shell).CreateShortcut('%SCRIPT_DIR%%SHORTCUT_NAME%'); $s.TargetPath = '%SCRIPT_DIR%%EXE_FILE%'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Save()"


:: 시작프로그램 폴더로 복사
echo [3/3] Registering to startup ...
copy /Y "%SCRIPT_DIR%%SHORTCUT_NAME%" "%STARTUP_FOLDER%\%SHORTCUT_NAME%"


del "%SCRIPT_DIR%%SHORTCUT_NAME%" >nul 2>&1


echo Complete
pause
