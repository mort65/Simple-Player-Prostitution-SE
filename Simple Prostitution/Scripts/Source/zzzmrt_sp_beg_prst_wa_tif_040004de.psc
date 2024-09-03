;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_beg_prst_wa_tif_040004de Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_main_qst_script MainScript = GetOwningQuest() As zzzmrt_sp_main_qst_script
if !MainScript.bBeggarRejectWalkAwayCheck
	return
endif
MainScript.setRejectingCustomerResult(akSpeaker, false, false, true, false)
if MainScript.ApproachMonitorScr.canPunishPlayerForRejectingSexOffer(akSpeaker)
	MainScript.rejectCusomer(akSpeaker)
endif
akSpeaker.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
