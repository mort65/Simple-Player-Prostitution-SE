;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname qf_zzzmrt_templeloanqst_05000c0c Extends Quest Hidden

;BEGIN ALIAS PROPERTY TempleLender
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TempleLender Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_loan_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_loan_qst_script kmyQuest = __temp as zzzmrt_sp_temple_loan_qst_script
;END AUTOCAST
;BEGIN CODE
kmyQuest.TempleLoanDeadLineDisplay.SetValueInt(kmyQuest.fDeadline as int)
kmyQuest.UpdateCurrentInstanceGlobal(kmyQuest.TempleLoanDeadLineDisplay)
kmyQuest.LenderScript.RegisterForSingleUpdateGameTime((kmyQuest.fDeadline as Int) * 24)
SetObjectiveDisplayed(0, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_loan_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_loan_qst_script kmyQuest = __temp as zzzmrt_sp_temple_loan_qst_script
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE zzzmrt_sp_temple_loan_qst_script
Quest __temp = self as Quest
zzzmrt_sp_temple_loan_qst_script kmyQuest = __temp as zzzmrt_sp_temple_loan_qst_script
;END AUTOCAST
;BEGIN CODE
FailAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
