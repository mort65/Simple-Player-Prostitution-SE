Scriptname zzzmrt_sp_flowergirls_interface extends Quest

Quest FlowerGirls
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  FlowerGirls = Game.GetFormFromFile(0x0012C5, "FlowerGirls SE.esm") as Quest ; Get quest now
  if FlowerGirls != None
    Debug.Notification("Simple Prostitution: FlowerGirls detected.")
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
  if Game.IsPluginInstalled("FlowerGirls SE.esm")
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

Int function haveSexWithPlayer(Actor Partner, Int Position)
  return -1
endfunction

Bool Function bHaveRandomSexWithPlayer(Actor Partner)
  return False
endfunction

state Installed
  Int function haveSexWithPlayer(Actor Partner, Int Position)
    return zzzmrt_SP_Int_Flowergirls.haveSexWithPlayerFG(FlowerGirls, Partner, Position)
  endfunction
  Bool Function bHaveRandomSexWithPlayer(Actor Partner)
    return zzzmrt_SP_Int_Flowergirls.bHaveRandomSexWithPlayerFG(FlowerGirls,Partner)
  endfunction
endstate
