Scriptname zzzmrt_sp_temple_loan_qst_script extends Quest Conditional

import zzzmrt_sp_utility

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
zzzmrt_sp_temple_lender_alias_script property LenderScript Auto
ReferenceAlias Property TempleLender Auto

Float property fDailyInterest = 0.0 Auto Hidden Conditional
Bool property bCompoundInterest = true Auto Hidden Conditional
Int property iGoldToLend1 = 2000 Auto Hidden Conditional
Int property iGoldToLend2 = 4000 Auto Hidden Conditional
Int property iGoldToLend3 = 6000 Auto Hidden Conditional
Int property iGoldToLend4 = 8000 Auto Hidden Conditional
Int property iGoldToLend5 = 10000 Auto Hidden Conditional
GlobalVariable property GoldToLendDisplay1 Auto
GlobalVariable property GoldToLendDisplay2 Auto
GlobalVariable property GoldToLendDisplay3 Auto
GlobalVariable property GoldToLendDisplay4 Auto
GlobalVariable property GoldToLendDisplay5 Auto
GlobalVariable property GameDaysPassed Auto
GlobalVariable property PlayerTempleDebtDisplay Auto
GlobalVariable property TempleLoanDeadLineDisplay Auto
Float property fLoanSpeechMult = 100.0 Auto Hidden Conditional
Float property fLoanTimeGameDaysPassed = 0.0 Auto Hidden Conditional
Int Property iPlayerDebt = 0 Auto Hidden Conditional
Int Property iPlayerBaseDebt = 0 Auto Hidden Conditional
Faction property CrimeFactionReach Auto
Message Property TempleSendToSlaveryMessage Auto
Bool property doSendToSlavey = False Auto Hidden Conditional
Faction Property TempleLoanFailedFaction Auto
Actor property player auto
Int property iLoanIndex = -1 Auto Hidden Conditional

Function updateDebt(Int iAmount, Bool bLog = False)
	if iAmount > 0
		iPlayerBaseDebt = maxInt(0, iPlayerBaseDebt + iAmount)
		iPlayerDebt = maxInt(0, GetPlayerDebt(iPlayerBaseDebt, bCompoundInterest))
	else
		iPlayerDebt = maxInt(0, GetPlayerDebt(iPlayerBaseDebt, bCompoundInterest))
		iPlayerDebt = iPlayerDebt + iAmount
	endif
	PlayerTempleDebtDisplay.SetValueInt(iPlayerDebt)
	UpdateCurrentInstanceGlobal(PlayerTempleDebtDisplay)
	If bLog
		MainScript.log("Your current debt is " + iPlayerDebt + " septim.", true, true, 1)
		MainScript.log("Your initial debt was " + iPlayerBaseDebt + " septim.", true, true, 1)
		Float fDays = (GameDaysPassed.GetValue() - fLoanTimeGameDaysPassed)
		MainScript.log("You have " + (fDays as int) + " day and " + (((fDays - (fDays as Int)) * 24) as int) + " hour to repay.", true, true, 1)
	endif
EndFunction

Function setLoanValues()
	fDailyInterest = (MainScript.iTempleLoanInterestDaily / 100.0)
	bCompoundInterest = MainScript.bTempleLoanInterestCompound
	fLoanSpeechMult = MainScript.fTempleLoanSpeechMult
	iGoldToLend1 = minInt(65534, (20.0 * fLoanSpeechMult) as Int) ; largest integer for gold is 65,535
	iGoldToLend2 = minInt(65534, (40.0 * fLoanSpeechMult) as Int)
	iGoldToLend3 = minInt(65534, (60.0 * fLoanSpeechMult) as Int)
	iGoldToLend4 = minInt(65534, (80.0 * fLoanSpeechMult) as Int)
	iGoldToLend5 = minInt(65534, (100.0 * fLoanSpeechMult) as Int)
	int iGold = player.getItemCount(MainScript.gold)
	if ((iGold + iGoldToLend1) > 65534)
		iGoldToLend1 = maxInt(0, (65534 - iGold))
	endif
	if ((iGold + iGoldToLend2) > 65534)
		iGoldToLend2 = maxInt(0, (65534 - iGold))
	endif
	if ((iGold + iGoldToLend3) > 65534)
		iGoldToLend3 = maxInt(0, (65534 - iGold))
	endif
	if ((iGold + iGoldToLend4) > 65534)
		iGoldToLend4 = maxInt(0, (65534 - iGold))
	endif
	if ((iGold + iGoldToLend5) > 65534)
		iGoldToLend5 = maxInt(0, (65534 - iGold))
	endif
	GoldToLendDisplay1.SetValueInt(iGoldToLend1)
	GoldToLendDisplay2.SetValueInt(iGoldToLend2)
	GoldToLendDisplay3.SetValueInt(iGoldToLend3)
	GoldToLendDisplay4.SetValueInt(iGoldToLend4)
	GoldToLendDisplay5.SetValueInt(iGoldToLend5)
	UpdateCurrentInstanceGlobal(GoldToLendDisplay1)
	UpdateCurrentInstanceGlobal(GoldToLendDisplay2)
	UpdateCurrentInstanceGlobal(GoldToLendDisplay3)
	UpdateCurrentInstanceGlobal(GoldToLendDisplay4)
	UpdateCurrentInstanceGlobal(GoldToLendDisplay5)
	iLoanIndex = -1
