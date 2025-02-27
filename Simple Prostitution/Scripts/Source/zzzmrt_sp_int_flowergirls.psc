Scriptname zzzmrt_sp_int_flowergirls Hidden

import zzzmrt_sp_utility

Int function haveSexWithPlayerFG(Quest FlowerGirls, Actor partner, Int Position) Global
  if Position < 0
    return -1
  endif
  dxFlowerGirlsScript FGScript = FlowerGirls as dxFlowerGirlsScript
  if !partner 
    return -1
  endif
  if FGScript.ThreadManager.GetActiveThreadForActor(partner as ObjectReference) != None
    logText("[FG] partner is busy in another scene: " + partner, False, True, 2)
    return -1
  endif
  Actor Actor1
  Actor Actor2
  actor player = Game.GetPlayer()
  if partner.GetLeveledActorBase().GetSex() == 1
    Actor1 = player
    Actor2 = partner
  else
    Actor1 = partner
    Actor2 = player
  endif
  if Position == 0
    int i = utility.randomInt(1, 4)
    if i == 1
      FGScript.CowgirlScene(Actor1, Actor2)
    elseif i == 2
      FGScript.MissionaryScene(Actor1, Actor2)
    elseif i == 3
      FGScript.DoggyScene(Actor1, Actor2)
    elseif i == 4
      FGScript.StandingScene(Actor1, Actor2)
    endif
  elseif Position == 1
    FGScript.AnalScene(Actor1, Actor2)
  elseif Position == 2
    FGScript.OralScene(Actor1, Actor2)
  endif
  if Position > -1
    if bCheckThreadForActorAndWaitFG(FlowerGirls, player)
      return Position
    endif
  endif
  return -1
endfunction


Bool function bHaveRandomSexWithPlayerFG(Quest FlowerGirls, Actor partner) Global
  if !partner
    return False
  endif
  dxFlowerGirlsScript FGScript = FlowerGirls as dxFlowerGirlsScript
  actor player = Game.GetPlayer()
  if (FGScript.ThreadManager.GetActiveThreadForActor(partner as ObjectReference) != None)
	logText("[FG] partner is busy in another scene: " + partner, False, True, 2)
    return False
  endif
  if partner.GetLeveledActorBase().GetSex() == player.GetActorBase().GetSex()
    FGScript.RandomScene(partner, player)
  else
    FGScript.RandomScene(player, partner)
  endif
  return bCheckThreadForActorAndWaitFG(FlowerGirls, player)
endfunction


Bool function bHaveGroupSexWithPlayerFG(Quest FlowerGirls, Actor[] partners) Global
  dxFlowerGirlsScript FGScript = FlowerGirls as dxFlowerGirlsScript
  actor player = Game.getPlayer()
  if partners.Length > 2
    logText("[FG] too many partners for flowergirls: " + partners, False, true, 2)
    return False
  ElseIf partners.Length == 1
    if partners[0]
      return bHaveRandomSexWithPlayerFG(FlowerGirls, partners[0])
    endif
	logText("[FG] Not enough partners: " + partners, False, true, 2)
    return False
  ElseIf partners.Length == 0
    logText("[FG] Not enough partners: " + partners, False, true, 2)
    return False
  endif
  int totalPartners = partners.Length
  int iIndex = totalPartners
  while iIndex > 0
    iIndex -= 1
    if partners[iIndex]
      if FGScript.ThreadManager.GetActiveThreadForActor(partners[iIndex] as ObjectReference) != None
	    logText("[FG] partner is busy in another scene: " + partners[iIndex], False, True, 2)
        totalPartners -= 1
      endif
    else
      totalPartners -= 1
    endif
  endwhile
  if totalPartners == 2
    FGScript.PlayThreesome(partners[0], player, partners[1])
    return bCheckThreadForActorAndWaitFG(FlowerGirls, player)
  elseif totalPartners == 1
    actor partner
    if partners[0] && !FGScript.ThreadManager.GetActiveThreadForActor(partners[0] as ObjectReference)
      partner = partners[0]
    elseif (partners.length == 2) && partners[1] && !FGScript.ThreadManager.GetActiveThreadForActor(partners[1] as ObjectReference)
      partner = partners[1]
    endif
    if partner
      FGScript.RandomScene(player, partner)
      return bCheckThreadForActorAndWaitFG(FlowerGirls, player)
    endif
	logText("[FG] Not enough available partners: " + partners, False, True, 2)
  else
    logText("[FG] Not enough available partners: " + partners, False, True, 2)
    return False
  endif
  return False
endfunction

Bool Function bCheckThreadForActorAndWaitFG(Quest FlowerGirls, Actor akActor) Global
  if akActor == None
    return False
  endif
  dxFlowerGirlsScript FGScript = FlowerGirls as dxFlowerGirlsScript
  if FGScript != None
    utility.Wait(3.0)
    dxSceneThread startedScene = FGScript.ThreadManager.GetActiveThreadForActor(akActor as ObjectReference)
    if startedScene != None
      while startedScene.IsRunning()
        Utility.Wait(0.1)
      endwhile
      return True
    endif
  endif
  return False
endfunction
