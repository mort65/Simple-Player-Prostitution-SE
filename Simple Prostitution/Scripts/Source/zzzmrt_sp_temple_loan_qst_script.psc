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
Int Property iInitialDebt = 0 Auto Hidden Conditional
Int Property iCurrentBaseDebt = 0 Auto Hidden Conditional
Faction property CrimeFactionReach Auto
Message Property TempleSendToSlaveryMessage Auto
Bool property doSendToSlavey = False Auto Hidden Conditional
Faction Property TempleLoanFailedFaction Auto
Actor property player auto
Int property iLoanIndex = -1 Auto Hidden Conditional
Int property maxGold = 65534 auto Hidden Conditional
Float property fDeadline = 0.0 auto Hidden Conditional
Float property fPaidTimeDayPassed = 0.0 auto Hidden Conditional

Function updateDebt(Int iAmount, Bool bLog = False)
	if (iAmount > 0)
		if iPlayerDebt < 1
			iInitialDebt = maxInt(0, iInitialDebt + iAmount)
			iCurrentBaseDebt = iInitialDebt
			iPlayerDebt = maxInt(0, GetPlayerDebt(iCurrentBaseDebt, bCompoundInterest))
		else
			MainScript.log("You can't get another loan when you're already in debt.", true, true, 2)
		endif
	else
		iPlayerDebt = maxInt(0, GetPlayerDebt(iCurrentBaseDebt, bCompoundInterest)) ;Calc current debt
		if (iAmount < 0)
			iPlayerDebt = iPlayerDebt + iAmount
			fPaidTimeDayPassed = GameDaysPassed.GetValue()
			iCurrentBaseDebt = iPlayerDebt
		endif
	endif
	PlayerTempleDebtDisplay.SetValueInt(iPlayerDebt)
	UpdateCurrentInstanceGlobal(PlayerTempleDebtDisplay)
	If bLog
		MainScript.log("Your current debt is " + iPlayerDebt + " septim.", true, true, 1)
		MainScript.log("Your initial debt was " + iInitialDebt + " septim.", true, true, 1)
		Float fDays = maxFloat(0.0, (fDeadline - (GameDaysPassed.GetValue() - fLoanTimeGameDaysPassed)))
		MainScript.log("You have " + (fDays as int) + " day and " + maxInt(0, (((fDays - (fDays as Int)) * 24) as int)) + " hour to repay.", true, true, 1)
	endif
EndFunction

Int function GetPlayerDebt(Int iDebt, Bool bCompounded = False)
	if fDailyInterest <= 0.0
		return iDebt
	endif
	if bCompounded
		int iDaysPassed = (GameDaysPassed.GetValue() - fPaidTimeDayPassed) As int
		Float fTotalDebt = iDebt
		While iDaysPassed > 0
			fTotalDebt = fTotalDebt + (fTotalDebt * fDailyInterest)
			iDaysPassed -= 1
		endWhile
		return (fTotalDebt as Int)
	endif
	return ((iDebt + (((GameDaysPassed.GetValue() - fPaidTimeDayPassed) As int) * fDailyInterest * iDebt)) as Int)
EndFunction

Function setLoanValues()
	fDeadline = MainScript.fTempleLoanDeadlineDays
	fDailyInterest = (MainScript.iTempleLoanInterestDaily / 100.0)
	bCompoundInterest = MainScript.bTempleLoanInterestCompound
	fLoanSpeechMult = MainScript.fTempleLoanSpeechMult
	iGoldToLend1 = minInt(maxGold, (20.0 * fLoanSpeechMult) as Int)
	iGoldToLend2 = minInt(maxGold, (40.0 * fLoanSpeechMult) as Int)
	iGoldToLend3 = minInt(maxGold, (60.0 * fLoanSpeechMult) as Int)
	iGoldToLend4 = minInt(maxGold, (80.0 * fLoanSpeechMult) as Int)
	iGoldToLend5 = minInt(maxGold, (100.0 * fLoanSpeechMult) as Int)
	int iGold = player.getItemCount(MainScript.gold)
	if ((iGold + iGoldToLend1) > maxGold)
		iGoldToLend1 = maxInt(0, (maxGold - iGold))
	endif
	if ((iGold + iGoldToLend2) > maxGold)
		iGoldToLend2 = maxInt(0, (maxGold - iGold))
	endif
	if ((iGold + iGoldToLend3) > maxGold)
		iGoldToLend3 = maxInt(0, (maxGold - iGold))
	endif
	if ((iGold + iGoldToLend4) > maxGold)
		iGoldToLend4 = maxInt(0, (maxGold - iGold))
	endif
	if ((iGold + iGoldToLend5) > maxGold)
		iGoldToLend5 = maxInt(0, (maxGold - iGold))
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
			CrimeFactionReach.ModCrimeGold(maxInt(0, minInt(maxGold - iPlayerDebt, iPlayerDebt)))
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
	if iAmount < 1
		return
	endif
	iInitialDebt = 0
	iCurrentBaseDebt = 0
	iPlayerDebt = 0
	player.addItem(MainScript.gold, iAmount)
	fLoanTimeGameDaysPassed = GameDaysPassed.GetValue()
	fPaidTimeDayPassed = fLoanTimeGameDaysPassed
	updateDebt(iAmount)
	SetStage(10)
EndFunction

function sendToSlavery()
	GoToState("SendToSlavery")
EndFunction

State SendToSlavery
	Event OnBeginState()
		if doSendToSlavey && isRunning() && (GetStage() == 10)
			if (iPlayerDebt > 0)
				if MainScript.InnWorkScript.doSendToSlavey
					MainScript.InnWorkScript.Fail()
				endif
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