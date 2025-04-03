Scriptname zzzmrt_sp_reapproach_qst_script extends Quest  Conditional

import zzzmrt_sp_utility

ReferenceAlias property ReApproachingAlias auto
zzzmrt_sp_main_qst_script property MainScript auto
Actor Property player auto

Bool Property bIsDibelCustomer = False Auto Hidden Conditional

Event OnInit()
	registerForSingleUpdate(30.0)
EndEvent

Event OnUpdate()
	if IsRunning()
		actor reapproachingActor = ReApproachingAlias.GetReference() as Actor
		If reapproachingActor && (reapproachingActor.GetDialogueTarget() == player)
			registerForSingleUpdate(15.0)
		else
			stopReapproach()
		endif
	endif
EndEvent

Function stopReapproach(Bool bConfirm = False)
	Actor act = ReApproachingAlias.getReference() as Actor
	if act && MainScript.bIsPapyrusUtilActive && (act.GetCurrentPackage() == MainScript.customerForceGreetAgainPackage)
		ActorUtil.RemovePackageOverride(act, MainScript.customerForceGreetAgainPackage)
		ActorUtil.RemoveAllPackageOverride(MainScript.customerForceGreetAgainPackage)
	endif
	stop()
	if !bConfirm
		return
	endif
	While IsRunning()
		Utility.WaitMenuMode(0.1)
	EndWhile
EndFunction

Bool function canPunishPlayer(Actor akActor)
	if !akActor
	elseif akActor.isDead() 
	elseif akActor.isDisabled() 
	elseif !akActor.Is3DLoaded()
	elseif player.IsInCombat()
	elseif player.IsBleedingOut()
	elseif MainScript.isActorHavingSex(player)
	elseif MainScript.isActorHavingSex(akActor)
	elseif MainScript.isPlayerGettingHarassed()
	elseif !Game.IsMovementControlsEnabled()
	elseif player.GetCurrentScene() != None
	elseif MainScript.bApproachExcludeIfInScene && (akActor.GetCurrentScene() != None)
	elseif akActor.GetDistance(player) > 3000.0
	elseif MainScript.ApproachMonitorScr.isPlayerBusyInMOA()
	else 
		if akActor.isInDialogueWithPlayer()
			return true
		else
			actor targetAct = getPlayerDialogueTarget(MainScript.bIsPyramidUtilsOK)
			if !targetAct || (targetAct == akActor)
				return true
			endif
		endif
	endif
	return false
EndFunction
