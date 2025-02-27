Scriptname zzzmrt_sp_slsfr_interface extends Quest

import zzzmrt_sp_utility

;Quest SLSFR_Main
GlobalVariable SLSFR_CurrentWhoreFame
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0)
  setVars()
endevent

Function setVars()
  ;SLSFR_Main = Game.GetFormFromFile(0x000808, "SLSF Reloaded.esp") as Quest
  SLSFR_CurrentWhoreFame = Game.GetFormFromFile(0x00080d, "SLSF Reloaded.esp") as GlobalVariable
  logText("SLSF Reloaded detected.", true, true , 1)
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
  if isPluginFound("SLSF Reloaded.esp")
		;Register SPP with SLSF Reloaded
		Int handle = Modevent.Create("SLSF_Reloaded_RegisterMod")
		If (handle)
			ModEvent.PushString(handle, "mrt_SimpleProstitution.esp")
			ModEvent.Send(handle)
		EndIf
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

Int function getWhoreFame()
	return 0
endfunction

function SLSFR_toggle_WhoreFlag(Bool bFlag)
endfunction

function SLSFR_toggle_WhoreEventFlag(Bool bFlag)
endfunction

function SLSFR_ManualWhoreFameGain(Int iMinFame, Int iMaxFame)
endfunction

state Installed
	Bool Function bCheckVars()
		return isFormValid(SLSFR_CurrentWhoreFame)
	endfunction
	
	Int function getWhoreFame()
		return SLSFR_CurrentWhoreFame.GetValue() as Int
	endfunction
	
	function SLSFR_toggle_WhoreFlag(Bool bFlag)
		int handle = ModEvent.Create("SLSF_Reloaded_SetWhoreFlag")
		if (handle)
				ModEvent.PushString(handle, "mrt_SimpleProstitution.esp")
				ModEvent.PushBool(handle, bFlag)
				ModEvent.Send(handle)
		endIf
	endfunction
	
	function SLSFR_toggle_WhoreEventFlag(Bool bFlag) ;for sexlab
		int handle = ModEvent.Create("SLSF_Reloaded_SetWhoreEventFlag")
		if (handle)
				ModEvent.PushString(handle, "mrt_SimpleProstitution.esp")
				ModEvent.PushBool(handle, bFlag)
				ModEvent.Send(handle)
		endIf
	endfunction

	function SLSFR_ManualWhoreFameGain(Int iMinFame, Int iMaxFame)
		int handle = ModEvent.Create("SLSF_Reloaded_SendManualFameGain")
		if (handle)
				ModEvent.PushString(handle, "Whore")
				ModEvent.PushString(handle, "Current")
				ModEvent.PushInt(handle, minInt(iMinFame,iMaxFame))
				ModEvent.PushInt(handle, maxInt(iMinFame,iMaxFame))
				ModEvent.Send(handle)
		endIf
	endfunction
endState