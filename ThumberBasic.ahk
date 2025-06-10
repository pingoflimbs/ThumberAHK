#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetStoreCapsLockMode Off


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
; [{c:"#f0f0f0",t:"#a8a8a8"},"\n`\n\n\n~",{a:3},"\n\n\n\n\n!\n\n\n\n\n\n1","\n\n\n\n\n@\n\n\n\n\n\n2","\n\n\n\n\n#\n\n\n\n\n\n3","\n\n\n\n\n$\n\n\n\n\n\n4","\n\n\n\n\n%\n\n\n\n\n\n5","\n\n\n\n\n^\n\n\n\n\n\n6","\n\n\n\n\n&\n\n\n\n\n\n7","\n\n\n\n\n*\n\n\n\n\n\n8","\n\n\n\n\n(\n\n\n\n\n\n9","\n\n\n\n\n)\n\n\n\n\n\n0","\n\n\n\n\n_\n\n\n\n\n\n-","\n\n\n\n\n+\n\n\n\n\n\n=",{a:7,w:2},"\n\n\n\nBackspace"],
; [{w:1.5},"\n\n\n\nTab","\n\n\n\nQ","\n\n\n\nW","\n\n\n\nE","\n\n\n\nR","\n\n\n\nT","\n\n\n\nY",{c:"#D0D4C0",t:"#000000",f:4},"◁\n\n\n\nU",{c:"#B8C0A8",f:6},"▲\n\n\n\nI",{c:"#D0D4C0",f:4},"▷\n\n\n\nO","△\n\n\n\nP",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n[","\n\n\n\n]",{w:1.5},"\n\n\n\n\\"],
; [{c:"#ce4c31",t:"#000000",w:1.75},"Fn\n\n\n\nCaps Lock",{c:"#f0f0f0",t:"#a8a8a8"},"\n\n\n\nA","\n\n\n\nS","\n\n\n\nD",{c:"#C9B99B",t:"#000000",a:5,n:true},"Left\n\n\n\nF\n\nClick","Right\n\n\n\nG\n\nClick",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nH",{c:"#B8C0A8",t:"#000000",f:4,n:true},"◀\n\n\n\nJ",{f:6},"▼\n\n\n\nK",{f:4},"▶\n\n\n\nL",{c:"#D0D4C0"},"▽\n\n\n\n;",{c:"#f0f0f0",t:"#a8a8a8",f:3},"\n\n\n\n\"",{w:2.25},"\n\n\n\nEnter"],
; [{w:2.25},"\n\n\n\nShift",{c:"#E0D5C7",t:"#000000",a:5},"Ctrl\n\n\n\nZ\n\nZ","Ctrl\n\n\n\nX\n\nX","Ctrl\n\n\n\nC\n\nC","Ctrl\n\n\n\nV\n\nV",{c:"#f0f0f0",t:"#a8a8a8",a:7},"\n\n\n\nB","\n\n\n\nN","\n\n\n\nM",{a:4},"\n,\n\n\n<","\n.\n\n\n>","\n/\n\n\n?",{a:7,w:2.75},"\n\n\n\nShift"],
; [{w:1.25},"\n\n\n\nCtrl",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nAlt",{w:6.25},"",{w:1.25},"\n\n\n\nAlt",{w:1.25},"\n\n\n\nWin",{w:1.25},"\n\n\n\nMenu",{w:1.25},"\n\n\n\nCtrl"]


imagePath := A_ScriptDir . "\thumber_basic_help.png"
Gui, +AlwaysOnTop +ToolWindow -Caption +E0x10000  ; WS_EX_LAYERED
; Gui, Color, 990000
Gui, Add, Picture, vMyPic Center, %imagePath%
Gui, Show, AutoSize Hide

;****************************************************************
; FnKey
;****************************************************************
*Capslock::
return

*$CapsLock Up::
	FnCount++
	setTimer,FnAct, 300
Return

FnAct:	
	setTimer,FnAct,off
	Gui, Hide
	if(FnCount = 2)
	{
		SendInput {Capslock}
	}
	if(FnCount >= 3)
	{
		Gui, Show, NoActivate
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
Capslock & i::Up
	return
Capslock & j::Left
	return
Capslock & k::Down
	return
Capslock & l::Right
	return
Capslock & u::Home
	return
Capslock & o::End
	return
Capslock & p::PgUp
	return
Capslock & `;::PgDn
	return


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


;****************************************************************
;			WINDOW CONTROL
;****************************************************************
Capslock & b::ShiftAltTab
	Return

Capslock & n::AltTab
	Return	

