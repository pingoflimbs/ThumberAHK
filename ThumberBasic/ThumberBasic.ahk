#NoEnv  ; 환경 변수를 자동으로 참조하지 않도록 설정합니다.성능 향상과 향후 AutoHotkey 버전과의 호환성을 위해 권장됩니다.변수 이름이 환경 변수와 충돌하는 것을 방지합니다.
SendMode Input  ; 키 입력을 보내는 방식을 'Input' 모드로 설정합니다.이 모드는 속도와 안정성 면에서 우수하여 새로운 스크립트에 권장됩니다.키 입력을 더 빠르고 정확하게 시뮬레이션할 수 있습니다.
SetWorkingDir %A_ScriptDir%  ; 스크립트의 작업 디렉토리를 스크립트 파일이 위치한 폴더로 설정합니다.%A_ScriptDir%는 현재 실행 중인 스크립트의 디렉토리를 나타내는 내장 변수입니다.이를 통해 스크립트가 상대 경로를 사용할 때 일관된 시작 지점을 가질 수 있습니다.
#MaxHotkeysPerInterval 10000; 지정된 시간 간격 동안 실행될 수 있는 최대 핫키 수를 설정합니다.기본값은 70이지만, 이를 10000으로 증가시켜 더 많은 핫키가 빠르게 연속해서 실행될 수 있도록 합니다.이는 매크로나 자동화 스크립트에서 유용할 수 있지만, 시스템 리소스를 많이 사용할 수 있으므로 주의가 필요합니다.
#Persistent
#SingleInstance, Force; Force를 추가하면, 스크립트가 이미 실행 중일 때 새로운 인스턴스가 시작되면 기존의 인스턴스를 자동으로 대체합니다.
DetectHiddenWindows, On
TrayTip ,ThumberBasic On, [Ver.20250611],1,1
FileEncoding, UTF-8-RAW

SetStoreCapsLockMode Off

;$$\    $$\  $$$$$$\  $$$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$$$\  $$$$$$\  
;$$ |   $$ |$$  __$$\ $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$ |      $$  _____|$$  __$$\ 
;$$ |   $$ |$$ /  $$ |$$ |  $$ |  $$ |  $$ /  $$ |$$ |  $$ |$$ |      $$ |      $$ /  \__|
;\$$\  $$  |$$$$$$$$ |$$$$$$$  |  $$ |  $$$$$$$$ |$$$$$$$\ |$$ |      $$$$$\    \$$$$$$\  
; \$$\$$  / $$  __$$ |$$  __$$<   $$ |  $$  __$$ |$$  __$$\ $$ |      $$  __|    \____$$\ 
;  \$$$  /  $$ |  $$ |$$ |  $$ |  $$ |  $$ |  $$ |$$ |  $$ |$$ |      $$ |      $$\   $$ |
;   \$  /   $$ |  $$ |$$ |  $$ |$$$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$\ $$$$$$$$\ \$$$$$$  |
;    \_/    \__|  \__|\__|  \__|\______|\__|  \__|\_______/ \________|\________| \______/ 


global imagePath := A_ScriptDir . "\ThumberBasic.png"
global IniFile := A_ScriptDir . "\ThumberBasic.ini"
global SEC_Help := "Help"
global KEY_LoadCnt := "LoadCnt"
global LmouseState=0
global RmouseState=0
global MmouseState=0



;****************************************************************
; 현재프로그램 종료하고 다른프로그램 실행 
;****************************************************************
CHANGE_PROGRAM(exeName)
{	
	SetWorkingDir, %A_ScriptDir%	
	Run, %A_ScriptDir%\%exeName%
	ExitApp
}

;****************************************************************
; 매뉴얼 GUI  
;****************************************************************
; --- 이미지 파일이 있는지 먼저 확인 ---
; GUI 정의
showHelp(level)
{
	Gui +AlwaysOnTop +ToolWindow -Caption
	Gui, Add, Picture, , %imagePath%
	Gui, Show, , CenteredImage
	WinSet, Transparent, 180, CenteredImage
}

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
	val := LoadIni(SEC_Help, KEY_LoadCnt)
	val++
	SaveIni(SEC_Help, KEY_LoadCnt, val)
	val--
	return val
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



