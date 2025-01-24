Scriptname zzzmrt_sp_int_ddx Hidden

import zzzmrt_sp_utility

Bool Function _LockRandomDeviceOnActor(Quest zdxQuest, Actor akActor, Int iLevel = 0, Int[] weightedChanceArray, LeveledItem corsets_regular, Form[] devArray = None) Global
	;iLevel 3 = Everything Allowed
	;iLevel 2 = No Heavy restraint, Blindfold, Hood and Suit
	;iLevel 1 = No Heavy restraint, Blindfold, Hood, Suit, closed belt, bra and gag other than ringed gaged
	;iLevel 0 = No Heavy restraints, Blindfold, Hood, Suit, belt, bra, gag, boot, glove, corset, harness, collar
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif

	Bool isFemale = (akActor.GetLeveledActorBase().GetSex() == 1)
	
	Form[] devs = new Form[20]
	devs[00] = DX.zad_dev_piercings_nipple
	devs[01] = DX.zad_dev_piercings_vaginal
	devs[02] = DX.zad_dev_plugs_anal
	devs[03] = DX.zad_dev_plugs_vaginal
	if devArray && devArray.length == 16
		devs[04] = devArray[00]
		devs[05] = devArray[01]
		devs[06] = devArray[02]
		devs[07] = devArray[03]
		devs[08] = devArray[04]
		devs[09] = devArray[05]
		devs[10] = devArray[06]
		devs[11] = devArray[07]
		devs[12] = devArray[08]
		devs[13] = devArray[09]
		devs[14] = devArray[10]
		devs[15] = devArray[11]
		devs[16] = devArray[12]
		devs[17] = devArray[13]
		devs[18] = devArray[14]
		devs[19] = devArray[15]
	else
		devs[04] = DX.zad_dev_armcuffs
		devs[05] = DX.zad_dev_legcuffs
		devs[06] = DX.zad_dev_collars
		devs[07] = DX.zad_dev_gloves
		devs[08] = DX.zad_dev_boots
		devs[09] = DX.zad_dev_corsets
		devs[10] = DX.zad_dev_harnesses
		devs[11] = DX.zad_dev_gags_ring
		devs[12] = DX.zad_dev_chastitybelts_open
		devs[13] = DX.zad_dev_chastitybelts_closed
		devs[14] = DX.zad_dev_chastitybras
		devs[15] = DX.zad_dev_gags
		devs[16] = DX.zad_dev_hoods
		devs[17] = DX.zad_dev_blindfolds
		devs[18] = DX.zad_dev_heavyrestraints
		devs[19] = DX.zad_dev_suits
		;devices[19] = DX.zad_dev_All
	endif

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
	
	if ((deviceChances[12] == 0) || (deviceChances[13] == 0)) && (devs[9] as LeveledItem) ; chastity corset not allowed
		devs[9] = corsets_regular
	endif

	int iEmpty = deviceChances.Find(1)

	if iEmpty < 0
		return _TightenRandomDevice(zdxQuest, akActor, devs)
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

	int iResult = weightedRandInt(deviceChances)
	if (iResult < 0) || iResult > (devs.Length - 1)
		return False
	endif

	Armor dev
	LeveledItem Dev_LVLI
	if devs[iResult] as Armor
		dev = devs[iResult] as Armor
	elseif devs[iResult] as LeveledItem
		Dev_LVLI = devs[iResult] as LeveledItem
		dev = DX.GetRandomDevice(Dev_LVLI)
	else
		return False
	endif
	
	keyWord Dev_kw = DX.libs.GetDeviceKeyword(dev)
	if akActor.WornHasKeyword(DX.libs.zad_Lockable)
		Armor rn_Dev = DX.libs.GetRenderedDevice(dev)
		if _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
			if Dev_LVLI as LeveledItem
				int i = 0
				while (i < 5) && _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
					dev = DX.GetRandomDevice(Dev_LVLI)
					Dev_kw = DX.libs.GetDeviceKeyword(dev)
					rn_Dev = DX.libs.GetRenderedDevice(dev)
					i += 1
				endwhile
			endif
			if _deviceHaveKeywordConflict(zdxQuest, akActor, rn_Dev)
				Debug.trace("Simple Prostitution: Could not find devious Device without keyword conflict. keyword = " + Dev_kw)
				return _TightenRandomDevice(zdxQuest, akActor, devs)
			endif
		endif
		Int rn_SlotMask = rn_Dev.GetSlotMask()
		int thisSlot = 0x01
		int slotsChecked = 0xc1423f72 ;sum of slots without any DD item
		while (thisSlot < 0x80000000)
			if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check devious slots
				Armor thisArmor = akActor.GetWornForm(thisSlot) as Armor
				if (thisArmor)
					if thisArmor.hasKeyword(DX.libs.zad_Lockable) && (Math.LogicalAnd(rn_SlotMask, thisSlot) == thisSlot)
						Debug.trace("Simple Prostitution: Device has conflict with equipped DD items in slot: "+ thisSlot)
						return _TightenRandomDevice(zdxQuest, akActor, devs)
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
		if dev.GetName()
			Debug.Notification("Simple Prostitution: " + dev.GetName() + " equipped.")
			Debug.Trace("Simple Prostitution: " + dev.GetName() + " equipped.")
		endif
		return true
	endif
	return false
EndFunction

Bool Function _IsPlugged(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return (akActor.WornHasKeyword(DX.libs.zad_DeviousPlug))
EndFunction

Bool Function _IsVaginallyPlugged(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return (akActor.WornHasKeyword(DX.libs.zad_DeviousPlugVaginal))
EndFunction

Bool Function _IsAnallyPlugged(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return False
	endif
	return (akActor.WornHasKeyword(DX.libs.zad_DeviousPlugAnal))
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

Bool Function _TightenRandomDevice(Quest zdxQuest, Actor akActor, Form[] akDevices) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX || !akDevices || (akDevices.Length == 0)
		return false
	endif
	int i = utility.randomint(0,akDevices.Length - 1)
	Armor rnd_Dev
	if akDevices[i] as armor
		rnd_Dev = akDevices[i] as armor
	elseif akDevices[i] as LeveledItem
		rnd_Dev = DX.GetRandomDevice(akDevices[i] as LeveledItem)
	else 
		return False
	endif
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

Function _MoanAndPlayHornyAnimation(Quest zdxQuest, Actor akActor) Global
	zadDeviceLists DX = zdxQuest as zadDeviceLists
	if !akActor || !DX
		return
	endif
  If DX.libs.IsAnimating(akActor)
		return
	EndIf	
	; don't play the animation in combat if it's the player
	actor player = Game.GetPlayer()
	if (akActor == player) && player.IsInCombat()
		return 
	Endif	
	DX.libs.SexlabMoan(akActor)	
	DX.libs.PlayHornyAnimation(akActor)	
EndFunction
