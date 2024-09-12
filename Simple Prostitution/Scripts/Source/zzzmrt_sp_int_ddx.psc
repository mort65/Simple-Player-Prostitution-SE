Scriptname zzzmrt_sp_int_ddx Hidden

import zzzmrt_sp_utility

Bool Function _LockRandomDeviceOnActor(Quest zdxQuest, Actor akActor, Int iLevel = 0, Int[] weightedChanceArray) Global
	;iLevel 3 = Everything Allowed
	;iLevel 2 = No Heavy restraint, Blindfold, Hood and Suit
	;iLevel 1 = No Heavy restraint, Blindfold, Hood, Suit, closed belt, bra and gag other than ringed gaged
	;iLevel 0 = No Heavy restraints, Blindfold, Hood, Suit, belt, bra, gag, boot, glove, corset, harness, collar
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	Debug.trace("iLevel: "+ iLevel)

	Bool isFemale = (akActor.GetLeveledActorBase().GetSex() == 1)
	
	LeveledItem[] devices = new LeveledItem[20]
	devices[00] = DX.zad_dev_piercings_nipple
	devices[01] = DX.zad_dev_piercings_vaginal
	devices[02] = DX.zad_dev_plugs_anal
	devices[03] = DX.zad_dev_plugs_vaginal
	devices[04] = DX.zad_dev_armcuffs
	devices[05] = DX.zad_dev_legcuffs
	devices[06] = DX.zad_dev_collars
	devices[07] = DX.zad_dev_gloves
	devices[08] = DX.zad_dev_boots
	devices[09] = DX.zad_dev_corsets
	devices[10] = DX.zad_dev_harnesses
	devices[11] = DX.zad_dev_gags_ring
	devices[12] = DX.zad_dev_chastitybelts_open
	devices[13] = DX.zad_dev_chastitybelts_closed
	devices[14] = DX.zad_dev_chastitybras
	devices[15] = DX.zad_dev_gags
	devices[16] = DX.zad_dev_hoods
	devices[17] = DX.zad_dev_blindfolds
	devices[18] = DX.zad_dev_heavyrestraints
	devices[19] = DX.zad_dev_suits
	;devices[19] = DX.zad_dev_All

	Debug.trace("devices: " + devices)
	Int[] deviceChances = new Int[20]

	deviceChances[0]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPiercingsNipple) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousPiercingsNipple)) as Int
	deviceChances[1]  = (isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPiercingsVaginal) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousPiercingsVaginal)) as Int
	deviceChances[2]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPlugAnal) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousPlugAnal)) As Int
	deviceChances[3]  = (isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPlugVaginal) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousPlugVaginal)) As Int
	deviceChances[4]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousArmCuffs) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousArmCuffs)) As Int
	deviceChances[5]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousLegCuffs) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousLegCuffs)) As Int
	deviceChances[6]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousCollar) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousCollar)) As Int
	deviceChances[7]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousGloves) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousGloves)) As Int
	deviceChances[8]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBoots) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousBoots)) As Int
	deviceChances[9]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousCorset) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousCorset)) As Int
	deviceChances[9]  = (deviceChances[9] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousHarness) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousHarness)) As Int
	deviceChances[10] = deviceChances[9]
	deviceChances[11] = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousGag) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousGag)) As Int
	deviceChances[12] = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBelt) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousBelt)) As Int
	deviceChances[13] = ((iLevel > 1) && deviceChances[12]) as Int
	deviceChances[14] = ((iLevel > 1) && isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBra) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousBra)) As Int
	deviceChances[15] = ((iLevel > 1) && deviceChances[11]) as Int
	deviceChances[16] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousHood) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousHood)) As Int
	deviceChances[17] = (deviceChances[16] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBlindfold) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousBlindfold)) As Int
	deviceChances[18] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousArmbinder) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousArmbinder)) As Int
	deviceChances[19] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousStraitJacket) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousStraitJacket)) As Int
	deviceChances[19] = (deviceChances[19] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousSuit) As Bool) && !akActor.WornHasKeyword(DX.libs.zad_DeviousSuit)) As Int

	int iEmpty = deviceChances.Find(1)

	if iEmpty < 0
		return _TightenRandomDevice(zdxQuest, akActor, Devices)
	endif

	if weightedChanceArray
		int i = weightedChanceArray.Length
		int j = deviceChances.Length
		While i > 0
			i -= 1
			if i < j
				if deviceChances[i] > 0
					deviceChances[i] = weightedChanceArray[i]
				endif
			endif
		endWhile
	endif

	Debug.trace("deviceChances: " + deviceChances)
	int iResult

	iResult = weightedRandInt(deviceChances)

	Debug.trace("iResult: " + iResult)
	if (iResult < 0) || iResult > (devices.Length - 1)
		return False
	endif
	LeveledItem Dev_LVLI = devices[iResult]
	Armor dev = DX.GetRandomDevice(Dev_LVLI)
	keyWord Dev_kw = DX.libs.GetDeviceKeyword(dev)

	Debug.trace("Device: " + dev)
	Debug.trace("Device Name: " + dev.GetName())
	
	if akActor.WornHasKeyword(DX.libs.zad_Lockable)
		Armor rn_Dev = DX.libs.GetRenderedDevice(dev)
		if _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
			Debug.trace("Device has keyword conflict: "+ rn_Dev)
			int i = 0
			while (i < 5) && _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
				dev = DX.GetRandomDevice(Dev_LVLI)
				Dev_kw = DX.libs.GetDeviceKeyword(dev)
				rn_Dev = DX.libs.GetRenderedDevice(dev)
				i += 1
			endwhile
			if _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
				Debug.trace("Could not find devious armor with selected keyword without keyword conflict.")
				return _TightenRandomDevice(zdxQuest, akActor, Devices)
			endif
		endif
		Debug.trace("Device rendered: " + rn_Dev)
		debug.trace("rendered device keywords: "+ rn_Dev.getkeywords())
		Int rn_SlotMask = rn_Dev.GetSlotMask()
		Debug.trace("Device rendered: rSlotMask: " + rn_SlotMask)
		int thisSlot = 0x01
		int slotsChecked = 0xc1423f72 ;sum of slots without any DD item
		while (thisSlot < 0x80000000)
			if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check devious slots
				Armor thisArmor = akActor.GetWornForm(thisSlot) as Armor
				if (thisArmor)
					debug.trace("thisArmor: "+ thisArmor)
					;debug.trace("thisArmor keywords: "+ (thisArmor as form).getkeywords())
					if thisArmor.hasKeyword(DX.libs.zad_Lockable) && (Math.LogicalAnd(rn_SlotMask, thisSlot) == thisSlot)
						Debug.trace("Device has conflict in slot: "+ thisSlot)
						return _TightenRandomDevice(zdxQuest, akActor, Devices)
					endif
				else ;no armor was found on this slot
					slotsChecked += thisSlot
				endif
			endif
			thisSlot *= 2 ;double the number to move on to the next slot
		endWhile
	endif

	if DX.libs.GetWornDeviceFuzzyMatch(akActor, Dev_kw) == None
		DX.libs.LockDevice(akActor, dev, false)
		utility.wait(0.2)
		return true
	endif
	return false
