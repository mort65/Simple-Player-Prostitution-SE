Scriptname zzzmrt_sp_appr_monitor_qst_script extends Quest  Conditional

ReferenceAlias property approachingRef auto
Quest Property ApproachQst auto
Actor property player auto
zzzmrt_sp_main_qst_script property MainScript auto

Bool property hasWhoreLicense = False Auto Hidden Conditional
Bool property hasDibelLicense = False Auto Hidden Conditional
Bool property hasLicense = False Auto Hidden Conditional
Bool property playerHavingSex = false Auto Hidden Conditional
Bool property playerWearingWhoreClothing = false Auto Hidden Conditional

Event OnUpdateGameTime()
	debug.trace("Simple Prostitution: OnUpdateGameTime() triggered for "+ self)
	updateApproach(True)
EndEvent

 Function PlayerLoadsGame()
 	debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for "+ self)
 	updateApproach(False)
EndFunction


Function stopApproach()
	ApproachQst.stop()
EndFunction

Function updateApproach(Bool bReset = False)
	actor approachingActor = approachingRef.getref() as actor
	Bool doReset = bReset
	if approachingRef
		if ApproachQst.IsRunning()
			if approachingActor.GetDialogueTarget() == player
				doReset = false
			else
				ApproachQst.stop()
				While ApproachQst.IsRunning()
					utility.wait(0.2)
				EndWhile
			endIf
		endIf
	endIf
	
	if MainScript.iCustomerApproachTimer < 1
		return
	endif

	if !doReset
	elseif !playerHasLicense()
	elseif !isplayerWearingWhoreClothing()
	elseif MainScript.bOnlyInteriorApproach && !player.IsInInterior()
	else
		ApproachQst.start()
	endif
		
	if doReset && playerHasLicense() && MainScript.iCustomerApproachTimer > 0
		ApproachQst.start()
	endif
	self.RegisterForSingleUpdateGameTime(MainScript.iCustomerApproachTimer + 1)
EndFunction

Bool Function playerHasLicense()
	hasWhoreLicense = MainScript.playerHasWhoreLicense()
	hasDibelLicense = MainScript.playerHasDibelLicence()
	if MainScript.bDibelEnabled && MainScript.isDibel
		hasLicense = (hasDibelLicense || hasWhoreLicense)
	elseif MainScript.bWhoreEnabled && MainScript.isWhore
		hasLicense = hasWhoreLicense
	else
		hasLicense = false
	endif
	return hasLicense
endfunction

Bool function isplayerHavingSex()
  playerHavingSex = MainScript.isActorHavingSex(player)
  return playerHavingSex
EndFunction

Bool function isplayerWearingWhoreClothing()
	if MainScript.bOnlyWhoreClothingApproach && !player.WornHasKeyword(MainScript.ProstituteClothing_kwd) && \
		!player.isEquipped(MainScript.whoreClothingList) && (player.WornHasKeyword(MainScript.ClothingBody_kwd) || player.WornHasKeyword(MainScript.ArmorCuirass_kwd))
		playerWearingWhoreClothing = False
	endif
	playerWearingWhoreClothing = True
	return playerWearingWhoreClothing
EndFunction


Function checkPlayerStatus()
	isplayerWearingWhoreClothing()
	isplayerHavingSex()
	playerHasLicense()
EndFunction