EndFunction

Function StartLoan(Int iIndex)
	if iIndex == 1
		addLoanToPlayer(iGoldToLend1)
	elseif iIndex == 2
		addLoanToPlayer(iGoldToLend2)
	elseif iIndex == 3
		addLoanToPlayer(iGoldToLend3)
	elseif iIndex == 4
		addLoanToPlayer(iGoldToLend4)
	elseif iIndex == 5
		addLoanToPlayer(iGoldToLend5)
	endif
EndFunction

Function FinishLoan()
	if (iPlayerDebt > 0)
		if doSendToSlavey || (MainScript.randInt(0, 999) < (MainScript.fTempleLoanSendToSlaveryChance * 10) as Int)
			if doSendToSlavey
				if MainScript.canPlayerEnslaved()
					sendToSlavery()
				endif
			else
				doSendToSlavey = True
				return
			endif
		else
			CrimeFactionReach.ModCrimeGold(maxInt(MainScript.iCrimeBounty, iPlayerDebt))
			MainScript.log("You reported by the temple for not paying your debt.", True, True, 2)
			fail()
		endif
	else
		Succeed()
	endif
EndFunction

Function payDebt()
	int iGold = player.getItemCount(MainScript.gold)
	if iGold >=iPlayerDebt
		player.removeItem(MainScript.gold, iPlayerDebt)
		iPlayerDebt = 0
		FinishLoan()
	else
		player.removeItem(MainScript.gold, iGold)
		updateDebt(-1 * iGold, true)
	endif
EndFunction

Function fail()
	doSendToSlavey = False
	iPlayerDebt = 0
	player.addToFaction(TempleLoanFailedFaction)
	SetStage(20)
EndFunction

Function Succeed()
	doSendToSlavey = False
	iPlayerDebt = 0
	SetStage(30)
EndFunction

function addLoanToPlayer(Int iAmount)
	iPlayerBaseDebt = 0
	iPlayerDebt = 0
	player.addItem(MainScript.gold, iAmount)
	fLoanTimeGameDaysPassed = GameDaysPassed.GetValue()
	updateDebt(iAmount)
	SetStage(10)
EndFunction

Int function GetPlayerDebt(Int iDebt, Bool bCompounded = False)
	if fDailyInterest <= 0.0
		return iDebt
	endif
	if bCompounded
		int iDaysPassed = (GameDaysPassed.GetValue() - fLoanTimeGameDaysPassed) As int
		int iTotalDebt = iDebt
		While iDaysPassed > 0
			iTotalDebt = iTotalDebt + (iTotalDebt * fDailyInterest) as Int
			iDaysPassed -= 1
		endWhile
		return iTotalDebt
	endif
	return (iDebt + (((GameDaysPassed.GetValue() - fLoanTimeGameDaysPassed) As int) * fDailyInterest * iDebt) as Int)
EndFunction

function sendToSlavery()
	GoToState("SendToSlavery")
EndFunction

State SendToSlavery
	Event OnBeginState()
		if doSendToSlavey && isRunning() && (GetStage() == 10)
			if (iPlayerDebt > 0)
				fail()
				TempleSendToSlaveryMessage.Show()
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