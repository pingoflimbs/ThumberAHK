;
;
;
;
;qwer op[]
;asdf kl;'
;zxcv m,./
;  
;갈데 없어지는 키들 : [],:?
;
;
;
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxHotkeysPerInterval 10000
;//마우스클릭 시프트 : ctrl vcxz




;SYSTEM
;APPSKEY
	;left
	;right
;ALT
	;asdfghjkl
;ENTER
	;left
	;right







;$$\    $$\  $$$$$$\  $$$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$$$\  $$$$$$\  
;$$ |   $$ |$$  __$$\ $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$ |      $$  _____|$$  __$$\ 
;$$ |   $$ |$$ /  $$ |$$ |  $$ |  $$ |  $$ /  $$ |$$ |  $$ |$$ |      $$ |      $$ /  \__|
;\$$\  $$  |$$$$$$$$ |$$$$$$$  |  $$ |  $$$$$$$$ |$$$$$$$\ |$$ |      $$$$$\    \$$$$$$\  
; \$$\$$  / $$  __$$ |$$  __$$<   $$ |  $$  __$$ |$$  __$$\ $$ |      $$  __|    \____$$\ 
;  \$$$  /  $$ |  $$ |$$ |  $$ |  $$ |  $$ |  $$ |$$ |  $$ |$$ |      $$ |      $$\   $$ |
;   \$  /   $$ |  $$ |$$ |  $$ |$$$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$\ $$$$$$$$\ \$$$$$$  |
;    \_/    \__|  \__|\__|  \__|\______|\__|  \__|\_______/ \________|\________| \______/ 
LmouseState=0
RmouseState=0
                                                                                         
                                                                                         












; $$$$$$\ $$\     $$\  $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\      $$\ 
;$$  __$$\\$$\   $$  |$$  __$$\\__$$  __|$$  _____|$$$\    $$$ |
;$$ /  \__|\$$\ $$  / $$ /  \__|  $$ |   $$ |      $$$$\  $$$$ |
;\$$$$$$\   \$$$$  /  \$$$$$$\    $$ |   $$$$$\    $$\$$\$$ $$ |
; \____$$\   \$$  /    \____$$\   $$ |   $$  __|   $$ \$$$  $$ |
;$$\   $$ |   $$ |    $$\   $$ |  $$ |   $$ |      $$ |\$  /$$ |
;\$$$$$$  |   $$ |    \$$$$$$  |  $$ |   $$$$$$$$\ $$ | \_/ $$ |
; \______/    \__|     \______/   \__|   \________|\__|     \__|
                                                               
            



;****************************************************************
; onoff
;****************************************************************
esc & down::
	Suspend, On
	TrayTip ,ChangKey,Turn Off,1,1
	return

esc & up::
	Suspend,Permit
	Suspend,Off
	TrayTip ,ChangKey,Turn On,1,1
	return



;***********************************************k*****************
;reload script
;****************************************************************
esc & End::
	TrayTip ,disable alt,is work,1,1
	Reload
	WinWait,ahk_class #32770,Error at line ,2
	return


+^!#esc::
+^!esc::
+^#esc::
+^esc::
+!#esc::
+!esc::
+#esc::
+esc::
^!#esc::
^!esc::
^#esc::
^esc::
!#esc::
!esc::
#esc::
esc::
	input_key = {Esc}
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return



;****************************************************************8
;한영 체크함수
;****************************************************************8
IME_CHECK(WinTitle) 
{ 
    WinGet,hWnd,ID,%WinTitle% 
    Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"") 
} 

Send_ImeControl(DefaultIMEWnd, wParam, lParam) 
{ 
    DetectSave := A_DetectHiddenWindows      
    DetectHiddenWindows,ON                          

    SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd% 
    if (DetectSave <> A_DetectHiddenWindows) 
        DetectHiddenWindows,%DetectSave% 
    return ErrorLevel 
} 

