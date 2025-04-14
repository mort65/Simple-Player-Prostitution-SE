Scriptname zzzmrt_sp_int_npc_sexlab Hidden

Import zzzmrt_sp_utility
Import zzzmrt_sp_int_sexlab

Bool function IsActorActiveSL(Quest SexLabQuestFramework, Actor ActorRef) Global
  SexLabFramework SexLab = SexLabQuestFramework as SexLabFramework
  return SexLab.IsActorActive(ActorRef)
endfunction

int function haveSexWithActorSL(Quest SexLabQuestFramework, Actor Partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "") Global
  if position < 0
	  return -1
  endif
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  if !SexLab.Enabled
    return -1
  endif
  string SuppressTagsForMale = "Lesbian,FF,"
  string SuppressTagsForNotRough = ""
  if !bAllowAggressive
    SuppressTagsForNotRough = "Aggressive,Rough,Forced,Bound,"
  endif
  String SuppressedTags = SuppressTagsForNotRough
  sslBaseAnimation[] anims
  sslBaseAnimation[] anims2
  actor[] sexActors = new actor[2]
  Bool isActorFemale = isFemale(SexLabQuestFramework, act)
  Bool isPartnerFemale = isFemale(SexLabQuestFramework, partner)
  String AllowedTags = ""
  String sGenders = ""
  if isActorFemale && !isPartnerFemale
      sexActors[0] = act
      sexActors[1] = Partner
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  elseif isPartnerFemale && !isActorFemale
      sexActors[0] = Partner
      sexActors[1] = act
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  else
    if isActorFemale
      sGenders = "FF"
      AllowedTags = sGenders + ","
    else
      sGenders = "MM"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
    endif
    if utility.randomInt(0,1)
        sexActors[0] = act
        sexActors[1] = Partner
    else
        sexActors[0] = Partner
        sexActors[1] = act
    endif
  endif
  string sType = ""
  Int iExtraTagsIndex = iGetExtraTagsIndex(Position, sGenders)
  if (iExtraTagsIndex > -1) && sExtraTags[iExtraTagsIndex]
    anims2 = SexLab.GetAnimationsByTags(2, sExtraTags[iExtraTagsIndex] + ",", "", RequireAll=bRequireAllTags[iExtraTagsIndex])
	
	if anims2.length == 0
		logText("[SexLab_NPC] couldn't find any animation with these tags: " + sExtraTags[iExtraTagsIndex], False, True, 2)
	endif
  endif
  if Position == 0
    sType = "vaginal"
    anims = SexLab.GetAnimationsByTags(2, AllowedTags + "vaginal,", SuppressedTags, RequireAll=true)
  elseif Position == 1
    sType = "anal"
    anims = SexLab.GetAnimationsByTags(2, AllowedTags + "anal,", SuppressedTags, RequireAll=true)
  else
    sType = "oral"
    if sGenders == "FF"
      anims = SexLab.GetAnimationsByTags(2, AllowedTags + "cunnilingus,", SuppressedTags, RequireAll=true)
    elseif sGenders == "MM"
      anims = SexLab.GetAnimationsByTags(2, AllowedTags + "blowjob,", SuppressedTags, RequireAll=true)
    else ;"MF"
        if utility.randomInt(0,1)
          anims = SexLab.GetAnimationsByTags(2, AllowedTags + "blowjob,", SuppressedTags, RequireAll=true)
        else
          anims = SexLab.GetAnimationsByTags(2, AllowedTags + "cunnilingus,", SuppressedTags, RequireAll=true)
        endif
    endif
  endif
  sslBaseAnimation[] myAnims
  if anims2.Length == 0
    if anims.Length == 0
      anims = SexLab.GetAnimationsByTags(2, "MF," + sType, SuppressTagsForNotRough, RequireAll=true)
    endif
    if anims.Length == 0
	  logText("[SexLab_NPC] couldn't find suitable animation.", False, True, 2)
      if bAllowAll
        anims = SexLab.GetAnimationsByTags(2, "MF,", "", RequireAll=true)
      endif
      if anims.Length == 0
	    logText("[SexLab_NPC] couldn't find any animation.", False, True, 2)
        return -1
      endif
    endif
    myAnims = anims
  else
      myAnims = anims2
  endif
  if sExcludedTags != ""
	anims = SexLab.RemoveTagged(myAnims, sExcludedTags)
	if anims.length > 0
		myAnims = anims
	Else
		logText("[SexLab_NPC] couldn't find any animation without these excluded tags: " + sExcludedTags, False, True, 2)
	endif
  Endif
  logText("[SexLab_NPC] Tags for selected Animations: " + SexLab.GetAllAnimationTagsInArray(myAnims))
  sexActors = SexLab.SortActors(sexActors, true)
  if SexLab.StartSex(sexActors, myAnims, none, none, true, "AnimationEnding,AnimationEnd") > -1
	return Position
  endif
  logText("[SexLab_NPC] couldn't start animation.", False, true, 2)
  return -1
endfunction

