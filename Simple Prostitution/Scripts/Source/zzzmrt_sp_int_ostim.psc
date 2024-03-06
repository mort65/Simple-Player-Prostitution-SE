Scriptname zzzmrt_sp_int_ostim Hidden

int function haveSexWithPlayerOS(Quest OSexIntegrationMainQuest, Actor partner, Int Position, Bool bAllowAggressive = False, Bool bAllowAll =False) Global
	if Position < 0
	  return -1
	endif
	string anim = ""
	actor[] actors = new actor[2]
    actor player = Game.GetPlayer()
	Bool isPlayerFemale = player.GetActorBase().GetSex()
	Bool isPartnerFemale = Partner.GetLeveledActorBase().GetSex()
	if isPlayerFemale && !isPartnerFemale
		actors[0] = partner
		actors[1] = Game.GetPlayer()
	elseif !isPlayerFemale && isPartnerFemale
		actors[0] = Game.GetPlayer()
		actors[1] = partner
	elseif Utility.randomInt(0,1)
		actors[0] = Game.GetPlayer()
		actors[1] = partner
	else
		actors[0] = partner
		actors[1] = Game.GetPlayer()
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
	if anim
		OThread.QuickStart(actors, StartingAnimation = anim)
		return Position
	else
		Debug.trace("SimpleProstitution: couldn't find suitable OStim animation.")
		if bAllowAll
			anim = OLibrary.GetRandomScene(actors)
			if anim
				OThread.QuickStart(actors, StartingAnimation = anim)
				return Position
			endif
			Debug.trace("SimpleProstitution: couldn't find any OStim animation.")
		endif
	endif
	return -1
endfunction


Bool Function IsSceneAggressiveOS(String SceneID) Global
    int aiIndex = OMetadata.GetActorCount(SceneID)
    While aiIndex > 0
        aiIndex -= 1
        If OMetadata.HasActorTag(SceneID, aiIndex, "aggressor")
            Return true
        EndIf
    EndWhile
    Return false
EndFunction

String Function getRandomAnimation(actor[] actors, string tagCSV, string exclusion = "") Global	
	string anim = OLibrary.GetRandomSceneWithAnyActionCSV(actors, tagCSV);
    If (anim == "")
        anim = OLibrary.GetRandomSceneWithAnySceneTagCSV(actors, tagCSV)
    EndIf
    If (anim == "")
        anim = OLibrary.GetRandomSceneSuperloadCSV(actors, AnyActionType = tagCSV, AnySceneTag = tagCSV, AnyActorTagForAny = tagCSV, ActionBlacklistTypes = exclusion, SceneTagBlacklist = exclusion);
    EndIf
    Return  anim
EndFunction