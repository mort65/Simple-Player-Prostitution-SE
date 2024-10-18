Scriptname zzzmrt_sp_ostim_interface extends Quest

import zzzmrt_sp_utility

Quest OSexIntegrationMainQuest
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  OSexIntegrationMainQuest = Game.GetFormFromFile(0x000801, "OStim.esp") as Quest
  if isFormValid(OSexIntegrationMainQuest)
    Debug.Notification("Simple Prostitution: OStim detected.")
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
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

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

int function haveSexWithPlayer(Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False)
  return -1
endfunction

Bool Function bHaveRandomSexWithPlayer(Actor Partner, Bool bAggressive = False)
  return False
EndFunction

Bool Function bHaveGroupSexWithPlayer(Actor[] partners, Bool bAllowAggressive = True)
  return false
EndFunction

Actor[] function getActors()
  Actor[] actors
  return actors
endfunction

Bool Function isActorActive(Actor act)
  return False
endfunction

state Installed

  function checkVars()
    if !isFormValid(OSexIntegrationMainQuest)
      OSexIntegrationMainQuest = Game.GetFormFromFile(0x000801, "OStim.esp") as Quest
    endif
  endfunction
  
  int function haveSexWithPlayer(Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False)
    return zzzmrt_sp_int_ostim.haveSexWithPlayerOS(OSexIntegrationMainQuest, Partner, Position, sExtraTags, bRequireAllTags, bAllowAggressive, bAllowAll)
  endfunction

  Actor[] function getActors()
    return zzzmrt_sp_int_ostim.getActorsOS(OSexIntegrationMainQuest)
  endfunction

  Bool Function bHaveRandomSexWithPlayer(Actor Partner, Bool bAggressive = False)
    return zzzmrt_sp_int_ostim.bHaveRandomSexWithPlayerOS(OSexIntegrationMainQuest, partner, bAggressive)
  endfunction

  Bool Function bHaveGroupSexWithPlayer(Actor[] partners, Bool bAllowAggressive = True)
    return zzzmrt_sp_int_ostim.bHaveGroupSexWithPlayerOS(OSexIntegrationMainQuest, partners, bAllowAggressive)
  endfunction

  Bool Function isActorActive(Actor act)
    return zzzmrt_sp_int_ostim.isActorActiveOS(OSexIntegrationMainQuest, act)
  endfunction
endstate