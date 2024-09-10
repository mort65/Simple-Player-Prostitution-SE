Scriptname zzzmrt_sp_player_qst_script extends ReferenceAlias

zzzmrt_sp_main_qst_script property MainScript auto

Bool bCheckVars = False
Bool bInit = False

event OnInit()
  ;Debug.trace("Simple Prostitution: OnInit() triggered for " + self)
  bInit = True
  bCheckVars = True
  RegisterForSingleUpdate(3.0)
endevent

event OnPlayerLoadGame()
  bCheckVars = True
  RegisterForSingleUpdate(3.0)
endevent

Function RegisterForEvents()
  RegisterForModEvent("SPP_StartFindSnitch", "OnStartFindSnitch")
  RegisterForModEvent("SPP_StartDetectAssault", "OnStartDetectAssault")
  RegisterForModEvent("SPP_StopDetectAssault", "OnStopDetectAssault")
endfunction

event OnUpdate()
  if bCheckVars
    setVars()
    bCheckVars = False
  endif
  MainScript.snitch()
  bInit = False
endevent

Event OnCellLoad()
  MainScript.GoToState("")
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  MainScript.checkCurrentLocation()
  MainScript.GoToState("")
  MainScript.stopApproach(true)
  MainScript.startCalcSTDCurePrice()
  MainScript.CheckAliases()
  if (MainScript.whoreSnitch || MainScript.dibelSnitch || MainScript.angryDibelCustomer || MainScript.angryWhoreCustomer)
    RegisterForSingleUpdate(utility.randomFloat(10.0,30.0)) 
  endif
endevent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
EndEvent

Event OnStartDetectAssault(string eventName, string strArg, float numArg, Form sender)
  GoToState("Assault")
EndEvent

Event OnStopDetectAssault(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnStartFindSnitch(Form sender, Bool bCheckDibel)
  ;Debug.Trace("Simple Prostitution: OnStartFindSnitch triggered.")
  MainScript.snitchers.revert()
  if !MainScript.GetState() == ""
    Bool bFound = False
    while !bFound && (MainScript.GetState() != "")
      bFound = MainScript.findSnitch(bCheckDibel)
      utility.wait(1.0)
    endWhile
  endif
EndEvent

function setVars()
  if !MainScript.STD_Quest.isRunning()
    MainScript.STD_Quest.Start()
  endIf
  RegisterForEvents()
  MainScript.STD_Script.registerForEvents()
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
  if !MainScript.DDI_Interface
    MainScript.DDI_Interface = MainScript.DDI_Interface_Qst as zzzmrt_sp_ddi_interface
  endIf
  if !MainScript.DDX_Interface
    MainScript.DDX_Interface = MainScript.DDX_Interface_Qst as zzzmrt_sp_ddx_interface
  endIf
  !bInit && MainScript.setVars()
  MainScript.SexLabInterface.PlayerLoadsGame()
  MainScript.OStimInterface.PlayerLoadsGame()
  MainScript.FlowerGirlsInterface.PlayerLoadsGame()
  MainScript.LicensesInterface.PlayerLoadsGame()
  MainScript.DDI_Interface.PlayerLoadsGame()
  MainScript.DDX_Interface.PlayerLoadsGame()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  MainScript.bIsPO3ExtenderActive = MainScript.bCheckPO3Extender()
  MainScript.bIsPyramidUtilsOK = MainScript.bCheckPyramidUtils()
  Utility.Wait(10.0)
  MainScript.bIsSexlabActive = MainScript.SexLabInterface.GetIsInterfaceActive()
  MainScript.bIsOStimActive = MainScript.OStimInterface.GetIsInterfaceActive()
  MainScript.bIsFlowerGirlsActive = MainScript.FlowerGirlsInterface.GetIsInterfaceActive()
  MainScript.bIsLicensesActive = MainScript.LicensesInterface.GetIsInterfaceActive()
  MainScript.bIsDDIntegrationActive = MainScript.DDI_Interface.GetIsInterfaceActive()
  MainScript.bIsDDExpansionActive = MainScript.DDX_Interface.GetIsInterfaceActive()
  MainScript.ApproachMonitorScr.PlayerLoadsGame()
endfunction


State Assault
  Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
    Debug.trace("Simple Prostitution: OnHit() triggered for " + self)
    MainScript.bAssaulted = true
    if GetState() == "Assault"
      GoToState("")
    endif
  EndEvent

  Event OnStopDetectAssault(string eventName, string strArg, float numArg, Form sender)
    if GetState() == "Assault"
      GoToState("")
    endif
  EndEvent
EndState