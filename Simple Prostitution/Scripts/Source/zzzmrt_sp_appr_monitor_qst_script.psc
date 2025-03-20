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
Bool property bNoApproach = False Auto Hidden Conditional

Event OnInit()
	logText("OnInit() triggered for " + self)
	RegisterForEvents()
EndEvent

Event OnUpdateGameTime()
    MainScript.log("OnUpdateGameTime() triggered for " + self)
	updateApproach(true)
EndEvent

Event onDisableApproach(string eventName, string strArg, float numArg, Form sender) ;ModEvent for disabling approach. spp_approach_enable must be send to enable approach afterward.
	logText("onDisableApproach() triggered for " + self + " by " + sender)
	bNoApproach = true
	updateApproach(False)
EndEvent

Event onEnableApproach(string eventName, string strArg, float numArg, Form sender) ;ModEvent for enabling approach.
	logText("onEnableApproach() triggered for " + self + " by " + sender)
	bNoApproach = False
	updateApproach(False)
EndEvent

Event onStopApproach(string eventName, string strArg, float numArg, Form sender) ;ModEvent for only stopping current approach without disabling it.
	logText("onStopApproach() triggered for " + self + " by " + sender)
	updateApproach(False)
EndEvent

Event onUpdateApproach(Form sender, Bool bReset)
	logText("onUpdateApproach() triggered for " + self + " by " + sender) ;ModEvent for stopping current approach and trying to start a new one if bReset is true.
	updateApproach(bReset)
EndEvent

Function RegisterForEvents()
	RegisterForModEvent("spp_approach_disable", "onDisableApproach")
	RegisterForModEvent("spp_approach_enable", "onEnableApproach")
	RegisterForModEvent("spp_approach_stop", "onStopApproach")
	RegisterForModEvent("spp_approach_update", "onUpdateApproach")
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
	int i = 0
	While ApproachQst.IsRunning() && (i < 10)
		Utility.WaitMenuMode(0.1)
		i += 1
	EndWhile
EndFunction

Function updateApproach(Bool bReset = False)
	Bool doReset = (bReset && (MainScript.GetState() != "rejecting"))
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
	
	if (MainScript.fCustomerApproachTimer < 0.2)
		MainScript.log("The player can't be approached because approach timer is low: " + MainScript.fCustomerApproachTimer)
		return
	elseif bNoApproach
		MainScript.log("The player can't be approached because approach is disabled by modevent")
		return
	endif

	if !doReset
	elseif !MainScript.isPlayerKnownWhore(False)
		MainScript.log("The player can't be approached because they are not known as a prostitute.")
	elseif !MainScript.isPlayerAroused()
		MainScript.log("The player can't be approached because they are not aroused.")
	elseif !canPlayerApproached()
	elseif (getPlayerDialogueTarget(MainScript.bIsPyramidUtilsOK) != None)
		MainScript.log("The player can't be approached because they are talking to someone.")
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
			if bCustomerCanApproach && ApproachQst.IsRunning()
				if approachingActor
					String sName = approachingActor.getDisplayName()
					if sName == ""
						sName = approachingActorBase.GetName()
					endif
					if sName == "" && MainScript.bIsPO3ExtenderActive
						sName = PO3_SKSEFunctions.GetFormEditorID(approachingActor)
					endif
					string msg = approachingActor + " | " + approachingActorBase  +  " : " + sName + " approaching player from : " + approachingActor.GetDistance(MainScript.player)
					if (MainScript.bIs_SLA_Active && MainScript.iSLA_MinApproachArousal > 0)
						msg = msg + " with this arousal: " +  iArousal
					endif
					MainScript.log(msg)
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
	MainScript.isPlayerGettingHarassed()
	checkMOAStatus()
	
	!playerWearingWhoreClothing && MainScript.log("Player is not wearing prostitute outfit.", true, true, 1)
	MainScript.bOnlyLicensedApproach && !hasLicense && MainScript.log("Player doesn't have license.", true, true, 1)
	if MainScript.bIs_SLA_Active
		!MainScript.bIsPCAroused && MainScript.log("Player not aroused ("+ MainScript.iSLA_PCArousal + ")", true, true, 1)
	endif
EndFunction

Function checkActorStatus(Actor akActor)
	actorHavingSex = MainScript.isActorHavingSex(akActor)
	Int iActorArousal = MainScript.SLA_Interface.GetActorArousal(akActor)
	bIsActorAroused = (!MainScript.bIs_SLA_Active || ((MainScript.iSLA_MinApproachArousal == 0) || (iActorArousal >= MainScript.iSLA_MinApproachArousal)))
	
	if MainScript.bIs_SLA_Active
		String actorname = akActor.getDisplayName()
		MainScript.log(actorName + " arousal level is " +  iActorArousal)
		!bIsActorAroused && MainScript.log(actorName + " not aroused (" + iActorArousal + ")", true, true, 1)
	endif
