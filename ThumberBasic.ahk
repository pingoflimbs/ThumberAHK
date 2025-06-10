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
; [{c:"#FFFFFF",t:"#808080",d:true},"~\n`",{d:true},"!\n1",{d:true},"@\n2",{d:true},"#\n3",{d:true},"$\n4",{d:true},"%\n5",{d:true},"^\n6",{d:true},"&\n7",{d:true},"*\n8",{d:true},"(\n9",{d:true},")\n0",{d:true},"_\n-",{d:true},"+\n=",{w:2,d:true},"Backspace"],
; [{w:1.5,d:true},"Tab",{d:true},"Q",{d:true},"W",{d:true},"E",{d:true},"R",{d:true},"T",{d:true},"Y",{a:7,f:4},"◁",{f:6},"▲",{f:4},"▷","△",{a:4,f:3,d:true},"{\n[",{d:true},"}\n]",{w:1.5,d:true},"|\n\\"],
; [{w:1.75},"Caps Lock",{d:true},"A",{d:true},"S",{d:true},"D",{d:true},"F",{d:true},"G",{d:true},"H",{a:7,f:4},"◀",{f:6},"▼",{f:4},"▶",{a:4},"\n;\n\n\n\n\n\n\n\n▽",{f:3,d:true},"\"\n'",{w:2.25,d:true},"Enter"],
; [{w:2.25,d:true},"Shift",{d:true},"Z",{d:true},"X",{d:true},"C",{d:true},"V",{d:true},"B",{d:true},"N",{d:true},"M",{d:true},"<\n,",{d:true},">\n.",{d:true},"?\n/",{w:2.75,d:true},"Shift"],
; [{w:1.25,d:true},"Ctrl",{w:1.25,d:true},"Win",{w:1.25,d:true},"Alt",{a:7,w:6.25,d:true},"",{a:4,w:1.25,d:true},"Alt",{w:1.25,d:true},"Win",{w:1.25,d:true},"Menu",{w:1.25,d:true},"Ctrl"]

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

