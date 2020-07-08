
MsgBox run Diaflow4 this is only a functions script!

pick_item(){
Send,{%loothotkey% down}
Sleep,400

Search_for_loot("perfect1")
Search_for_loot("perfect2")
Search_for_loot("uniqe_item1")
Search_for_loot("uniqe_item2")
Search_for_loot("fusion_mark1")
Search_for_loot("fusion_mark2")
Search_for_loot("rune")
Search_for_loot("jewel1")
Search_for_loot("jewel2")
Search_for_loot("flawless1")
Search_for_loot("flawless2")

Sleep,300
send, {%loothotkey% up}
send, {%loothotkey% down}
send, {%loothotkey%  3}
}
return



Search_for_loot(image){
Global

pick_up_name =

IF (image = "uniqe_item1" OR "uniqe_item2")
{
pick_up_name = "Uniqe item"
}
IF (image = "fusion_mark1" OR "fusion_mark2")
{
pick_up_name = "Mark of Infusion"
}
IF (image = "rune")
{
pick_up_name = "Rune"
}
IF (image = "flawless1" OR "flawless2")
{
pick_up_name = "Flawless Gem"
}
IF (image = "perfect1" OR "perfect2")
{
pick_up_name = Perfect Gem
}
IF (image = "jewel1" OR "jewel2")
{
pick_up_name = jewel
}

loop,2
{


ImageSearch, FoundX, FoundY, 5, 78, 1012, 629, *54 %A_ScriptDir%/loot/%image%.png
If ErrorLevel = 0
{
FoundX += 10
Foundy += 10
MouseMove, %FoundX%, %FoundY%
Sleep,200

ImageSearch, FoundX, FoundY, 29, 107, 1008, 636, %A_ScriptDir%/loot/item_hover.png
If ErrorLevel = 0
{


ImageSearch, FoundX, FoundY, 29, 107, 1008, 636,%A_ScriptDir%/loot/item_hover_wrong.png
If ErrorLevel = 0
{
	
IF (image = "jewel1" OR "jewel2")
{
	; ToolTip %pick_up_name% %image%
goto,Skip_pickup
return
}

}


Found++
    Update_log("Found ",pick_up_name)
	GuiControl,,Gui_loot,%Found%
	click
	Sleep,100
	MouseMove,%Foundx%,%Foundy%+30
	Sleep,1600
	Skip_pickup:


}
	
	
	
}
}






}
return

#Include, Diaflow4.ahk