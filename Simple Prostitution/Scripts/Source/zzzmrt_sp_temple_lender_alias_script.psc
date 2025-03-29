Scriptname zzzmrt_sp_temple_lender_alias_script extends ReferenceAlias


import zzzmrt_sp_utility

event OnReset()
  logText("Temple lender is gone.")
  (GetOwningQuest() as zzzmrt_sp_temple_loan_qst_script).fail()
endevent

event OnDying(Actor akKiller)
  logText("Temple lender is dying.")
  (GetOwningQuest() as zzzmrt_sp_temple_loan_qst_script).fail()
endevent

event OnUpdateGameTime()
	logText("OnUpdateGameTime() triggered for " + self)
	Quest myQuest = GetOwningQuest()
	zzzmrt_sp_temple_loan_qst_script myQuestScript = myQuest as zzzmrt_sp_temple_loan_qst_script
	If (GetActorReference() && myQuest && myQuest.isRunning() && (myQuest.GetStage() == 10))
		if (GetActorReference().GetParentCell() != myQuestScript.player.GetParentCell())
			myQuestScript.FinishLoan()
			if (GetActorReference() && myQuestScript.doSendToSlavey && myQuest.isRunning() && (myQuest.GetStage() == 10))
				RegisterForSingleUpdateGameTime(myQuestScript.MainScript.randint(1,3))
			endif
		else
			RegisterForSingleUpdateGameTime(3.0)
		endif
	endif
endEvent 