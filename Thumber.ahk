#NoEnv  ; 환경 변수를 자동으로 참조하지 않도록 설정합니다.성능 향상과 향후 AutoHotkey 버전과의 호환성을 위해 권장됩니다.변수 이름이 환경 변수와 충돌하는 것을 방지합니다.
SendMode Input  ; 키 입력을 보내는 방식을 'Input' 모드로 설정합니다.이 모드는 속도와 안정성 면에서 우수하여 새로운 스크립트에 권장됩니다.키 입력을 더 빠르고 정확하게 시뮬레이션할 수 있습니다.
SetWorkingDir %A_ScriptDir%  ; 스크립트의 작업 디렉토리를 스크립트 파일이 위치한 폴더로 설정합니다.%A_ScriptDir%는 현재 실행 중인 스크립트의 디렉토리를 나타내는 내장 변수입니다.이를 통해 스크립트가 상대 경로를 사용할 때 일관된 시작 지점을 가질 수 있습니다.
#MaxHotkeysPerInterval 10000; 지정된 시간 간격 동안 실행될 수 있는 최대 핫키 수를 설정합니다.기본값은 70이지만, 이를 10000으로 증가시켜 더 많은 핫키가 빠르게 연속해서 실행될 수 있도록 합니다.이는 매크로나 자동화 스크립트에서 유용할 수 있지만, 시스템 리소스를 많이 사용할 수 있으므로 주의가 필요합니다.
#Persistent
#SingleInstance, Force; Force를 추가하면, 스크립트가 이미 실행 중일 때 새로운 인스턴스가 시작되면 기존의 인스턴스를 자동으로 대체합니다.
DetectHiddenWindows, On
TrayTip ,Thumber On, [Ver.20250602],1,1
FileEncoding, UTF-8-RAW



;$$\    $$\  $$$$$$\  $$$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$$$\  $$$$$$\  
;$$ |   $$ |$$  __$$\ $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$ |      $$  _____|$$  __$$\ 
;$$ |   $$ |$$ /  $$ |$$ |  $$ |  $$ |  $$ /  $$ |$$ |  $$ |$$ |      $$ |      $$ /  \__|
;\$$\  $$  |$$$$$$$$ |$$$$$$$  |  $$ |  $$$$$$$$ |$$$$$$$\ |$$ |      $$$$$\    \$$$$$$\  
; \$$\$$  / $$  __$$ |$$  __$$<   $$ |  $$  __$$ |$$  __$$\ $$ |      $$  __|    \____$$\ 
;  \$$$  /  $$ |  $$ |$$ |  $$ |  $$ |  $$ |  $$ |$$ |  $$ |$$ |      $$ |      $$\   $$ |
;   \$  /   $$ |  $$ |$$ |  $$ |$$$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$\ $$$$$$$$\ \$$$$$$  |
;    \_/    \__|  \__|\__|  \__|\______|\__|  \__|\_______/ \________|\________| \______/ 




;****************************************************************
; 설정파일
;****************************************************************
IniFile := "ThumberSettings.ini"
IniSection := "Stats"
IniKey := "Count"

; 1. 저장된 값 불러오기 (없으면 0으로 초기화)
IniRead, press_count, %IniFile%, %IniSection%, %IniKey%, 0

; 2. F1 키 누르면 press_count 증가
F1::
    press_count++
    ToolTip You pressed F1 %press_count% times
    ; 저장
    IniWrite, %press_count%, %IniFile%, %IniSection%, %IniKey%
    return

; 3. 종료 시 저장 (예외적으로 안전하게)
OnExit("SaveCount")

SaveCount() {
    global press_count, IniFile, IniSection, IniKey
    IniWrite, %press_count%, %IniFile%, %IniSection%, %IniKey%
}




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
; 마우스 
;****************************************************************
LmouseState=0
RmouseState=0
MmouseState=0

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
; HELP GUI
;****************************************************************
;	Esc F1  F2  F3  F4  F5  F6  F7  F8  F8  F10 F11 F12 Del
; 	Win 1   2   3   4   5   6   7   8   9   0   _   =   Bsp
;	Alt  Q   W   E   R   T   [   ]   Y   U   I   O   P  Tab
;	Ctrl  A   S   D   F   G  F`13 F`14 H   J   K   L   Enter
;	LShift  Z   X   C   V   B   .   ,   N   M   /    RShift
;	Cps ` Fn     ===========F`15=======F`16 한자    방향키

; Gui, +AlwaysOnTop -Caption +ToolWindow
; Gui, Color, 333333
; Gui, Font, s8 c

; keys := []
; keys.Push(["esc","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","del"])
; keys.Push(["``","1","2","3","4","5","6","7","8","9","0","-","=","bksp"])
; keys.Push(["tab","Q","W","E","R","T","Y","U","I","O","P","[","]","\"])
; keys.Push(["cplk","A","S","D","F","G","H","J","K","L",";","'","Enter"])
; keys.Push(["lshift","Z","X","C","V","B","N","M",",",".","/","rshift"])
; keys.Push(["ctrl","win","alt","space","alt","ctrl"])

; size := 30
; y := 5
; for i, row in keys {	
; 	x := 5
;     for j, key in row 
; 	{
; 		if(i=1){
; 			h:= 0.5 * size
; 			w:= 1 * size
; 		}
;         else if (key = "ctrl" or key = "alt" or key = "\")
; 		{
; 			h:= 1 * size
; 			w:= 1.25 * size
; 		}
; 		else if (key = "tab")
; 		{
; 			h:= 1 * size
; 			w:= 1.5 * size
; 		}
;         else if (key = "cplk" or key = "bksp")
; 		{
; 			h:= 1 * size
; 			w:= 1.75 * size
; 		}
; 		else if (key = "lshift" or key = "enter")
; 		{
; 			h:= 1 * size
; 			w:= 2.25 * size
; 		}
; 		else if (key = "rshift")
; 		{
; 			h:= 1 * size
; 			w:= 2.75 * size
; 		}
; 		else if (key = "space")
; 		{
; 			h:= 1 * size
; 			w:= 7.5 * size
; 		}
;         else
; 		{
; 			h:= 1 * size
; 			w:= 1 * size
; 		}
            
; 		Gui, Add, Button, x%x% y%y% w%w% h%h%, %key%        
; 		x := w + x + 5
;     }
;     y := size + y + 5
; }

; Gui, +LastFound
; WinSet, Transparent, 100




;****************************************************************
; 매뉴얼 GUI  
;****************************************************************

imagePath := A_ScriptDir . "\thumber_help.png"
Gui, +AlwaysOnTop +ToolWindow -Caption +E0x00001  ; WS_EX_LAYERED
; Gui, Color, 990000
Gui, Add, Picture, vMyPic Center, %imagePath%
Gui, Show, AutoSize Hide


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
<+>+up::
	;CHANGE_PROGRAM("ThumberOff.ahk")
	CHANGE_PROGRAM("ThumberOff.exe")
	Return

<+>+down::
    Return

<+>+right::
appskey & esc::
    if A_IsAdmin
        Run, %A_ScriptFullPath%
    else
        Run *RunAs %A_ScriptFullPath%    
    ExitApp
	Return

;****************************************************************
;F15 기본세팅
;****************************************************************
helpManual()
{
	GetKeyState, stateF15, F15
	;TrayTip ,testTitle, %stateF15%,1,1
	if(stateF15 = 1)
	{
		Gui, Show, NoActivate
		Return
	}
	Return
}

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
		Gui, Show, NoActivate
		TrayTip ,testTitle, triple,1,1
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
F15 & .:: 
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









