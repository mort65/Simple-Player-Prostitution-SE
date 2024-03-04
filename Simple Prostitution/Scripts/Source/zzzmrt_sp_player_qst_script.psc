Scriptname zzzmrt_sp_player_qst_script extends ReferenceAlias

zzzmrt_sp_main_qst_script property MainScript auto

Bool bBusy = False

event OnInit()
  RegisterForSingleUpdate(1.0)
endevent

event OnPlayerLoadGame()
  RegisterForSingleUpdate(1.0)
endevent

event OnUpdate()
  setVars()
endevent

function setVars()
  if bBusy
    return
  endif
  bBusy = True
  MainScript.SexLabInterface.PlayerLoadsGame()
  MainScript.FlowerGirlsInterface.PlayerLoadsGame()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  Utility.Wait(10.0)
  MainScript.bIsSexlabActive = MainScript.SexLabInterface.GetIsInterfaceActive()
  MainScript.bIsFlowerGirlsActive = MainScript.FlowerGirlsInterface.GetIsInterfaceActive()
  bBusy = False
endfunction
