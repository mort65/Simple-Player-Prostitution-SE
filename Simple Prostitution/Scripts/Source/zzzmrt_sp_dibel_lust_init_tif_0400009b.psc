;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_dibel_lust_init_tif_0400009b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_main_qst_script MainScript = GetOwningQuest() As zzzmrt_sp_main_qst_script
if (MainScript.player.getItemCount(MainScript.Gold) >= MainScript.fTempleTaskSeptimCost) && (MainScript.player.getItemCount(MainScript.dibelMark) >= MainScript.fTempleTaskMarkCost)
	MainScript.player.removeItem(MainScript.gold, MainScript.fTempleTaskSeptimCost as Int, false, akSpeaker)
	MainScript.player.removeItem(MainScript.dibelMark, MainScript.fTempleTaskMarkCost as Int, false, akSpeaker)
	MainScript.DibellanLust_Qst.start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
