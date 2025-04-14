;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_teammate_sell0_tif_05000d3a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_teammate_handler_qst_script myOwningScript = getOwningQuest() as zzzmrt_sp_teammate_handler_qst_script
myOwningScript.detectTeamMates(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
