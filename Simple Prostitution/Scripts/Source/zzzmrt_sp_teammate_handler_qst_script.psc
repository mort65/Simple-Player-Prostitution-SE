Scriptname zzzmrt_sp_teammate_handler_qst_script extends Quest Conditional

import zzzmrt_sp_utility

zzzmrt_sp_main_qst_script property MainScript auto
Quest property teammMateDetector Auto

ReferenceAlias property teamMate1 Auto
ReferenceAlias property teamMate2 Auto
ReferenceAlias property teamMate3 Auto
ReferenceAlias property teamMate4 Auto
ReferenceAlias property teamMate5 Auto
ReferenceAlias property teamMate6 Auto
ReferenceAlias property teamMate7 Auto
ReferenceAlias property teamMate8 Auto
ReferenceAlias property teamMate9 Auto
ReferenceAlias property teamMate10 Auto

Form property WhoreTeamMate = None Auto Hidden Conditional
Form property teamMateClient = None Auto Hidden Conditional
FormList property BedsList auto
Spell property TeammateCustomerSpell Auto

Function detectTeamMates(Actor client)
	if !isClientReady(client)
		return
	endif
	if teammMateDetector.isrunning()
		teammMateDetector.Stop()
		while teammMateDetector.isRunning()
			Utility.wait(0.1)
		endWhile
	endif
	teammMateDetector.Start()
	int iIndex = teammMateDetector.GetNumAliases()
	ReferenceAlias TeamMateRef
	while iIndex > 0
		iIndex -= 1
		if teammMateDetector.GetNthAlias(iIndex)
			TeamMateRef = teammMateDetector.GetNthAlias(iIndex) as ReferenceAlias
			if !isTeamMateReady(TeamMateRef.GetReference() as Actor)
				TeamMateRef.clear()
			endif
		endif
	endWhile
EndFunction


Function StartWhoring(Actor Client, Actor Whore)
	if (!Client || !Whore)
		teammMateDetector.Stop()
		return
	endif
	While getstate() == "Whoring"
		Utility.wait(1.0)
	EndWhile
	teamMateClient = Client as Form
	WhoreTeamMate = Whore as Form
	GoTostate("Whoring")
EndFunction

