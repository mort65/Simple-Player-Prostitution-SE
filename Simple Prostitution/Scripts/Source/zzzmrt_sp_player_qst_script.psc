Scriptname zzzmrt_sp_player_qst_script extends ReferenceAlias

zzzmrt_sp_main_qst_script property MainScript auto

Bool bBusy = False
Bool bCheckVars = False
Bool bInit = False

event OnInit()
  bInit = True
  bCheckVars = True
  RegisterForModEvent("SPP_StartFindSnitch", "OnStartFindSnitch")
  RegisterForSingleUpdate(1.0)
endevent

event OnPlayerLoadGame()
  bCheckVars = True
  RegisterForModEvent("SPP_StartFindSnitch", "OnStartFindSnitch")
  RegisterForSingleUpdate(1.0)
endevent

event OnUpdate()
  if bCheckVars
    setVars()
    bCheckVars = False
  endif
  if !bInit && !MainScript.bFindingSnitch
    MainScript.snitch()
  endif
  if bInit
    bInit = false
  endif
endevent

Event OnCellLoad()
  MainScript.bFindingSnitch = False
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  MainScript.bFindingSnitch = False
  if MainScript.whoreSnitch || MainScript.dibelSnitch
    RegisterForSingleUpdate(utility.randomFloat(15.0,60.0)) 
  endif
endevent

Event OnStartFindSnitch(Form sender, Bool bCheckDibel)
  ;Debug.Trace("Simple Prostitution: OnStartFindSnitch triggered.")
  MainScript.snitchers.revert()
  if !MainScript.bFindingSnitch
    MainScript.bFindingSnitch = True
    while MainScript.bFindingSnitch
      MainScript.findSnitch(bCheckDibel)
      utility.wait(1.0)
    endWhile
    MainScript.bFindingSnitch = False
  endif
EndEvent

function setVars()
  if bBusy
    return
  endif
  bBusy = True
  if !MainScript.SexLabInterface
    MainScript.SexLabInterface = MainScript.SexLabInterfaceQst as zzzmrt_sp_sexlab_interface 
  endif
  if !MainScript.OStimInterface
    MainScript.OStimInterface = MainScript.OStimInterfaceQst as zzzmrt_sp_ostim_interface 
  endif
  if !MainScript.FlowerGirlsInterface
    MainScript.FlowerGirlsInterface = MainScript.FlowerGirlsInterfaceQst as zzzmrt_sp_flowergirls_interface 
  endif
  if !MainScript.LicensesInterface
    MainScript.LicensesInterface = MainScript.LicensesInterfaceQst as zzzmrt_sp_licenses_interface 
  endif
  MainScript.SexLabInterface.PlayerLoadsGame()
  MainScript.OStimInterface.PlayerLoadsGame()
  MainScript.FlowerGirlsInterface.PlayerLoadsGame()
  MainScript.LicensesInterface.PlayerLoadsGame()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  Utility.Wait(10.0)
  MainScript.bIsSexlabActive = MainScript.SexLabInterface.GetIsInterfaceActive()
  MainScript.bIsOStimActive = MainScript.OStimInterface.GetIsInterfaceActive()
  MainScript.bIsFlowerGirlsActive = MainScript.FlowerGirlsInterface.GetIsInterfaceActive()
  MainScript.bIsLicensesActive = MainScript.LicensesInterface.GetIsInterfaceActive()
  bBusy = False
endfunction