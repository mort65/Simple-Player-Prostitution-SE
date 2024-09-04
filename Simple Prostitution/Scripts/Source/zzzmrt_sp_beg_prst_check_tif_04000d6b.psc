;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname zzzmrt_sp_beg_prst_check_tif_04000d6b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_main_qst_script MainScript = GetOwningQuest() As zzzmrt_sp_main_qst_script
MainScript.ApproachMonitorScr.playerHasLicense()
MainScript.ApproachMonitorScr.checkMOAStatus()
MainScript.ApproachMonitorScr.playerHavingSex = MainScript.isActorHavingSex(MainScript.player)
MainScript.ApproachMonitorScr.actorHavingSex = MainScript.isActorHavingSex(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
