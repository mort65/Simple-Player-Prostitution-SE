Scriptname zzzmrt_SimpleProstitutionMainQstScr extends Quest  

Actor Property player Auto
Quest Property flowerGirls Auto
Faction Property whoreFaction Auto
GlobalVariable Property minReward Auto
GlobalVariable Property maxReward Auto
GlobalVariable Property successChance Auto
MiscObject Property gold Auto
Formlist Property currentAllowedLocations Auto
Spell Property customerSpell Auto
ReferenceAlias Property Owner Auto
Int Property baseSuccessChance = 25 Auto Hidden
ImageSpaceModifier Property blackScreen Auto
ImageSpaceModifier Property fadeOut Auto
ImageSpaceModifier Property fastFadeOut Auto
ImageSpaceModifier Property fadeIn Auto


Function AllowProstitution(Actor akOwner)
	If akOwner && akOwner.GetCurrentLocation() 
		currentAllowedLocations.Revert()
		currentAllowedLocations.AddForm(akOwner.GetCurrentLocation() As Form)
		If !player.IsInFaction(whoreFaction)
			player.AddToFaction(whoreFaction)
		EndIf
		Owner.ForceRefTo(akOwner)
		Int baseChance = minInt(maxInt(baseSuccessChance,player.getActorValue("Speechcraft") As Int), 100)
		Int chance = minInt(Math.Ceiling(Math.sqrt(baseChance / 100.0) * 100), 100) ;p(chance) ∩ p(chance) = p(baseChance) 
		successChance.SetValueInt(chance)
		SetStage(10)
		Debug.Trace("SimpleProstitution: Work allowed in "+currentAllowedLocations.GetAt(0)+" that's owned by "+akOwner)
	EndIf
EndFunction

Function ProstitutePlayerTo(Actor akCustomer)
	If akCustomer
		;ReferenceAlias aliasSpeaker = flowerGirls.getAlias(4) as ReferenceAlias
		;aliasSpeaker.ForceRefTo(akCustomer)
		;flowerGirls.SetStage(40)
		If Owner.getActorReference()
			ObjectReference bed = (Owner.getActorReference() as RentRoomScript).Bed as ObjectReference
			If bed.getParentCell() == Player.getParentCell()
				fastFadeOut.Apply()
				Utility.Wait(1.0)
				fadeOut.PopTo(blackScreen)
				Player.setPosition(bed.getPositionX(), bed.getPositiony(), bed.getPositionz() + 50.0)
				player.setAngle(0.0, 0.0, 0.0)
				player.setAngle(0.0, 0.0, bed.getAngleZ())
				akCustomer.setPosition(bed.getPositionX() , bed.getPositiony(), bed.getPositionz() + 50.0)
				akCustomer.setAngle(0.0, 0.0, 0.0)
				akCustomer.setAngle(0.0, 0.0, bed.getAngleZ())
				Utility.wait(1.0)
				blackScreen.PopTo(fadeIn)
			EndIf
		EndIf
		If akCustomer.GetActorBase().GetSex() == 1
			(flowerGirls as dxFlowerGirlsScript).RandomScene(player, akCustomer)
		Else
			(flowerGirls as dxFlowerGirlsScript).RandomScene(akCustomer, player)
		EndIf
		flowerGirls.SetStage(10)
		Int bonus = maxInt(0,player.getActorValue("Speechcraft") as int)
		int minPay = minReward.GetValueInt() + (bonus / 2)
		Int maxPay = maxReward.GetValueInt() + bonus
		Int payment = Utility.randomInt(minPay, maxPay)
		debug.trace("SimpleProstitution: Client="+akCustomer+", Bonus="+bonus+", Min Pay="+minPay+", Max Pay="+maxPay+", Payment="+payment)
		player.Additem(gold,payment)
	EndIf
EndFunction

Int Function maxInt(Int var1,Int var2)
	If var1 > var2
		Return var1
	EndIf
	Return var2
EndFunction

Int Function minInt(Int var1,Int var2)
	If var1 < var2
		Return var1
	EndIf
	Return var2
EndFunction
