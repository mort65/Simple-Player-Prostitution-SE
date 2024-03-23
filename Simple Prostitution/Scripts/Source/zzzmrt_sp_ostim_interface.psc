Scriptname zzzmrt_sp_ostim_interface extends Quest

Quest OSexIntegrationMainQuest
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  OSexIntegrationMainQuest = Game.GetFormFromFile(0x000801, "OStim.esp") as Quest
  if OSexIntegrationMainQuest != None
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
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if Game.IsPluginInstalled("OStim.esp")
    if GetState() != "Installed"
      GoToState("Installed")
    endif
  else
    if GetState() != ""
      GoToState("")
    endif
  endif
  bChecked = True
endfunction

int function haveSexWithPlayer(Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False)
  return -1
endfunction

state Installed
  int function haveSexWithPlayer(Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False)
    return zzzmrt_sp_int_ostim.haveSexWithPlayerOS(OSexIntegrationMainQuest, Partner, Position, sExtraTags, bRequireAllTags, bAllowAggressive, bAllowAll)
  endfunction
endstate