ImmGetDefaultIMEWnd(hWnd) 
{ 
    return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint) 
} 



;****************************************************************
;a /한영_(edit)-[appskey]
;****************************************************************

;english := IME_CHECK("A") 
;	hangul := IME_CHECK("han")
;	if %english% = 0 
;	{
;		TrayTip ,,Hangul,1,
;		Send, {vk15sc138}
;	} 
;	else if %hangul% = 0
;	{ 
;		
;		TrayTip ,,Eng,1,skjh
;		Send, {vk15sc138}
;	} 
;	return 


;****************************************************************
;appskey 기본세팅
;****************************************************************
appskey Up::
	if counter >= 0 ; setTimer already started, so we log the keypress instead
	{
		counter++
		return
	}
	counter = 0 ; Start setTimer and set the number of logged keypresses to 0
	setTimer,appsFunc, 400
	return

appsFunc:
	setTimer,appsFunc,off
	if counter = 0 ; The key is pressed once
	{
		;TrayTip ,testTitle, once,1,1
	}
	if counter = 1 ; The key is pressed twice
	{
		if GetKeyState("CapsLock", "T") = 1
		SetCapsLockState, AlwaysOff
else if GetKeyState("CapsLock", "T") = 0
		SetCapsLockState, AlwaysOn
		;TrayTip ,testTitle, twice,1,1
	}
	if counter = 2 ; The key is pressed thrice
	{
	}
	counter = -1
	return





;****************************************************************
;		Enter
;****************************************************************
Enter Up::sendInput {Enter}
	return
+Enter::SendInput +{Enter}
	return
^Enter::SendInput ^{Enter}
	return
!Enter::SendInput !{Enter}
	return
#Enter::SendInput #{Enter}
	return












































; $$$$$$\  $$$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$\     $$\ 
;$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$ | $$  |$$  _____|\$$\   $$  |
;$$ /  $$ |$$ |  $$ |$$ |  $$ |$$ /  \__|$$ |$$  / $$ |       \$$\ $$  / 
;$$$$$$$$ |$$$$$$$  |$$$$$$$  |\$$$$$$\  $$$$$  /  $$$$$\      \$$$$  /  
;$$  __$$ |$$  ____/ $$  ____/  \____$$\ $$  $$<   $$  __|      \$$  /   
;$$ |  $$ |$$ |      $$ |      $$\   $$ |$$ |\$$\  $$ |          $$ |    
;$$ |  $$ |$$ |      $$ |      \$$$$$$  |$$ | \$$\ $$$$$$$$\     $$ |    
;\__|  \__|\__|      \__|       \______/ \__|  \__|\________|    \__|    
;                $$\       $$$$$$$$\ $$$$$$$$\ $$$$$$$$\                 
;   $$\          $$ |      $$  _____|$$  _____|\__$$  __|                
;   $$ |         $$ |      $$ |      $$ |         $$ |                   
;$$$$$$$$\       $$ |      $$$$$\    $$$$$\       $$ |                   
;\__$$  __|      $$ |      $$  __|   $$  __|      $$ |                   
;   $$ |         $$ |      $$ |      $$ |         $$ |                   
;   \__|         $$$$$$$$\ $$$$$$$$\ $$ |         $$ |                   
;                \________|\________|\__|         \__|                   
                                




;****************************************************************
;		L CLICK / R CLLICK
;****************************************************************
appskey & f::
	if(LmouseState==0)
	mouseClick,left,,,1,,D,
	LmouseState=1
	return

appskey & f up::
	MouseClick,left,,,1,,U,
	LmouseState=0
	return

appskey & g::
	if(RmouseState==0)
	mouseClick,right,,,1,,D,
	RmouseState=1
	return

appskey & g up::
	MouseClick,right,,,1,,U,
	RmouseState=0
	return



;****************************************************************
;		ESC
;****************************************************************
appskey & w::
	input_key = {Esc}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return




