Scriptname zzzmrt_sp_ostim_npc_interface extends Quest

import zzzmrt_sp_utility
Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto

Quest OSexIntegrationMainQuest
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  OSexIntegrationMainQuest = Game.GetFormFromFile(0x000801, "OStim.esp") as Quest
  if isFormValid(OSexIntegrationMainQuest)
    MainScript.log("OStim detected (NPC).", False, True, 1)
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
  if isPluginFound("OStim.esp")
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
endfunction

Bool Function bHaveGroupSexWithActor(Actor[] partners, Actor act, Bool bAllowAggressive = True, String sExcludedTags = "")
	return False
endfunction

Int function haveSexWithActor(Actor partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "")
	return -1
endfunction

state Installed

  function checkVars()
    if !isFormValid(OSexIntegrationMainQuest)
      OSexIntegrationMainQuest = Game.GetFormFromFile(0x000801, "OStim.esp") as Quest
    endif
  endfunction

  Bool Function isActorActive(Actor act)
    return zzzmrt_sp_int_npc_ostim.isActorActiveOS(OSexIntegrationMainQuest, act)
  endfunction
  
  Bool Function bHaveGroupSexWithActor(Actor[] partners, Actor act, Bool bAllowAggressive = True, String sExcludedTags = "")
    return zzzmrt_sp_int_npc_ostim.bHaveGroupSexWithActorOS(OSexIntegrationMainQuest, partners, act, bAllowAggressive, sExcludedTags)
  endfunction
  
  Int function haveSexWithActor(Actor partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "")
	return zzzmrt_sp_int_npc_ostim.haveSexWithActorOS(OSexIntegrationMainQuest, partner, act, Position, sExtraTags, bRequireAllTags, bAllowAggressive, bAllowAll, sExcludedTags)
  endfunction
endstate