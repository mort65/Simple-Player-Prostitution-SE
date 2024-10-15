;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname qf_zzzmrt_temple_escort_04000098 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Client01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Client01 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_escort_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_escort_qst_script kmyQuest = __temp as zzzmrt_sp_temple_escort_qst_script
;END AUTOCAST
;BEGIN CODE
FailAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_escort_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_escort_qst_script kmyQuest = __temp as zzzmrt_sp_temple_escort_qst_script
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_escort_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_escort_qst_script kmyQuest = __temp as zzzmrt_sp_temple_escort_qst_script
;END AUTOCAST
;BEGIN CODE
setObjectiveDisplayed(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
