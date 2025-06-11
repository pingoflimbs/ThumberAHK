@echo off
setlocal

set "PRJ_NAME=Thumber"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "SRC_DIR=%~dp0"
set "EXE_NAME=%PRJ_NAME%.exe"
set "OFF_EXE_NAME=%PRJ_NAME%_Off.exe"
set "IMG_NAME=%PRJ_NAME%.png"
set "SHORTCUT_NAME=%PRJ_NAME%.lnk"

set "TARGET_DIR=%APPDATA%\ThumberAHK\%PRJ_NAME%"
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist "%TARGET_DIR%" (
    rmdir /s /q "%TARGET_DIR%"
)
mkdir "%TARGET_DIR%"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
copy /Y "%SRC_DIR%%EXE_NAME%" "%TARGET_DIR%\"
copy /Y "%SRC_DIR%%OFF_EXE_NAME%" "%TARGET_DIR%\"
copy /Y "%SRC_DIR%%IMG_NAME%" "%TARGET_DIR%\"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
powershell -noprofile -command ^
  "$s = (New-Object -ComObject WScript.Shell).CreateShortcut('%TEMP%\%SHORTCUT_NAME%');" ^
  "$s.TargetPath = '%TARGET_DIR%\%EXE_NAME%';" ^
  "$s.WorkingDirectory = '%TARGET_DIR%';" ^
  "$s.Save()"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
copy /Y "%TEMP%\%SHORTCUT_NAME%" "%STARTUP_FOLDER%\"
del /Q "%TEMP%\%SHORTCUT_NAME%" > nul

echo [완료] 2초 후 종료됩니다...
timeout /t 2 > nul
exit 0