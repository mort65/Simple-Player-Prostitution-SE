Scriptname zzzmrt_sp_std_qst_script extends Quest Conditional

import zzzmrt_sp_utility

zzzmrt_sp_main_qst_script property MainScript auto
Formlist property stds auto ;stds_ByStage
Formlist property stds_ByType auto 
Formlist property stds_I auto 
Formlist property stds_II auto
Formlist property stds_III auto
Formlist property stds_IV auto
Formlist property curSTDStages auto
Formlist property nextSTDStages auto
Formlist property possibleNewSTDs auto
GlobalVariable Property currentCureSTDsPriceDisplay Auto
Potion property CureNormalDiseasePotion auto
Actor Property player Auto
MiscObject Property Gold001 Auto
String sexMode
Bool bBusy = False

Event OnUpdate()
	registerForEvents()
	setCureSTDCost(player)
EndEvent

Event OnInit()
	registerForSingleUpdate(3.0)
EndEvent

event OnInfectPlayerWithSTD(Form akSender, String  sMode)
	GoToState("Infecting")
	sexMode = sMode
	registerForSingleUpdate(5.0)
endevent

Event OnCalcPlayerSTDCurePrice(Form akSender)
	setCureSTDCost(player)
EndEvent

Function registerForEvents()
	RegisterForModEvent("SPP_InfectPlayerWithSTD", "OnInfectPlayerWithSTD")
	RegisterForModEvent("SPP_CalcPlayerSTDCurePrice", "OnCalcPlayerSTDCurePrice")	
EndFunction

Int function actorHasSTD(Actor akActor)
	if !akActor
		akActor = player
	endif
	int jIndex	
	Formlist stdList
	int iIndex = stds_ByType.GetSize()
	while iIndex > 0
		iIndex -= 1
		stdList = stds_ByType.GetAt(iIndex) as Formlist
		jIndex = stdList.GetSize()
		while jIndex > 0
			jIndex -= 1
			if akActor.hasSpell(stdList.GetAt(jIndex) As Spell)
				return (jIndex + 1)
			endif
		endWhile
	endWhile
	return 0
Endfunction

Bool function cureActorSTDs(Actor akActor, Bool bPay = true, int maxStage = 0, int maxCures = -1)
	if !akActor
		akActor = player
	endif
	GoToState("Healing")
	Int[] priceArr = new Int[4]
	priceArr[0] = MainScript.fCureSTDICost As Int
	priceArr[1] = MainScript.fCureSTDIICost As Int
	priceArr[2] = MainScript.fCureSTDIIICost As Int
	priceArr[3] = MainScript.fCureSTDIVCost As Int
	Int totalPrice = 0
	Bool bCured = False
	Formlist stdList
	Spell std
	Form[] stdArr = shuffleFormArr(formlistToArr(stds_ByType))
	Int iIndex = stdArr.Length
	Int jIndex
	while iIndex > 0
		iIndex -= 1
		stdList = stdArr[iIndex] as Formlist
		jIndex = maxStage
		if (jIndex < 1) || (jIndex > stdList.GetSize())
			jIndex = stdList.GetSize()
		endif
		while jIndex > 0
			jIndex -= 1
			std = stdList.GetAt(jIndex) As Spell
			if akActor.hasSpell(std)
				if (maxCures < 0) || ((maxCures - 1) > -1)
					akActor.RemoveSpell(std)
					totalPrice += priceArr[jIndex]
					bCured = true
					maxCures -= 1
					Debug.trace("Simple Prostitution: " + std.GetName() + " cured.")
					Debug.Notification(std.GetName() + " cured.")
				endif
			endif
		endWhile
	endWhile
	akActor.EquipItem(CureNormalDiseasePotion, False, True)
	if totalPrice == 0
		totalPrice = MainScript.fCureNormalDiseaseCost as Int
	endif
	if bPay && (totalPrice > 0)
		akActor.RemoveItem(Gold001, totalPrice)
	endif
	setCureSTDCost(akActor)
	registerForSingleUpdate(1.0)
	return bCured
Endfunction

Int Function setCureSTDCost(Actor akActor)
	if !akActor
		akActor = player
	endif
	if bBusy
		return 0
	endif
	bBusy = true
	Int[] priceArr = new Int[4]
	priceArr[0] = MainScript.fCureSTDICost As Int
	priceArr[1] = MainScript.fCureSTDIICost As Int
	priceArr[2] = MainScript.fCureSTDIIICost As Int
	priceArr[3] = MainScript.fCureSTDIVCost As Int
	Int totalPrice = 0
	int jIndex
	Formlist stdList
	int iIndex = stds_ByType.GetSize()
	while iIndex > 0
		iIndex -= 1
		stdList = stds_ByType.GetAt(iIndex) as Formlist
		jIndex = stdList.GetSize()	
		while jIndex > 0
			jIndex -= 1
			if akActor.hasSpell(stdList.GetAt(jIndex) As Spell)
				totalPrice += priceArr[jIndex]
			endif
		endWhile
	endWhile
	if totalPrice == 0 
		totalPrice = MainScript.fCureNormalDiseaseCost As Int ;for Potion of Cure Disease
	endif
	currentCureSTDsPriceDisplay.SetValueInt(totalPrice)
	UpdateCurrentInstanceGlobal(currentCureSTDsPriceDisplay)
	bBusy = False
	Return totalPrice
