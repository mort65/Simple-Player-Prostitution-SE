Scriptname zzzmrt_sp_ddi_interface extends Quest

import zzzmrt_sp_utility

Form[] ddkeys
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet. 
  setVars()
endevent

Function setVars()
  int iIndex = 0
  form restraintsKey = Game.GetFormFromFile(0x01775f, "Devious Devices - Integration.esm")
  if isFormValid(restraintsKey) && restraintsKey.getType() == 45
    iIndex += 1
  else
    restraintsKey = None
    Debug.Trace("Simple Prostitution: [DD] Restraint key not found.")
  endif
  form chastityKey = Game.GetFormFromFile(0x008a4f, "Devious Devices - Integration.esm")
  if isFormValid(chastityKey) && chastityKey.getType() == 45
    iIndex += 1
  else
    chastityKey = None
    Debug.Trace("Simple Prostitution: [DD] Chastity key not found.")
  endif
  form piercingKey = Game.GetFormFromFile(0x0409a4, "Devious Devices - Integration.esm")
  if isFormValid(piercingKey) && piercingKey.getType() == 45
    iIndex += 1
  else
    piercingKey = None
    Debug.Trace("Simple Prostitution: [DD] Piercing key not found.")
  endif
  if iIndex > 0
    ddkeys = utility.createFormArray(iIndex)
    While iIndex > 0
      iIndex -= 1
      if piercingKey && (ddkeys.find(piercingKey) < 0)
        ddkeys[iIndex] = piercingKey
      elseif chastityKey && (ddkeys.find(chastityKey) < 0)
        ddkeys[iIndex] = chastityKey
      elseif restraintsKey && (ddkeys.find(restraintsKey) < 0)
        ddkeys[iIndex] = restraintsKey
      endif
    endWhile
    Debug.Notification("Simple Prostitution: Devious Devices Integration detected.")
  endif
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
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("Devious Devices - Integration.esm")
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

Int Function iAddRandomDDKeyToRef(ObjectReference akRef, Int aiNum = 1)
	return 0
endfunction

state Installed
  Bool Function bCheckVars()
    if ddkeys && ddkeys.Length == 3
      int iIndex = 3
      while iIndex > 0
        iIndex -= 1
        if !isFormValid(ddkeys[iIndex])
          return False
        endif
      endWhile
      return True
    endif
    return False
  endfunction
  
  Int Function iAddRandomDDKeyToRef(ObjectReference akRef, Int aiNum = 1)
    return zzzmrt_sp_int_ddi._iAddRandomKeyToRef(akRef, ddkeys, aiNum)
  endfunction
endState