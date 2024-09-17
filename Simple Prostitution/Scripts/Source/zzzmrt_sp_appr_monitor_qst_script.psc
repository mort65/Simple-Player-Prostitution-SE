Scriptname zzzmrt_sp_appr_monitor_qst_script extends Quest  Conditional

import zzzmrt_sp_utility

ReferenceAlias property approachingRef auto
Quest Property ApproachQst auto
Actor property player auto
zzzmrt_sp_main_qst_script property MainScript auto

Bool property hasWhoreLicense = False Auto Hidden Conditional
Bool property hasDibelLicense = False Auto Hidden Conditional
Bool property hasLicense = False Auto Hidden Conditional
Bool property playerHavingSex = false Auto Hidden Conditional
Bool property actorHavingSex = False Auto Hidden Conditional
Bool property playerWearingWhoreClothing = false Auto Hidden Conditional
Bool property playerIsBusyInMOA = false Auto Hidden Conditional

Event OnUpdateGameTime()
	debug.trace("Simple Prostitution: OnUpdateGameTime() triggered for "+ self)
	updateApproach(True)
EndEvent

Function PlayerLoadsGame()
	debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for "+ self)
	updateApproach(False)
EndFunction


Function stopApproach(Bool bConfirm = true)
	actor apprActor = approachingRef.GetActorRef()
	ApproachQst.stop()
	if !bConfirm
		return
	endif
	While ApproachQst.IsRunning()
		Utility.WaitMenuMode(0.1)
	EndWhile
	if MainScript.bIsPapyrusUtilActive && apprActor && (apprActor.GetCurrentPackage() == MainScript.customerForceGreetPackage)
		ActorUtil.RemovePackageOverride(apprActor, MainScript.customerForceGreetPackage)
		apprActor.EvaluatePackage()
	endif
EndFunction

Function updateApproach(Bool bReset = False)
	actor approachingActor = approachingRef.getref() as actor
	Bool doReset = bReset
	if approachingRef
		if ApproachQst.IsRunning()
			if approachingActor.GetDialogueTarget() == player
				doReset = false
			else
				stopApproach(doReset)
			endif
		endIf
	endIf
	
	if MainScript.iCustomerApproachTimer < 1
		return
	endif

	if !doReset
	elseif !MainScript.isPlayerKnownWhore(False)
	elseif !canPlayerApproached()
	elseif MainScript.randInt(0,99) < MainScript.fCustomerApproachChance as Int
		ApproachQst.start()
	endif
	
	self.RegisterForSingleUpdateGameTime(MainScript.iCustomerApproachTimer)
EndFunction

Bool Function playerHasLicense()
	hasWhoreLicense = MainScript.playerHasWhoreLicense()
	hasDibelLicense = MainScript.playerHasDibelLicence()
	if MainScript.bDibelEnabled && MainScript.isDibel
		hasLicense = hasDibelLicense
	elseif MainScript.bWhoreEnabled && MainScript.isWhore
		hasLicense = hasWhoreLicense
	else
		hasLicense = false
	endif
	return hasLicense
endfunction

Bool function isplayerWearingWhoreClothing()
	if MainScript.bOnlyWhoreClothingApproach
		if player.WornHasKeyword(MainScript.ProstituteClothing_kwd)
		elseif player.isEquipped(MainScript.whoreClothingList)
		elseif (!player.WornHasKeyword(MainScript.ClothingBody_kwd) && !player.WornHasKeyword(MainScript.ArmorCuirass_kwd))
		else
			playerWearingWhoreClothing = false
			return playerWearingWhoreClothing
		endif
		playerWearingWhoreClothing = true
		return playerWearingWhoreClothing
	endif
	playerWearingWhoreClothing = true
	return playerWearingWhoreClothing
EndFunction


Function checkPlayerStatus()
	isplayerWearingWhoreClothing()
	playerHasLicense()
	playerHavingSex = MainScript.isActorHavingSex(player)
	checkMOAStatus()
EndFunction

Function checkActorStatus(Actor akActor)
	actorHavingSex = MainScript.isActorHavingSex(akActor)
EndFunction

Function checkStatus(Actor akActor)
	checkPlayerStatus()
	if akActor != player
		checkActorStatus(akActor)
	endif
EndFunction

Bool Function canPlayerApproached()
	if player.IsInCombat()
	elseif MainScript.bOnlyLicensedApproach && !playerHasLicense()
	elseif MainScript.bOnlyInteriorApproach && !player.IsInInterior()
	elseif !isplayerWearingWhoreClothing()
	else
		return true
	endif
	return false
EndFunction

Bool function canPunishPlayerForRejectingApproach(Actor akActor)
	if !akActor
	elseif !canPlayerApproached()
	elseif player.IsBleedingOut()
	elseif MainScript.isActorHavingSex(player)
	elseif MainScript.isActorHavingSex(akActor)
	elseif !Game.IsMovementControlsEnabled()
	elseif !MainScript.bMaleCustomerApproach && !akActor.GetLeveledActorBase().GetSex()
	elseif !MainScript.bFemaleCustomerApproach && akActor.GetLeveledActorBase().GetSex()
	elseif !MainScript.bGuardsMayApproach && akActor.IsGuard()
	elseif player.GetCurrentScene() != None
	elseif akActor.GetCurrentScene() != None
	elseif akActor.GetDistance(player) > 3000.0
	elseif isPlayerBusyInMOA()
	else 
		if akActor.isInDialogueWithPlayer()
			return true
		else
			actor targetAct = getPlayerDialogueTarget(player)
			if !targetAct || (targetAct == akActor)
				return true
			endif
		endif
	endif
	return false
EndFunction

Bool Function canPunishPlayerForRejectingSexOffer(Actor akActor)
	if MainScript.bOnlyLicensedBeggarSexOffer && !playerHasLicense()
	elseif MainScript.bOnlyInteriorBeggarOfferSex && !player.IsInInterior()
	elseif !MainScript.bBeggingMaleSexOffer && !akActor.GetLeveledActorBase().GetSex()
	elseif !MainScript.bBeggingFemaleSexOffer && akActor.GetLeveledActorBase().GetSex()
	elseif !MainScript.bBeggarGuardsSexOffer && akActor.IsGuard()
	elseif MainScript.isActorHavingSex(player)
	elseif MainScript.isActorHavingSex(akActor)
	elseif !Game.IsMovementControlsEnabled()
	elseif player.GetCurrentScene() != None
	elseif akActor.GetCurrentScene() != None
	elseif akActor.GetDistance(player) > 3000.0
	elseif player.IsInCombat()
	elseif isPlayerBusyInMOA()
	else
		if akActor.isInDialogueWithPlayer()
			return true
		else
			actor targetAct = getPlayerDialogueTarget(player)
			if !targetAct || (targetAct == akActor)
				return true
			endif
		endif
	endif
	return False
EndFunction


Function checkMOAStatus()
	playerIsBusyInMOA = player.haskeywordstring("zzzmoa_ActorBusy_KWD")
EndFunction

Bool Function isPlayerBusyInMOA()
	checkMOAStatus()
	return playerIsBusyInMOA
EndFunction