Endfunction

State Infecting
	Event OnUpdate()
		GoToState("")
	EndEvent
	
	Event OnEndState()
		Bool bInfect
		Bool bProgress
		if sexMode == "Dibeling"
			bInfect = (MainScript.fDibelSTDInfectChance > Utility.RandomInt(0, 99)) && (MainScript.bDibelAllowMultipleSTDs || !actorHasSTD(player))
			bProgress = MainScript.fDibelSTDProgressChance > Utility.RandomInt(0, 99)
		elseif sexMode == "Whoring"
			bInfect = (MainScript.fWhoreSTDInfectChance > Utility.RandomInt(0, 99)) && (MainScript.bWhoreAllowMultipleSTDs || !actorHasSTD(player))
			bProgress =  MainScript.fWhoreSTDProgressChance > Utility.RandomInt(0, 99)
	    elseif sexMode == ""
	        bInfect = (MainScript.fNormalSTDInfectChance > Utility.RandomInt(0, 99)) && (MainScript.bNormalAllowMultipleSTDs || !actorHasSTD(player))
			bProgress = MainScript.fNormalSTDProgressChance > Utility.RandomInt(0, 99)
	    endif
	    if bInfect || bProgress
			nextSTDStages.revert()
			curSTDStages.revert()
			possibleNewSTDs.revert()
			int jIndex
			int iIndex = stds_ByType.GetSize()
			Form stdStage
			Form firstSTDStage
			Formlist stdList
			while iIndex > 0
				iIndex -= 1
				stdList = stds_ByType.GetAt(iIndex) As FormList
				firstSTDStage = stdList.GetAt(0)
				possibleNewSTDs.addForm(firstSTDStage)
				jIndex = stdList.GetSize()
				while jIndex > 0
					jIndex -= 1
					stdStage = stdList.getAt(jIndex)
					if player.hasSpell(stdStage As Spell)
						possibleNewSTDs.removeAddedForm(firstSTDStage)
						if jIndex < stdList.GetSize() - 1 ;not in last stage
							curSTDStages.addForm(stdStage)
							nextSTDStages.addForm(stdList.getAt(jIndex + 1))
						endif
					endif
				endWhile
			endWhile
			bProgress = bProgress && (nextSTDStages.GetSize() > 0)
			bInfect = bInfect && (possibleNewSTDs.GetSize() > 0)
			if bProgress && bInfect
				if Utility.randomInt(0,1)
				  bProgress = false
				else
				  bInfect = False
				endif
			endif
			if bProgress
				iIndex = utility.randomint(0, nextSTDStages.GetSize() - 1)
				Spell curSTDStage = curSTDStages.GetAt(iIndex) As Spell
				Spell nextSTDStage = nextSTDStages.GetAt(iIndex) As Spell
				player.RemoveSpell(curSTDStage)
				player.addSpell(nextSTDStage)
				Debug.Trace("Simple Prostitution: STD progressed, Infected: " + player + ", CurrentStage: " + nextSTDStage.GetName() + ", PreviousStage: " + curSTDStage.GetName())
			endif
			if bInfect
				iIndex = utility.randomint(0, possibleNewSTDs.GetSize() - 1)
				spell std = possibleNewSTDs.GetAt(iIndex) As Spell
				player.addSpell(std)
				Debug.Trace("Simple Prostitution: STD transmitted, infected: " + player + ", CurrentStage: " + std.GetName())
			endif
			setCureSTDCost(player)
	    endif		
	EndEvent
	
	Event OnCalcPlayerSTDCurePrice(Form akSender)
	EndEvent

	event OnInfectPlayerWithSTD(Form akSender, String  sMode)
	EndEvent
	
	Bool function cureActorSTDs(Actor akActor, Bool bPay = true, int maxStage = 0, int maxCures = -1)
	EndFunction

EndState


State Healing
	Event OnUpdate()
		GoToState("")
	EndEvent
	
	Event OnCalcPlayerSTDCurePrice(Form akSender)
	EndEvent

	event OnInfectPlayerWithSTD(Form akSender, String  sMode)
	EndEvent

	Bool function cureActorSTDs(Actor akActor, Bool bPay = true, int maxStage = 0, int maxCures = -1)
	EndFunction

EndState
