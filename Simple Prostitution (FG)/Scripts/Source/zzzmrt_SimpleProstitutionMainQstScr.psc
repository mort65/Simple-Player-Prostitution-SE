Scriptname zzzmrt_SimpleProstitutionMainQstScr extends Quest

GlobalVariable property AnalPay auto
GlobalVariable property BegPayMax auto
GlobalVariable property BegPayMin auto
GlobalVariable property BeggingAllowed auto
GlobalVariable property BeggingSpeechBonusMult auto
GlobalVariable property OralPay auto
ReferenceAlias property Owner auto
GlobalVariable property SpeechBonusMult auto
GlobalVariable property TeleportToBed auto
GlobalVariable property VaginalPay auto
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Spell property customerBeggerSpell auto
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

string SuppressTagsForMale = "Lesbian,FF,"
string SuppressTagsForNotRough = "Cowgirl,Aggressive,Rough,Forced,Bound,"
Int positionReward

function AllowProstitution(Actor akOwner)
  if akOwner && akOwner.GetCurrentLocation()
    currentAllowedLocations.Revert()
    currentAllowedLocations.AddForm(akOwner.GetCurrentLocation() As Form)
    if !player.IsInFaction(whoreFaction)
      player.AddToFaction(whoreFaction)
    endif
    Owner.ForceRefTo(akOwner)
    setChance()
    SetStage(10)
    Debug.Trace("SimpleProstitution: Work allowed in " + currentAllowedLocations.GetAt(0) + " that's owned by " + akOwner)
  endif
endfunction

function ProstitutePlayerTo(Actor akCustomer, bool bAccept=true)
  setChance()
  if akCustomer
    customerSpell.Cast(akCustomer, akCustomer)
    if !bAccept
      return
    endif
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
    Int speechBonusRange = maxInt(0, (player.getActorValue("Speechcraft") * SpeechBonusMult.GetValue()) As Int + 1)
    Int minBonus = minBaseBonus.GetValueInt() + (speechBonusRange / 2) As Int
    Int maxBonus = maxBaseBonus.GetValueInt() + speechBonusRange
    Int totalPay = positionReward + Utility.randomInt(minBonus, maxBonus)
    debug.trace("SimpleProstitution: Client=" + akCustomer + ", speech bonus range=" + speechBonusRange + ", Min Bonus=" + minBonus + ", Max Bonus=" + maxBonus + ", Position Reward=" + positionReward + ", Total=" + totalPay)
    player.Additem(gold, maxInt(0, totalPay))
  endif
endfunction

function haveSexFG(Actor akActor)
  Actor Actor1
  Actor Actor2
  if akActor.GetLeveledActorBase().GetSex() == 1
    Actor1 = player
    Actor2 = akActor
  else
    Actor1 = akActor
    Actor2 = player
  endif
  int position = Utility.randomInt(1, 3)
  if position == 1
    int i = utility.randomInt(1, 4)
    if i == 1
      (flowerGirls as dxFlowerGirlsScript).CowgirlScene(Actor1, Actor2)
    elseif i == 2
      (flowerGirls as dxFlowerGirlsScript).MissionaryScene(Actor1, Actor2)
    elseif i == 3
      (flowerGirls as dxFlowerGirlsScript).DoggyScene(Actor1, Actor2)
    elseif i == 4
      (flowerGirls as dxFlowerGirlsScript).StandingScene(Actor1, Actor2)
    endif
    positionReward = VaginalPay.GetValueInt()
  elseif position == 2
    (flowerGirls as dxFlowerGirlsScript).AnalScene(Actor1, Actor2)
    positionReward = AnalPay.GetValueInt()
  elseif position == 3
    (flowerGirls as dxFlowerGirlsScript).OralScene(Actor1, Actor2)
    positionReward = OralPay.GetValueInt()
  endif
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

function playerBegTo(Actor akActor, Bool bPay=True)
  if akActor
    customerBeggerSpell.Cast(akActor, akActor)
  endif
  if bPay
    player.Additem(gold, maxInt(0, Utility.RandomInt(BegPayMin.GetValueInt(), BegPayMax.GetValueInt() + maxInt(0, (player.getActorValue("Speechcraft") * BeggingSpeechBonusMult.GetValue()) As Int))))
  endif
  setChance()
endfunction

function setChance() ;1-sqrt(1-n)=m => p(m) or p(m) = p(n)
  successChance.SetValueInt(minInt(maxInt(1, (player.getActorValue("Speechcraft") * SpeechBonusMult.GetValue() As Float) As Int), 99))
endfunction

;Float Function getBaseVersion()
;  Return 1.0
;EndFunction
;Float Function getCurrentVersion()
; Return getBaseVersion() + 0.05
;EndFunction
