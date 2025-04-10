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
Armor property TavernBoot Auto
Bool property bPlayerPaidForRoom = False Auto Hidden Conditional
Bool property bPlayerRentedRoom = False Auto Hidden Conditional
Quest Property DialogueGeneric Auto
Float Property fDeadlineHours = 24.0 Auto Hidden Conditional
Faction Property InnWorkDoneFaction Auto
GlobalVariable property RoomCost Auto
GlobalVariable property PlayerDebtDisplay Auto
GlobalVariable property LicensePriceDisplay Auto
GlobalVariable property InnWorkDeadLineDisplay Auto
GlobalVariable property GameDaysPassed Auto
Message Property sendToSlaveryMessage Auto
Bool property doSendToSlavey = False Auto Hidden Conditional
Float property fInnDebtTimeGameDaysPassed = 0.0 Auto Hidden Conditional
Float Property fInnWorkDeadlineDays = 0.0 Auto Hidden Conditional
FormList Property innWhoreClothingList Auto


Function checkStatus()
	bNeedWhoreLicense = MainScript.playerNeedWhoreLicense()
	bHasWhoreLicense = MainScript.playerHasWhoreLicense()
	if bNeedWhoreLicense
		iWhoreLicenseCost = MainScript.LicensesInterface.getWhoreLicenseCost()
	else
		iWhoreLicenseCost = 0
	endif
	LicensePriceDisplay.SetValueInt(iWhoreLicenseCost)
	UpdateCurrentInstanceGlobal(RoomCost)
EndFunction

Function addRoomRentalDebt()
	int iRoomCost = RoomCost.GetValueInt()
	if iRoomCost > 0
		updateDebt(iRoomCost)
	endif
	bPlayerRentedRoom = true
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
	RentRoom(akInnOwner)
	InnOwner.ForceRefTo(akInnOwner)
	MainScript.AllowProstitution(akInnOwner)
	if iPlayerDebt > 0
		SetStage(20)
	endif	
EndFunction

Function RentRoom(Actor akInnOwner)
	if (!akInnOwner || (akInnOwner.GetActorValue("Variable09") == 1))
		return
	endif
	int iRoomCost = RoomCost.GetValueInt()
	if ((iRoomCost > 0) && (bPlayerPaidForRoom || (bPlayerRentedRoom && iPlayerDebt > 0)))
		MainScript.player.additem(MainScript.gold, iRoomCost)
	endif
	(akInnOwner as RentRoomScript).RentRoom(DialogueGeneric as DialogueGenericScript)
EndFunction

Function addWhoreClothingToPlayer()
	if innWhoreClothingList.GetSize() > 0
		int i = innWhoreClothingList.GetSize()
		while i > 0
			i -= 1
			if innWhoreClothingList.GetAt(i) as Armor
				if MainScript.player.GetItemCount(innWhoreClothingList.GetAt(i) as Armor) < 1
					MainScript.player.additem(innWhoreClothingList.GetAt(i) as Armor, 1)
				endif
			endif
		endWhile
	else
		if MainScript.player.GetItemCount(TavernClothing) < 1
			MainScript.player.additem(TavernClothing, 1)
		endif
		if MainScript.player.GetItemCount(TavernBoot) < 1
			MainScript.player.additem(TavernBoot, 1)
		endif
	endif
EndFunction

Function removeWhoreClothingFromPlayer()
	if  innWhoreClothingList.GetSize() > 0
		int i = innWhoreClothingList.GetSize()
		while i > 0
			i -= 1
			if innWhoreClothingList.GetAt(i) as Armor
				if MainScript.player.GetItemCount(innWhoreClothingList.GetAt(i) as Armor) > 0
					MainScript.player.removeitem(innWhoreClothingList.GetAt(i) as Armor, 1)
				endif
			endif
		endWhile
	else
		if MainScript.player.GetItemCount(TavernClothing) > 0
			MainScript.player.removeitem(TavernClothing, 1)
		endif
		if MainScript.player.GetItemCount(TavernBoot) > 0
			MainScript.player.removeitem(TavernBoot, 1)
		endif
	endif
