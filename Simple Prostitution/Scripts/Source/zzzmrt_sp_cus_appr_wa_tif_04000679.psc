;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname zzzmrt_sp_cus_appr_wa_tif_04000679 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_main_qst_script MainScript = GetOwningQuest() As zzzmrt_sp_main_qst_script
MainScript.stopApproach(true)
MainScript.setRejectingCustomerResult(akSpeaker, false, false, false, true)
if MainScript.ApproachMonitorScr.canPunishPlayerForRejectingApproach(akSpeaker)
	MainScript.rejectCusomer(akSpeaker)
endif
akSpeaker.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
