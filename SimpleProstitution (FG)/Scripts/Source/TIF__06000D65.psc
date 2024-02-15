;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__06000D65 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zzzmrt_SimpleProstitutionMainQstScr MainScript = GetOwningQuest() As zzzmrt_SimpleProstitutionMainQstScr
MainScript.CustomerSpell.Cast(akSpeaker,akSpeaker)
MainScript.ProstitutePlayerTo(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
