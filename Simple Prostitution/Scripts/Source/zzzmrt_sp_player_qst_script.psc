Scriptname zzzmrt_sp_player_qst_script extends ReferenceAlias

zzzmrt_sp_main_qst_script property MainScript auto

import zzzmrt_sp_utility

Bool bCheckVars = False
Bool bInit = False

event OnInit()
  MainScript.MCMScript.MCM_BUSY.SetValue(1)
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
  RegisterForModEvent("SPP_AELStruggle", "OnStruggleEnd")
endfunction

event OnUpdate()
  if bCheckVars
    setVars()
    bCheckVars = False
  endif
  if ((MainScript.InnWorkScript.doSendToSlavey || MainScript.TempleLoanScript.doSendToSlavey) && MainScript.canPlayerEnslaved())
	sendToSlavery()
  else
	MainScript.snitch()
  endif
  RegisterForSleep()
  if bInit
	bInit = False
	MainScript.log("Simple Player Prostitution started", True, True, 0)
	if MainScript.MCMScript.GetState() == "reset"
		MainScript.MCMScript.gotostate("")
	endif
	MainScript.MCMScript.MCM_BUSY.SetValue(0)
  endif
endevent

Event OnCellLoad()
  MainScript.GoToState("")
  MainScript.SLSFR_Interface.SLSFR_toggle_WhoreFlag(MainScript.isPlayerDibeling() || MainScript.isPlayerWhoring())
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  MainScript.checkCurrentLocation()
  MainScript.GoToState("")
  MainScript.bIsBusy = False
  if !mainscript.bPreventFruitlessApproaches
	MainScript.stopApproach(true)
  endif
  if !MainScript.InnWorkQst.isRunning()
	MainScript.InnWorkQst.start()
  endif
  if !MainScript.TempleLoanQst.isRunning()
	MainScript.TempleLoanQst.start()
  endif
  MainScript.startCalcSTDCurePrice()
  MainScript.CheckAliases()
  MainScript.SLSFR_Interface.SLSFR_toggle_WhoreFlag(MainScript.isPlayerDibeling() || MainScript.isPlayerWhoring())
  if (MainScript.whoreSnitch || MainScript.dibelSnitch || MainScript.angryDibelCustomer || MainScript.angryWhoreCustomer || MainScript.InnWorkScript.doSendToSlavey || MainScript.TempleLoanScript.doSendToSlavey)
    RegisterForSingleUpdate(utility.randomFloat(10.0,30.0)) 
  endif
endevent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
EndEvent

Event OnSleepStop(bool abInterrupted)
	if !abInterrupted
		if (MainScript.InnWorkScript.doSendToSlavey || MainScript.TempleLoanScript.doSendToSlavey)
			Utility.wait(3.0)
			if MainScript.canPlayerEnslaved()
				sendToSlavery()
			endif
		 endif
	endif
EndEvent

Event OnStartDetectAssault(string eventName, string strArg, float numArg, Form sender)
  GoToState("Assault")
EndEvent

Event OnStopDetectAssault(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnStartFindSnitch(Form sender, Bool bCheckDibel)
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
  if !MainScript.RewardHandlerScript
	MainScript.RewardHandlerScript = (getOwningQuest() as zzzmrt_sp_reward_handler_script)
  endif
  MainScript.RewardHandlerScript.registerForEvents()
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
  if !MainScript.SLSFR_Interface
    MainScript.SLSFR_Interface = MainScript.SLSFR_Interface_Qst as zzzmrt_sp_slsfr_interface
  endIf
	if !MainScript.SLHH_Interface
		MainScript.SLHH_Interface = MainScript.SLHH_InterFace_Qst as zzzmrt_sp_slhh_interface
	endif
  if !MainScript.SLA_Interface
    MainScript.SLA_Interface = MainScript.SLA_Interface_Qst as zzzmrt_sp_sla_interface
  endIf
  !bInit && MainScript.setVars()
  MainScript.SexLabInterface.PlayerLoadsGame()
  MainScript.OStimInterface.PlayerLoadsGame()
  MainScript.FlowerGirlsInterface.PlayerLoadsGame()
  MainScript.LicensesInterface.PlayerLoadsGame()
  MainScript.DDI_Interface.PlayerLoadsGame()
  MainScript.DDX_Interface.PlayerLoadsGame()
  MainScript.SLSFR_Interface.PlayerLoadsGame()
  MainScript.SLHH_Interface.PlayerLoadsGame()
  MainScript.SLA_Interface.PlayerLoadsGame()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  MainScript.bIsPO3ExtenderActive = MainScript.bCheckPO3Extender()
  MainScript.bIsPyramidUtilsOK = MainScript.bCheckPyramidUtils()
  MainScript.bIsAELStruggleOK = MainScript.bCheckAELStruggle()
	if bInit
		While MainScript.getState() == "Init"
			Utility.wait(0.1)
		endWhile
	else
		Utility.Wait(6.0)
		While MainScript.isCheckingIntegrations()
			Utility.wait(0.1)
		endWhile
	endif
  MainScript.bIsSexlabActive = MainScript.SexLabInterface.GetIsInterfaceActive()
  MainScript.bIsOStimActive = MainScript.OStimInterface.GetIsInterfaceActive()
  MainScript.bIsFlowerGirlsActive = MainScript.FlowerGirlsInterface.GetIsInterfaceActive()
  MainScript.bIsLicensesActive = MainScript.LicensesInterface.GetIsInterfaceActive()
  MainScript.bIsDDIntegrationActive = MainScript.DDI_Interface.GetIsInterfaceActive()
  MainScript.bIsDDExpansionActive = MainScript.DDX_Interface.GetIsInterfaceActive()
  MainScript.bIs_SLSFR_Active = MainScript.SLSFR_Interface.GetIsInterfaceActive()
  MainScript.bIs_SLHH_Active = MainScript.SLHH_Interface.GetIsInterfaceActive()
  MainScript.bIs_SLA_Active = MainScript.SLA_Interface.GetIsInterfaceActive()
  bInit && MainScript.ApproachMonitorScr.updateApproach(False)
  MainScript.templeTaskSeptimCostDisplay.SetValueInt(MainScript.fTempleTaskSeptimCost as Int)
  MainScript.MCMScript.MainQuest.UpdateCurrentInstanceGlobal(MainScript.templeTaskSeptimCostDisplay) ;putting this in mainscript causes this error when compiling the script:  attempting to add temporary variable to free list multiple times...
  MainScript.templeTaskMarkCostDisplay.SetValueInt(MainScript.fTempleTaskMarkCost as Int)
  MainScript.MCMScript.MainQuest.UpdateCurrentInstanceGlobal(MainScript.templeTaskMarkCostDisplay)

endfunction

Function sendToSlavery()
	if  MainScript.TempleLoanScript.doSendToSlavey
		MainScript.TempleLoanScript.sendToSlavery()
	elseif MainScript.InnWorkScript.doSendToSlavey 
		MainScript.InnWorkScript.sendToSlavery()
	endif
endfunction

Event OnStruggleEnd(Form akVictim, Form akAggressor, bool abVictimEscaped)
endevent


State Assault
  Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
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

State struggle

	Event OnStruggleEnd(Form akVictim, Form akAggressor, bool abVictimEscaped)
		MainScript.bStruggleVictimEscaped = abVictimEscaped
		MainScript.bStruggleEnded = true
		if GetState() == "struggle"
			GoToState("")
		endif
	EndEvent

	event OnBeginState()
		MainScript.bStruggleEnded = False
		MainScript.bStruggleVictimEscaped = True
	EndEvent
	
	event OnEndState()
	endEvent

EndState
