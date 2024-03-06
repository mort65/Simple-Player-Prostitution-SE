Scriptname zzzmrt_sp_int_sexlab Hidden

int function haveSexWithPlayerSL(Quest SexLabQuestFramework, Actor Partner, Int Position, ObjectReference CenterOn=none, bool AllowBed=true, string Hook="", Bool bAllowAggressive = False, Bool bAllowAll = False) Global
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
  actor[] sexActors = new actor[2]
  actor player = Game.GetPlayer()
  Bool isPlayerFemale = player.GetActorBase().GetSex()
  Bool isPartnerFemale = Partner.GetLeveledActorBase().GetSex()
  String AllowedTags = ""
  if isPlayerFemale && !isPartnerFemale
      sexActors[0] = player
      sexActors[1] = Partner
      AllowedTags = "MF,"
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  elseif isPartnerFemale && !isPlayerFemale
      sexActors[0] = Partner
      sexActors[1] = player
      AllowedTags = "MF,"
      SuppressedTags = SuppressedTags + SuppressTagsForMale
  else
    if isPlayerFemale
      AllowedTags = "FF,"
    else
      AllowedTags = "MM,"
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
  string type = ""
  if Position == 0
    type = "vaginal"
    anims = SexLab.GetAnimationsByTags(2, AllowedTags + "vaginal,", SuppressedTags, RequireAll=true)
  elseif Position == 1
    type = "anal"
    anims = SexLab.GetAnimationsByTags(2, AllowedTags + "anal,", SuppressedTags, RequireAll=true)
  else
    type = "oral"
    if AllowedTags == "FF,"
      anims = SexLab.GetAnimationsByTags(2, AllowedTags + "cunnilingus,", SuppressedTags, RequireAll=true)
    elseif AllowedTags == "MM,"
      anims = SexLab.GetAnimationsByTags(2, AllowedTags + "blowjob,", SuppressedTags, RequireAll=true)
    else ;"MF"
        if utility.randomInt(0,1)
          anims = SexLab.GetAnimationsByTags(2, AllowedTags + "blowjob,", SuppressedTags, RequireAll=true)
        else
          anims = SexLab.GetAnimationsByTags(2, AllowedTags + "cunnilingus,", SuppressedTags, RequireAll=true)
        endif
    endif
  endif
  if anims.Length == 0
    anims = SexLab.GetAnimationsByTags(2, "MF," + type, SuppressTagsForNotRough, RequireAll=true)
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
  sexActors = SexLab.SortActors(sexActors, true)

  ;RegisterForModEvent("AnimationEnd", "zzzDibSex_End")
  if SexLab.StartSex(sexActors, anims, none, none, true, "") > -1
    return Position
  endif
  Debug.trace("SimpleProstitution: couldn't start Sexlab animation.")
  return -1
endfunction
