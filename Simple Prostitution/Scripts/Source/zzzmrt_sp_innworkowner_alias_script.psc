Scriptname zzzmrt_sp_innworkowner_alias_script extends ReferenceAlias

import zzzmrt_sp_utility
zzzmrt_sp_inn_work_qst_script property InnWorkScript Auto

event OnReset()
  logText("Inn owner is gone.")
  InnWorkScript.finishWhoring()
endevent

event OnDying(Actor akKiller)
  logText("Inn owner is dying.")
  InnWorkScript.finishWhoring()
endevent

event OnUpdateGameTime()
	logText("OnUpdateGameTime() triggered for " + self)
	Quest myQuest = GetOwningQuest()
	If (GetActorReference() && myQuest && myQuest.isRunning() && ((myQuest.GetStage() == 20) || (myQuest.GetStage() == 20)))
		if (GetActorReference().GetParentCell() != InnWorkScript.MainScript.player.GetParentCell())
			InnWorkScript.finishWhoring()
		else
			RegisterForSingleUpdateGameTime(3.0)
		endif
	endif
endEvent
