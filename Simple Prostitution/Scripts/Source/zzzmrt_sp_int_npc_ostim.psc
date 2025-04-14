Scriptname zzzmrt_sp_int_npc_ostim Hidden

import zzzmrt_sp_utility
import zzzmrt_sp_int_ostim

Bool function isActorActiveOS(Quest OSexIntegrationMainQuest, Actor act) Global
  OSexIntegrationMain OSexMainQuest = OSexIntegrationMainQuest as OSexIntegrationMain
  return OSexMainQuest.IsActorActive(act)
EndFunction

int function haveSexWithActorOS(Quest OSexIntegrationMainQuest, Actor partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "") Global
	if Position < 0
	  return -1
	endif
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	string anim = ""
	string anim2 = ""
	actor[] actors = new actor[2]
	string sGenders = ""
	Bool isActorFemale = ostim.isFemale(act)
	Bool isPartnerFemale = ostim.isFemale(partner)
	if isActorFemale && !isPartnerFemale
		sGenders = "MF"
		actors[0] = partner
		actors[1] = act
	elseif !isActorFemale && isPartnerFemale
		sGenders = "MF"
		actors[0] = act
		actors[1] = partner
	else
		if isActorFemale
			sGenders = "FF"
		else
			sGenders = "MM"
		endif
		if Utility.randomInt(0,1)
			actors[0] = act
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = act
		endif
	endif
	Int iExtraTagsIndex = iGetExtraTagsIndex(Position, sGenders)
	Int iAggressive = -1
	if !bAllowAggressive 
		iAggressive = 0
	endif
	if (iExtraTagsIndex > -1) && sExtraTags[iExtraTagsIndex]
		if bRequireAllTags[iExtraTagsIndex]
			anim2 = getRandomAnimationWithAllTags(actors, sExtraTags[iExtraTagsIndex] + ",", sExcludedTags, iAggressive)
		else
			anim2 = getRandomAnimation(actors, sExtraTags[iExtraTagsIndex] + ",", sExcludedTags, iAggressive)
		endif
		if (!anim2 && sExcludedTags)
		    logText("[OStim_NPC] couldn't find any animation with these tags: " + sExtraTags[iExtraTagsIndex] + " and these excluded tags: " + sExcludedTags, False, True, 2)
			if bRequireAllTags[iExtraTagsIndex]
				anim2 = getRandomAnimationWithAllTags(actors, sExtraTags[iExtraTagsIndex] + ",", "", iAggressive)
			else
				anim2 = getRandomAnimation(actors, sExtraTags[iExtraTagsIndex] + ",", "", iAggressive)
			endif
		endif
		!anim2 && logText("[OStim_NPC] couldn't find any animation with these tags: " + sExtraTags[iExtraTagsIndex], False, True, 2)
	endif
	string myAnim = anim2
	if (!myAnim && sExcludedTags)
		if Position == 0
			Anim = getRandomAnimation(actors, "vaginalsex,doggystyle,missionary,cowgirl,", sExcludedTags, iAggressive)
		elseif Position == 1
			Anim = getRandomAnimation(actors, "analsex,", sExcludedTags, iAggressive)
		else
			Anim = getRandomAnimation(actors, "blowjob,cunnilingus,sixtynine,facesitting,", sExcludedTags, iAggressive)
		endif
		myAnim = Anim
		!myAnim && logText("[OStim_NPC] couldn't find any suitable animation without these excluded tags: " + sExcludedTags, False, True, 2)
	endif
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
		logText("[OStim_NPC] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
		if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
			return Position
		endif
	else
		logText("[OStim_NPC] couldn't find suitable animation.", False, True, 2)
		if bAllowAll
			myAnim = getRandomAnimation(actors)
			if myAnim
				logText("[OStim_NPC] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
				if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
					return Position
				endif
				logText("[OStim_NPC] couldn't start animation.", False, True, 2)
				return -1
			endif
			logText("[OStim_NPC] couldn't find any animation.", False, True, 2)
		endif
	endif
	return -1
endfunction

Bool function bHaveRandomSexWithActorOS(Quest OSexIntegrationMainQuest, Actor partner, Actor act, Bool bAggressive = False, String sExcludedTags = "") Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	actor[] actors = new actor[2]
	Bool isActorFemale = ostim.isFemale(act)
	Bool isPartnerFemale = ostim.isFemale(partner)
	if isActorFemale && !isPartnerFemale
		actors[0] = partner
		actors[1] = act
	elseif !isActorFemale && isPartnerFemale
		actors[0] = act
		actors[1] = partner
	else
		if Utility.randomInt(0,1) || bAggressive
			actors[0] = act
			actors[1] = partner
		else
			actors[0] = partner
			actors[1] = act
		endif
	endif
	String  myAnim
	if bAggressive
		myAnim = getRandomAnimation(actors, "dominant,aggressor,", sExcludedTags, 1)
		if sExcludedTags && (myAnim == "")
			logText("[OStim_NPC] couldn't find any suitable animation without these excluded tags: " + sExcludedTags, False, True, 2)
			myAnim = getRandomAnimation(actors, "dominant,aggressor,", "", 1)
		endif
		if myAnim == ""
			logText("[OStim_NPC] couldn't find any suitable animation.", False, True, 2)
			myAnim = getRandomAnimation(actors, "", "", 1)
		endif
	else
		myAnim = getRandomAnimation(actors, "", sExcludedTags, 0)
		if sExcludedTags && (myAnim == "")
			logText("[OStim_NPC] couldn't find any suitable animation without these these excluded tags: " + sExcludedTags, False, True, 2)
			myAnim = getRandomAnimation(actors, "", "", 0)
		endif
	endif
	if myAnim
		logText("[OStim_NPC] Scene Name: " + OMetadata.GetName(myAnim) + ", Scene ID: " + myAnim + ", Scene Tags: " + OMetadata.GetSceneTags(myAnim))
		if (OThread.QuickStart(actors, StartingAnimation = myAnim) > -1)
			return true
		endif
		logText("[OStim_NPC] couldn't start animation.", False, True, 2)
		return False
	endif
	logText("[OStim_NPC] couldn't find any animation.", False, True, 2)
	return False
endfunction


Bool function bHaveGroupSexWithActorOS(Quest OSexIntegrationMainQuest, Actor[] partners, Actor act, Bool bAllowAggressive = True, String sExcludedTags = "") Global
	OSexIntegrationMain ostim = OSexIntegrationMainQuest as OSexIntegrationMain
	if partners.length > 4
	    logText("[OStim_NPC] too many partners: " + partners, False, True, 2)
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
	elseIf totalActors <= 1
	    logText("[OStim_NPC] Not enough partners: " + partners, False, True, 2)
		return False
	endif
		
	Bool isActorFemale = ostim.isFemale(act)
	iIndex = partners.length
	int jIndex = 0
	int kIndex = totalActors - 1
	if isActorFemale
		actors[kIndex] = act
		kIndex -= 1
	else
		actors[jIndex] = act
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
		logText("[OStim_NPC] Scene Name: " + OMetadata.GetName(sAnim) + ", Scene ID: " + sAnim + ", Scene Tags: " + OMetadata.GetSceneTags(sAnim))
		if OThread.QuickStart(actors, StartingAnimation = sAnim) > -1
			return True
		endif
		logText("[OStim_NPC] couldn't start animation.", False, True, 2)
		Return  false
	endif
	if sExcludedTags
		logText("[OStim_NPC] couldn't find any animation for " + actors.length + " actors without these excluded tags: " + sExcludedTags, False, True, 2)
	else
		logText("[OStim_NPC] couldn't find any animation for " + actors.length + " actors.", False, True, 2)
	endif
	return False
EndFunction



