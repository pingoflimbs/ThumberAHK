#NoEnv  ; 환경 변수를 자동으로 참조하지 않도록 설정합니다.성능 향상과 향후 AutoHotkey 버전과의 호환성을 위해 권장됩니다.변수 이름이 환경 변수와 충돌하는 것을 방지합니다.
SendMode Input  ; 키 입력을 보내는 방식을 'Input' 모드로 설정합니다.이 모드는 속도와 안정성 면에서 우수하여 새로운 스크립트에 권장됩니다.키 입력을 더 빠르고 정확하게 시뮬레이션할 수 있습니다.
SetWorkingDir %A_ScriptDir%  ; 스크립트의 작업 디렉토리를 스크립트 파일이 위치한 폴더로 설정합니다.%A_ScriptDir%는 현재 실행 중인 스크립트의 디렉토리를 나타내는 내장 변수입니다.이를 통해 스크립트가 상대 경로를 사용할 때 일관된 시작 지점을 가질 수 있습니다.
#MaxHotkeysPerInterval 10000; 지정된 시간 간격 동안 실행될 수 있는 최대 핫키 수를 설정합니다.기본값은 70이지만, 이를 10000으로 증가시켜 더 많은 핫키가 빠르게 연속해서 실행될 수 있도록 합니다.이는 매크로나 자동화 스크립트에서 유용할 수 있지만, 시스템 리소스를 많이 사용할 수 있으므로 주의가 필요합니다.
#Persistent
#SingleInstance, Force; Force를 추가하면, 스크립트가 이미 실행 중일 때 새로운 인스턴스가 시작되면 기존의 인스턴스를 자동으로 대체합니다.
DetectHiddenWindows, On
TrayTip ,Thumber On,[Ver.20250613]`n스페이스바를 세번눌러 도움말열기,1,1
FileEncoding, UTF-8-RAW



;$$\    $$\  $$$$$$\  $$$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$$$\  $$$$$$\  
;$$ |   $$ |$$  __$$\ $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$ |      $$  _____|$$  __$$\ 
;$$ |   $$ |$$ /  $$ |$$ |  $$ |  $$ |  $$ /  $$ |$$ |  $$ |$$ |      $$ |      $$ /  \__|
;\$$\  $$  |$$$$$$$$ |$$$$$$$  |  $$ |  $$$$$$$$ |$$$$$$$\ |$$ |      $$$$$\    \$$$$$$\  
; \$$\$$  / $$  __$$ |$$  __$$<   $$ |  $$  __$$ |$$  __$$\ $$ |      $$  __|    \____$$\ 
;  \$$$  /  $$ |  $$ |$$ |  $$ |  $$ |  $$ |  $$ |$$ |  $$ |$$ |      $$ |      $$\   $$ |
;   \$  /   $$ |  $$ |$$ |  $$ |$$$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$\ $$$$$$$$\ \$$$$$$  |
;    \_/    \__|  \__|\__|  \__|\______|\__|  \__|\_______/ \________|\________| \______/ 


global imageDir := A_ScriptDir . "\"
global IniFile := A_ScriptDir . "\Thumber.ini"
global SEC_Help := "Help"
global KEY_LoadCnt := "LoadCnt"
global LmouseState=0
global RmouseState=0
global MmouseState=0

;****************************************************************
; 10진수 -> 2진수로 변경
;****************************************************************
DecimalToBinary(decimal)
{
    if (decimal = 0)
        return "0"
    
    binary := ""
    while (decimal > 0)
    {
        binary := Mod(decimal, 2) . binary
        decimal := decimal // 2
    }
    return binary
}


;****************************************************************
; 프로그램 선택
;****************************************************************
global currentIndex := 0
SelectProgram(program)
{
    WinGet, activeId, ID, A  ; 현재 활성 창의 ID 가져오기
    IfWinExist, ahk_exe %program%
    {
        WinGet, id, List, ahk_exe %program%
        if (id > 0)
        {
            Loop, %id%
            {
                currentIndex := Mod(currentIndex, id) + 1
                WinActivate, % "ahk_id " id%currentIndex%
                WinGetActiveTitle, title
                if (WinActive("ahk_id " id%currentIndex%) and id%currentIndex% != activeId)
                    break
            }
        }
    }
    else
    {
        Run, %program%
        currentIndex := 1
    }
}



;****************************************************************
; 대체키맵 모디적용
;****************************************************************
ReKey(input_key) {
    modifiers := ""	

	if (GetKeyState("Shift", "P")) {
        modifiers .= "+"
    }
    if (GetKeyState("Ctrl", "P")) {
        modifiers .= "^"
    }
    if (GetKeyState("Alt", "P")) {
        modifiers .= "!"
    }
    if (GetKeyState("LWin", "P") or GetKeyState("RWin", "P")) {
        modifiers .= "#"
    }

    Send %modifiers%%input_key%
    Return
}

;****************************************************************
; 한글일때 1리턴
;****************************************************************
IME_GET(WinTitle="")
{
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

;****************************************************************
; 현재프로그램 종료하고 다른프로그램 실행 
;****************************************************************
CHANGE_PROGRAM(exeName)
{	
	SetWorkingDir, %A_ScriptDir%	
	Run, %A_ScriptDir%\%exeName%
	ExitApp
}

Gui, Add, Picture, vHelpImage , %imagePath%

;****************************************************************
; 매뉴얼 GUI  
;****************************************************************
; --- 이미지 파일이 있는지 먼저 확인 ---
; GUI 정의
showHelp(level)
{
	global imageDir
	imagePath := imageDir . "ThumberBasic_lv" . level . ".png"

	; MsgBox, , , %imagePath%

	Gui +AlwaysOnTop +ToolWindow -Caption			
	
    ; 이미 GUI가 초기화되지 않았다면 초기화
    if (!GuiHasInit)
	{
		; Gui, Add, Picture, vHelpImage w600 h400, %imagePath%
		; Gui, Add, Picture, vHelpImage , %imagePath%
		GuiHasInit := true
	}
	else
	{		
		GuiControl, , vHelpImage, %imagePath%
	}
	; Gui, Add, Picture, , %imagePath%
	y := 640
	x := 20
	xpad := 100
	; 버튼 추가 (위치와 크기 조정 가능)
	; 게임모드

	if (!ButtonHasInit)
	{
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton1, Button1
	x += %xpad%
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton2, Button2
	x += %xpad%
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton3, Button3
	x += %xpad%
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton4, Button4
	x += %xpad%
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton5, Button5
	x += %xpad%
	Gui, Add, Button, x%x%+%xpad% y%y% w80 h80, gButton6, Button6	
	x += %xpad%
	}

	Gui, Show, , 
	WinSet, Transparent, 80, CenteredImage
}

; 각 버튼에 대한 핸들러
;시작프로그램에 등록
;16진수계산기..?
;메모장?
;뭐할라했지..?
Button1:  
return

Button2:
	Gui, Submit, NoHide  ; GUI 상태를 스크립트 변수로 반영
	MsgBox, chkbox: %MyCheckBox1%
return

Button3:
    MsgBox, Button 3 Clicked
return

Button4:
    MsgBox, Button 4 Clicked
return

Button5:
    MsgBox, Button 5 Clicked
return

Button6:
    MsgBox, Button 6 Clicked
return

;****************************************************************
; 설정파일
;****************************************************************
LoadIni(sec, key) {
    value := ""
    if (sec = "" || key = "") {
		return 0
	}
    IniRead, value, %IniFile%, %sec%, %key%, 0  ; 기본값 0 설정    
    if value is integer
        return value
    else
        return 0
}

SaveIni(sec, key, value) {
	; IniFile := A_ScriptDir . "\Thumber.ini"
    if (sec = "" || key = "") {        
        return false
    }    
    IniWrite, %value%, %IniFile%, %sec%, %key%
    return true
}

IncreaseHelpCnt()
{
	global SEC_Help, KEY_LoadCnt
	val := LoadIni(SEC_Help, KEY_LoadCnt)
	val++
	SaveIni(SEC_Help, KEY_LoadCnt, val)
	val--
	return val
}


; $$$$$$\ $$\     $$\  $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\      $$\ 
;$$  __$$\\$$\   $$  |$$  __$$\\__$$  __|$$  _____|$$$\    $$$ |
;$$ /  \__|\$$\ $$  / $$ /  \__|  $$ |   $$ |      $$$$\  $$$$ |
;\$$$$$$\   \$$$$  /  \$$$$$$\    $$ |   $$$$$\    $$\$$\$$ $$ |
; \____$$\   \$$  /    \____$$\   $$ |   $$  __|   $$ \$$$  $$ |
;$$\   $$ |   $$ |    $$\   $$ |  $$ |   $$ |      $$ |\$  /$$ |
;\$$$$$$  |   $$ |    \$$$$$$  |  $$ |   $$$$$$$$\ $$ | \_/ $$ |
; \______/    \__|     \______/   \__|   \________|\__|     \__|
                                                               
;****************************************************************
; 일시정지, 재시작
;****************************************************************
<+>+down::
	CHANGE_PROGRAM("Thumber_Off.exe")
	Return

<+>+up::
    Return

<+>+right::

appskey & esc::
    if A_IsAdmin
        Run, %A_ScriptFullPath%
    else
        Run *RunAs %A_ScriptFullPath%
    ExitApp
	Return


F15 Up::
	Gui, Hide
	if counter >= 0 ; setTimer already started, so we log the keypress instead
	{
		counter++
		Return
	}
	counter = 0 ; Start setTimer and set the number of logged keypresses to 0
	setTimer,appsFunc, 400
	Return

appsFunc:
	setTimer,appsFunc,off
	if counter = 0 ; The key is pressed once
	{		
		;TrayTip ,testTitle, once,1,1
	}
	if counter = 1 ; The key is pressed twice
	{		
		Send,{appskey}
		;TrayTip ,testTitle, twice,1,1
	}
	if counter = 2 ; The key is pressed thrice
	{
		helpCnt := IncreaseHelpCnt()		
		
		if helpCnt <4
		{
			showHelp(1)
		}
		else if helpCnt < 7
		{
			showHelp(2)
		}
		else if helpCnt < 10
		{
			showHelp(3)
		}
		else if helpCnt < 13
		{
			showHelp(4)
		}
		else if helpCnt < 16
		{
			showHelp(5)
		}
		else if helpCnt < 19
		{
			showHelp(6)
		}
		else if helpCnt < 22
		{
			showHelp(7)
		}
		else if helpCnt < 25
		{
			showHelp(8)
		}
		else
		{
			showHelp(9)
		}		
	}
	counter = -1
	Return

;****************************************************************
;영어/한글 
;****************************************************************

+F14::
;한글
isHan := IME_GET()
if(isHan = 0)
{
	Send, {vk15sc138}
}
Return

^F14::
;영어
isHan := IME_GET()
if(isHan = 1)
{
	Send, {vk15sc138}
}
Return

F14::
;한영
Send, {vk15sc138}
Return

;****************************************************************
;Space
;****************************************************************
F16::Space




; $$$$$$\  $$$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$\     $$\ 
;$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$ | $$  |$$  _____|\$$\   $$  |
;$$ /  $$ |$$ |  $$ |$$ |  $$ |$$ /  \__|$$ |$$  / $$ |       \$$\ $$  / 
;$$$$$$$$ |$$$$$$$  |$$$$$$$  |\$$$$$$\  $$$$$  /  $$$$$\      \$$$$  /  
;$$  __$$ |$$  ____/ $$  ____/  \____$$\ $$  $$<   $$  __|      \$$  /   
;$$ |  $$ |$$ |      $$ |      $$\   $$ |$$ |\$$\  $$ |          $$ |    
;$$ |  $$ |$$ |      $$ |      \$$$$$$  |$$ | \$$\ $$$$$$$$\     $$ |    
;\__|  \__|\__|      \__|       \______/ \__|  \__|\________|    \__|    

;****************************************************************
;F15Tab :: AltTab
;****************************************************************
F15 & tab::AltTab
	Return

;****************************************************************
;		L CLICK / R CLICK / M CLICK
;****************************************************************
F15 & r::
	if(LmouseState==0)
	mouseClick,left,,,1,,D,
	LmouseState=1
	Return

F15 & r up::
	MouseClick,left,,,1,,U,
	LmouseState=0
	Return

F15 & t::
	if(RmouseState==0)
	mouseClick,right,,,1,,D,
	RmouseState=1
	Return

F15 & t up::
	MouseClick,right,,,1,,U,
	RmouseState=0
	Return

F15 & g::
	if(RmouseState==0)
	mouseClick,middle,,,1,,D,
	RmouseState=1
	Return

F15 & g up::
	MouseClick,middle,,,1,,U,
	RmouseState=0
	Return


;****************************************************************
;		ESC
;****************************************************************
F15 & q::
	ReKey("{Esc}")
	Return

;****************************************************************
; 프로그램 선택
;****************************************************************
F15 & F1::
	SelectProgram("Code.exe")
	Return

F15 & F2::
	SelectProgram("eclipse.exe")
	Return

F15 & F3::
	SelectProgram("notepad++.exe")
	Return

F15 & F4::
	;SelectProgram("Code.exe")
	Return


;****************************************************************
;		SPACE
;****************************************************************
F15 & w::
	Rekey("{Space}")	
	Return

;****************************************************************
;		WORD
;****************************************************************
F15 & e:: 
	SendInput {Ctrl Down}{Left}{Shift Down}
	Sleep, 4
	SendInput {Right}{Shift Up}{Ctrl Up}
	Return

;****************************************************************
;		LINE
;****************************************************************
F15 & a::
	Send, {Home}
	Send, {Shift Down}
	Sleep, 4
	Send, {End}	
	Send, {Shift Up}
	Return

;****************************************************************
;		BACKSPACE
;****************************************************************
F15 & s::	
	Rekey("{BackSpace}")
	Return

;****************************************************************
;		ENTER
;****************************************************************
F15 & d::	
	Rekey("{Enter}")
	Return

;****************************************************************
;		DELETE
;****************************************************************
F15 & f:: 	
	Rekey("{Delete}")
	Return

;****************************************************************
;		Date
;****************************************************************
F15 & ,:: 
	FormatTime, CurrentDateTime,, yyyyMMdd
	SendInput %CurrentDateTime%
	Return

;****************************************************************
;		UNDO / CUT / COPY / PASTE
;****************************************************************
F15 & z::
	SendInput {ctrl down}z{ctrl up}
	Return

F15 & x::
	SendInput {ctrl down}x{ctrl up}
	Return

F15 & c::
	SendInput {ctrl down}c{ctrl up}	
	Return

F15 & v::
	SendInput {ctrl down}v{ctrl up}
	Return   

;****************************************************************
; 			UP / DOWN / LEFT / RIGHT
;****************************************************************
F15 & u::
	Rekey("{Up}")
	Return

F15 & j::
	Rekey("{Down}")
	Return

F15 & h::
	Rekey("{Left}")
	Return

F15 & k::
	Rekey("{Right}")
	Return

;****************************************************************
;		PAGE UP/ PAGE DOWN
;****************************************************************
F15 & o:: 
	Rekey("{PgUp}")	
	Return

F15 & l:: 
	Rekey("{PgDn}")	
	Return

;****************************************************************
;			HOME / END
;****************************************************************
F15 & y::
	Rekey("{Home}")	
	Return

F15 & i::
	Rekey("{End}")	
	Return

;****************************************************************
;			WINDOW CONTROL
;****************************************************************
F15 & b::ShiftAltTab
	Return

F15 & n::AltTab
	Return

F15 & m::
	GetKeyState, stateLctrl, Lctrl
	GetKeyState, stateShift, Shift
	WinGetTitle,title,A 
	WinGet,status,MinMax,%title% 
	if stateLctrl = D
	{
		WinMinimize,%title% 
		Return 
	}	
	if stateShift = D
	{
		SendInput {Lwin Down}{right}{Lwin Up}
		
		Return
	}
	if status=0 
	{ 
		WinMaximize,%title% 
		Return 
	} 
	if status=1 
	{ 
		WinRestore,%title% 
		Return 
	} 
	Return

F15 & p:: Send, !{F4}
	Return



;$$$$$$$$\ $$\   $$\ $$$$$$$$\ $$$$$$$$\ $$$$$$$\        
;$$  _____|$$$\  $$ |\__$$  __|$$  _____|$$  __$$\       
;$$ |      $$$$\ $$ |   $$ |   $$ |      $$ |  $$ |      
;$$$$$\    $$ $$\$$ |   $$ |   $$$$$\    $$$$$$$  |      
;$$  __|   $$ \$$$$ |   $$ |   $$  __|   $$  __$$<       
;$$ |      $$ |\$$$ |   $$ |   $$ |      $$ |  $$ |      
;$$$$$$$$\ $$ | \$$ |   $$ |   $$$$$$$$\ $$ |  $$ |      
;\________|\__|  \__|   \__|   \________|\__|  \__|      

;****************************************************************
;		Enter
;****************************************************************
Enter Up::
	sendInput {Enter}
	Return
+Enter::
	SendInput +{Enter}
	Return
^Enter::
	SendInput ^{Enter}
	Return
!Enter::
	SendInput !{Enter}
	Return
#Enter::
	SendInput #{Enter}
	Return

;****************************************************************
;tab		 	+tab ?왜만들었지
;****************************************************************
;Enter & Tab::SendInput +{tab}
;Return

;   + - * / =    _ , . ;  :     ' " ?
;****************************************************************
;q w e r	t	[ ] + - :
;****************************************************************
Enter & q::SendInput {+}
Return
Enter & w::SendInput {-}
Return
Enter & e::SendInput {=}
Return
Enter & r::SendInput {*}
Return
Enter & t::SendInput {/}
Return

;****************************************************************
;a s d f g	( ) = . _
;****************************************************************
Enter & a::SendInput {,}
Return
Enter & s::SendInput {.}
Return
Enter & d::SendInput {:}
Return
Enter & f::SendInput {`;}
Return
Enter & g::SendInput {_}
Return


