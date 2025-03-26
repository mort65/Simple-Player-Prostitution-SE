Scriptname zzzmrt_sp_innworkowner_alias_script extends ReferenceAlias

import zzzmrt_sp_utility

event OnReset()
  logText("Inn owner is gone.")
  (GetOwningQuest() as zzzmrt_sp_inn_work_qst_script).finishWhoring()
endevent

event OnDying(Actor akKiller)
  logText("Inn owner is dying.")
  (GetOwningQuest() as zzzmrt_sp_inn_work_qst_script).finishWhoring()
endevent

event OnUpdateGameTime()
	logText("OnUpdateGameTime() triggered for " + self)
	Quest myQuest = GetOwningQuest()
	zzzmrt_sp_inn_work_qst_script myQuestScript = myQuest as zzzmrt_sp_inn_work_qst_script
	If (GetActorReference() && myQuest && myQuest.isRunning() && ((myQuest.GetStage() == 20) || (myQuest.GetStage() == 10)))
		if (GetActorReference().GetParentCell() != myQuestScript.MainScript.player.GetParentCell())
			myQuestScript.finishWhoring()
			if GetActorReference() && myQuestScript.doSendToSlavey && myQuest.isRunning() && ((myQuest.GetStage() == 20) || (myQuest.GetStage() == 10))
				RegisterForSingleUpdateGameTime(myQuestScript.MainScript.randint(1,3))
			endif
		else
			RegisterForSingleUpdateGameTime(3.0)
		endif
	endif
endEvent 
