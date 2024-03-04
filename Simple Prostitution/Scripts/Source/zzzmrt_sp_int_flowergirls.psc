Scriptname zzzmrt_sp_int_flowergirls Hidden

Int function haveSexWithPlayerFG(Quest FlowerGirls, Actor partner, Int Position) Global
  if Position < 0
    return -1
  endif
  dxFlowerGirlsScript FGScript = FlowerGirls as dxFlowerGirlsScript
  if FGScript.ThreadManager.GetActiveThreadForActor(partner as ObjectReference) != None
    return -1
  endif
  Actor Actor1
  Actor Actor2
  if partner.GetLeveledActorBase().GetSex() == 1
    Actor1 = Game.GetPlayer()
    Actor2 = partner
  else
    Actor1 = partner
    Actor2 = Game.GetPlayer()
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
  return Position
endfunction
