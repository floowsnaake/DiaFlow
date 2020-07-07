
pick_item(){

Search_for_loot("perfect1")
Search_for_loot("perfect2")
Search_for_loot("uniqe_item1")
Search_for_loot("uniqe_item2")
;Search_for_loot("fusion_mark1")
;Search_for_loot("fusion_mark2")
Search_for_loot("rune")
Search_for_loot("flawless1")
Search_for_loot("flawless2")

Sleep,300
send, {%loothotkey% up}
send, {%loothotkey% down}
send, {%loothotkey% 3}
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



Send,{%loothotkey% down}
Sleep,400

loop,2
{

ImageSearch, FoundX, FoundY, 29, 107, 1008, 636, *10 C:\Users\snowflake\Desktop\Authotkey bot\loot\%image%.png
If ErrorLevel = 0
{
FoundX += 10
Foundy += 10
MouseMove, %FoundX%, %FoundY%
Sleep,200

ImageSearch, FoundX, FoundY, 29, 107, 1008, 636, C:\Users\snowflake\Desktop\Authotkey bot\loot\item_hover.png
If ErrorLevel = 0
{

Found++

	Update_log("Found ",image)
	GuiControl,,Gui_loot,%Found%
	click
	Sleep,100
	MouseMove,%Foundx%,%Foundy%+30
	Sleep,1600
	
	
	
}

}
}
send, {%loothotkey%}

}

return


#Include Diaflow4.ahk