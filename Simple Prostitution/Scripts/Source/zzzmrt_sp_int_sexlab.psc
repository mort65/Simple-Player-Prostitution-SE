Scriptname zzzmrt_sp_int_sexlab Hidden

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
  Bool isPlayerFemale = player.GetActorBase().GetSex()
  Bool isPartnerFemale = Partner.GetLeveledActorBase().GetSex()
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
      Debug.trace("SimpleProstitution: couldn't find suitable Sexlab animation.")
      if bAllowAll
        anims = SexLab.GetAnimationsByTags(2, "MF,", "", RequireAll=true)
      endif
      if anims.Length == 0
        Debug.trace("SimpleProstitution: couldn't find any Sexlab animation.")
        return -1
      endif
    endif
    myAnims = anims
  else
    if anims.Length == 0
      myAnims = anims2
    else
      myAnims = SexLab.MergeAnimationLists(anims,anims2)
    endif
  endif
  sexActors = SexLab.SortActors(sexActors, true)

  ;RegisterForModEvent("AnimationEnd", "zzzDibSex_End")
  if SexLab.StartSex(sexActors, myAnims, none, none, true, "") > -1
    return Position
  endif
  Debug.trace("SimpleProstitution: couldn't start Sexlab animation.")
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