;****************************************************************
;z x c v b 	< > ' " /
;****************************************************************
Enter & z::SendInput {?}
Return
Enter & x::SendInput {`!}
Return
Enter & c::SendInput {'}
Return
Enter & v::SendInput {"}
Return

;****************************************************************
;		괄호
;****************************************************************                                                                                                                         
Enter & u::SendInput <
Return
enter & i::SendInput >
Return
enter & k::SendInput [
Return
enter & l::SendInput ]
Return
enter & h::SendInput (
Return
enter & j::SendInput )
Return
enter & n::SendInput {`{}
Return
enter & m::SendInput {`}}
Return






; $$$$$$\  $$\    $$$$$$$$\                            
;$$  __$$\ $$ |   \__$$  __|                           	
;$$ /  $$ |$$ |      $$ |                              
;$$$$$$$$ |$$ |      $$ |                              
;$$  __$$ |$$ |      $$ |                              
;$$ |  $$ |$$ |      $$ |                              
;$$ |  $$ |$$$$$$$$\ $$ |                              
;\__|  \__|\________|\__|                                                                                   
;****************************************************************
;		1 ~ 12
;****************************************************************
\ & 1::SendInput {F1}
Return
\ & 2::SendInput {F2}
Return
\ & 3::SendInput {F3}
Return
\ & 4::SendInput {F4}
Return
\ & 5::SendInput {F5}
Return
\ & 6::SendInput {F6}
Return
\ & 7::SendInput {F7}
Return
\ & 8::SendInput {F8}
Return
\ & 9::SendInput {F9}
Return
\ & 0::SendInput {F10}
Return
\ & -::SendInput {F11}
Return
\ & =::SendInput {F12}
Return

;****************************************************************
;		Q ~ P
;****************************************************************                                                           
\ & q::SendInput {`!}
Return
\ & w::SendInput @
Return
\ & e::SendInput {`#}
Return
\ & r::SendInput `$
Return
\ & t::SendInput `%
Return
\ & [::SendInput {^}
Return
\ & ]::SendInput &
Return
\ & y::SendInput {*}
Return
\ & u::SendInput \
Return
\ & i::SendInput |
Return
\ & o::SendInput ``
Return
\ & p::SendInput ~
Return

KeyHistory
#InstallKeybdHook

;****************************************************************
;		A ~ L
;****************************************************************                                                           
\ & a::SendInput 1
Return
\ & s::SendInput 2
Return
\ & d::SendInput 3
Return
\ & f::SendInput 4
Return
\ & g::SendInput 5
Return
\ & F14::SendInput 6
Return
\ & h::SendInput 7
Return
\ & j::SendInput 8
Return
\ & k::SendInput 9
Return
\ & l::SendInput 0
Return









