Scriptname zzzmrt_sp_flowergirls_npc_interface extends Quest

import zzzmrt_sp_utility

Bool property bChecked = False Auto Hidden
Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto

Quest FlowerGirls
Faction AnimatingFaction

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  FlowerGirls = Game.GetFormFromFile(0x0012C5, "FlowerGirls SE.esm") as Quest ; Get quest now
  AnimatingFaction = Game.GetFormFromFile(0x5bef2c, "FlowerGirls SE.esm") as Faction
  if isFormValid(FlowerGirls)
    MainScript.log("FlowerGirls detected (NPC).", false, true, 1)
  endif
endevent

Bool function GetIsInterfaceActive()
  if GetState() == "Installed"
    return true
  endif
  return false
endfunction

function PlayerLoadsGame()
  bChecked = False
  logText("PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("FlowerGirls SE.esm")
    if GetState() != "Installed"
      GoToState("Installed")
    else
      checkVars()
    endif
  else
    if GetState() != ""
      GoToState("")
    endif
  endif
  bChecked = True
endfunction

function checkVars()
endfunction

Bool Function isActorActive(Actor act)
  return False
endFunction

Bool function bHaveGroupSexWithActor(Actor[] partners, Actor act)
	return False
endfunction

  Int function haveSexWithActor(Actor partner, Actor act, Int Position)
	return -1
  endfunction

state Installed
  function checkVars()
    if !isFormValid(FlowerGirls)
      FlowerGirls = Game.GetFormFromFile(0x0012C5, "FlowerGirls SE.esm") as Quest 
    endif
    if !isFormValid(AnimatingFaction)
      AnimatingFaction = Game.GetFormFromFile(0x5bef2c, "FlowerGirls SE.esm") as Faction
    endif
  endfunction
  
  Bool Function isActorActive(Actor act)
    if !act
      return false
    endif
    Return act.isInfaction(AnimatingFaction)
  endfunction
  
  Bool function bHaveGroupSexWithActor(Actor[] partners, Actor act)
    return zzzmrt_sp_int_npc_flowergirls.bHaveGroupSexWithActorFG(FlowerGirls, partners, act)
  endfunction
  
  Int function haveSexWithActor(Actor partner, Actor act, Int Position)
	return zzzmrt_sp_int_npc_flowergirls.haveSexWithActorFG(FlowerGirls, partner, act, Position)
  endfunction
endstate
