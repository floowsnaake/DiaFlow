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
Global say_game
Global pick_up_name


runs = 1

Round_two = 0
 
IfExist,Settings.ini
{
FileReadLine,Game_name_output,Settings.ini,3
FileReadLine,Game_password_output,Settings.ini,4
FileReadLine,logg_it,Settings.ini,5
FileReadLine,Clear_view,Settings.ini,6
FileReadLine,TP_on_exit,Settings.ini,7
FileReadLine,New_diablo,Settings.ini,8
FileReadLine,say_game,Settings.ini,9
}

Gui, +AlwaysOnTop
Gui, Add, ListView,x6 y6 w355 h355 ReadOnly NoSortHdr  grid, Time|Status|Loot


Gui, Add, text,x0,Game Name:
Gui, Add, edit, ReadOnly x3 w100,%Game_name_output%

Gui, Add, text,x0,Game Password:
Gui, Add, edit, ReadOnly x3 w100,%Game_password_output%

Gui, Add, Checkbox, vDebugg_logg Checked%logg_it% x128 y385,Save Logg after run

Gui, Add, Checkbox,vClear_list Checked%Clear_view% x128 y409,Clear List after run

Gui, Add, Checkbox,vTP Checked%TP_on_exit% x128 y435,TP on exit

Gui, Add, Checkbox,vSay_next_game Checked%say_game% x128 y455,Announce next Game

Gui, Add, Button,gStart w90 x3  y479,Run

Gui, Add, Checkbox,vLunch_game Checked%New_diablo% x128 y479,New Diablo instance

Gui, Add, text,x106 y368,Total Loot found:
Gui, Add, text,x189 y368 vGui_loot,0

Gui, Add, text,x210 y368,Current Game:
Gui, Add, text,x280 y368 cblue vGui_game_name w100,

 LV_ModifyCol(1,65)
 LV_ModifyCol(2,210)
 LV_ModifyCol(3,80)
 
; MsgBox, 262208, Diaflow Verion 3 info | Floowsnaake, Pick ups are  bugged`, says its picking up gems instead of crosses`, but it works anyway despite the logger being broken as of now.`n`nClear view/clean when making a new game cleans it until bot is restarted.`n`nThe Settings.ini does not write down the values from the GUI it only reeads the ini and outs the ifo into the GUI.
 
Gui, Show, w373 h500, Diaflow v3 Floowsnaake
return

start:
gui,submit
Gui, Show,x1479 y121 w363 h500, Diafloow

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
ImageSearch, FoundX, FoundY, 667, 587, 709, 602, *11 C:\Users\snowflake\AppData\Roaming\MacroCreator\Screenshots\Screen_20200621144834.png ; in lobby creat button
If ErrorLevel = 0
{
Update_log("Creating " game "-" runs "*" gamePassword,"")

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
ImageSearch, FoundX, FoundY, 777, 719, 862, 792, *11 C:\Users\snowflake\AppData\Roaming\MacroCreator\Screenshots\Screen_20200621133527.png ; if in game
If ErrorLevel = 0
{
Update_log("Successfully Joined","")
Sleep,2000
break
}


}

Summon("F1",4,0)
Summon("F2",6,0)
Summon("F3",2,0)

Sleep,2000
Update_log("Taking waypoint","")
Sleep,300
click,185, 678 ;down staris act 5
Sleep,1850
click,369, 567
Sleep,1850
Click 150, 210 ; frigid land
Sleep,300

check_wildernes()
Update_log("Frigid Highlands","")
Send, {F7}

Check_Blink(904, 394)
Check_Blink(831, 643)
Check_Blink(725, 638)


Check_Blink(951, 609)
Check_Blink(951, 609)
Summon("F2",6,1)
Check_Blink(951, 609)

Loop
{
ImageSearch, FoundX, FoundY, 265, 392, 785, 701, *11 C:\Users\snowflake\Desktop\shank.png ;if shank boss is near/alive

If ErrorLevel = 1
{
Update_log("Shank died","")
Sleep,2000
break
}
}


Send, {F7}


pick_item()


Sleep,500

IF (TP = 1)
{
send, {F10}
Sleep,600
MouseMove,519, 382
Sleep,700
Update_log("TP made","")
click right
Sleep,900
send, {F7}
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

IF (Clear_list = 1)
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
Update_log("Next Game " game "-" runs "*" gamePassword,"")
goto, restartnig
return


/*
============================================================================================
==                                                                      FUNCTIONS                                                                                                                                  ==
==                                                                                                                                                                                                                            ==
============================================================================================

*/




Summon(Skill_key,sums,Teleport_mode){
Global

summon_name =
IF (Skill_key = "F1")
summon_name := "Blood Skeleton"
IF (Skill_key = "F2")
summon_name := "Night Hawks"
IF (Skill_key = "F3")
{
summon_name := "Abyss Knight"
}

	Send, {%Skill_key%}
	Sleep,300
	Update_log("Summon " summon_name " x " sums,"")
	Loop,%sums%
{
click right
Sleep,340
}

IF (Teleport_mode = 1)
{
send, {F7}
Sleep,200
}

Sleep,700

}

return


check_wildernes(){
	
Loop
{

ImageSearch, FoundX, FoundY, 173, 671, 204, 702, *11 C:\Users\snowflake\AppData\Roaming\MacroCreator\Screenshots\Screen_20200621142648.png

If ErrorLevel = 0
{
Sleep,300
break
}

}
}
return

Check_Blink(click_x,click_y){
Global
blinks++

	Loop
{
ImageSearch, FoundX, FoundY, 777, 719, 862, 792, *11 C:\Users\snowflake\AppData\Roaming\MacroCreator\Screenshots\Screen_20200621133527.png
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

IF (Debugg_logg = 1)
{
FileAppend,%Date_time%   %message%   %loot%`n,%A_ScriptDir%\Logs\%Game_name_output%_%runs%.txt
}

LV_Add("", Date_time,message,loot)
GC:=LV_GetCount()
LV_Modify(LV_GetCount(), "Vis")
}
 return
 
 
#Include start.ahk
#Include auto_pick.ahk

^Esc::
Suspend
return