State Whoring
	Event OnBeginState()
		if !(WhoreTeamMate as Actor) || !(teamMateClient as Actor)
			GoToState("")
		Endif
		actor whore = WhoreTeamMate as Actor
		actor whoreClient = teamMateClient as Actor
		endDialogueWithPlayer(whoreClient)
		Bool bAllowAggressive = MainScript.bTeamMateAllowAggressive
		Bool bAllowAll = MainScript.bAllPosAllowed(MainScript.fTeamMateVaginalChance, MainScript.fTeamMateAnalChance, MainScript.fTeamMateOralChance)
		Int iPosition
		if MainScript.bTeamMatePositionMenu
			iPosition = MainScript.positionChooserByMenu(whore.GetLeveledActorBase().GetSex() || whoreClient.GetLeveledActorBase().GetSex())
		else
			Int iVagChance = 0
			If (whore.GetLeveledActorBase().GetSex() || whoreClient.GetLeveledActorBase().GetSex())
				iVagChance = MainScript.fTeamMateVaginalChance as Int
			endif
			iPosition = MainScript.positionChooser(iVagChance, MainScript.fTeamMateAnalChance as Int, MainScript.fTeamMateOralChance as Int)
		endif
		String sInterf = MainScript.sGetCurAnimInteface()
		Bool bResult = False
		if ((sInterf == "flowergirls") || (sInterf == "sexlab") || (sInterf == "ostim"))
			ObjectReference bedRef
			if sInterf == "flowergirls"
				bedRef = FindBed(whore as ObjectReference)
			endif
			debug.sendanimationevent(whore, "idleforcedefaultstate")
			debug.sendanimationevent(whoreClient, "idleforcedefaultstate")
			if (!whore.Is3DLoaded() || !whoreClient.Is3DLoaded() || (bedRef && (sInterf == "flowergirls")))
				Utility.Wait(0.5)
				whore.EnableAI(False)
				whoreClient.EnableAI(False)
				if sInterf == "flowergirls"
					if !whore.Is3DLoaded()
						teleport(whore, whoreClient)
						utility.wait(0.5)
					endif
					if !whoreClient.Is3DLoaded()
						teleport(whoreClient, whore)
						utility.wait(0.5)
					endif
					if bedRef
						whore.SetPosition(bedRef.GetPositionX(), bedRef.GetPositiony(), bedRef.GetPositionz() + 30.0)
						whoreClient.SetPosition(bedRef.GetPositionX() , bedRef.GetPositiony(), bedRef.GetPositionz() + 30.0)
						Utility.wait(0.5)
					endif
				else
					if !whore.Is3DLoaded()
						teleport(whore, whoreClient)
						Utility.wait(0.5)
					endif
					if !whoreClient.Is3DLoaded()
						teleport(whoreClient, whore)
						Utility.wait(0.5)
					endif
				endif
				whore.EnableAI(True)
				whoreClient.EnableAI(True)
				whore.EvaluatePackage()
				whoreClient.EvaluatePackage()
			else
				Utility.wait(0.5)
			endif
		endif
		if sInterf == "sexlab"
			if MainScript.bIsSexlabActive
				bResult = (MainScript.SexLabNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("sexlab"), MainScript.bGetRegAllTagsArr("sexlab"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_SL_NotGroup) > -1)
				if (!bResult && MainScript.bTryAllInterfaces)
					if MainScript.bIsOstimActive
						bResult = (MainScript.OStimNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("ostim"), MainScript.bGetRegAllTagsArr("ostim"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_OS_NotGroup) > -1)
					endif
					if (!bResult && MainScript.bIsFlowerGirlsActive)
						bResult = MainScript.FlowerGirlsNPCInterface.haveSexWithActor(whoreClient, whore, iPosition)
					endif
				endif
			endif
		elseif sInterf == "ostim"
			if MainScript.bIsOstimActive
				bResult = (MainScript.OStimNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("ostim"), MainScript.bGetRegAllTagsArr("ostim"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_OS_NotGroup) > -1)
				if (!bResult && MainScript.bTryAllInterfaces)
					if MainScript.bIsSexlabActive
						bResult = (MainScript.SexLabNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("sexlab"), MainScript.bGetRegAllTagsArr("sexlab"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_SL_NotGroup) > -1)
					endif
					if (!bResult && MainScript.bIsFlowerGirlsActive)
						bResult = MainScript.FlowerGirlsNPCInterface.haveSexWithActor(whoreClient, whore, iPosition)
					endif
				endif
			endif		
		elseif sInterf == "flowergirls"
			if MainScript.bIsFlowerGirlsActive
				bResult = MainScript.FlowerGirlsNPCInterface.haveSexWithActor(whoreClient, whore, iPosition)
				if (!bResult && MainScript.bTryAllInterfaces)
					if MainScript.bIsOstimActive
						bResult = (MainScript.OStimNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("ostim"), MainScript.bGetRegAllTagsArr("ostim"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_OS_NotGroup) > -1)
					endif
					if (!bResult && MainScript.bIsSexlabActive)
						bResult = (MainScript.SexLabNPCInterface.haveSexWithActor(whoreClient, whore, iPosition, MainScript.sGetExtraTagsArr("sexlab"), MainScript.bGetRegAllTagsArr("sexlab"), bAllowAggressive, bAllowAll, MainScript.sExclude_Tags_SL_NotGroup) > -1)
					endif
				endif
			endif	
		else
			Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
			MainScript.FastFadeOut.Apply()
			Utility.Wait(1.0)
			MainScript.FastFadeOut.PopTo(MainScript.BlackScreen)
			whoreClient.EnableAI(False)
			whore.EnableAI(False)
			Utility.Wait(5.0)
			whore.EnableAI(True)
			whoreClient.EnableAI(True)
			MainScript.BlackScreen.PopTo(MainScript.FadeIn)
			Game.EnablePlayerControls()
			bResult = True
		endif
		if bResult
			payPlayer(iPosition)
			TeammateCustomerSpell.Cast(whoreClient, whoreClient)
			MainScript.persuade(MainScript.fTeamMatePersuasionXPMult)
		endif
		GoToState("")
	EndEvent
	
	Event OnEndState()
		teammMateDetector.Stop()
	EndEvent
EndState


Bool Function isTeamMateReady(Actor teamMate)
	if !teamMate
	elseif MainScript.isActorHavingSex(teamMate)
	elseif !checkArousal(teamMate, MainScript.iSLA_MinTeamMateArousal)
	elseif isWhoring(teamMate)
	else
		return true
	endif
	return False
EndFunction

Bool Function isClientReady(Actor client)
	if !client
	elseif MainScript.isActorHavingSex(client)
	elseif (MainScript.bExcludeIfInScene && client.GetCurrentScene())
		MainScript.log(client.GetDisplayName() + " is busy.", true, true, 1)
	elseif !checkArousal(client, MainScript.iSLA_MinTeamMateCustomerArousal)
	else
		return true
	endif
	return False
EndFunction

