
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

Teleport(450, 39)
Update_log("Frigid Highlands","")
Teleport(450, 39)
Teleport(490, 83)
Skill("F2",6,1)
Skill("F1",4,0)
Sleep, 4000
pick_item()
Teleport(450, 39)
Teleport(450, 39)
Skill("F2",6,1)
pick_item()

#Include Diaflow4.ahk
#Include pickit.ahk