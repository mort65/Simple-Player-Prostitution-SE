Scriptname zzzmrt_sp_inn_work_qst_script extends Quest Conditional

import zzzmrt_sp_utility

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
zzzmrt_sp_innworkowner_alias_script property InnOwnerScript Auto
ReferenceAlias Property InnOwner Auto
Int Property iWhoreLicenseCost = 0 Auto Hidden Conditional
Int Property iPlayerDebt = 0 Auto Hidden Conditional
Bool Property bHasWhoreLicense = False Auto Hidden Conditional
Bool property bNeedWhoreLicense = False Auto Hidden Conditional
Armor property TavernClothing Auto
Bool property bplayerPaid = False Auto Hidden Conditional
Quest Property DialogueGeneric Auto
Float Property fDeadlineHours = 24.0 Auto Hidden Conditional
Faction Property InnWorkDoneFaction Auto
GlobalVariable property RoomCost Auto
GlobalVariable property PlayerDebtDisplay Auto


Function checkStatus()
	bNeedWhoreLicense = MainScript.playerNeedWhoreLicense()
	bHasWhoreLicense = MainScript.playerHasWhoreLicense()
	if bHasWhoreLicense
		iWhoreLicenseCost = MainScript.LicensesInterface.getWhoreLicenseCost()
	else
		iWhoreLicenseCost = 0
	endif
	MainScript.log("bNeedWhoreLicense: " + bNeedWhoreLicense)
	MainScript.log("bHasWhoreLicense: " + bHasWhoreLicense)
	MainScript.log("iWhoreLicenseCost: " + iWhoreLicenseCost)
	UpdateCurrentInstanceGlobal(RoomCost)
EndFunction

Function addRoomRentalDebt()
	int iRoomCost = RoomCost.GetValueInt()
	if iRoomCost > 0
		updateDebt(iRoomCost)
	endif
EndFunction

Function addLicenseDebt(Actor akInnOwner)
	if !akInnOwner || (iWhoreLicenseCost <= 0)
		return
	endif
	InnOwner.ForceRefTo(akInnOwner)
	MainScript.player.additem(MainScript.gold, iWhoreLicenseCost)
	updateDebt(iWhoreLicenseCost)
	SetStage(10)
EndFunction


Function startWhoring(Actor akInnOwner)
	if !akInnOwner
		return
	endif
	InnOwner.ForceRefTo(akInnOwner)
	int iRoomCost = RoomCost.GetValueInt()
	RoomCost.SetValueInt(0) ;player paid before or borrowed from innowner
	(akInnOwner as RentRoomScript).RentRoom(DialogueGeneric as DialogueGenericScript)
	RoomCost.SetValueInt(iRoomCost)
	MainScript.AllowProstitution(akInnOwner)
	if iPlayerDebt > 0
		SetStage(20)
	endif
	InnOwnerScript.RegisterForSingleUpdateGameTime(fDeadlineHours)
	
EndFunction

Function resetWhoring()
	iPlayerDebt = 0
	bplayerPaid = False
	InnOwner.Clear()
	SetStage(0)
EndFunction

Function finishWhoring()
	InnOwner.GetActorReference() && InnOwner.GetActorReference().AddToFaction(InnWorkDoneFaction)
	if InnOwner.GetActorReference() && (iPlayerDebt > 0)
		Actor ownerActor = InnOwner.GetActorReference()
		ownerActor.getcrimefaction().ModCrimeGold(maxInt(MainScript.iCrimeBounty, iPlayerDebt))
		if ownerActor.GetDisplayName()
			MainScript.log(ownerActor.GetDisplayName() + " reported you for not paying your debt.", True, True, 2)
		else
			MainScript.log("Inn owner reported you for not paying your debt.", True, True, 2)
		endif
		fail()
	else
		Succeed()
	endif
	iPlayerDebt = 0
	bplayerPaid = False
	InnOwner.Clear()
EndFunction

Function updateDebt(Int iAmount)
	iPlayerDebt = maxInt(0, iPlayerDebt + iAmount)
	PlayerDebtDisplay.SetValueInt(iPlayerDebt)
	UpdateCurrentInstanceGlobal(PlayerDebtDisplay)
	if iPlayerDebt < 1
		finishWhoring()
	endif
EndFunction

Bool Function isPlayerInDebt()
	return isRunning() && ((GetStage() == 10) || (GetStage() == 20)) && (iPlayerDebt > 0)
EndFunction

Bool Function innWorkOwnerHere()
	return InnOwner.GetActorReference() && (InnOwner.GetActorReference().GetParentCell() == MainScript.Player.GetparentCell())
EndFunction

Function Fail()
	SetStage(30)
EndFunction


Function Succeed()
	SetStage(40)
EndFunction

