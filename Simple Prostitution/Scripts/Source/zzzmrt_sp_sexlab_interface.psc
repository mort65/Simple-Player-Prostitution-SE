Scriptname zzzmrt_sp_sexlab_interface extends Quest

Quest SexLabQuestFramework
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  SexLabQuestFramework = Game.GetFormFromFile(0x000d62, "SexLab.esm") as Quest ; Get quest now
  if SexLabQuestFramework != None
    Debug.Notification("Simple Prostitution: SexLab detected.")
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
  if Game.IsPluginInstalled("SexLab.esm")
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

Bool Function hasPlayer(string argStr)
  return False
endfunction

Actor[] Function hookActors(string argStr)
  Actor[] Actors
  return Actors
endfunction

Bool Function bHaveRandomSexWithPlayer(Actor Partner, Bool bAggressive = False)
  return False
EndFunction

Bool function bHaveGroupSexWithPlayer(Actor[] partners, Bool bAllowAggressive = True)
  return False
EndFunction

Bool function IsActorActive(Actor ActorRef)
  return False
endfunction

state Installed
  function checkVars()
    if SexLabQuestFramework == None
      SexLabQuestFramework = Game.GetFormFromFile(0x000d62, "SexLab.esm") as Quest
    endif
  endfunction

  Bool function IsActorActive(Actor ActorRef)
    return zzzmrt_sp_int_sexlab.IsActorActiveSL(SexLabQuestFramework, ActorRef)
  endfunction

  int function haveSexWithPlayer(Actor Partner, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False)
    return zzzmrt_sp_int_sexlab.haveSexWithPlayerSL(SexLabQuestFramework, Partner, Position, sExtraTags, bRequireAllTags, bAllowAggressive, bAllowAll)
  endfunction

  Actor[] Function hookActors(string argStr)
    return zzzmrt_sp_int_sexlab.HookActorsSL(SexLabQuestFramework, argStr)
  endfunction

  Bool Function hasPlayer(string argStr)
    return zzzmrt_sp_int_sexlab.hasPlayerSL(SexLabQuestFramework, argStr)
  endfunction
  
  Bool Function bHaveRandomSexWithPlayer(Actor Partner, Bool bAggressive = False)
    return zzzmrt_sp_int_sexlab.bHaveRandomSexWithPlayerSL(SexLabQuestFramework, Partner, bAggressive)
  EndFunction

  Bool function bHaveGroupSexWithPlayer(Actor[] partners, Bool bAllowAggressive = True)
    return zzzmrt_sp_int_sexlab.bHaveGroupSexWithPlayerSL(SexLabQuestFramework, partners, bAllowAggressive)
  EndFunction
endstate
