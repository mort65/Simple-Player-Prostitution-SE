;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_prst_set_reappr_040000aa Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_reapproach_qst_script QuestScript = GetOwningQuest() As zzzmrt_sp_reapproach_qst_script
QuestScript.stopReapproach(True)
if QuestScript.bIsDibelCustomer
	QuestScript.MainScript.setRejectingCustomerResult(akSpeaker, false, true, false, false)
else
	QuestScript.MainScript.setRejectingCustomerResult(akSpeaker, true, false, false, false)
endif
QuestScript.MainScript.bRejectOrgasm = True
Debug.Notification("Simple Prostitution: " + akSpeaker.GetDisplayName() + " not orgasmed.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
