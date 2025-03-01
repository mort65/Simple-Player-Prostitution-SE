Scriptname zzzmrt_sp_approaching_alias_script extends ReferenceAlias 

zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto

event OnReset()	
	ApproachMonitorScr.stopApproach(False)
	ApproachMonitorScr.MainScript.log("Approaching NPC is gone.")
endevent

event OnDying(Actor akKiller)
	ApproachMonitorScr.stopApproach(False)
	ApproachMonitorScr.MainScript.log("Approaching NPC is dying.")
endevent

Event OnUpdate()
	;ApproachMonitorScr.MainScript.log("OnUpdate() triggered for " + self)
	if getReference() && !((getReference() as Actor).isInDialogueWithPlayer())
		Actor me = getReference() as Actor
		if !ApproachMonitorScr.canContinueApproach(me)
			ApproachMonitorScr.stopApproach(False)
			ApproachMonitorScr.MainScript.log(me.getDisplayName() + " can't continue approaching player. | Approacher ID=" + me)
		elseif (GetOwningQuest().IsRunning() && !me.isInDialogueWithPlayer())
			registerForSingleUpdate(1.0)
		endif
	endif
EndEvent
