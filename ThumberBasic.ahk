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

Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Color, 333333
Gui, Font, s12

keys := []
keys.Push(["esc","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","del"])
keys.Push(["``","1","2","3","4","5","6","7","8","9","0","-","=","bksp"])
keys.Push(["tab","Q","W","E","R","T","Y","U","I","O","P","[","]","\"])
keys.Push(["cplk","A","S","D","F","G","H","J","K","L",";","'","Enter"])
keys.Push(["lshift","Z","X","C","V","B","N","M",",",".","/","rshift"])
keys.Push(["ctrl","win","alt","space","alt","ctrl"])

size := 8
y := 8
for i, row in keys {
	x := 8
    for j, key in row 
	{
		if(i=1)
		{
			if(key = "esc")
			{
				h:= 4 * size
				w:= 11 * size
			}
			else if(key = "del")
			{
				h:= 4 * size
				w:= 11 * size
			}
			else
			{
				h:= 4 * size
				w:= 8 * size
			}			
		}
        else if (key = "ctrl" or key = "alt" or key = "\")
		{
			h:= 8 * size
			w:= 10 * size
		}
		else if (key = "tab")
		{
			h:= 8 * size
			w:= 12 * size
		}
        else if (key = "cplk" or key = "bksp")
		{
			h:= 8 * size
			w:= 14 * size		
		}
		else if (key = "lshift")
		{
			h:= 8 * size
			w:= 18 * size	
		}
		else if (key = "enter")
		{
			h:= 8 * size
			w:= (18 * size) - (12)
		}
		else if (key = "rshift")
		{
			h:= 8 * size
			w:= (22 * size) - (8)
		}
		else if (key = "space")
		{
			h:= 8 * size
			w:= 56 * size
		}
        else
		{
			h:= 8 * size
			w:= 8 * size
		}
        		
		c := 0
		if(key == "j" or key = "k"  or key = "l"  or key = "i")
		{
			c := 1
		}
		if(key == "u" or key = "o")
		{
			c := 2
		}
		if(key == "u" or key = "o")
		{
			c := 3
		}		

		Gui, Add, Button, x%x% y%y% w%w% h%h%, %key%
	
		
		x := w + x + 4
    }
    y := (size *8) + y + 4
}

Gui, +LastFound
WinSet, Transparent, 200


setButtonColor(hwnd, color) 
{
    static init := OnMessage(0x0133, "WM_CTLCOLORBTN")
    return DllCall("SendMessage", "Ptr", hwnd, "UInt", 0x172, "Ptr", 0, "Ptr", color)
}

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
Capslock & j::Left
	return
Capslock & k::Down
	return
Capslock & i::Up
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