;****************************************************************
;		WORD
;****************************************************************
appskey & r:: 
	SendInput {Ctrl Down}{Left}{Shift Down}
	Sleep, 1
	SendInput {Right}{Shift Up}{Ctrl Up}
	return



;****************************************************************
;		LINE
;****************************************************************
appskey & t::
	Send, {Home}
	Send, {Shift Down}
	Sleep, 1
	Send, {End}	
	Send, {Shift Up}
	return




;****************************************************************
;		CTRLBACKSPACE
;****************************************************************
appskey & q::
	input_key = {left}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send +^!#%input_key%
				;TrayTip, Title, shift ctrl alt win, 1, 1
			}	
			else
			{
				Send +^!%input_key%
				;TrayTip, Title, shift ctrl alt - , 1, 1
			}		
		}
		else
		{
			if state_win = D
			{
				Send +^#%input_key%
				;TrayTip, Title, shift ctrl - win, 1, 1
			}	
			else
			{
				Send +^%input_key%
				;TrayTip, Title, shift ctrl - -, 1, 1
			}
		}
	
	}
	else
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send ^!#%input_key%
				;TrayTip, Title, - ctrl alt win, 1, 1
			}	
			else
			{
				Send ^!%input_key%
				;TrayTip, Title,  - ctrl alt - , 1, 1
			}
		}
		else
		{
			if state_win = D
			{
				Send ^#%input_key%
				;TrayTip, Title, - ctrl - win, 1, 1
			}	
			else
			{
				Send ^%input_key%
				;TrayTip, Title, - ctrl - -, 1, 1
			}
		}
	}
	Return


;****************************************************************
;		CTRLBACKDELETE
;****************************************************************
appskey & e::
	input_key = {right}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send +^!#%input_key%
				;TrayTip, Title, shift ctrl alt win, 1, 1
			}	
			else
			{
				Send +^!%input_key%
				;TrayTip, Title, shift ctrl alt - , 1, 1
			}		
		}
		else
		{
			if state_win = D
			{
				Send +^#%input_key%
				;TrayTip, Title, shift ctrl - win, 1, 1
			}	
			else
			{
				Send +^%input_key%
				;TrayTip, Title, shift ctrl - -, 1, 1
			}
		}
	
	}
	else
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send ^!#%input_key%
				;TrayTip, Title, - ctrl alt win, 1, 1
			}	
			else
			{
				Send ^!%input_key%
				;TrayTip, Title,  - ctrl alt - , 1, 1
			}
		}
		else
		{
			if state_win = D
			{
				Send ^#%input_key%
				;TrayTip, Title, - ctrl - win, 1, 1
			}	
			else
			{
				Send ^%input_key%
				;TrayTip, Title, - ctrl - -, 1, 1
			}
		}
	}
	Return



;****************************************************************
;		BACKSPACE
;****************************************************************
appskey & a::
	input_key = {BackSpace}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return








;****************************************************************
;		ENTER
;****************************************************************
appskey & s::
	input_key = {Enter}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D	
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return


;****************************************************************
;		DELETE
;****************************************************************
appskey & d:: 
	input_key = {Delete}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return




;****************************************************************
;		Today
;****************************************************************
appskey & b:: 
	input_key = {Delete}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin
	FormatTime, CurrentDateTime,, yyyyMMdd
	SendInput %CurrentDateTime%
	Return





;****************************************************************
;		UNDO / CUT / COPY / PASTE
;****************************************************************
appskey & z::SendInput {ctrl down}z{ctrl up}
	return
appskey & x::SendInput {ctrl down}x{ctrl up}
	return
appskey & c::SendInput {ctrl down}c{ctrl up}
	return
appskey & v::SendInput {ctrl down}v{ctrl up}
	return



























