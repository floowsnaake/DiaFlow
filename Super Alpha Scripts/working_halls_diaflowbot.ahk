
/*

todays date as it was finished: 2020-12-15 (tuedsay) -03:45 night time


Start the bot in Halls of pain standing on the Waypoint with map revealed (Press R key to show the full map) and then make the map open/show the mini map (so the bot can see the map).

make sure that the pictures/images are in the same folder as the bot script

make sure thet you run the script as admin and that you use a teleport as skill (ONLY TESTED WITH A BLINK STAFF!)




*/










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

Global first_time

Global winCenterX

Global winCenterY
Global targetX
Global targetY

Global winW
Global WinH

x1 := 0
y1 := 0
x2 := winW
y2 := winH

winCenterX := winW/2
winCenterY := winH/2

Global saw_one_time
Global notfound
Global times
global first_move
Global message
global loot

first_move = 1


Gui 1:Default
Gui, +AlwaysOnTop
Gui, Add, ListView,x6 y6 w355 h355 ReadOnly NoSortHdr  grid, Time|Debug Info
Gui, Add, text,, Exit Mode:
Gui, Add, Pic, w60 h60 vpic_get,
Gui, Add, Button,gtest,test


 LV_ModifyCol(1,65)
 LV_ModifyCol(2,210)
 LV_ModifyCol(3,80)
 
gui,show,, Map Debugger | Diaflow 4

return


x::
test:
first_time = 1
WinActivate, Diablo II
WinWaitActive, Diablo II


WinGetPos, winTopL_x, winTopL_y, width, height,Diablo II
winCenter_x := winTopL_x + width/2
winCenter_y := winTopL_y + height/2


search:
Loop
{
taco++
IF (A_Index = 5)
{
taco = 1
}

GuiControl,, pic_get, test%taco%.png
ImageSearch, targetx, targety, 11, 26, 1023, 651,  *51 test%taco%.png



If ErrorLevel = 0
{

found_exit = 1

Loop
{
 
 IF (found_exit = 1)
 {

Click %winCenter_x%, %targety%
Sleep,100
MouseMove, %targetx%, %targety%, 3
click Down
Sleep,300
click, right
ToolTip, %timex%
timex++

IF (timex = 7)
{
 taco = 1
 timex = 0
 found_exit = 0
 
send, {tab}
Sleep,500
send, {tab}
Sleep,500

Check_exit_closenes()

goto,search
}

}

}

}


If ErrorLevel = 1
{
goto, move_map
}

}
return

move_map:
{

send, {tab}
Sleep,500
send, {tab}
Sleep,500

IF (first_move = 1)
{
Move_the_map("Up")
first_move = 2
goto,search
return
}

IF (first_move = 2)
{
Move_the_map("Right")
first_move = 3
goto,search
return
}

IF (first_move = 3)
{
Move_the_map("Down")
first_move = 4
goto,search
return
}

IF (first_move = 4)
{
Move_the_map("Left")
first_move = 1
goto,search
return
}

}
return


Check_exit_closenes(){
ToolTip, Checking if close to exit,0,0
GuiControl,, pic_get, halls.png
ImageSearch, x, y, 11, 26, 1023, 651,  *110 halls.png

If ErrorLevel = 0
{
   	MouseMove,%x%,%y%
   Sleep,5100
   click, Right
   Sleep,1000
    click 3
ToolTip, player close to the exit!!
    Sleep,2000

ToolTip, in exit mode
Sleep,1000
send, {tab}
Sleep,1000

ImageSearch, x2, y2, 11, 26, 1023, 651,  *110 halls1.png
GuiControl,, pic_get, halls1.png
If ErrorLevel = 0
{
   y2+=20
   ToolTip, found exit place 1
	MouseMove,%x2%,%y2%
    Sleep,1500
    Click 
    Sleep,2000
}

ImageSearch, x3, y3, 11, 26, 1023, 651,  *110 halls2.png
GuiControl,, pic_get, halls2.png
If ErrorLevel = 0
{
      ToolTip, found exit place 2
         y3+=20
	MouseMove,%x3%,%y3%
    Sleep,1500
    Click 
    Sleep,2000
}

 }
}
return




Move_the_map(Dir)
{
global
ToolTip moving map, Dir,0
Send, {%Dir% 12}
Sleep,300
}
return

Update_log(message,loot){
Global
Date_time = [%A_Hour%:%A_min%:%A_Sec%]

LV_Add("", Date_time,message,loot)
GC:=LV_GetCount()
LV_Modify(LV_GetCount(), "Vis")
}
 return
 
 
 esc::
 ExitApp
 return
