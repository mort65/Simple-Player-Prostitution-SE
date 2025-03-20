Scriptname zzzmrt_sp_reward_handler_script extends Quest

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
Actor property player auto

import zzzmrt_sp_utility

Function RegisterForEvents()
	RegisterForModEvent("SPP_addRewardToPlayer", "on_spp_add_reward_to_Player")
EndFunction

event on_spp_add_reward_to_Player(Form akSender, Float afRewardChance = 100.0, Float afRewardEnchantedChance = 100.0 , Int aiCount = 1)
	if !akSender
		return
	endif
	logText("on_spp_add_reward_to_Player() triggered by " + akSender)
	addExtraRewardsToPlayer(afRewardChance, afRewardEnchantedChance, aiCount)
endevent

Function addExtraRewardsToPlayer(Float fRewardChance = 100.0, Float fRewardEnchantedChance = 100.0, int iCount = 1)
	int iIndex = 0
	While iIndex < iCount
		addEnchantedRewardToPlayer(fRewardChance, fRewardEnchantedChance)
		iIndex += 1
	endWhile
EndFunction

Function addEnchantedRewardToPlayer(Float fRewardChance = 100.0, Float fRewardEnchantedChance = 100.0)
	if !MainScript
		MainScript = MainQuest as zzzmrt_sp_main_qst_script
	endif
	if mainscript.randInt(0, 999) >= (fRewardChance * 10) as Int
		return
	endif
	Form Item = GetRandomItemFromLeveledList(MainScript.LItemTempleReward, MainScript.bIsPO3ExtenderActive)
	String sName = item.GetName()
	if !isFormValid(Item)
	    mainscript.log("No valid reward found.")
		return
	endif
	mainscript.log("The extra reward is " + Item + " | Available LeveledLists/Items = " + MainScript.LItemTempleReward.GetNumForms())
	if (mainscript.randInt(0, 999) >= (fRewardEnchantedChance * 10) as Int) || (!(Item As Armor) && !(Item As Weapon)) || ((Item As Armor) && (Item As Armor).GetEnchantment()) || ((Item As Weapon) && (Item As Weapon).GetEnchantment())
		mainscript.log("Reward won't be enchanted.")
		player.additem(item, 1, true)
		mainscript.log(sName + " added.", true, true, 0)
		return
	endif
	Formlist enchList
	if Item As Armor
		if (Item.HasKeywordstring("ArmorClothing") || Item.HasKeywordstring("ArmorJewelry"))
			enchList = MainScript.Ench_Clothing_Lists
		else
			enchList = MainScript.Ench_Armor_Lists
		endif
	elseif Item as Weapon
		enchList = MainScript.Ench_Weapon_Lists
	endif
	if !enchList
	    mainscript.log("No valid enchantment found for the reward.")
		player.additem(item, 1, true)
		mainscript.log(sName + " added.", true, true, 0)
		return
	endif
	int iTotal = 0
	int iIndex = 0
	int iSize = enchList.getSize()
	While iIndex < iSize
		if enchList.getAt(iIndex) As FormList
			iTotal = iTotal + (enchList.getAt(iIndex) As FormList).GetSize()
		else
			iTotal += 1
		endif
		iIndex += 1
	endWhile
	if iTotal < 1
	    mainscript.log("No valid enchantment found for the reward.")
		player.additem(item, 1, true)
		mainscript.log(sName + " added.", true, true, 0)
		return
	endif
	Int enchIndex = mainscript.randInt(0, iTotal - 1)
	iIndex = 0
	Int iSubListSize = 0
	Enchantment ench
	While !ench && (iIndex < iSize) && (enchIndex > -1)
		if enchList.getAt(iIndex) As FormList
			iSubListSize = (enchList.getAt(iIndex) As FormList).GetSize()
			if iSubListSize < 1
			elseif (enchIndex - iSubListSize) > -1
				enchIndex = enchIndex - iSubListSize
			else
				ench = (enchList.getAt(iIndex) As FormList).getAt(enchIndex) as Enchantment
			endif
		else
			if (enchIndex == 0)
				ench =  enchList.getAt(iIndex) As Enchantment
			else
				enchIndex -= 1
			endif
		endif
		iIndex += 1
	endWhile
	if isFormValid(ench) && (ench.GetFormID() <= 4278190080) ;An enchantment with a formID greater than 0xFF000000 will cause the game to crash according to https://ck.uesp.net/wiki/GetEnchantment_-_Armor
	    mainscript.log("Reward's enchantment is " + ench + " | Available enchantments For the Item = " + iTotal)
		ObjectReference itemRef = player.placeAtMe(Item, 1)
		itemRef.SetEnchantment(ench, 100.0)
		player.additem(itemRef, 1, true)
		mainscript.log(itemRef.GetDisplayName() + " added.", true, true, 0)
	else
	    mainscript.log("No valid enchantment found for the reward.")
		player.additem(item, 1, true)
		mainscript.log(sName + " added.", true, true, 0)
	endif
EndFunction