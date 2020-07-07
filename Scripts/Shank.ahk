
Update_log("summon Blood Skeleton","")
Skill("F1",4,0)
Update_log("summon Night Hawks","")
Skill("F2",6,0)
Update_log("summon Abyss Knight","")
Skill("F3",2,0)

Update_log("Taking waypoint","")
Sleep,300
click,185, 678 ; Walk down the stairs in act 5
Sleep,1850
click,369, 567 ; Clicking Waypoint
Sleep,1850
Click 150, 210 ; Frigid Land waypoint button
Sleep,300

check_wildernes()
Update_log("Frigid Highlands","")
Send, {%teleporthotkey%}

Teleport(904, 394)
Teleport(831, 643)
Update_log("Teleporting Shank","")
Teleport(725, 638)
Teleport(951, 609)
Teleport(951, 609)
Skill("F2",6,1)
Teleport(951, 609)

Loop
{
ImageSearch, FoundX, FoundY, 265, 392, 785, 701, *11 %image_dir%/shank.png ;if shank boss is near/alive

If ErrorLevel = 1
{
Update_log("Shank died","")
Sleep,2000
break
}
}


#Include Diaflow4.ahk
