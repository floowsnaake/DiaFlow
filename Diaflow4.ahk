IF NOT A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#SingleInstance,Force

CoordMode, Mouse, Client
CoordMode, Pixel, Client
CoordMode, ToolTip, Client

SetWorkingDir, %A_ScriptDir%

image_dir = %A_ScriptDir%\images

Global Found
Global runs
Global blinks
Global times
Global log_date
Global game
Global gamePassword
Global Game_name_output
Global Game_password_output
Global Debugg_logg
Global logg_it
Global New_diablo
Global Say_next_game
Global pick_up_name
Global image
Global say_text
Global Hotkeys
Global game_dir
Global acc_name
Global acc_password
Global loothotkey
Global teleporthotkey
Global Clear_view
Global portalhotkey


runs = 1

Round_two = 0
 
IfExist,Diaflow.ini
{

;       account
IniRead, acc_name,Diaflow.ini,Account,username
IniRead, acc_password, Diaflow.ini, Account,password

;             game
IniRead, Game_name_output, Diaflow.ini, Game,Game_name
IniRead, Game_password_output, Diaflow.ini, Game,Game_password

;             Misc
IniRead, logg_it, Diaflow.ini, Misc,save_log
IniRead, Clear_view, Diaflow.ini, Misc,Auto_clear
IniRead, TP_on_exit, Diaflow.ini, Misc,TP_exit
IniRead, Say_next_game, Diaflow.ini, Misc,Announce_game
IniRead, say_text, Diaflow.ini, Misc,Announce_text
IniRead, game_dir, Diaflow.ini, Misc,Game_path
IniRead, New_diablo, Diaflow.ini, Misc,New_Game_instance


;                        Hotkeys
IniRead, loothotkey, Diaflow.ini, Hotkeys,Loot_key
IniRead, teleporthotkey, Diaflow.ini, Hotkeys,Teleport_key
IniRead, portalhotkey, Diaflow.ini, Hotkeys,Portal_key


}



Gui, +AlwaysOnTop
Gui, Add, ListView,x6 y6 w355 h355 ReadOnly NoSortHdr  grid, Time|Status|Loot


Gui, Add, text,x0,Game Name:
Gui, Add, text, ReadOnly x3 w100,%Game_name_output%

Gui, Add, text,x0,Game Password:
Gui, Add, text, ReadOnly x3 w100,%Game_password_output%


Gui, Add, Button,gStart w90 x3  y479,Run

Gui, Add, Button,gRun_ini w90 x110  y479,Config INI

Gui, Add, Button,gRun_script_folder w90 x210  y479,Script Folder

Gui, Add, Picture,x300 y425 ,devil.png

Gui, Add, text,x106 y368,Total Loot found:
Gui, Add, text,x189 y368 vGui_loot,0

Gui, Add, text,x210 y368,Current Game:
Gui, Add, text,x280 y368 cblue vGui_game_name w100,

 LV_ModifyCol(1,65)
 LV_ModifyCol(2,210)
 LV_ModifyCol(3,80)
 
 
Gui, Show, w373 h510, Diaflow v4 Floowsnaake
return

Run_script_folder:
Run explorer Scripts
return

Run_ini:
Run Diaflow.ini
return

GuiClose:
ExitApp
return

start:
gui,submit
Gui, Show,x1479 y121 w363 h510, Diaflow v4 Floowsnaake

IF (New_diablo = 1)
{
Start_login()
}

restartnig:
  

Blinks =
Alredy_run = 0

game = %Game_name_output%
gamePassword = %Game_password_output%

GuiControl,,Gui_game_name,%game%-%runs%

Sleep,2000
Loop
{
ImageSearch, FoundX, FoundY, 667, 587, 709, 602, *11 %A_ScriptDir%\images\lobby.png
If ErrorLevel = 0
{
Update_log("Creating " game "-" runs "  " gamePassword,"")

 Click, %FoundX%, %FoundY% Left, 1
     Sleep,4000
	Click
	Sleep,2800
;game name
SendInput,%game%-%runs%
Sleep,400
send, {tab}
Sleep,100
Send, %gamePassword%
Sleep,1200
Update_log("Joining...","")
Send, {enter} ; to create game
break
}

}
;check if ingame:

