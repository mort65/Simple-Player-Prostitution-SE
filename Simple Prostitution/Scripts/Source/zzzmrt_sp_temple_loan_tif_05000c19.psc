;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_temple_loan_tif_05000c19 Extends TopicInfo Hidden

import zzzmrt_sp_utility

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_temple_loan_qst_script myOwningScript = getOwningQuest() as zzzmrt_sp_temple_loan_qst_script
myOwningScript.payDebt()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
