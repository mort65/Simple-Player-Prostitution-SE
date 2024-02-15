Scriptname zzzmrt_SimpleProstitutionMainQstScr extends Quest  

Actor Property player Auto
Faction Property whoreFaction Auto
GlobalVariable Property minBaseBonus Auto
GlobalVariable Property maxBaseBonus Auto
GlobalVariable Property successChance Auto
MiscObject Property gold Auto
Formlist Property currentAllowedLocations Auto
Spell Property customerSpell Auto
ReferenceAlias Property Owner Auto
Int Property baseSuccessChance = 15 Auto Hidden
ImageSpaceModifier Property blackScreen Auto
ImageSpaceModifier Property fadeOut Auto
ImageSpaceModifier Property fastFadeOut Auto
ImageSpaceModifier Property fadeIn Auto
Quest Property SexLabQuestFramework Auto
GlobalVariable Property OralPay Auto
GlobalVariable Property VaginalPay Auto
GlobalVariable Property AnalPay Auto
GlobalVariable Property SpeechBonusMult Auto
GlobalVariable Property TeleportToBed Auto

string SuppressTagsForNotRough = "Cowgirl,Aggressive,Rough,Forced,Bound,"
string SuppressTagsForMale = "Lesbian,FF,"

Int positionReward

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
		positionReward = 0
		If sexLabEnabled()
			If (TeleportToBed.GetValueInt() != 0) && Owner.getActorReference()
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
			haveSexLL(akCustomer)
		Else
			haveSexSFW()
		EndIf
		Int speechBonusRange = maxInt(0,(player.getActorValue("Speechcraft") * SpeechBonusMult.GetValue()) As Int)
		Int minBonus = minBaseBonus.GetValueInt() + (speechBonusRange / 2)
		Int maxBonus = maxBaseBonus.GetValueInt() + speechBonusRange
		Int totalPay = positionReward
		totalPay = totalPay + Utility.randomInt(minBonus, maxBonus)
		debug.trace("SimpleProstitution: Client="+akCustomer+", speech bonus range="+speechBonusRange+", Min Bonus="+minBonus+", Max Bonus="+maxBonus+", Position Reward="+positionReward+", Total="+totalPay)
		player.Additem(gold,maxInt(0,totalPay))
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

Function haveSexLL(Actor akActor)
	SexLabFramework SexLab =  SexLabQuestFramework As SexLabFramework
	sslBaseAnimation[] anims
	actor[] sexActors = new actor[2]
	int position = Utility.RandomInt(1, 3) 
	If Player.GetActorBase().GetSex() == 1
		sexActors[0] = Player
		sexActors[1] = akActor
		If position == 1
			positionReward = VaginalPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Vaginal,MF", SuppressTagsForNotRough, RequireAll=true)
		ElseIf position == 2
			positionReward = AnalPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Anal,MF", SuppressTagsForNotRough, RequireAll=true)
		Else
			positionReward = OralPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Lesbian,Oral", SuppressTagsForNotRough, RequireAll=true)
		EndIf
	Else
		sexActors[0] = akActor
		sexActors[1] = Player
		If position == 1
			positionReward = VaginalPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Vaginal", SuppressTagsForMale+SuppressTagsForNotRough, RequireAll=true)
		ElseIf position == 2
			positionReward = AnalPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Anal", SuppressTagsForMale+SuppressTagsForNotRough, RequireAll=true)
		Else
			positionReward = OralPay.GetValueInt()
			anims = SexLab.GetAnimationsByTags(2, "Blowjob", SuppressTagsForMale+SuppressTagsForNotRough, RequireAll=true)
		EndIf
	EndIf
	sexActors = SexLab.SortActors(sexActors, true)
	;RegisterForModEvent("AnimationEnd", "zzzDibSex_End")
	SexLab.StartSex(sexActors, anims, none, none, true, "")
EndFunction

Function haveSexSFW()
		Game.DisablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = False, abLooking = False, abSneaking = True, abMenu = True, abActivate = True, abJournalTabs = False, aiDisablePOVType = 0)	
		FastFadeOut.Apply()
		Utility.Wait(1.0)
		FastFadeOut.PopTo(BlackScreen)
		Utility.Wait(5.0)
		BlackScreen.PopTo(FadeIn)
		Game.EnablePlayerControls()
EndFunction

Bool Function sexLabEnabled()
	Return ((SexLabQuestFramework As SexLabFramework).Enabled == True)
EndFunction

;Event zzzDibSex_End(string eventName, string argString, float argNum, form sender)
;	UnregisterForModEvent("AnimationEnd")
;EndEvent
