Scriptname zzzmrt_sp_int_ostim Hidden

Actor[] function getActorsOS(Quest OSexIntegrationMainQuest) Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	return ostim.getActors()
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
		actors[1] = Game.GetPlayer()
	elseif !isPlayerFemale && isPartnerFemale
		sGenders = "MF"
		actors[0] = Game.GetPlayer()
		actors[1] = partner
	else
		if isPlayerFemale
			sGenders = "FF"
		else
			sGenders = "MM"
		endif
		if Utility.randomInt(0,1)
			actors[0] = Game.GetPlayer()
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = Game.GetPlayer()
		endif
	endif
	Int iExtraTagsIndex = iGetExtraTagsIndex(Position, sGenders)
	if (iExtraTagsIndex > -1) && sExtraTags[iExtraTagsIndex]
		if bRequireAllTags[iExtraTagsIndex]
			anim2 = getRandomAnimationWithAllTags(actors, sExtraTags[iExtraTagsIndex] + ",")
		else
			anim2 = getRandomAnimation(actors, sExtraTags[iExtraTagsIndex] + ",")
		endif
	endif
	int i = 20
	while !anim && i > 0
		i-=1
		if Position == 0
			Anim = getRandomAnimation(actors, "vaginalsex,doggystyle,missionary,cowgirl,")

		elseif Position == 1
			Anim = getRandomAnimation(actors, "analsex,")
		else
			Anim = getRandomAnimation(actors, "blowjob,cunnilingus,sixtynine,facesitting,")
		endif
		if anim && (i > 0)
			if !bAllowAggressive 
				if IsSceneAggressiveOS(anim)
					anim = ""
				endif
			endif
		endif
    endwhile
    string myAnim = ""
    if anim2
    	if anim && Utility.randomInt(0,1)
    		myAnim = anim
    	else
    		myAnim = anim2
    	endif
    else
    	myAnim = anim
    endif
	if myAnim && (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
		return Position
	else
		Debug.trace("Simple Prostitution: [OStim] couldn't find suitable animation.")
		if bAllowAll
			myAnim = OLibrary.GetRandomScene(actors)
			if myAnim
				if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
					return Position
				endif
				Debug.trace("Simple Prostitution: [OStim] couldn't start animation.")
				return -1
			endif
			Debug.trace("Simple Prostitution: [OStim] couldn't find any animation.")
		endif
	endif
	return -1
endfunction


Bool Function IsSceneAggressiveOS(String SceneID) Global
    int aiIndex = OMetadata.GetActorCount(SceneID)
    While aiIndex > 0
        aiIndex -= 1
        If OMetadata.HasActorTag(SceneID, aiIndex, "aggressor")
        		Debug.trace("Simple Prostitution: [OStim] Scene with aggressor tag found: " + SceneID)
            Return true
        elseif OMetadata.HasActorTag(SceneID, aiIndex, "dominant")
        	Debug.trace("Simple Prostitution: [OStim] Scene with dominant tag found: " + SceneID)
        	Return true
        EndIf
    EndWhile
    Return false
EndFunction

String Function getRandomAnimation(actor[] actors, string tagCSV, string exclusion = "") Global
  string anim = OLibrary.GetRandomSceneSuperloadCSV(actors, AnySceneTag = tagCSV, AnyActionType = tagCSV, AnyActorTagForAny = tagCSV, ActionBlacklistTypes = exclusion, SceneTagBlacklist = exclusion);
  If (anim == "")
      anim = OLibrary.GetRandomSceneWithAnySceneTagCSV(actors, tagCSV)
  EndIf
  If (anim == "")
      anim = OLibrary.GetRandomSceneWithAnyActionCSV(actors, tagCSV);
  EndIf
  Return  anim
EndFunction

String Function getRandomAnimationWithAllTags(actor[] actors, string tagCSV, string exclusion = "") Global	
	string anim = OLibrary.GetRandomSceneSuperloadCSV(actors, AllSceneTags = tagCSV, AllActionTypes = tagCSV, AllActorTagsForAny = tagCSV, ActionBlacklistTypes = exclusion, SceneTagBlacklist = exclusion);
  If (anim == "")
      anim = OLibrary.GetRandomSceneWithAllSceneTagsCSV(actors, tagCSV)
  EndIf
  If (anim == "")
      anim = OLibrary.GetRandomSceneWithAllActionsCSV(actors, tagCSV);
  EndIf
  Return  anim
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
		if Utility.randomInt(0,1)
			actors[0] = player
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = player
		endif
	endif
	String  myAnim
	if bAggressive
		myAnim = getRandomAnimation(actors, "dominant,aggressor,", "")
		if myAnim == ""
			Debug.trace("Simple Prostitution: [OStim] couldn't find any Aggressive animation.")
			myAnim = OLibrary.GetRandomScene(actors)
		endif
	else
		myAnim = OLibrary.GetRandomScene(actors)
	endif
	Int iIndex = 29
	While (iIndex > 0) && (IsSceneAggressiveOS(myAnim) != bAggressive)
		myAnim = OLibrary.GetRandomScene(actors)
		iIndex -= 1
	EndWhile
	if (IsSceneAggressiveOS(myAnim) != bAggressive)
		Debug.trace("Simple Prostitution: [OStim] couldn't find any suitable animation.")
	endif
	if myAnim 
		if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
			return true
		endif
		Debug.trace("Simple Prostitution: [OStim] couldn't start animation.")
		return False
	endif
	Debug.trace("Simple Prostitution: [OStim] couldn't find any animation.")
	return False
endfunction


Bool function bHaveGroupSexWithPlayerOS(Quest OSexIntegrationMainQuest, Actor[] partners, Bool bAllowAggressive = True) Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	Actor player = Game.GetPlayer()
	if partners.length > 4
		Debug.trace("Simple Prostitution: [OStim] too many partners: " + partners)
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
		Debug.trace("Simple Prostitution: [OStim] Not enough partners (OStim): " + partners)
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
	string sAnim = OLibrary.GetRandomScene(actors)
	if !bAllowAggressive
		iIndex = 29
		While (iIndex > 0) && IsSceneAggressiveOS(sAnim)
			sAnim = OLibrary.GetRandomScene(actors)
			iIndex -= 1
		EndWhile
	endif
	if sAnim
    if OThread.QuickStart(actors, StartingAnimation = sAnim) > -1
    	return True
    endif
    Debug.trace("Simple Prostitution: [OStim] couldn't start animation.") 
    Return  false
	endif
	Debug.trace("Simple Prostitution: [OStim] couldn't find any animation for " + actors.length + " actors." )
	return False
EndFunction


