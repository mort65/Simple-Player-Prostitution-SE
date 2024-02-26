Scriptname zzzmrt_sp_int_sexlab Hidden

int function haveSexWithPlayerSL(Quest SexLabQuestFramework, Actor Partner, Int Position, ObjectReference CenterOn=none, bool AllowBed=true, string Hook="") Global
  if position < 0
	return -1
  endif
  SexLabFramework SexLab = SexLabQuestFramework As SexLabFramework
  if !SexLab.Enabled
    return -1
  endif
  string SuppressTagsForMale = "Lesbian,FF,"
  string SuppressTagsForNotRough = "Cowgirl,Aggressive,Rough,Forced,Bound,"
  sslBaseAnimation[] anims
  actor[] sexActors = new actor[2]
  actor player = Game.GetPlayer()
  int playerSex = player.GetActorBase().GetSex()
  if player.GetActorBase().GetSex() == 1
    sexActors[0] = player
    sexActors[1] = Partner
    if Position == 0
      anims = SexLab.GetAnimationsByTags(2, "Vaginal,MF", SuppressTagsForNotRough, RequireAll=true)
    elseif Position == 1
      anims = SexLab.GetAnimationsByTags(2, "Anal,MF", SuppressTagsForNotRough, RequireAll=true)
    else
      anims = SexLab.GetAnimationsByTags(2, "Lesbian,Oral", SuppressTagsForNotRough, RequireAll=true)
    endif
  else
    sexActors[0] = Partner
    sexActors[1] = player
    if Position == 0
      anims = SexLab.GetAnimationsByTags(2, "Vaginal", SuppressTagsForMale + SuppressTagsForNotRough, RequireAll=true)
    elseif Position == 1
      anims = SexLab.GetAnimationsByTags(2, "Anal", SuppressTagsForMale + SuppressTagsForNotRough, RequireAll=true)
    else
      anims = SexLab.GetAnimationsByTags(2, "Blowjob", SuppressTagsForMale + SuppressTagsForNotRough, RequireAll=true)
    endif
  endif
  sexActors = SexLab.SortActors(sexActors, true)

  ;RegisterForModEvent("AnimationEnd", "zzzDibSex_End")
  if SexLab.StartSex(sexActors, anims, none, none, true, "") > -1
    return Position
  endif
  return -1
endfunction
