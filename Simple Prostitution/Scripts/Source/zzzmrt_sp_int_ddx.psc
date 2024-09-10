Scriptname zzzmrt_sp_int_ddx Hidden

import zzzmrt_sp_utility

Bool Function _lockRandomDeviceOnActor(Quest zdxQuest, Actor akActor, Int iLevel = 0, Int[] weightedChanceArray) Global
	;iLevel 3 = Everything Allowed
	;iLevel 2 = No Heavy restraint, Blindfold, Hood and Suit
	;iLevel 1 = No Heavy restraint, Blindfold, Hood, Suit, closed belt, bra and gag other than ringed gaged
	;iLevel 0 = No Heavy restraints, Blindfold, Hood, Suit, belt, bra, gag, boot, glove, corset, harness, collar
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	;Bool bLocked = False
	;Bool bTighten = False
	;Bool bLockIt = False

	Debug.trace("iLevel: "+ iLevel)

	Bool isFemale = (akActor.GetLeveledActorBase().GetSex() == 1)
	
	LeveledItem[] devices = new LeveledItem[20]
	devices[0] = DX.zad_dev_piercings_nipple
	devices[1] = DX.zad_dev_piercings_vaginal
	devices[2] = DX.zad_dev_plugs_anal
	devices[3] = DX.zad_dev_plugs_vaginal
	devices[4] = DX.zad_dev_armcuffs
	devices[5] = DX.zad_dev_legcuffs
	devices[6] = DX.zad_dev_collars
	devices[7] = DX.zad_dev_gloves
	devices[8] = DX.zad_dev_boots
	devices[9] = DX.zad_dev_corsets
	devices[10] = DX.zad_dev_harnesses
	devices[11] = DX.zad_dev_gags_ring
	devices[12] = DX.zad_dev_chastitybelts_open
	devices[13] = DX.zad_dev_chastitybelts_closed
	devices[14] = DX.zad_dev_chastitybras
	devices[15] = DX.zad_dev_gags
	devices[16] = DX.zad_dev_blindfolds
	devices[17] = DX.zad_dev_hoods
	devices[18] = DX.zad_dev_heavyrestraints
	devices[19] = DX.zad_dev_suits
	;devices[19] = DX.zad_dev_All

	Debug.trace("devices: " + devices)
	Int[] deviceChances = new Int[20]

	deviceChances[0]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPiercingsNipple) As Bool)) as Int
	deviceChances[1]  = (isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPiercingsVaginal) As Bool)) as Int
	deviceChances[2]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPlugAnal) As Bool)) As Int
	deviceChances[3]  = (isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousPlugVaginal) As Bool)) As Int
	deviceChances[4]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousArmCuffs) As Bool)) As Int
	deviceChances[5]  = (!(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousLegCuffs) As Bool)) As Int
	deviceChances[6]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousCollar) As Bool)) As Int
	deviceChances[7]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousGloves) As Bool)) As Int
	deviceChances[8]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBoots) As Bool)) As Int
	deviceChances[9]  = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousCorset) As Bool)) As Int
	deviceChances[9]  = (deviceChances[9] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousHarness) As Bool)) As Int
	deviceChances[10] = deviceChances[9]
	deviceChances[11] = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousGag) As Bool)) As Int
	deviceChances[12] = ((iLevel > 0) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBelt) As Bool)) As Int
	deviceChances[13] = ((iLevel > 1) && deviceChances[12]) as Int
	deviceChances[14] = ((iLevel > 1) && isFemale && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBra) As Bool)) As Int
	deviceChances[15] = ((iLevel > 1) && deviceChances[11]) as Int
	deviceChances[16] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousBlindfold) As Bool)) As Int
	deviceChances[16] = (deviceChances[16] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousHood) As Bool)) As Int
	deviceChances[17] = deviceChances[16]
	deviceChances[18] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousArmbinder) As Bool)) As Int
	deviceChances[19] = ((iLevel > 2) && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousStraitJacket) As Bool)) As Int
	deviceChances[19] = (deviceChances[19] && !(DX.libs.GetWornDeviceFuzzyMatch(akActor, DX.libs.zad_DeviousSuit) As Bool)) As Int

	int iEmpty = deviceChances.Find(1)

	if iEmpty < 0
		return False
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
	;Bool bForce = False

	;if iEmpty > -1
	iResult = weightedRandInt(deviceChances)
	;else
	;iResult = utility.RandomInt(0, deviceChances.Length - 1)
	;	bForce = true
	;endif
	Debug.trace("iResult: " + iResult)
	if (iResult < 0) || iResult > (devices.Length - 1)
		return False
	endif
	LeveledItem Dev_LVLI = devices[iResult]
	Armor dev = DX.GetRandomDevice(Dev_LVLI)
	keyWord Dev_kw = DX.libs.GetDeviceKeyword(dev)

	Debug.trace("Device: " + dev)
	Debug.trace("Device Name: " + dev.GetName())
	Armor rn_Dev = DX.libs.GetRenderedDevice(dev)
	Debug.trace("Device rendered: " + rn_Dev)
	Int rn_SlotMask = rn_Dev.GetSlotMask()
	Debug.trace("Device rendered: rSlotMask: " + rn_SlotMask)
	
	int thisSlot = 0x01
	;slotsIgnored += 0x80000000 ;61
	;slotsIgnored += 0x40000000 ;60
	;slotsIgnored += 0x01000000 ;54
	;slotsIgnored += 0x00400000 ;52
	;slotsIgnored += 0x00020000 ;47
	;slotsIgnored += 0x00002000 ;43
	;slotsIgnored += 0x00001000 ;42
	;slotsIgnored += 0x00000800 ;41
	;slotsIgnored += 0x00000400 ;40
	;slotsIgnored += 0x00000200 ;39
	;slotsIgnored += 0x00000100 ;38
	;slotsIgnored += 0x00000040 ;36
	;slotsIgnored += 0x00000020 ;35
	;slotsIgnored += 0x00000010 ;34
	;slotsIgnored += 0x00000001 ;31
	int slotsIgnored = 0xc1423f71
	Bool bBreak = false
	while !bBreak && (thisSlot < 0x80000000)
		if (Math.LogicalAnd(slotsIgnored, thisSlot) != thisSlot) ;only check devious slots
			Armor thisArmor = akActor.GetWornForm(thisSlot) as Armor
			if (thisArmor)
				debug.trace("thisArmor: "+ thisArmor)
				debug.trace("thisArmor keywords: "+ (thisArmor as form).getkeywords())

				if thisArmor.hasKeywordString("zad_Lockable")
					if Math.LogicalAnd(rn_SlotMask, thisSlot) == thisSlot
						Debug.trace("Device conflict in slot: "+ thisSlot)
						int i = 0
						While i < 5 && (Math.LogicalAnd(rn_SlotMask, thisSlot) == thisSlot)
							dev = DX.GetRandomDevice(Dev_LVLI)
							Dev_kw = DX.libs.GetDeviceKeyword(dev)
							rn_Dev = DX.libs.GetRenderedDevice(dev)
							rn_SlotMask = rn_Dev.GetSlotMask()
							
							i += 1
						endWhile
						if (Math.LogicalAnd(rn_SlotMask, thisSlot) == thisSlot)
							Debug.trace("Could not find devious armor with selected keyword without conflict.")
							return false
						endif
						bBreak = true
					endif
				endif
				;    if (thisArmor.GetEnchantment()) ;check for basic enchantments
				;        wornEnchantedForms[index] = thisArmor.getName()
				;        index += 1
				;    elseif (WornObject.GetEnchantment(target, 0, thisSlot)) ;check for player-added enchantments
				;        wornEnchantedForms[index] = WornObject.GetDisplayName(target, 0, thisSlot)
				;        if (!wornEnchantedForms[index]) ;if it wasn't given a custom name, take the item's original name:
				;            wornEnchantedForms[index] = thisArmor.getName()
				;        endif
				;        index += 1
				;    endif
				;    slotsIgnored += thisArmor.GetSlotMask() ;add all slots this item covers to our slotsIgnored variable
			else ;no armor was found on this slot
				slotsIgnored += thisSlot
			endif
		endif
		thisSlot *= 2 ;double the number to move on to the next slot
	endWhile


	;Int itemIndex = 30
	;form equippedArmor
	;while itemIndex < 60
	;    equippedArmor = akActor.GetWornForm(Armor.GetMaskForSlot(itemIndex))
	;    if equippedArmor As Armor
	;      if EquipmentArray.find(equippedArmor) < 0
	;        iEmpty = EquipmentArray.Find(None)
	;        if iEmpty > -1
	;          EquipmentArray[iEmpty] = equippedArmor
	;        endif
	;      endif
	;    endif
	;    itemIndex += 1
	;  endwhile

	;if (Dev_kw == DX.libs.zad_DeviousCorset) || (Dev_kw == DX.libs.zad_DeviousHarness) || (Dev_kw == DX.libs.zad_DeviousBelt) ;Some corsets have belt
	;	Armor rn_Dev = DX.libs.GetRenderedDevice(dev)
	;	if rn_Dev
	;		Debug.trace("rendered Device: " + rn_Dev)
	;		Armor cur_Dev
	;		Keyword curDev_KW
	;		if (Dev_kw == DX.libs.zad_DeviousBelt)
	;			curDev_KW = DX.libs.zad_DeviousCorset
	;		else
	;			curDev_KW = DX.libs.zad_DeviousBelt
	;		endif
	;		cur_Dev = DX.libs.GetWornDeviceFuzzyMatch(akActor, curDev_KW)
	;		if (cur_Dev == None) && (Dev_kw == DX.libs.zad_DeviousBelt)
	;			curDev_KW = DX.libs.zad_DeviousHarness
	;			cur_Dev = DX.libs.GetWornDeviceFuzzyMatch(akActor, curDev_KW)
	;		endif
	;		Debug.trace("cur_Dev: " + cur_Dev)
	;		if cur_Dev
	;			Int rn_SlotMask = rn_Dev.GetSlotMask()
	;			Debug.trace("rn_SlotMask: " + rn_SlotMask)
	;			Int curDev_SlotMask = DX.libs.GetSlotMaskForDeviceType(curDev_KW)
	;			Debug.trace("curDev_SlotMask: " + curDev_SlotMask)
	;			if Math.LogicalAnd(rn_SlotMask, curDev_SlotMask) == curDev_SlotMask
	;				Debug.trace("Slot Conflict")
	;				if (Dev_kw == DX.libs.zad_DeviousBelt)
	;					Debug.trace("Cant's equip any belt.")
	;					return false
	;				endif
	;				int i = 4
	;;				while (i > 0) && (Math.LogicalAnd(rn_SlotMask, curDev_SlotMask) == curDev_SlotMask)
	;				dev = DX.GetRandomDevice(Dev_LVLI)
	;					Dev_kw = DX.libs.GetDeviceKeyword(dev)
	;				rn_Dev = DX.libs.GetRenderedDevice(dev)
	;				rn_SlotMask = rn_Dev.GetSlotMask()
	;				i -= 1
	;			endWhile
	;				if (Math.LogicalAnd(rn_SlotMask, curDev_SlotMask) == curDev_SlotMask)
	;					return False
	;				endif
	;			endif
	;		endif
	;
	;		endif
	;	endif
	;endif
	;Armor curDev = DX.libs.GetWornDeviceFuzzyMatch(akActor, Dev_kw)
	;if bForce || curDev
	;		DX.libs.LockDevice(akActor, dev, true)
	;	else
	if DX.libs.GetWornDeviceFuzzyMatch(akActor, Dev_kw) == None
		DX.libs.LockDevice(akActor, dev, false)
		utility.wait(0.2)
		return true
	endif
	return false
EndFunction

Bool Function _isBounded(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousHeavyBondage)
EndFunction

Bool Function _isGagged(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousGag)
EndFunction

Bool Function _isBelted(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousBelt)
EndFunction

Bool Function _isBlindfolded(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return akActor.WornHasKeyword(DX.libs.zad_DeviousBlindfold)
EndFunction