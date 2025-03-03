Scriptname zzzmrt_sp_customer_approach_script extends Quest  Conditional

Quest Property ApproachMonitorQst Auto
Quest property MainQuest auto
zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto
zzzmrt_sp_main_qst_script property MainScript auto
ReferenceAlias property approachingCustomerAlias Auto

Event OnInit()
	if isrunning() && MainScript.bPreventFruitlessApproaches && (approachingCustomerAlias && approachingCustomerAlias.GetReference()) && !((approachingCustomerAlias.getReference() as Actor).isInDialogueWithPlayer())
	    Actor approacher = approachingCustomerAlias.GetReference() as Actor
		if ApproachMonitorScr.canContinueApproach(approacher)
			approachingCustomerAlias.RegisterforSingleupdate(1.0)
		else
			ApproachMonitorScr.stopApproach(False)
			MainScript.log(approacher.getDisplayName() + " can't approach player. | Approacher ID = " + approacher)
		endif
	endif
EndEvent