Loop
{
ImageSearch, FoundX, FoundY, 777, 719, 862, 792, *11 %A_ScriptDir%\images\teleport.png ; if in game
If ErrorLevel = 0
{
Update_log("Successfully Joined","")
Sleep,2000
break
}


}

;=======================================
; place for scripts
;========================================

#Include, %A_ScriptDir%/Scripts/Shank.ahk

;===================================

Send, {%teleporthotkey%}


pick_item()


Sleep,500

IF (TP_on_exit = 1)
{
send, {%portalhotkey%}
Sleep,600
MouseMove,519, 382
Sleep,700
Update_log("TP made","")
click right
Sleep,900
send, {%teleporthotkey%}
Sleep,900

}

IF (Say_next_game = 1)
{
Sleep,200
send, {enter}
Sleep,700
Next_game := runs + 1
 say_text = Next: %game%-%Next_game% %gamePassword%
SendInput,%say_text%
Sleep,700
Update_log("Next Game announced","")
send, {enter}
Sleep,2000
}

Update_log("Leaving Game","")
click,602, 738   ;bring up exit
Sleep,1300
send, {down 4} ; down to map
Sleep,900

send, {up} ; up to exit menu
Sleep,900
send, {enter} ; press exit game

IF (Clear_view = 1)
{
LV_Delete()  ; delete all rows in listview

LV_ModifyCol(1,65)
LV_ModifyCol(2,210)
LV_ModifyCol(3,80)
}

MouseMove,100,100

Sleep,2300
MouseMove,100,100
Round_two = 1
runs++
Update_log("Next Game " game "-" runs "  " gamePassword,"")
goto, restartnig
return


/*
============================================================================================
==                                                                      FUNCTIONS                                                                                                                                  ==
==                                                                                                                                                                                                                            ==
============================================================================================

*/


Start_login()
{
Update_log("Starting game.exe","")
run,%game_dir% -w -skiptobnet
WinActivate,Diablo II
WinWaitActive,Diablo II

Loop
{
ImageSearch, FoundX, FoundY, 357, 642, 689, 739, *4 %A_ScriptDir%\images\login.png ; in login screen

If ErrorLevel =1
{
Sleep,1400	
}

If ErrorLevel = 0
{
Update_log("Logging in...","")
Sleep,2000
send, {tab}
SendInput,%acc_name%
Sleep,300
send, {tab}
Sleep,300
SendInput,%acc_password%
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


skill(Skill_key,sums,Teleport_mode){
Global

	Send, {%Skill_key%}
	Sleep,300
	
	Loop,%sums%
{
click right
Sleep,340
}

IF (Teleport_mode = 1)
{
send, {%teleporthotkey%}
Sleep,200
}

Sleep,700

}

return


check_wildernes(){
	
Loop
{

ImageSearch, FoundX, FoundY, 173, 671, 204, 702, *11 %A_ScriptDir%\images\wilderness.png

If ErrorLevel = 0
{
Sleep,300
break
}

}
}
return

Teleport(click_x,click_y){
Global
blinks++

	Loop
{
ImageSearch, FoundX, FoundY, 777, 719, 862, 792, *11 %A_ScriptDir%\images\teleport.png
If ErrorLevel = 0
{
MouseMove,%click_x%, %click_y%
Sleep,100
Click Right
Sleep,400
break
}

}
}
return

Update_log(message,loot){
Global
Date_time = [%A_Hour%:%A_min%:%A_Sec%]

IF (logg_it = 1)
{
FileAppend,%Date_time%   %message%   %loot%`n,%A_ScriptDir%\Logs\%Game_name_output%_%runs%.txt
}

LV_Add("", Date_time,message,loot)
GC:=LV_GetCount()
LV_Modify(LV_GetCount(), "Vis")
}
 return
 

#Include pickit.ahk
#Include %A_ScriptDir%/Scripts


^Esc::
Suspend
return