Function payPlayer(Int position)
	Float fSpeech
	if MainScript.bTeamMatePayUseBaseSpeech
		fSpeech = MainScript.player.GetBaseActorValue("Speechcraft")
	else
		fSpeech = MainScript.player.getActorValue("Speechcraft")
	endif
	Int minBonus = maxInt(0, ((fSpeech * MainScript.fTeamMateMinSpeechBonusMult) As Int) + 1)
	Int maxBonus = maxInt(0, ((fSpeech * MainScript.fTeamMateMaxSpeechBonusMult) As Int) + 1)
	minBonus = minInt(minBonus,maxBonus)
	maxBonus = maxInt(minBonus,maxBonus)
	int positionReward = 0
	if position == 0
		positionReward = MainScript.fTeamMateVagPay As Int
	elseif position == 1
		positionReward = MainScript.fTeamMateAnalPay As Int
	elseif position == 2
		positionReward = MainScript.fTeamMateOralPay As Int
	endif
	Int totalPay = maxInt(0, positionReward + MainScript.randInt(minBonus, maxBonus))
	MainScript.player.additem(MainScript.Gold, totalPay)
	if MainScript.fTeamMateMarkChance > 0.0
		MainScript.addDibelMarkToPlayer(MainScript.fTeamMateMarkChance, 1)
	endif
	if MainScript.fTeamMateExtraRewardChance > 0.0
		MainScript.addExtraRewardsToPlayer(MainScript.fTeamMateExtraRewardChance, MainScript.fTeamMateExtraRewardEnchantedChance, 1)
	endif
EndFunction

Bool function checkArousal(Actor act, Int iMinArousal = 0)
	if !act
		return false
	endif
	if (!MainScript.bIs_SLA_Active || iMinArousal < 1)
		return true
	endif
	int iArousal = MainScript.SLA_Interface.GetActorArousal(act)
	if (iArousal >= iMinArousal)
		return true
	endif
	MainScript.log(act.GetDisplayName() + " not aroused (" + iArousal + ")", true, true, 1)
	return False
endfunction

Bool Function isWhoring(Actor act)
	return (WhoreTeamMate && (GetState() == "Whoring") && (WhoreTeamMate == (act as Form)))
EndFunction

Function endWhoring(Actor client, Bool bComplete = true)
	bComplete && client && TeammateCustomerSpell.Cast(client, client)
	teammMateDetector.Stop()
Endfunction

ObjectReference function FindBed(ObjectReference CenterRef, float Radius=1600.0)
  if !CenterRef
    return none
  endif
  if MainScript.bIsOstimActive
    return MainScript.OStimInterface.FindBed(CenterRef, Radius)
  endif
  if (Radius < 1.0)
	return None
  endif
  ObjectReference NearRef
  ObjectReference BedRef
  Form[] Suppressed = new Form[10]
  ObjectReference anyBedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
  if anyBedRef
	  if CheckBed(anyBedRef)
		if anyBedRef.GetDistance(CenterRef) < 600.0
			return anyBedRef
		else
			NearRef = anyBedRef
		endif
	  else
		Suppressed[0] = anyBedRef
	  endif
  else
    return None
  endif
  
  int j
  int i = BedsList.GetSize()
  Float fBedDistance
  while i
    i -= 1
    Form BedType = BedsList.GetAt(i)
    if BedType
      BedRef = Game.FindClosestReferenceOfTypeFromRef(BedType, CenterRef, Radius)
      if (BedRef && (Suppressed.Find(BedRef) == -1) && CheckBed(BedRef))
		fBedDistance = BedRef.GetDistance(CenterRef)
        if (!NearRef || (fBedDistance < NearRef.GetDistance(CenterRef)))
		  if fBedDistance < 600.0
		    return NearRef
		  endif
		  NearRef = BedRef
        endif
      endif
    endif
  endwhile
  
  if NearRef
    return NearRef
  endif

  i = 12
  while i
    i -= 1
    BedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
    if !BedRef
		return none
	elseif (Suppressed.Find(BedRef) > -1)
	else
		if CheckBed(BedRef)
			return BedRef
		else
		  j = Suppressed.Find(None)
		  if j > -1
			Suppressed[j] = BedRef
		  else
			return none
		  endif
		endif
    endif
  endwhile
  return none
endfunction

bool function CheckBed(ObjectReference BedRef, bool IgnoreUsed=true)
  return BedRef && BedRef.IsEnabled() && BedRef.Is3DLoaded() && (!IgnoreUsed || !BedRef.IsFurnitureInUse(true))
endfunction

Bool Function isFollower(Actor act)
	return (act && (act.isPlayerTeammate() || act.IsInFaction(MainScript.playerFollowerFaction)))
EndFunction