EndFunction

Bool Function _IsBounded(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousHeavyBondage)
EndFunction

Bool Function _IsGagged(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousGag)
EndFunction

Bool Function _IsBelted(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousBelt)
EndFunction

Bool Function _IsBlindfolded(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousBlindfold)
EndFunction


Bool Function _DeviceHaveKeywordConflict(Quest zdxQuest, Actor akActor, Armor akDevice) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX || !akDevice
		return False
	endif
	if akActor.WornHasKeyword(DX.libs.zad_DeviousArmCuffs) && akDevice.hasKeyword(DX.libs.zad_DeviousArmCuffs)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousGag) && akDevice.hasKeyword(DX.libs.zad_DeviousGag)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousHarness) && (akDevice.hasKeyword(DX.libs.zad_DeviousHarness) || akDevice.hasKeyword(DX.libs.zad_DeviousCorset))
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousCorset) && (akDevice.hasKeyword(DX.libs.zad_DeviousHarness) || akDevice.hasKeyword(DX.libs.zad_DeviousCorset))
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousCollar) && akDevice.hasKeyword(DX.libs.zad_DeviousCollar)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousStraitJacket) && (akDevice.hasKeyword(DX.libs.zad_DeviousStraitJacket) || akDevice.hasKeyword(DX.libs.zad_DeviousSuit))
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousArmbinder) && akDevice.hasKeyword(DX.libs.zad_DeviousArmbinder)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousPlugAnal) && akDevice.hasKeyword(DX.libs.zad_DeviousPlugAnal)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousBelt) && akDevice.hasKeyword(DX.libs.zad_DeviousBelt)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousPiercingsVaginal) && akDevice.hasKeyword(DX.libs.zad_DeviousPiercingsVaginal)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousPiercingsNipple) && akDevice.hasKeyword(DX.libs.zad_DeviousPiercingsNipple)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousLegCuffs) && akDevice.hasKeyword(DX.libs.zad_DeviousLegCuffs)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousBlindfold) && akDevice.hasKeyword(DX.libs.zad_DeviousBlindfold)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousBra) && akDevice.hasKeyword(DX.libs.zad_DeviousBra)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousPlugVaginal) && akDevice.hasKeyword(DX.libs.zad_DeviousPlugVaginal)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousSuit) && (akDevice.hasKeyword(DX.libs.zad_DeviousStraitJacket) || akDevice.hasKeyword(DX.libs.zad_DeviousSuit))
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousGloves) && akDevice.hasKeyword(DX.libs.zad_DeviousGloves)
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousHood) && (akDevice.hasKeyword(DX.libs.zad_DeviousHood) || akDevice.hasKeyword(DX.libs.zad_DeviousBlindfold))
	elseif akActor.WornHasKeyword(DX.libs.zad_DeviousBoots) && akDevice.hasKeyword(DX.libs.zad_DeviousBoots)
	else
		return False
	endif
	return true
