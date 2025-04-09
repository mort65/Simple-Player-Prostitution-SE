Scriptname zzzmrt_sp_int_ostim Hidden

import zzzmrt_sp_utility

Actor[] function getActorsOS(Quest OSexIntegrationMainQuest) Global
	;OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	return OThread.GetActors(0)
EndFunction

Bool function isActorActiveOS(Quest OSexIntegrationMainQuest, Actor act) Global
  OSexIntegrationMain OSexMainQuest = OSexIntegrationMainQuest as OSexIntegrationMain
  return OSexMainQuest.IsActorActive(act)
EndFunction

Bool function isActorVictimOS(Quest OSexIntegrationMainQuest, Actor act) Global
  OSexIntegrationMain OSexMainQuest = OSexIntegrationMainQuest as OSexIntegrationMain
  return OSexMainQuest.IsVictim(act)
EndFunction

int function haveSexWithPlayerOS(Quest OSexIntegrationMainQuest, Actor partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll =False) Global
	if Position < 0
	  return -1
	endif
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	string anim = ""
	string anim2 = ""
	actor[] actors = new actor[2]
	string sGenders = ""
  actor player = Game.GetPlayer()
	Bool isPlayerFemale = ostim.isFemale(player)
	Bool isPartnerFemale = ostim.isFemale(partner)
	if isPlayerFemale && !isPartnerFemale
		sGenders = "MF"
		actors[0] = partner
		actors[1] = player
	elseif !isPlayerFemale && isPartnerFemale
		sGenders = "MF"
		actors[0] = player
		actors[1] = partner
	else
		if isPlayerFemale
			sGenders = "FF"
		else
			sGenders = "MM"
		endif
		if Utility.randomInt(0,1)
			actors[0] = player
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = player
		endif
	endif
	Int iExtraTagsIndex = iGetExtraTagsIndex(Position, sGenders)
	Int iAggressive = -1
	if !bAllowAggressive 
		iAggressive = 0
	endif
	if (iExtraTagsIndex > -1) && sExtraTags[iExtraTagsIndex]
		if bRequireAllTags[iExtraTagsIndex]
			anim2 = getRandomAnimationWithAllTags(actors, sExtraTags[iExtraTagsIndex] + ",", "", iAggressive)
		else
			anim2 = getRandomAnimation(actors, sExtraTags[iExtraTagsIndex] + ",", "", iAggressive)
		endif
		if !anim2
		    logText("[OStim] couldn't find any animation with these tags: " + sExtraTags[iExtraTagsIndex], False, True, 2)
		endif
	endif
	string myAnim = anim2
	if !myAnim
		if Position == 0
			Anim = getRandomAnimation(actors, "vaginalsex,doggystyle,missionary,cowgirl,", "", iAggressive)
		elseif Position == 1
			Anim = getRandomAnimation(actors, "analsex,", "", iAggressive)
		else
			Anim = getRandomAnimation(actors, "blowjob,cunnilingus,sixtynine,facesitting,", "", iAggressive)
		endif
		myAnim = Anim
	endif
	if myAnim
		logText("[OStim] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
		if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
			return Position
		endif
	else
		logText("[OStim] couldn't find suitable animation.", False, True, 2)
		if bAllowAll
			myAnim = getRandomAnimation(actors)
			if myAnim
				logText("[OStim] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
				if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
					return Position
				endif
				logText("[OStim] couldn't start animation.", False, True, 2)
				return -1
			endif
			logText("[OStim] couldn't find any animation.", False, True, 2)
		endif
	endif
	return -1
endfunction

Bool function bHaveRandomSexWithPlayerOS(Quest OSexIntegrationMainQuest, Actor partner, Bool bAggressive = False) Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	actor[] actors = new actor[2]
	actor player = Game.GetPlayer()
	Bool isPlayerFemale = ostim.isFemale(player)
	Bool isPartnerFemale = ostim.isFemale(partner)
	if isPlayerFemale && !isPartnerFemale
		actors[0] = partner
		actors[1] = player
	elseif !isPlayerFemale && isPartnerFemale
		actors[0] = player
		actors[1] = partner
	else
		if Utility.randomInt(0,1) || bAggressive
			actors[0] = player
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = player
		endif
	endif
	String  myAnim
	if bAggressive
		myAnim = getRandomAnimation(actors, "dominant,aggressor,", "", 1)
		if myAnim == ""
			logText("[OStim] couldn't find any suitable animation.", False, True, 2)
			myAnim = getRandomAnimation(actors, "", "", 1)
		endif
	else
		myAnim = getRandomAnimation(actors, "", "", 0)
	endif
	if myAnim
		logText("[OStim] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
		if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
			return true
		endif
		logText("[OStim] couldn't start animation.", False, True, 2)
		return False
	endif
	logText("[OStim] couldn't find any animation.", False, True, 2)
	return False
endfunction


Bool function bHaveGroupSexWithPlayerOS(Quest OSexIntegrationMainQuest, Actor[] partners, Bool bAllowAggressive = True, String sExcludedTags = "") Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	Actor player = Game.GetPlayer()
	if partners.length > 4
	    logText("[OStim] too many partners: " + partners, False, True, 2)
		return False
	endif
	int totalPartners = partners.Length
	Int iIndex = totalPartners
	while iIndex > 0
		iIndex -= 1
		if !partners[iIndex]
			totalPartners -= 1
		endIf
	EndWhile
	Actor[] actors
	int totalActors = totalPartners + 1
	if totalActors == 5
		actors = new actor[5]
	ElseIf totalActors == 4
		actors = new actor[4]
	ElseIf totalActors == 3
		actors = new actor[3]
	ElseIf totalActors == 2
		actors = new actor[2]
	elseIf totalActors <= 1 ; onlyplayer
	    logText("[OStim] Not enough partners: " + partners, False, True, 2)
		return False
	endif
		
	Bool isPlayerFemale = ostim.isFemale(player)
	iIndex = partners.length
	int jIndex = 0
	int kIndex = totalActors - 1
	if isPlayerFemale
		actors[kIndex] = player
		kIndex -= 1
	else
		actors[jIndex] = player
		jIndex += 1
	endif
	While iIndex > 0
		iIndex -= 1
		if partners[iIndex]
			if ostim.isFemale(partners[iIndex])
				actors[kIndex] = partners[iIndex]
				kIndex -= 1
			else
				actors[jIndex] = partners[iIndex]
				jIndex += 1
			endif
		endif
	EndWhile
	string sAnim
	if bAllowAggressive && (sExcludedTags == "")
		sAnim = getRandomAnimation(actors)
	else
		sAnim = getRandomAnimation(actors, "", sExcludedTags, 0)
	endif
	if sAnim
		logText("[OStim] Scene Name: " + OMetadata.GetName(sAnim) + ", Scene ID: " + sAnim + ", Scene Tags: " + OMetadata.GetSceneTags(sAnim))
		if OThread.QuickStart(actors, StartingAnimation = sAnim) > -1
			return True
		endif
		logText("[OStim] couldn't start animation.", False, True, 2)
		Return  false
	endif
	logText("[OStim] couldn't find any animation for " + actors.length + " actors.", False, True, 2)
	return False
EndFunction

Bool Function IsSceneAggressiveOS(String SceneID) Global
    if OMetadata.HasAnySceneTagCSV(SceneID, "aggressive,forced,rough,")
		logText("[OStim] Scene with aggressive tag found: " + SceneID)
    	Return true
    endif
    int aiIndex = OMetadata.GetActorCount(SceneID)
    While aiIndex > 0
        aiIndex -= 1
        if OMetadata.HasAnyActorTagCSV(SceneID, aiIndex, "aggressor,dominant,")
		    logText("[OStim] Scene with aggressive actor tag found: " + SceneID)
        	Return true
        EndIf
    EndWhile
    Return false
EndFunction

String Function getRandomAnimation(actor[] actors, string tagCSV = "", string exclusion = "", Int iAggressive = -1)  Global
  int i = 29
  string anim = ""
  Bool bAnimInRange = False
  Bool bAggressionFound = (iAggressive == -1)
  while ((i > 0) && (!bAggressionFound || (anim == "") || !bAnimInRange))
	  bAnimInRange = False
	  if ((tagCSV == "") && (exclusion == ""))
		  Anim = OLibrary.GetRandomScene(actors)
		  if Anim
			bAnimInRange = hasScenesInRange(anim, actors)
		  Endif
	  else
		  anim = OLibrary.GetRandomSceneSuperloadCSV(actors, AnySceneTag = tagCSV, AnyActionType = tagCSV, AnyActorTagForAny = tagCSV, ActionBlacklistTypes = exclusion, SceneTagBlacklist = exclusion);
		  If (anim == "")
			  anim = OLibrary.GetRandomSceneWithAnySceneTagCSV(actors, tagCSV)
			  if anim
				bAnimInRange = hasScenesInRange(anim, actors)
			  endif
		  Else
			bAnimInRange = hasScenesInRange(anim, actors)
		  EndIf
		  If (anim == "")
			  anim = OLibrary.GetRandomSceneWithAnyActionCSV(actors, tagCSV)
			  if anim
				bAnimInRange = hasScenesInRange(anim, actors)
			  endif
		  Else
			bAnimInRange = hasScenesInRange(anim, actors)
		  EndIf
	  Endif
	  if iAggressive == 0
		bAggressionFound = (anim && !IsSceneAggressiveOS(anim))
	  Elseif iAggressive == 1
		bAggressionFound = (anim && IsSceneAggressiveOS(anim))
	  Endif
	  i -= 1
  EndWhile
  Return  anim
EndFunction

String Function getRandomAnimationWithAllTags(actor[] actors, string tagCSV, string exclusion = "", Int iAggressive = -1) Global	
  int i = 29
  string anim = ""
  Bool bAnimInRange = False
  Bool bAggressionFound = (iAggressive == -1)
  while ((i > 0) && (!bAggressionFound || (anim == "") || !bAnimInRange))
	  bAnimInRange = False
	  anim = OLibrary.GetRandomSceneSuperloadCSV(actors, AllSceneTags = tagCSV, AllActionTypes = tagCSV, AllActorTagsForAny = tagCSV, ActionBlacklistTypes = exclusion, SceneTagBlacklist = exclusion)
	  If (anim == "")
		  anim = OLibrary.GetRandomSceneWithAllSceneTagsCSV(actors, tagCSV)
		  if anim
			bAnimInRange = hasScenesInRange(anim, actors)
		  Endif
	  Else
		bAnimInRange = hasScenesInRange(anim, actors)
	  EndIf
	  If (anim == "")
		  anim = OLibrary.GetRandomSceneWithAllActionsCSV(actors, tagCSV)
		  if anim
			bAnimInRange = hasScenesInRange(anim, actors)
		  Endif
	  Else
		  bAnimInRange = hasScenesInRange(anim, actors)
	  EndIf
	  if iAggressive == 0
		bAggressionFound = (anim && !IsSceneAggressiveOS(anim))
	  Elseif iAggressive == 1
		bAggressionFound = (anim && IsSceneAggressiveOS(anim))
	  Endif
	  i -= 1
  EndWhile
  Return  anim
EndFunction

Bool function hasScenesInRange(string Id, Actor[] Actors) Global
	String[] Scenes = OLibrary.GetScenesInRange(Id, actors)
	return (Scenes && (Scenes.length > 0))
EndFunction

int Function iGetExtraTagsIndex(string iPos, string sGenders) Global
  if iPos == 0
    if sGenders == "MF"
      return 6
    elseif sGenders == "FF"
      return 7
    endif
  elseif iPos == 1
    if sGenders == "MF"
      return 3
    elseif sGenders == "FF"
      return 4
    elseif sGenders == "MM"
      return 5
    endif
  elseif iPos == 2
    if sGenders == "MF"
      return 0
    elseif sGenders == "FF"
      return 1
    elseif sGenders == "MM"
      return 2
    endif
  endif
  return -1
endfunction



