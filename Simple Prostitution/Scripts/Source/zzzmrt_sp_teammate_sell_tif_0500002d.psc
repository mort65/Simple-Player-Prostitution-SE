;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_teammate_sell_tif_0500002d Extends TopicInfo Hidden
zzzmrt_sp_main_qst_script property MainScript auto
;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_teammate_handler_qst_script myOwningScript = getOwningQuest() as zzzmrt_sp_teammate_handler_qst_script
MainScript.teamMateHandlerScript.StartWhoring(akSpeaker, MainScript.teamMateHandlerScript.teamMate6.GetReference() as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
