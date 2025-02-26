Scriptname zzzmrt_sp_int_sexlab Hidden

Actor[] Function hookActorsSL(Quest SexLabQuestFramework, String argString) Global
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  return SexLab.ThreadSlots.GetController(argString as int).Positions
endfunction

Bool Function hasPlayerSL(Quest SexLabQuestFramework, String argString) Global
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  return SexLab.ThreadSlots.GetController(argString as int).HasPlayer
endfunction

Bool function IsActorActiveSL(Quest SexLabQuestFramework, Actor ActorRef) Global
  SexLabFramework SexLab = SexLabQuestFramework as SexLabFramework
  return SexLab.IsActorActive(ActorRef)
endfunction

Bool function IsActorVictimSL(Quest SexLabQuestFramework, Int tid, Actor ActorRef) Global
	SexLabFramework SexLab = SexLabQuestFramework as SexLabFramework
	return SexLab.IsVictim(tid, ActorRef)
endfunction

int function haveSexWithPlayerSL(Quest SexLabQuestFramework, Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False) Global
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
  actor player = Game.GetPlayer()
  Bool isPlayerFemale = isFemale(SexLabQuestFramework, player)
  Bool isPartnerFemale = isFemale(SexLabQuestFramework, partner)
  String AllowedTags = ""
  String sGenders = ""
  if isPlayerFemale && !isPartnerFemale
      sexActors[0] = player
      sexActors[1] = Partner
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  elseif isPartnerFemale && !isPlayerFemale
      sexActors[0] = Partner
      sexActors[1] = player
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  else
    if isPlayerFemale
      sGenders = "FF"
      AllowedTags = sGenders + ","
    else
      sGenders = "MM"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
    endif
    if utility.randomInt(0,1)
        sexActors[0] = player
        sexActors[1] = Partner
    else
        sexActors[0] = Partner
        sexActors[1] = player
    endif
  endif
  string sType = ""
  Int iExtraTagsIndex = iGetExtraTagsIndex(Position, sGenders)
  if (iExtraTagsIndex > -1) && sExtraTags[iExtraTagsIndex]
    anims2 = SexLab.GetAnimationsByTags(2, sExtraTags[iExtraTagsIndex] + ",", "", RequireAll=bRequireAllTags[iExtraTagsIndex])
		if anims2.length == 0
			Debug.trace("Simple Prostitution: [SexLab] couldn't find any animation with these tags: " + sExtraTags[iExtraTagsIndex])
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
      Debug.trace("Simple Prostitution: [SexLab] couldn't find suitable animation.")
      if bAllowAll
        anims = SexLab.GetAnimationsByTags(2, "MF,", "", RequireAll=true)
      endif
      if anims.Length == 0
        Debug.trace("Simple Prostitution: [SexLab] couldn't find any animation.")
        return -1
      endif
    endif
    myAnims = anims
  else
      myAnims = anims2
  endif
  sexActors = SexLab.SortActors(sexActors, true)

  if SexLab.StartSex(sexActors, myAnims, none, none, true, "AnimationEnding,AnimationEnd") > -1
    return Position
  endif
  Debug.trace("Simple Prostitution: [SexLab] couldn't start animation.")
  return -1
endfunction


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


Bool function bHaveRandomSexWithPlayerSL(Quest SexLabQuestFramework, Actor Partner, Bool bAggressive = False) Global
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
  actor player = Game.GetPlayer()
  Bool isPlayerFemale = isFemale(SexLabQuestFramework, player)
  Bool isPartnerFemale = isFemale(SexLabQuestFramework, partner)
  Int iMales = -1
  Int iFemales = -1
  String AllowedTags = ""
  String sGenders = ""
  if isPlayerFemale && !isPartnerFemale
      sexActors[0] = player
      sexActors[1] = Partner
      sGenders = "MF"
      iMales = 1
      iFemales = 1
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  elseif isPartnerFemale && !isPlayerFemale
      sexActors[0] = Partner
      sexActors[1] = player
      iMales = 1
      iFemales = 1
      sGenders = "MF"
      AllowedTags = sGenders + ","
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  else
    if isPlayerFemale
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
        sexActors[1] = player
    else
        sexActors[0] = player
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
        Debug.trace("Simple Prostitution: [SexLab] couldn't find any animation.")
        return False
      endif
    endif
  endif
  sexActors = SexLab.SortActors(sexActors, true)
  if SexLab.StartSex(sexActors, anims, none, none, true, "AnimationEnding,AnimationEnd") > -1
    return True
  endif
  Debug.trace("Simple Prostitution: [SexLab] couldn't start animation.")
  return False
endfunction

Bool function bHaveGroupSexWithPlayerSL(Quest SexLabQuestFramework, Actor[] partners, Bool bAllowAggressive = True) Global
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  if !SexLab.Enabled
    return False
  endif
  Actor player = Game.GetPlayer()
  Int iMales = 0
  Int iFemales = 0
  if partners.length > 4
    Debug.trace("Simple Prostitution: [SexLab] too many partners: " + partners)
    return False
  endif
  if isFemale(SexLabQuestFramework, player)
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
    Debug.trace("Simple Prostitution: [SexLab] Not enough partners: " + partners)
    return False
  endif
  actors[0] = player
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
    myAnims = SexLab.MergeAnimationLists(anims,anims2)
  else
    myAnims = anims
  endif
  if myAnims.Length > 0
    actors = SexLab.SortActors(actors, true)
    if SexLab.StartSex(actors, anims, none, none, true, "AnimationEnding,AnimationEnd") > -1
      return True
    endif
    Debug.trace("Simple Prostitution: [SexLab] couldn't start SexLab animation.") 
    Return  false
  endif
  Debug.trace("Simple Prostitution: [SexLab] couldn't find any SexLab animation for " + actors.length + " actors." )
  return False
EndFunction


Bool function isFemale(Quest SexLabQuestFramework, Actor akActor) Global
  Int iGender = (SexLabQuestFramework As SexLabFramework).GetGender(akActor)
  return ((iGender == 1) || (iGender == 3)) ;1 = Human Female | 3 = Female Creature
EndFunction
