Scriptname zzzmrt_sp_appr_monitor_qst_script extends Quest  Conditional

import zzzmrt_sp_utility

ReferenceAlias property approachingRef auto
Quest Property ApproachQst auto
Actor property player auto
zzzmrt_sp_main_qst_script property MainScript auto
Formlist property checkedActors Auto
Bool property bCustomerCanApproach = false Auto Hidden Conditional

Bool property hasWhoreLicense = False Auto Hidden Conditional
Bool property hasDibelLicense = False Auto Hidden Conditional
Bool property hasLicense = False Auto Hidden Conditional
Bool property playerHavingSex = false Auto Hidden Conditional
Bool property actorHavingSex = False Auto Hidden Conditional
Bool property bIsActorAroused = False Auto Hidden Conditional
Bool property playerWearingWhoreClothing = false Auto Hidden Conditional
Bool property playerIsBusyInMOA = false Auto Hidden Conditional

Event OnUpdateGameTime()
	debug.trace("Simple Prostitution: OnUpdateGameTime() triggered for "+ self)
	updateApproach(true)
EndEvent

Function PlayerLoadsGame()
	debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for "+ self)
	updateApproach(False)
EndFunction


Function stopApproach(Bool bConfirm = true)
	bCustomerCanApproach = False
	actor apprActor = approachingRef.GetActorRef()
	if MainScript.bIsPapyrusUtilActive && apprActor && (apprActor.GetCurrentPackage() == MainScript.customerForceGreetPackage)
		ActorUtil.RemovePackageOverride(apprActor, MainScript.customerForceGreetPackage)
		;apprActor.EvaluatePackage()
	endif
	ApproachQst.stop()
	if !bConfirm
		return
	endif
	While ApproachQst.IsRunning()
		Utility.WaitMenuMode(0.1)
	EndWhile
EndFunction

Function updateApproach(Bool bReset = False)
	Bool doReset = (bReset && !MainScript.bRejecting)
	actor approachingActor
	Form approachingActorBase
	int iArousal = 0
	if ApproachQst.IsRunning()
		approachingActor = approachingRef.GetReference() as actor
		approachingActorBase = approachingActor.GetLeveledActorBase()
		if approachingActor.GetDialogueTarget() == player
			doReset = false
		else
			stopApproach(doReset)
		endif
	endif
	
	if MainScript.fCustomerApproachTimer < 0.2
		return
	endif

	if !doReset
	elseif !MainScript.isPlayerKnownWhore(False)
	elseif !MainScript.isPlayerAroused()
	elseif !canPlayerApproached()
	elseif MainScript.randInt(0,99) < MainScript.fCustomerApproachChance as Int
		checkedActors.revert()
		bCustomerCanApproach = false
		ApproachQst.start()
		if ApproachQst.IsRunning()
			approachingActor = approachingRef.GetReference() as actor
			approachingActorBase = approachingActor.GetLeveledActorBase()
			if MainScript.bIs_SLA_Active && (MainScript.iSLA_MinApproachArousal > 0)
				int i = 14
				iArousal = MainScript.SLA_Interface.GetActorArousal(approachingActor)
				while i > 0 && ApproachQst.IsRunning() && approachingActor && (iArousal < MainScript.iSLA_MinApproachArousal)
					i -= 1
					if approachingActorBase
						checkedActors.AddForm(approachingActorBase)
					endif
					ApproachQst.stop()
					While ApproachQst.IsRunning()
						Utility.WaitMenuMode(0.1)
					EndWhile
					ApproachQst.start()
					if ApproachQst.IsRunning()
						approachingActor = approachingRef.GetReference() as actor
						approachingActorBase = approachingActor.GetLeveledActorBase()
						iArousal = MainScript.SLA_Interface.GetActorArousal(approachingActor)
					endif
				EndWhile
				if ApproachQst.IsRunning() && approachingActor && (iArousal >= MainScript.iSLA_MinApproachArousal)
					bCustomerCanApproach = true
				else
					stopApproach(true)
				endif
			else
				bCustomerCanApproach = true
			endif
			if bCustomerCanApproach
				if approachingActor
					String sName = approachingActorBase.GetName()
					if sName == "" && MainScript.bIsPO3ExtenderActive
						sName = PO3_SKSEFunctions.GetFormEditorID(approachingActor)
					endif
					string msg = "Simple Prostitution: " + approachingActor + " | " + approachingActorBase  +  " : " + sName + " approaching player from : " + approachingActor.GetDistance(MainScript.player)
					if (MainScript.bIs_SLA_Active && MainScript.iSLA_MinApproachArousal > 0)
						msg = msg + " with this arousal: " +  iArousal
					endif
					Debug.trace(msg)
				endif
			endif
		endif
		checkedActors.revert()
	endif
	
	self.RegisterForSingleUpdateGameTime(MainScript.fCustomerApproachTimer)
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
	MainScript.isPlayerAroused()
	checkMOAStatus()
EndFunction

Function checkActorStatus(Actor akActor)
	actorHavingSex = MainScript.isActorHavingSex(akActor)
	bIsActorAroused = (!MainScript.bIs_SLA_Active || ((MainScript.iSLA_MinApproachArousal == 0) || (MainScript.SLA_Interface.GetActorArousal(akActor) >= MainScript.iSLA_MinApproachArousal)))
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
			actor targetAct = getPlayerDialogueTarget(MainScript.bIsPyramidUtilsOK)
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
			actor targetAct = getPlayerDialogueTarget(MainScript.bIsPyramidUtilsOK)
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
