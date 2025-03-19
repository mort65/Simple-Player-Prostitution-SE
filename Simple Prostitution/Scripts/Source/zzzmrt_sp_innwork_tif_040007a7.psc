;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname zzzmrt_sp_innwork_tif_040007a7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_sp_inn_work_qst_script myOwningScript = getOwningQuest() as zzzmrt_sp_inn_work_qst_script
if myOwningScript.iPlayerDebt > 0
	myOwningScript.InnOwner.ForceRefTo(akSpeaker)
	GetOwningQuest().SetStage(10)
	if myOwningScript.bPlayerPaidForRoom || myOwningScript.bPlayerRentedRoom
		myOwningScript.RentRoom(akSpeaker)
	endif
elseif myOwningScript.bPlayerPaidForRoom
	myOwningScript.RentRoom(akSpeaker)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
