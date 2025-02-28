Scriptname zzzmrt_sp_slhh_interface extends Quest

import zzzmrt_sp_utility
Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto

Keyword SLHHScriptEventKeyword
Quest SLHH

Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0)
  setVars()
endevent

Function setVars()
  SLHH = Game.GetFormFromFile(0x0012c4, "SexLabHorribleHarassment.esp") as Quest
  SLHHScriptEventKeyword = Game.GetFormFromFile(0x00c510, "SexLabHorribleHarassment.esp") as Keyword
  MainScript.log("Horrible Harassment Expansion detected.", True, true, 1, true)
endfunction

Bool function GetIsInterfaceActive()
  if GetState() == "Installed"
    return true
  endif
  return false
endfunction

function PlayerLoadsGame(Bool bForce = False)
  bChecked = False
  logText("PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("SexLabHorribleHarassment.esp")
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

Bool Function bCheckVars()
	return true
endfunction

Bool function isPlayerGettingHarassed()
	return False
endfunction

Function SLHHActivate(Actor pTarget)
endFunction

state Installed
	Bool Function bCheckVars()
		return (isFormValid(SLHHScriptEventKeyword) && isFormValid(SLHH))
	endfunction
	
	Function SLHHActivate(Actor pTarget)
		SLHHScriptEventKeyword.SendStoryEvent(None, pTarget as ObjectReference)
	endFunction
	
	Bool function isPlayerGettingHarassed()
		return (SLHH.isRunning() && SLHH.Getstage() > 0 && SLHH.Getstage() <= 130)
	endfunction
	
endState