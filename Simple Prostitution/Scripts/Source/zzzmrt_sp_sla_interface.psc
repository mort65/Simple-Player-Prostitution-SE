Scriptname zzzmrt_sp_sla_interface extends Quest

Quest sla_Framework
Bool property bChecked = False Auto Hidden

import zzzmrt_sp_utility

event OnEndState()
  Utility.Wait(5.0)
  setVars()
endevent

Function setVars()
  sla_Framework = Game.GetFormFromFile(0x04290F, "SexLabAroused.esm") as Quest
  Debug.Notification("Simple Prostitution: SL Aroused detected.")
endfunction

Bool Function bCheckVars()
  return True
endfunction

Bool function GetIsInterfaceActive()
  if GetState() == "Installed"
    return true
  endif
  return false
endfunction

function PlayerLoadsGame(Bool bForce = False)
	bChecked = False
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("SexLabAroused.esm")
    if GetState() != "Installed"
      GoToState("Installed")
    elseif bForce || !bCheckVars()
      setVars()
    endif
  else
    if GetState() != ""
      GoToState("")
    endif
  endif
  bChecked = True
endfunction

int Function GetActorArousal(Actor akActor)
	return -3
endfunction

state Installed
  
  Bool Function bCheckVars()
    return isFormValid(sla_Framework)
  endfunction
	
	Int Function GetActorArousal(Actor akActor)
		return zzzmrt_sp_int_sla._GetActorArousal(sla_Framework, akActor)
	endfunction
EndState