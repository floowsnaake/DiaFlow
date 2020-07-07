
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
Sleep,600
Click 260, 78 ; act 3 waypoint page
Sleep,800
click,62, 208 ; trav wp button
Sleep,1850

check_wildernes()
Update_log("Travincal","")
Send, {%teleporthotkey%}

Teleport(991, 329)
Update_log("Teleporting Altar","")
Teleport(991, 329)

pick_item()

#Include Diaflow4.ahk
#Include pickit.ahk