; $$$$$$\ $$\     $$\  $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\      $$\ 
;$$  __$$\\$$\   $$  |$$  __$$\\__$$  __|$$  _____|$$$\    $$$ |
;$$ /  \__|\$$\ $$  / $$ /  \__|  $$ |   $$ |      $$$$\  $$$$ |
;\$$$$$$\   \$$$$  /  \$$$$$$\    $$ |   $$$$$\    $$\$$\$$ $$ |
; \____$$\   \$$  /    \____$$\   $$ |   $$  __|   $$ \$$$  $$ |
;$$\   $$ |   $$ |    $$\   $$ |  $$ |   $$ |      $$ |\$  /$$ |
;\$$$$$$  |   $$ |    \$$$$$$  |  $$ |   $$$$$$$$\ $$ | \_/ $$ |
; \______/    \__|     \______/   \__|   \________|\__|     \__|

;****************************************************************
; HELP GUI
;****************************************************************
;	Esc F1  F2  F3  F4  F5  F6  F7  F8  F8  F10 F11 F12 Del
; 	Win 1   2   3   4   5   6   7   8   9   0   _   =   Bsp
;	Alt  Q   W   E   R   T   [   ]   Y   U   I   O   P  Tab
;	Ctrl  A   S   D   F   G  F`13 F`14 H   J   K   L   Enter
;	LShift  Z   X   C   V   B   .   ,   N   M   /    RShift
;	Cps ` Fn     ===========F`15=======F`16 한자    방향키

;****************************************************************
; 매뉴얼 GUI  
;****************************************************************
;LEVEL 1
; [{c:"#f0f0f0",t:"#a8a8a8"},"\n`\n\n\n~",{a:3},"\n\n\n\n\n!\n\n\n\n\n\n1","\n\n\n\n\n@\n\n\n\n\n\n2","\n\n\n\n\n#\n\n\n\n\n\n3","\n\n\n\n\n$\n\n\n\n\n\n4","\n\n\n\n\n%\n\n\n\n\n\n5","\n\n\n\n\n^\n\n\n\n\n\n6","\n\n\n\n\n&\n\n\n\n\n\n7","\n\n\n\n\n*\n\n\n\n\n\n8","\n\n\n\n\n(\n\n\n\n\n\n9","\n\n\n\n\n)\n\n\n\n\n\n0","\n\n\n\n\n_\n\n\n\n\n\n-","\n\n\n\n\n+\n\n\n\n\n\n=",{a:7,w:2},"\n\n\n\nBackspace"],
; [{w:1.5},"\n\n\n\nTab","\n\n\n\nQ","\n\n\n\nW","\n\n\n\nE","\n\n\n\nR","\n\n\n\nT","\n\n\n\nY",{c:"#D0D4C0",t:"#000000",f:4},"◁\n\n\n\nU",{c:"#B8C0A8",f:6},"▲\n\n\n\nI",{c:"#D0D4C0",f:4},"▷\n\n\n\nO","△\n\n\n\nP",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n[","\n\n\n\n]",{w:1.5},"\n\n\n\n\\"],
; [{c:"#ce4c31",t:"#000000",w:1.75},"Fn\n\n\n\nCaps Lock",{c:"#f0f0f0",t:"#a8a8a8"},"\n\n\n\nA","\n\n\n\nS","\n\n\n\nD",{c:"#C9B99B",t:"#000000",a:5,n:true},"Left\n\n\n\nF\n\nClick","Right\n\n\n\nG\n\nClick",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nH",{c:"#B8C0A8",t:"#000000",f:4,n:true},"◀\n\n\n\nJ",{f:6},"▼\n\n\n\nK",{f:4},"▶\n\n\n\nL",{c:"#D0D4C0"},"▽\n\n\n\n;",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n\"",{w:2.25},"\n\n\n\nEnter"],
; [{w:2.25},"\n\n\n\nShift",{c:"#E0D5C7",t:"#000000",a:5},"Ctrl\n\n\n\nZ\n\nZ","Ctrl\n\n\n\nX\n\nX","Ctrl\n\n\n\nC\n\nC","Ctrl\n\n\n\nV\n\nV",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nB","\n\n\n\nN","\n\n\n\nM",{a:4},"\n,\n\n\n<","\n.\n\n\n>","\n/\n\n\n?",{a:7,w:2.75},"\n\n\n\nShift"],
; [{w:1.25},"\n\n\n\nCtrl",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nAlt",{w:6.25},"",{w:1.25},"\n\n\n\nAlt",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nMenu",{w:1.25},"\n\n\n\nCtrl"]

; [{c:"#f0f0f0",t:"#a8a8a8"},"\n`\n\n\n~",{a:3},"\n\n\n\n\n!\n\n\n\n\n\n1","\n\n\n\n\n@\n\n\n\n\n\n2","\n\n\n\n\n#\n\n\n\n\n\n3","\n\n\n\n\n$\n\n\n\n\n\n4","\n\n\n\n\n%\n\n\n\n\n\n5","\n\n\n\n\n^\n\n\n\n\n\n6","\n\n\n\n\n&\n\n\n\n\n\n7","\n\n\n\n\n*\n\n\n\n\n\n8","\n\n\n\n\n(\n\n\n\n\n\n9","\n\n\n\n\n)\n\n\n\n\n\n0","\n\n\n\n\n_\n\n\n\n\n\n-","\n\n\n\n\n+\n\n\n\n\n\n=",{a:7,w:2},"\n\n\n\nBackspace"],
; [{w:1.5},"\n\n\n\nTab","\n\n\n\nQ","\n\n\n\nW","\n\n\n\nE","\n\n\n\nR","\n\n\n\nT","\n\n\n\nY",{c:"#D0D4C0",t:"#000000",f:4},"◁\n\n\n\nU",{c:"#B8C0A8",f:6},"▲\n\n\n\nI",{c:"#D0D4C0",f:4},"▷\n\n\n\nO","△\n\n\n\nP",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n[","\n\n\n\n]",{w:1.5},"\n\n\n\n\\"],
; [{c:"#ce4c31",t:"#000000",w:1.75},"Fn\n\n\n\nCaps Lock",{c:"#f0f0f0",t:"#a8a8a8"},"\n\n\n\nA","\n\n\n\nS","\n\n\n\nD",{c:"#C9B99B",t:"#000000",a:5,n:true},"Left\n\n\n\nF\n\nClick","Right\n\n\n\nG\n\nClick",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nH",{c:"#B8C0A8",t:"#000000",f:4,n:true},"◀\n\n\n\nJ",{f:6},"▼\n\n\n\nK",{f:4},"▶\n\n\n\nL",{c:"#D0D4C0"},"▽\n\n\n\n;",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n\"",{w:2.25},"\n\n\n\nEnter"],
; [{w:2.25},"\n\n\n\nShift",{c:"#E0D5C7",t:"#000000",a:5},"Ctrl\n\n\n\nZ\n\nZ","Ctrl\n\n\n\nX\n\nX","Ctrl\n\n\n\nC\n\nC","Ctrl\n\n\n\nV\n\nV",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nB","\n\n\n\nN","\n\n\n\nM",{a:4},"\n,\n\n\n<","\n.\n\n\n>","\n/\n\n\n?",{a:7,w:2.75},"\n\n\n\nShift"],
; [{w:1.25},"\n\n\n\nCtrl",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nAlt",{w:6.25},"",{w:1.25},"\n\n\n\nAlt",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nMenu",{w:1.25},"\n\n\n\nCtrl"]

;****************************************************************
; FnKey
;****************************************************************
*Capslock::
return

*$CapsLock Up::
	Gui, Hide
	FnCount++
	setTimer,FnAct, 350
Return

FnAct:	
	setTimer,FnAct,off	
	if(FnCount = 2)
	{
		SendInput {Capslock}
	}
	if(FnCount >= 3)
	{
		helpCnt := IncreaseHelpCnt()
		showHelp(helpCnt)
	}	
	FnCount = 0
Return


AddToStartupFolder()
{
    FileGetShortcut, %A_Startup%\%A_ScriptName%.lnk, existingTarget  ; 기존 바로가기 확인
    
    if (existingTarget = "")  ; 바로가기가 없으면 생성
    {
        FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk
        if (ErrorLevel)  ; 바로가기 생성 실패시
        {
            MsgBox, 시작프로그램 등록에 실패했습니다.
            return false
        }
        else  ; 성공시
        {
            MsgBox, 시작프로그램에 등록되었습니다.
            return true
        }
    }
    else
    {        
        return false
    }
}


<+>+down::
	CHANGE_PROGRAM("ThumberBasic_Off.exe")
	Return

<+>+up::
    Return


; $$$$$$\  $$$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$\     $$\ 
;$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$ | $$  |$$  _____|\$$\   $$  |
;$$ /  $$ |$$ |  $$ |$$ |  $$ |$$ /  \__|$$ |$$  / $$ |       \$$\ $$  / 
;$$$$$$$$ |$$$$$$$  |$$$$$$$  |\$$$$$$\  $$$$$  /  $$$$$\      \$$$$  /  
;$$  __$$ |$$  ____/ $$  ____/  \____$$\ $$  $$<   $$  __|      \$$  /   
;$$ |  $$ |$$ |      $$ |      $$\   $$ |$$ |\$$\  $$ |          $$ |    
;$$ |  $$ |$$ |      $$ |      \$$$$$$  |$$ | \$$\ $$$$$$$$\     $$ |    
;\__|  \__|\__|      \__|       \______/ \__|  \__|\________|    \__|    

#If GetKeyState("CapsLock", "P")
#If

;****************************************************************
; 			UP / DOWN / LEFT / RIGHT / PAGE UP/ PAGE DOWN / HOME / END
;****************************************************************
Capslock & i::
	Rekey("{Up}")
	return
Capslock & j::
	Rekey("{Left}")
	return
Capslock & k::
	Rekey("{Down}")
	return
Capslock & l::
	Rekey("{Right}")
	return

Capslock & u::
	ReKey("{Home}")
	return
Capslock & o::
	ReKey("{End}")
	return
Capslock & p::
	ReKey("{PgUp}")
	return
Capslock & `;::
	ReKey("{PgDn}")
	return


Capslock & [::
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



Capslock & ,::
	SendInput {ctrl down}{PgUp}{ctrl up}
	return

Capslock & .::
	SendInput {ctrl down}{PgDn}{ctrl up}
	return


;****************************************************************
;			WINDOW CONTROL
;****************************************************************
Capslock & n::ShiftAltTab
	Return

Capslock & m::AltTab
	Return


;****************************************************************
;		UNDO / CUT / COPY / PASTE
;****************************************************************
Capslock & z::SendInput {ctrl down}z{ctrl up}
	return
Capslock & x::SendInput {ctrl down}x{ctrl up}
	return
Capslock & c::SendInput {ctrl down}c{ctrl up}	
	return
Capslock & v::SendInput {ctrl down}v{ctrl up}
	return

;****************************************************************
; 			LEFT
;****************************************************************
Capslock & a::
	ReKey("{BackSpace}")
	return

Capslock & s::
	ReKey("{Esc}")
	return

Capslock & d::
	ReKey("{Delete}")
	return

Capslock & q:: ;word
	SendInput {Ctrl Down}{Left}{Shift Down}
	Sleep, 4
	SendInput {Right}{Shift Up}{Ctrl Up}
	return

Capslock & w:: ;line
	Send, {Home}
	Send, {Shift Down}
	Sleep, 4
	Send, {End}
	Send, {Shift Up}
	return

Capslock & e:: ;entire
	SendInput {ctrl down}a{ctrl up}
	return

Capslock & r:: ;뒤로가기
	ReKey("{XButton1}")
	return

Capslock & t:: ;앞으로가기
	ReKey("{XButton2}")
	return

Capslock & ]:: Send, !{F4}
	return

;****************************************************************
;		Date
;****************************************************************
Capslock & b:: 
	FormatTime, CurrentDateTime,, yyyyMMdd
	SendInput %CurrentDateTime%
	Return

;****************************************************************
;		L CLICK / R CLICK / M CLICK
;****************************************************************
Capslock & f::
	Click down left
	KeyWait, f
	Click up left
	return

Capslock & g::
	Click down right
	KeyWait, g 
	Click up right
	return

Capslock & 1::	
	SendInput, {LWin down}1{LWin up}
	return
Capslock & 2::	
	SendInput, {LWin down}2{LWin up}
	return
Capslock & 3::	
	SendInput, {LWin down}3{LWin up}
	return
Capslock & 4::	
	SendInput, {LWin down}4{LWin up}
	return
Capslock & 5::	
	SendInput, {LWin down}5{LWin up}
	return
Capslock & 6::	
	SendInput, {LWin down}6{LWin up}
	return
Capslock & 7::	
	SendInput, {LWin down}7{LWin up}
	return
Capslock & 8::	
	SendInput, {LWin down}8{LWin up}
	return
Capslock & 9::	
	SendInput, {LWin down}9{LWin up}
	return
Capslock & 0::	
	SendInput, {LWin down}0{LWin up}
	return
	


