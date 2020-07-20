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


x::


Loop
{
Check_exit()
}
return


Check_exit()
{

IF (found = 1)
{
MsgBox outside entrance
}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *70 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\tower.png
If ErrorLevel = 0
{
found = 1
}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *70 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\tower2.png
If ErrorLevel = 0
{
found = 1
}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *70 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\tower3.png
If ErrorLevel = 0
{
found = 1
}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *70 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\tower4.png
If ErrorLevel = 0
{
found = 1
}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *70 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\entrance_map.png
If ErrorLevel = 0
{
Click, %FoundX%, %FoundY% right, 1

Click down
Sleep 3000
Click up

}

ImageSearch, FoundX, FoundY, 11, 26, 1023, 651, *50 *Trans0x7C7470 C:\Users\snowflake\Documents\GitHub\DiaFlow\images\entrance_map2.png
If ErrorLevel = 0
{

Click, %FoundX%, %FoundY% right, 1

Click down
Sleep 3000
Click up
}



ImageSearch, FoundX, FoundY, 777, 719, 862, 792, *11 %A_ScriptDir%\images\teleport.png
If ErrorLevel = 0
{
Sleep,100
Click Right
Sleep,400
}

}
return

