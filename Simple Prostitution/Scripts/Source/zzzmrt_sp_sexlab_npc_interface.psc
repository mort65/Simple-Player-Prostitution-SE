Scriptname zzzmrt_sp_sexlab_npc_interface extends Quest

import zzzmrt_sp_utility
Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto

Quest SexLabQuestFramework
Bool property bChecked = False Auto Hidden

event OnEndState()
  Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
  SexLabQuestFramework = Game.GetFormFromFile(0x000d62, "SexLab.esm") as Quest ; Get quest now
  if isFormValid(SexLabQuestFramework)
    MainScript.log("SexLab detected (NPC).", False, True, 1)
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
  if isPluginFound("SexLab.esm")
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

Bool function IsActorActive(Actor ActorRef)
  return False
endfunction

Bool Function bHaveGroupSexWithActor(Actor[] partners, Actor act, Bool bAllowAggressive = True, Bool bForceAgressive = false, String sExcludedTags = "")
	return False
EndFunction

  Int Function haveSexWithActor(Actor Partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "")
	return -1
  endfunction

state Installed
  function checkVars()
    if !isFormValid(SexLabQuestFramework)
      SexLabQuestFramework = Game.GetFormFromFile(0x000d62, "SexLab.esm") as Quest
    endif
  endfunction
  
  Bool function IsActorActive(Actor ActorRef)
    return zzzmrt_sp_int_npc_sexlab.IsActorActiveSL(SexLabQuestFramework, ActorRef)
  endfunction
  
  Bool Function bHaveGroupSexWithActor(Actor[] partners, Actor act, Bool bAllowAggressive = True, Bool bForceAgressive = false, String sExcludedTags = "")
	return zzzmrt_sp_int_npc_sexlab.bHaveGroupSexWithActorSL(SexLabQuestFramework, partners, act, bAllowAggressive, bForceAgressive, sExcludedTags)
  EndFunction
  
  Int Function haveSexWithActor(Actor Partner, Actor act, Int Position, String[] sExtraTags, Bool[] bRequireAllTags, Bool bAllowAggressive = False, Bool bAllowAll = False, String sExcludedTags = "")
	return zzzmrt_sp_int_npc_sexlab.haveSexWithActorSL(SexLabQuestFramework, Partner, act, Position, sExtraTags, bRequireAllTags, bAllowAggressive, bAllowAll, sExcludedTags)
  endfunction
endstate
