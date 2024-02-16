Scriptname zzzmrt_SimpleProstitutionMainQstScr extends Quest

GlobalVariable property AnalPay auto
GlobalVariable property OralPay auto
ReferenceAlias property Owner auto
GlobalVariable property SpeechBonusMult auto
GlobalVariable property TeleportToBed auto
GlobalVariable property VaginalPay auto
Int property baseSuccessChance=15 auto Hidden
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Spell property customerSpell auto
ImageSpaceModifier property fadeIn auto
ImageSpaceModifier property fadeOut auto
ImageSpaceModifier property fastFadeOut auto
Quest property flowerGirls auto
MiscObject property gold auto
GlobalVariable property maxBaseBonus auto
GlobalVariable property minBaseBonus auto
Actor property player auto
GlobalVariable property successChance auto
Faction property whoreFaction auto

Int positionReward

function AllowProstitution(Actor akOwner)
  if akOwner && akOwner.GetCurrentLocation()
    currentAllowedLocations.Revert()
    currentAllowedLocations.AddForm(akOwner.GetCurrentLocation() As Form)
    if !player.IsInFaction(whoreFaction)
      player.AddToFaction(whoreFaction)
    endif
    Owner.ForceRefTo(akOwner)
    Int baseChance = minInt(maxInt(baseSuccessChance, player.getActorValue("Speechcraft") As Int), 100)
    Int chance = minInt(Math.Ceiling(Math.sqrt(baseChance / 100.0) * 100), 100) ;p(chance) ∩ p(chance) = p(baseChance)
    successChance.SetValueInt(chance)
    SetStage(10)
    Debug.Trace("SimpleProstitution: Work allowed in " + currentAllowedLocations.GetAt(0) + " that's owned by " + akOwner)
  endif
endfunction

function ProstitutePlayerTo(Actor akCustomer)
  if akCustomer
    positionReward = 0
    if (TeleportToBed.GetValueInt() != 0) && Owner.getActorReference()
      ObjectReference bed = (Owner.getActorReference() as RentRoomScript).Bed as ObjectReference
      if bed.getParentCell() == Player.getParentCell()
        fastFadeOut.Apply()
        Utility.Wait(1.0)
        fadeOut.PopTo(blackScreen)
        Player.setPosition(bed.getPositionX(), bed.getPositiony(), bed.getPositionz() + 50.0)
        player.setAngle(0.0, 0.0, 0.0)
        player.setAngle(0.0, 0.0, bed.getAngleZ())
        akCustomer.setPosition(bed.getPositionX(), bed.getPositiony(), bed.getPositionz() + 50.0)
        akCustomer.setAngle(0.0, 0.0, 0.0)
        akCustomer.setAngle(0.0, 0.0, bed.getAngleZ())
        Utility.wait(1.0)
        blackScreen.PopTo(fadeIn)
      endif
    endif
    haveSexFG(akCustomer)
    Int speechBonusRange = maxInt(0, (player.getActorValue("Speechcraft") * SpeechBonusMult.GetValue()) As Int)
    Int minBonus = minBaseBonus.GetValueInt() + (speechBonusRange / 2)
    Int maxBonus = maxBaseBonus.GetValueInt() + speechBonusRange
    Int totalPay = positionReward
    totalPay = totalPay + Utility.randomInt(minBonus, maxBonus)
    debug.trace("SimpleProstitution: Client=" + akCustomer + ", speech bonus range=" + speechBonusRange + ", Min Bonus=" + minBonus + ", Max Bonus=" + maxBonus + ", Position Reward=" + positionReward + ", Total=" + totalPay)
    player.Additem(gold, maxInt(0, totalPay))
  endif
endfunction

function haveSexFG(Actor akActor)
  if akActor.GetActorBase().GetSex() == 1
    (flowerGirls as dxFlowerGirlsScript).RandomScene(player, akActor)
  else
    (flowerGirls as dxFlowerGirlsScript).RandomScene(akActor, player)
  endif
  flowerGirls.SetStage(10)
endfunction

function haveSexSFW()
  Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
  FastFadeOut.Apply()
  Utility.Wait(1.0)
  FastFadeOut.PopTo(BlackScreen)
  Utility.Wait(5.0)
  BlackScreen.PopTo(FadeIn)
  Game.EnablePlayerControls()
endfunction

Int function maxInt(Int var1, Int var2)
  if var1 > var2
    return var1
  endif
  return var2
endfunction

Int function minInt(Int var1, Int var2)
  if var1 < var2
    return var1
  endif
  return var2
endfunction

;Event zzzDibSex_End(string eventName, string argString, float argNum, form sender)
;	UnregisterForModEvent("AnimationEnd")
;EndEvent
