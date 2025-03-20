;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_innwork_tif_04000e39 Extends TopicInfo Hidden

import zzzmrt_sp_utility

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_inn_work_qst_script myOwningScript = getOwningQuest() as zzzmrt_sp_inn_work_qst_script
Actor player = myOwningScript.MainScript.player
MiscObject gold = myOwningScript.MainScript.Gold
player.Removeitem(gold, maxInt(0, minInt(player.GetItemCount(gold), myOwningScript.iPlayerDebt)))
myOwningScript.iPlayerDebt = 0
myOwningScript.finishWhoring()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