; $$$$$$\  $$$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$\     $$\ 
;$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$ | $$  |$$  _____|\$$\   $$  |
;$$ /  $$ |$$ |  $$ |$$ |  $$ |$$ /  \__|$$ |$$  / $$ |       \$$\ $$  / 
;$$$$$$$$ |$$$$$$$  |$$$$$$$  |\$$$$$$\  $$$$$  /  $$$$$\      \$$$$  /  
;$$  __$$ |$$  ____/ $$  ____/  \____$$\ $$  $$<   $$  __|      \$$  /   
;$$ |  $$ |$$ |      $$ |      $$\   $$ |$$ |\$$\  $$ |          $$ |    
;$$ |  $$ |$$ |      $$ |      \$$$$$$  |$$ | \$$\ $$$$$$$$\     $$ |    
;\__|  \__|\__|      \__|       \______/ \__|  \__|\________|    \__|    
;                $$$$$$$\  $$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\         
;   $$\          $$  __$$\ \_$$  _|$$  __$$\ $$ |  $$ |\__$$  __|        
;   $$ |         $$ |  $$ |  $$ |  $$ /  \__|$$ |  $$ |   $$ |           
;$$$$$$$$\       $$$$$$$  |  $$ |  $$ |$$$$\ $$$$$$$$ |   $$ |           
;\__$$  __|      $$  __$$<   $$ |  $$ |\_$$ |$$  __$$ |   $$ |           
;   $$ |         $$ |  $$ |  $$ |  $$ |  $$ |$$ |  $$ |   $$ |           
;   \__|         $$ |  $$ |$$$$$$\ \$$$$$$  |$$ |  $$ |   $$ |           
;                \__|  \__|\______| \______/ \__|  \__|   \__|           




;****************************************************************
; 			UP / DOWN / LEFT / RIGHT
;****************************************************************

;****************************************************************
;		up
;****************************************************************

appskey & i::
	input_key = {Up}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return



;****************************************************************
;		down
;****************************************************************

appskey & k::
	input_key = {Down}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return




;****************************************************************
;		LEFT
;****************************************************************

appskey & j::
	input_key = {Left}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return


;****************************************************************
;		right
;****************************************************************

appskey & l::
	input_key = {Right}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return








;****************************************************************
;		PAGE UP/ PAGE DOWN
;****************************************************************
appskey & p:: 
	input_key = {PgUp}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return




