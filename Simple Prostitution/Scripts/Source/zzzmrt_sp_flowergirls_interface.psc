Scriptname zzzmrt_sp_flowergirls_interface extends Quest

Quest FlowerGirls

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  FlowerGirls = Game.GetFormFromFile(0x0012C5, "FlowerGirls SE.esm") as Quest ; Get quest now
endevent

Bool function GetIsInterfaceActive()
  if GetState() == "Installed"
    return true
  endif
  return false
endfunction

;returns and function parameterss should not be a type that doesn't exist without the optional mod like dxSceneThread!!!
;event OnInit()
;  Debug.trace("Simple Prostitution: OnInit() trigged for " + self)
;  RegisterForModEvent("MOA_Int_PlayerLoadsGame", "On_MOA_Int_PlayerLoadsGame")
;endevent
;event On_MOA_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
;  PlayerLoadsGame()
;endevent
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
endfunction

Int function haveSexWithPlayer(Actor Partner, Int Position)
  return -1
endfunction

state Installed
  Int function haveSexWithPlayer(Actor Partner, Int Position)
    return zzzmrt_SP_Int_Flowergirls.haveSexWithPlayerFG(FlowerGirls, Partner, Position)
  endfunction
endstate