EndFunction

Function checkStatus(Actor akActor)
	checkPlayerStatus()
	if akActor != player
		checkActorStatus(akActor)
	endif
EndFunction

Bool Function canContinueApproach(Actor akAproacher)
	if !isFormValid(akAproacher)
		MainScript.log("The player can't be approached because the approacher is invalid.")
		return False
	endif
	string apprName = akAproacher.getDisplayName()
	if (!MainScript.isWhore && !MainScript.isDibel)
		MainScript.log(apprName + " can't continue approaching player because the player not flaged as a prostitute or dibel. | Approacher ID = " + akAproacher)
	elseif !canPlayerApproached()
	   MainScript.log(apprName + " can't continue approaching player because the player cannot be approached. | Approacher ID = " + akAproacher)
	elseif MainScript.isActorHavingSex(akAproacher)
	   MainScript.log(apprName + " can't continue approaching player because they are having sex. | Approacher ID = " + akAproacher)
	;elseif !MainScript.bMaleCustomerApproach && !akAproacher.GetLeveledActorBase().GetSex()
	;   MainScript.log(apprName + " can't continue approaching player because males are not allowed to approach player. | Approacher ID = " + akAproacher)
	;elseif !MainScript.bFemaleCustomerApproach && akAproacher.GetLeveledActorBase().GetSex()
	;   MainScript.log(apprName + " can't continue approaching player because females are not allowed to approach player. | Approacher ID = " + akAproacher)
	;elseif !MainScript.bGuardsMayApproach && akAproacher.IsGuard()
	;   MainScript.log(apprName + " can't continue approaching player because guards are not allowed to approach player. | Approacher ID = " + akAproacher)
	elseif akAproacher.GetDistance(player) > 10000.0
	   MainScript.log(apprName + " can't continue approaching player because the player is too far away. | Approacher ID = " + akAproacher)
	else
		if !isPlayerTalkingToSomeoneElse(akAproacher)
			return true
		endif
		MainScript.log(apprName + " can't continue approaching player because the player is talking to someone else. | Approacher ID = " + akAproacher)
	endif
	return false
EndFunction

Bool Function canPlayerApproached()
    if !player.is3dloaded()
	    MainScript.log("The player cannot be approached because their 3D is not currently loaded.")
	elseif player.IsInCombat()
	    MainScript.log("The player cannot be approached because they are in combat.")
	elseif MainScript.bOnlyLicensedApproach && !playerHasLicense()
	    MainScript.log("The player cannot be approached because they don't have a license.")
	elseif MainScript.bOnlyInteriorApproach && !player.IsInInterior()
	    MainScript.log("The player cannot be approached because they are not in an interiour cell.")
	elseif !isplayerWearingWhoreClothing()
	    MainScript.log("The player cannot be approached because they are not wearing prostitute clothing.")
	elseif MainScript.ReApproachQst.IsRunning()
		MainScript.log("The player cannot be approached because they are getting harassed by an unsatisfied client.")
	elseif player.IsBleedingOut()
		MainScript.log("The player cannot be approached because they are in bleedout state.")
	elseif MainScript.isActorHavingSex(player)
		MainScript.log("The player cannot be approached because they are having sex.")
	elseif MainScript.isPlayerGettingHarassed()
		MainScript.log("The player cannot be approached because they are getting horribly harassed (SLHH).")
	elseif player.GetCurrentScene() != None
		MainScript.log("The player cannot be approached because they are busy in a scene.")
	elseif MainScript.isPlayerInBeastForm()
		MainScript.log("The player cannot be approached because they are in beast form.")
	elseif isPlayerBusyInMOA()
		MainScript.log("The player cannot be approached because they are getting handled by another mod (mark of aray).")
	else
		return true
	endif
	return false
EndFunction