Bool function bHaveRandomSexWithActorSL(Quest SexLabQuestFramework, Actor Partner, Actor act, Bool bAggressive = False, String sExcludedTags = "") Global
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  if !SexLab.Enabled
    return False
  endif
  string SuppressTagsForMale = "Lesbian,FF,"
  String SuppressTagsForNotRough = "Aggressive,Rough,Forced,Bound,"
  String SuppressedTags = ""
  if !bAggressive
    SuppressedTags = "Aggressive,Rough,Forced,Bound,"
  endif
  actor[] sexActors = new actor[2]
  Bool isActorFemale = isFemale(SexLabQuestFramework, act)
  Bool isPartnerFemale = isFemale(SexLabQuestFramework, partner)
  Int iMales = -1
  Int iFemales = -1
  String AllowedTags = ""
  String sGenders = ""
  if isActorFemale && !isPartnerFemale
      sexActors[0] = act
      sexActors[1] = Partner
      sGenders = "MF"
      iMales = 1
      iFemales = 1
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  elseif isPartnerFemale && !isActorFemale
      sexActors[0] = Partner
      sexActors[1] = act
      iMales = 1
      iFemales = 1
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  else
    if isActorFemale
      iMales = 0
      iFemales = 2
      sGenders = "FF"
      AllowedTags = sGenders + ","
    else
      iMales = 2
      iFemales = 0
      sGenders = "MM"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
    endif
    if utility.randomInt(0,1) || bAggressive
        sexActors[0] = Partner
        sexActors[1] = act
    else
        sexActors[0] = act
        sexActors[1] = Partner
    endif
  endif
  sslBaseAnimation[] anims = SexLab.GetAnimationsByType(2, iMales, iFemales, -1, bAggressive, true)
  if anims.Length == 0
    anims = SexLab.GetAnimationsByTags(2, AllowedTags, SuppressedTags, RequireAll=true)
    if anims.Length == 0
      anims = SexLab.GetAnimationsByTags(2, AllowedTags, "", RequireAll=true)
      if anims.Length == 0
        anims = SexLab.GetAnimationsByTags(2, "MF,", "", RequireAll=true)
      endif
      if anims.Length == 0
	    logText("[SexLab_NPC] couldn't find any animation.", False, True, 2)
        return False
      endif
    endif
  endif
  if sExcludedTags != ""
	sslBaseAnimation[] anims2 = SexLab.RemoveTagged(anims, sExcludedTags)
	if anims2.length > 0
		anims = anims2
	Else
		logText("[SexLab_NPC] couldn't find any animation without these excluded tags: " + sExcludedTags, False, True, 2)
	endif
  Endif
  sexActors = SexLab.SortActors(sexActors, true)
  logText("[SexLab_NPC] Tags for selected Animations: " + SexLab.GetAllAnimationTagsInArray(anims))
  if SexLab.StartSex(sexActors, anims, none, none, true, "AnimationEnding,AnimationEnd") > -1
    return True
  endif
  logText("[SexLab_NPC] couldn't start animation.", False, True, 2)
  return False
endfunction

Bool function bHaveGroupSexWithActorSL(Quest SexLabQuestFramework, Actor[] partners, Actor act, Bool bAllowAggressive = True, Bool bForceAgressive = false, String sExcludedTags = "") Global
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  if !SexLab.Enabled
    return False
  endif
  Int iMales = 0
  Int iFemales = 0
  if partners.length > 4
    logText("[SexLab_NPC] too many partners: " + partners, False, True, 2)
    return False
  endif
  if isFemale(SexLabQuestFramework, act)
    iFemales += 1
  else
    iMales += 1
  endif
  int totalActors = partners.Length + 1
  Int iIndex = partners.Length
  while iIndex > 0
    iIndex -= 1
    if partners[iIndex]
      if isFemale(SexLabQuestFramework, partners[iIndex]) ;female
        iFemales += 1
      else
        iMales += 1
      endif
    else
      totalActors -= 1
    endIf
  EndWhile
  Actor[] actors
  if totalActors == 5
    actors = new actor[5]
  ElseIf totalActors == 4
    actors = new actor[4]
  ElseIf totalActors == 3
    actors = new actor[3]
  ElseIf totalActors == 2
    actors = new actor[2]
  elseIf totalActors <= 1
	logText("[SexLab_NPC] Not enough partners: " + partners, False, True, 2)
    return False
  endif
  actors[0] = act
  iIndex = partners.Length
  int jIndex = 0
  while iIndex > 0
    iIndex -= 1
    if partners[iIndex]
      jIndex = actors.find(None)
      if jIndex > -1
        actors[jIndex] = partners[iIndex]
      endif
    endif
  EndWhile
  sslBaseAnimation[] myAnims
  sslBaseAnimation[] anims = SexLab.getAnimationsByType(totalActors, iMales, iFemales, -1, false, true)
  if bAllowAggressive
    sslBaseAnimation[] anims2 = SexLab.getAnimationsByType(totalActors, iMales, iFemales, -1, true, true)
	if bForceAgressive
		if anims2.length > 0
			myAnims = anims2
		else
			myAnims = anims
		endif
	else
		myAnims = SexLab.MergeAnimationLists(anims,anims2)
	endif
  else
    myAnims = anims
  endif
  if sExcludedTags != ""
	anims = SexLab.RemoveTagged(myAnims, sExcludedTags)
	if anims.length > 0
		myAnims = anims
	Else
		logText("[SexLab_NPC] couldn't find any animation for " + actors.length + " actors without these excluded tags: " + sExcludedTags, False, True, 2)
		return False
	endif
  Endif
  if myAnims.Length > 0
    actors = SexLab.SortActors(actors, true)
	logText("[SexLab_NPC] Tags for selected Animations: " + SexLab.GetAllAnimationTagsInArray(myAnims))
    if SexLab.StartSex(actors, myAnims, none, none, true, "AnimationEnding,AnimationEnd") > -1
      return True
    endif
	logText("[SexLab_NPC] couldn't start SexLab animation.", False, True, 2)
    Return  false
  endif
  logText("[SexLab_NPC] couldn't find any SexLab animation for " + actors.length + " actors.", False, True, 2)
  return False
EndFunction

