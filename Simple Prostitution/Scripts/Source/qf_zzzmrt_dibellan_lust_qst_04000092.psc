;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname qf_zzzmrt_dibellan_lust_qst_04000092 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Priestess
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Priestess Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE zzzmrt_sp_dibellan_lust_qst_script
Quest __temp = self as Quest
zzzmrt_sp_dibellan_lust_qst_script kmyQuest = __temp as zzzmrt_sp_dibellan_lust_qst_script
;END AUTOCAST
;BEGIN CODE
kmyQuest.DibellanLustCustomers_g.SetValue(0)
UpdateCurrentInstanceGlobal(kmyQuest.DibellanLustCustomers_g)
setObjectiveDisplayed(0, abForce = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
FailAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveCompleted(0)
setObjectiveDisplayed(1, abForce = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE zzzmrt_sp_dibellan_lust_qst_script
Quest __temp = self as Quest
zzzmrt_sp_dibellan_lust_qst_script kmyQuest = __temp as zzzmrt_sp_dibellan_lust_qst_script
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
kmyQuest.MainScript.giveTempleQuestReward()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