Bool function canPunishPlayerForRejectingApproach(Actor akActor)
	if !isFormValid(akActor)
	   MainScript.log("The player cannot get punished because the punisher is invalid.")
	   return False
	endif
	string actorName = akActor.getDisplayName()
	if !canPlayerApproached()
	    MainScript.log(actorName + " cannot punish player because the player cannot be approached. | Punisher ID = " + akActor)
	elseif MainScript.isActorHavingSex(akActor)
	    MainScript.log(actorName + " cannot punish player because they are having sex. | Punisher ID = " + akActor)
	elseif !Game.IsMovementControlsEnabled()
	    MainScript.log(actorName + " cannot punish player because the player can't move. | Punisher ID = " + akActor)
	elseif !MainScript.bMaleCustomerApproach && !akActor.GetLeveledActorBase().GetSex()
	    MainScript.log(actorName + " cannot punish player because males are not allowed to approach player. | Punisher ID = " + akActor)
	elseif !MainScript.bFemaleCustomerApproach && akActor.GetLeveledActorBase().GetSex()
	    MainScript.log(actorName + " cannot punish player because females are not allowed to approach player. | Punisher ID = " + akActor)
	elseif !MainScript.bGuardsMayApproach && akActor.IsGuard()
	    MainScript.log(actorName + " cannot punish player because guards are not allowed to approach player. | Punisher ID = " + akActor)
	elseif akActor.GetCurrentScene() != None
	   MainScript.log(actorName + " cannot punish player because the punisher is busy in a scene. | Punisher ID = " + akActor)
	elseif akActor.GetDistance(player) > 3000.0
	   MainScript.log(actorName + " cannot punish player because the player is too far away. | Punisher ID = " + akActor)
	else 
	    if !isPlayerTalkingToSomeoneElse(akActor)
			return true
		endif
		MainScript.log(actorName + " cannot punish player because the player is talking to someone else. | Punisher ID = " + akActor)
	endif
	return false
EndFunction

Bool Function canPunishPlayerForRejectingSexOffer(Actor akActor)
	if !isFormValid(akActor)
	   MainScript.log("The player cannot get punished because the punisher is invalid.")
	   return False
	endif
	string actorName = akActor.getDisplayName()
	if MainScript.bOnlyLicensedBeggarSexOffer && !playerHasLicense()
	    MainScript.log(actorName + " cannot punish player because the player doesn't have a license. | Punisher ID = " + akActor)
	elseif MainScript.bOnlyInteriorBeggarOfferSex && !player.IsInInterior()
	   MainScript.log(actorName + " cannot punish player because the player is in an interiour cell. | Punisher ID = " + akActor)
	elseif !MainScript.bBeggingMaleSexOffer && !akActor.GetLeveledActorBase().GetSex()
		MainScript.log(actorName + " cannot punish player because males are not allowed to approach player. | Punisher ID = " + akActor)
	elseif !MainScript.bBeggingFemaleSexOffer && akActor.GetLeveledActorBase().GetSex()
		MainScript.log(actorName + " cannot punish player because females are not allowed to approach player. | Punisher ID = " + akActor)
	elseif !MainScript.bBeggarGuardsSexOffer && akActor.IsGuard()
		MainScript.log(actorName + " cannot punish player because guards are not allowed to approach player. | Punisher ID = " + akActor)
	elseif MainScript.ReApproachQst.IsRunning()
		MainScript.log(actorName + " cannot punish player because the player is getting harassed by an unsatisfied client. | Punisher ID = " + akActor)
	elseif MainScript.isActorHavingSex(player)
		MainScript.log(actorName + " cannot punish player because the player is having sex. | Punisher ID = " + akActor)
	elseif MainScript.isActorHavingSex(akActor)
		MainScript.log(actorName + " cannot punish player because they are having sex. | Punisher ID = " + akActor)
	elseif MainScript.isPlayerGettingHarassed()
		MainScript.log(actorName + " cannot punish player because the player is getting horribly harassed (SLHH). | Punisher ID = " + akActor)
	elseif !Game.IsMovementControlsEnabled()
		MainScript.log(actorName + " cannot punish player because the player can't move. | Punisher ID = " + akActor)
	elseif player.GetCurrentScene() != None
		MainScript.log(actorName + " cannot punish player because the player is busy in a scene. | Punisher ID = " + akActor)
	elseif akActor.GetCurrentScene() != None
		MainScript.log(actorName + " cannot punish player because the punisher is busy in a scene. | Punisher ID = " + akActor)
	elseif akActor.GetDistance(player) > 3000.0
		MainScript.log(actorName + " cannot punish player because the player is too far away. | Punisher ID = " + akActor)
	elseif player.IsInCombat()
		MainScript.log(actorName + " cannot punish player because the player is in combat. | Punisher ID = " + akActor)
	elseif isPlayerBusyInMOA()
		MainScript.log(actorName + " cannot punish player because the player is getting handled by another mod (mark of aray). | Punisher ID = " + akActor)
	else
	    if !isPlayerTalkingToSomeoneElse(akActor)
			return true
		endif
		MainScript.log(actorName + " cannot punish player because the player is talking to someone else. | Punisher ID = " + akActor)
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

Bool Function isPlayerTalkingToSomeoneElse(Actor akActor)
	if akActor.isInDialogueWithPlayer()
		return false
	else
		actor targetAct = getPlayerDialogueTarget(MainScript.bIsPyramidUtilsOK)
		if !targetAct || (targetAct == akActor)
			return false
		endif
	endif
	return true
EndFunction
