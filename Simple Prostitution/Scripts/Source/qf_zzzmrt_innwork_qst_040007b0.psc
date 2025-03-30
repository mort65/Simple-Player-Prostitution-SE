;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname qf_zzzmrt_innWork_qst_040007b0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY InnOwner
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_InnOwner Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE zzzmrt_sp_inn_work_qst_script
Quest __temp = self as Quest
zzzmrt_sp_inn_work_qst_script kmyQuest = __temp as zzzmrt_sp_inn_work_qst_script
;END AUTOCAST
;BEGIN CODE
float fHours = ((kmyQuest.MainScript.fInnWorkDeadlineDays as Int) * 24)
kmyQuest.InnWorkDeadLineDisplay.SetValueInt(fHours as Int)
kmyQuest.UpdateCurrentInstanceGlobal(kmyQuest.InnWorkDeadLineDisplay)
kmyQuest.fInnWorkDeadlineDays = kmyQuest.MainScript.fInnWorkDeadlineDays
kmyQuest.InnOwnerScript.RegisterForSingleUpdateGameTime(fHours)
kmyQuest.fInnDebtTimeGameDaysPassed = kmyQuest.GameDaysPassed.GetValue()
SetObjectiveCompleted(0)
SetObjectiveDisplayed(1, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE zzzmrt_sp_inn_work_qst_script
Quest __temp = self as Quest
zzzmrt_sp_inn_work_qst_script kmyQuest = __temp as zzzmrt_sp_inn_work_qst_script
;END AUTOCAST
;BEGIN CODE
FailAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE zzzmrt_sp_inn_work_qst_script
Quest __temp = self as Quest
zzzmrt_sp_inn_work_qst_script kmyQuest = __temp as zzzmrt_sp_inn_work_qst_script
;END AUTOCAST
;BEGIN CODE
kmyQuest.UpdateCurrentInstanceGlobal(kmyQuest.InnWorkDeadLineDisplay)
kmyQuest.InnOwnerScript.RegisterForSingleUpdateGameTime(kmyQuest.fDeadlineHours)
kmyQuest.fInnDebtTimeGameDaysPassed = kmyQuest.GameDaysPassed.GetValue()
SetObjectiveDisplayed(0, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE zzzmrt_sp_inn_work_qst_script
Quest __temp = self as Quest
zzzmrt_sp_inn_work_qst_script kmyQuest = __temp as zzzmrt_sp_inn_work_qst_script
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