EndFunction

Function _LockDeviousDevice(Quest zdxQuest, Actor akActor, Armor akDevice, Bool bForce = False) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX || !akDevice
		return
	endif
	DX.libs.LockDevice(akActor, akDevice, bForce)
EndFunction

Bool Function _TightenRandomDevice(Quest zdxQuest, Actor akActor, LeveledItem[] akDevices) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX || !akDevices || (akDevices.Length == 0)
		return false
	endif
	int i = utility.randomint(0,akDevices.Length - 1)
	Armor rnd_Dev = DX.GetRandomDevice(akDevices[i])
	keyWord rnd_Dev_kw = DX.libs.GetDeviceKeyword(rnd_Dev)
	Armor equippedDev = DX.libs.GetWornDeviceFuzzyMatch(akActor, rnd_Dev_kw)
	if (equippedDev != None) && DX.libs.CanTightenDevice(akActor, equippedDev)
			DX.libs.TightenDevice(akActor, equippedDev)
			return true
	endif
	return false		
EndFunction

Function _InflateRandomPlug(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return
	endif
	if utility.randomint(0,1) && akActor.WornHasKeyword(DX.libs.zad_kw_InflatablePlugAnal)
		DX.libs.InflateAnalPlug(akActor)
	elseif utility.randomint(0,1) && akActor.WornHasKeyword(DX.libs.zad_kw_InflatablePlugVaginal)
		DX.libs.InflateVaginalPlug(akActor)			
	endif
EndFunction