Scriptname zzzmrt_sp_licenses_interface extends Quest

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
import zzzmrt_sp_utility

Quest BMLicenses
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  BMLicenses = Game.GetFormFromFile(0x000d62, "Licenses.esp") as Quest ; Get quest now
  if isFormValid(BMLicenses)
    MainScript.log("Licenses - Player Oppression detected.", true, true, 1, True)
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
  if isPluginFound("Licenses.esp")
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

Bool function bHasWhoreLicense()
  return True
endfunction

Bool Function bFlagWhoreViolation()
  return False
endfunction

Function setWhoreViolation()
endfunction

Int Function getWhoreLicenseCost()
	return 0
endfunction

state Installed 
  function checkVars()
    if !isFormValid(BMLicenses)
      BMLicenses = Game.GetFormFromFile(0x000d62, "Licenses.esp") as Quest
    endif
  endfunction
  
  Bool function bHasWhoreLicense()
    return zzzmrt_sp_int_licenses.bHasWhoreLicenseBM(BMLicenses)
  endfunction
  
  Bool function bFlagWhoreViolation()
    return zzzmrt_sp_int_licenses.bFlagWhoreViolationBM(BMLicenses)
  endfunction
  
  Function setWhoreViolation()
    zzzmrt_sp_int_licenses.setWhoreViolationBM(BMLicenses)
  endfunction
  
  Int Function getWhoreLicenseCost()
	return zzzmrt_sp_int_licenses.getWhoreLicenseCostBM(BMLicenses)
  EndFunction
endstate