EndFunction

Function resetWhoring()
	iPlayerDebt = 0
	bPlayerPaidForRoom = False
	bPlayerRentedRoom = False
	doSendToSlavey = False
	InnOwner.Clear()
	SetStage(0)
EndFunction

Function finishWhoring()
	if InnOwner.GetActorReference() && (iPlayerDebt > 0)
		Actor ownerActor = InnOwner.GetActorReference()
		if doSendToSlavey || !ownerActor.getcrimefaction() || (MainScript.randInt(0, 999) < (MainScript.fInnWorkSendToSlaveryChance * 10) as Int)
			if doSendToSlavey
				if MainScript.canPlayerEnslaved()
					sendToSlavery()
				endif
			else
				doSendToSlavey = True
				return
			endif
		else
			ownerActor.getcrimefaction().ModCrimeGold(maxInt(MainScript.iCrimeBounty, iPlayerDebt))
			if ownerActor.GetDisplayName()
				MainScript.log(ownerActor.GetDisplayName() + " reported you for not paying your debt.", True, True, 2)
			else
				MainScript.log("Inn owner reported you for not paying your debt.", True, True, 2)
			endif
			fail()
		endif
	else
		InnOwner.GetActorReference() && InnOwner.GetActorReference().AddToFaction(InnWorkDoneFaction)
		Succeed()
	endif
	iPlayerDebt = 0
	bPlayerPaidForRoom = False
	bPlayerRentedRoom = False
	InnOwner.Clear()
EndFunction

function sendToSlavery()
	GoToState("SendToSlavery")
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
	iPlayerDebt = 0
	doSendToSlavey = False
	InnOwner.GetActorReference() && InnOwner.GetActorReference().AddToFaction(InnWorkDoneFaction)
	SetStage(30)
EndFunction

Function Succeed()
	iPlayerDebt = 0
	doSendToSlavey = False
	SetStage(40)
EndFunction

State SendToSlavery
	Event OnBeginState()
		if doSendToSlavey && isRunning() && ((GetStage() == 10) || (GetStage() == 20))
			InnOwner.GetActorReference() && InnOwner.GetActorReference().AddToFaction(InnWorkDoneFaction)
			if InnOwner.GetActorReference() && (iPlayerDebt > 0)
				if MainScript.TempleLoanScript.doSendToSlavey
					MainScript.TempleLoanScript.fail()
				endif
				fail()
				sendToSlaveryMessage.Show()
				sendModEvent("SSLV Entry")
			else
				Succeed()
			endif
		else
			doSendToSlavey = False
		endif
		GoToState("")
	EndEvent
	
	function sendToSlavery()
	EndFunction
endState


Function logDebtStatus()
	if (!MainScript.InnWorkQst.isRunning() || ((MainScript.InnWorkQst.GetStage() != 10) && (MainScript.InnWorkQst.GetStage() != 20)))
		return
	endif
	float fDays = -1.0
	if fInnDebtTimeGameDaysPassed > 0
		if MainScript.InnWorkQst.GetStage() == 10
			fDays = maxFloat(0.0, ((fDeadlineHours / 24.0) - (GameDaysPassed.GetValue() - fInnDebtTimeGameDaysPassed)))
		elseif MainScript.InnWorkQst.GetStage() == 20
			fDays = maxFloat(0.0, (fInnWorkDeadlineDays - (GameDaysPassed.GetValue() - fInnDebtTimeGameDaysPassed)))
		endif
	endif
	MainScript.log("Your debt is " + iPlayerDebt + " septim.", true, true, 1)
	(fDays >= 0) && MainScript.log("You have " + (fDays as int) + " day and " + maxInt(0, (((fDays - (fDays as Int)) * 24) as int)) + " hour to repay.", true, true, 1)
EndFunction

