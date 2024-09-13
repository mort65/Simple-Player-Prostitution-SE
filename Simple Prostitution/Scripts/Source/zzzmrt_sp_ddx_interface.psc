Scriptname zzzmrt_sp_ddx_interface extends Quest

import zzzmrt_sp_utility

Quest zadxQuest
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet. 
  setVars()
endevent

Function setVars()
  zadxQuest = Game.GetFormFromFile(0x00ca01, "Devious Devices - Expansion.esm") as Quest
  Debug.Notification("Simple Prostitution: Devious Devices Expansion detected.")
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

Bool Function lockRandomDeviceOnActor(Actor akActor, Int iLevel = 0, Int[] chanceArray)
  Return false
endfunction

Bool function isAnallyPlugged(Actor akActor)
	return False
endfunction

Bool function isVaginallyPlugged(Actor akActor)
	return False
endfunction

Bool function isPlugged(Actor akActor)
	return False
endfunction

Bool Function isBounded(Actor akActor)
  Return false
EndFunction

Bool Function isGagged(Actor akActor)
  Return false
EndFunction

Bool Function isBelted(Actor akActor)
  Return false
EndFunction

Bool Function isBlindfolded(Actor akActor)
  Return false
EndFunction

Bool function deviceHaveKeywordConflict(Actor akActor, Armor akDevice)
  return false
EndFunction

Function lockDeviousDevice(Actor akActor, Armor akDevice, Bool bForce = False)
EndFunction


Bool Function TightenRandomDevice(Actor akActor, LeveledItem[] akDevices)
  return False
EndFunction

Function MoanAndPlayHornyAnimation(Actor akActor)
endfunction

function InflateRandomPlug(Actor akActor)
endfunction

function PlayerLoadsGame(Bool bForce = False)
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("Devious Devices - Expansion.esm")
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

state Installed
  
  Bool Function bCheckVars()
    return isFormValid(zadxQuest)
  endfunction
  
  Bool Function lockRandomDeviceOnActor(Actor akActor, Int iLevel = 0, Int[] chanceArray)
    return zzzmrt_sp_int_ddx._lockRandomDeviceOnActor(zadxQuest, akActor,  iLevel, chanceArray)
  endfunction
	
	Bool function isPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool function isAnallyPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isAnallyPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool function isVaginallyPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isVaginallyPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool Function isBounded(Actor akActor)
    return zzzmrt_sp_int_ddx._isBounded(zadxQuest, akActor)
  endfunction
  
  Bool Function isGagged(Actor akActor)
    return zzzmrt_sp_int_ddx._isGagged(zadxQuest, akActor)
  endfunction
  
  Bool Function isBelted(Actor akActor)
    return zzzmrt_sp_int_ddx._isBelted(zadxQuest, akActor)
  endfunction
  
  Bool Function isBlindfolded(Actor akActor)
    return zzzmrt_sp_int_ddx._isBlindfolded(zadxQuest, akActor)
  endfunction

  Bool function deviceHaveKeywordConflict(Actor akActor, Armor akDevice)
    return zzzmrt_sp_int_ddx._deviceHaveKeywordConflict(zadxQuest, akActor, akDevice)
  EndFunction

  Function LockDeviousDevice(Actor akActor, Armor akDevice, Bool bForce = False)
    zzzmrt_sp_int_ddx._LockDeviousDevice(zadxQuest, akActor, akDevice, bForce)
  endfunction

  Bool Function TightenRandomDevice(Actor akActor, LeveledItem[] akDevices)
    return zzzmrt_sp_int_ddx._TightenRandomDevice(zadxQuest, akActor, akDevices)
  EndFunction

  function InflateRandomPlug(Actor akActor)
    zzzmrt_sp_int_ddx._InflateRandomPlug(zadxQuest, akActor)
  endfunction
	
	Function MoanAndPlayHornyAnimation(Actor akActor)
		zzzmrt_sp_int_ddx._MoanAndPlayHornyAnimation(zadxQuest, akActor)
	endfunction

endState