appskey & `;:: 
	input_key = {PgDn}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return



	



;****************************************************************
;			HOME / END
;****************************************************************
appskey & u::
	input_key = {Home}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return



appskey & o::
	input_key = {End}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +^!#%input_key%
					;TrayTip, Title, shift ctrl alt win, 1, 1
				}	
				else
				{
					Send +^!%input_key%
					;TrayTip, Title, shift ctrl alt - , 1, 1
				}		
			}
			else
			{
				if state_win = D
				{
					Send +^#%input_key%
					;TrayTip, Title, shift ctrl - win, 1, 1
				}	
				else
				{
					Send +^%input_key%
					;TrayTip, Title, shift ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send +!#%input_key%
					;TrayTip, Title, shift - alt win, 1, 1
				}	
				else
				{
					Send +!%input_key%
					;TrayTip, Title, shift - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send +#%input_key%
					;TrayTip, Title, shift - - win, 1, 1
				}	
				else
				{
					Send +%input_key%
					;TrayTip, Title, shift - - -, 1, 1
				}
			}	
		}		
	}
	else
	{
		if state_ctl = D
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send ^!#%input_key%
					;TrayTip, Title, - ctrl alt win, 1, 1
				}	
				else
				{
					Send ^!%input_key%
					;TrayTip, Title,  - ctrl alt - , 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send ^#%input_key%
					;TrayTip, Title, - ctrl - win, 1, 1
				}	
				else
				{
					Send ^%input_key%
					;TrayTip, Title, - ctrl - -, 1, 1
				}
			}
		}	
		else ;state_sft = T
		{
			if state_alt = D
			{
				if state_win = D
				{
					Send !#%input_key%
					;TrayTip, Title, - - alt win, 1, 1
				}	
				else
				{
					Send !%input_key%
					;TrayTip, Title, - - alt -, 1, 1
				}
			}
			else
			{
				if state_win = D
				{
					Send #%input_key%
					;TrayTip, Title, - - - win, 1, 1
				}	
				else
				{
					Send %input_key%
				}
			}	
		}		
	}
	Return



;****************************************************************
;		CTRLUP
;****************************************************************
appskey & y::
	input_key = {pgup}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send +^!#%input_key%
				;TrayTip, Title, shift ctrl alt win, 1, 1
			}	
			else
			{
				Send +^!%input_key%
				;TrayTip, Title, shift ctrl alt - , 1, 1
			}		
		}
		else
		{
			if state_win = D
			{
				Send +^#%input_key%
				;TrayTip, Title, shift ctrl - win, 1, 1
			}	
			else
			{
				Send +^%input_key%
				;TrayTip, Title, shift ctrl - -, 1, 1
			}
		}
	
	}
	else
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send ^!#%input_key%
				;TrayTip, Title, - ctrl alt win, 1, 1
			}	
			else
			{
				Send ^!%input_key%
				;TrayTip, Title,  - ctrl alt - , 1, 1
			}
		}
		else
		{
			if state_win = D
			{
				Send ^#%input_key%
				;TrayTip, Title, - ctrl - win, 1, 1
			}	
			else
			{
				Send ^%input_key%
				;TrayTip, Title, - ctrl - -, 1, 1
			}
		}
	}
	Return


;****************************************************************
;		CTRLBACKSPACE
;****************************************************************
appskey & h::
	input_key = {PgDn}	
	GetKeyState, state_sft, Shift
	GetKeyState, state_ctl, Ctrl
	GetKeyState, state_alt, Alt
	GetKeyState, state_win, LWin

	if state_sft = D
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send +^!#%input_key%
				;TrayTip, Title, shift ctrl alt win, 1, 1
			}	
			else
			{
				Send +^!%input_key%
				;TrayTip, Title, shift ctrl alt - , 1, 1
			}		
		}
		else
		{
			if state_win = D
			{
				Send +^#%input_key%
				;TrayTip, Title, shift ctrl - win, 1, 1
			}	
			else
			{
				Send +^%input_key%
				;TrayTip, Title, shift ctrl - -, 1, 1
			}
		}
	
	}
	else
	{
		if state_alt = D
		{
			if state_win = D
			{
				Send ^!#%input_key%
				;TrayTip, Title, - ctrl alt win, 1, 1
			}	
			else
			{
				Send ^!%input_key%
				;TrayTip, Title,  - ctrl alt - , 1, 1
			}
		}
		else
		{
			if state_win = D
			{
				Send ^#%input_key%
				;TrayTip, Title, - ctrl - win, 1, 1
			}	
			else
			{
				Send ^%input_key%
				;TrayTip, Title, - ctrl - -, 1, 1
			}
		}
	}
	Return




;****************************************************************
;			WINDOW CONTROL
;****************************************************************
appskey & n::ShiftAltTab
	return

appskey & ,::AltTab
	return


appskey & m::
	GetKeyState, stateLctrl, Lctrl
	GetKeyState, stateShift, Shift
	WinGetTitle,title,A 
	WinGet,status,MinMax,%title% 
	if stateLctrl = D
	{
		WinMinimize,%title% 
		return 
	}	
	if stateShift = D
	{
		SendInput {Lwin Down}{right}{Lwin Up}
		
		return
	}
	if status=0 
	{ 
		WinMaximize,%title% 
		return 
	} 
	if status=1 
	{ 
		WinRestore,%title% 
		return 
	} 
	return



appskey & \:: Send, !{F4}
	Return




