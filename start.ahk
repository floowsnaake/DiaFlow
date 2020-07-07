
Global log_date

Start_login()
{
IfExist,Settings.ini
{
FileReadLine,name,Settings.ini,1	
FileReadLine,Passwordx,Settings.ini,2
goto,send_mode
}

IfNOTExist,settings.ini
{
Gui, Add, Text,, Account Name
Gui, Add, Text,, Password:
Gui, Add, Edit, vname ym  ; The ym option starts a new column of controls.
Gui, Add, Edit, vpassword
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, D2 Bot Login
return  ; End of auto-execute section. The script is idle until the user does something.
}

ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
FileAppend,%name%`n,Settings.ini
FileAppend,%Password%,Settings.ini

send_mode:
Update_log("Starting game.exe","")
run,"D:\Program Files (x86)\Diablo II\Diablo II.exe" -w -skiptobnet
WinActivate,Diablo II
WinWaitActive,Diablo II

Loop
{
ImageSearch, FoundX, FoundY, 357, 642, 689, 739, *4 C:\Users\snowflake\AppData\Roaming\MacroCreator\Screenshots\Screen_20200622164004.png ; in login screen

If ErrorLevel =1
{
Sleep,1400	
}

If ErrorLevel = 0
{
Update_log("Logging in...","")
Sleep,2000
send, {tab}
SendInput,%name%
Sleep,300
send, {tab}
Sleep,300
SendInput,%Passwordx%
Sleep,300
Send,{enter}
Sleep,2200
send, {enter}
Sleep,600
send, {enter}
Sleep,2000
Update_log("In Lobby","")
break
}
}
}
return
