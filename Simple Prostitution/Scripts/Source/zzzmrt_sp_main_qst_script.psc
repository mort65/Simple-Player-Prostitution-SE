Scriptname zzzmrt_sp_main_qst_script extends Quest Conditional

GlobalVariable property BeggarFailureChance auto
GlobalVariable property DibelFailureChance auto
zzzmrt_sp_flowergirls_interface property FlowerGirlsInterface auto
zzzmrt_sp_sexlab_interface property SexLabInterface auto
zzzmrt_sp_mcm_qst_script property MCMScript auto
ReferenceAlias property Owner auto
GlobalVariable property WhoreFailureChance auto
Bool property bBeggingClothing=True auto Hidden Conditional
Bool property bBeggingEnabled=True auto Hidden Conditional
Bool property bPoorHelpBeggar=True auto Hidden Conditional
Bool property bGuardHelpBeggar=False auto Hidden Conditional
Bool property bDibelAgent=True auto Hidden Conditional
Bool property bDibelCrown=True auto Hidden Conditional
Bool property bDibelEnabled=True auto Hidden Conditional
Bool property bDibelNaked=True auto Hidden Conditional
Bool property bDibelNeedLicense=False auto Hidden Conditional
Bool property bIsFlowerGirlsActive=False auto Hidden Conditional
Bool property bIsSexlabActive=False auto Hidden Conditional
Bool property bModEnabled=True auto Hidden Conditional
Bool property bTeleportToBed=False auto Hidden Conditional
Bool property bWhoreClothing=False auto Hidden Conditional
Bool property bWhoreEnabled=True auto Hidden Conditional
Bool property bWhoreNeedLicense=True auto Hidden Conditional
Bool Property bIsPapyrusUtilActive=False Auto Hidden
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Spell property customerBeggarSpell auto
Spell property customerSpell auto
Float property fBegPayMax=5.0 auto Hidden Conditional
Float property fBegPayMin=1.0 auto Hidden Conditional
Float property fDibelAnalPay=15.0 auto Hidden Conditional
Float property fDibelOralPay=10.0 auto Hidden Conditional
Float property fDibelVagPay=20.0 auto Hidden Conditional
Float property fDibelAnalChance=50.0 auto Hidden Conditional
Float property fDibelOralChance=50.0 auto Hidden Conditional
Float property fDibelVagChance=50.0 auto Hidden Conditional
Float property fMaxSpeechBegBonusMult=0.8 auto Hidden Conditional
Float property fMaxSpeechDibelBonusMult=1.5 auto Hidden Conditional
Float property fMaxSpeechWhoreBonusMult=1.2 auto Hidden Conditional
Float property fMinSpeechBegBonusMult=0.0 auto Hidden Conditional
Float property fMinSpeechDibelBonusMult=0.0 auto Hidden Conditional
Float property fMinSpeechWhoreBonusMult=0.0 auto Hidden Conditional
Float property fSpeechDifficultyArr auto Hidden
Float property fWhoreAnalPay=10.0 auto Hidden Conditional
Float property fWhoreOralPay=5.0 auto Hidden Conditional
Float property fWhoreVagPay=15.0 auto Hidden Conditional
Float property fWhoreAnalChance=50.0 auto Hidden Conditional
Float property fWhoreOralChance=50.0 auto Hidden Conditional
Float property fWhoreVagChance=50.0 auto Hidden Conditional

ImageSpaceModifier property fadeIn auto
ImageSpaceModifier property fadeOut auto
ImageSpaceModifier property fastFadeOut auto
MiscObject property gold auto
Actor property player auto
Faction property whoreFaction auto

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
    Int position = haveSex(akCustomer, sGetCurAnimInteface(), fWhoreVagChance As Int, fWhoreAnalChance As Int, fWhoreOralChance As Int)
    if position > -1
      payWhore(player, position)
    endif
  endif
endfunction

Float function getBaseVersion()
  return 1.0
endfunction

Float function getCurrentVersion()
  return getBaseVersion() + 0.07
endfunction

int function haveSex(Actor akActor, String interface, int vaginalWeight = 50, int analWeight=50, int oralWeight = 50)
  if !akActor
    return -1
  endif
  int position = -1
  if bTeleportToBed && Owner.getActorReference()
    ObjectReference bed = (Owner.getActorReference() as RentRoomScript).Bed as ObjectReference
    if bed.getParentCell() == Player.getParentCell()
      fastFadeOut.Apply()
      Utility.Wait(1.0)
      fadeOut.PopTo(blackScreen)
      Player.setPosition(bed.getPositionX(), bed.getPositiony(), bed.getPositionz() + 50.0)
      player.setAngle(0.0, 0.0, 0.0)
      player.setAngle(0.0, 0.0, bed.getAngleZ())
      akActor.setPosition(bed.getPositionX(), bed.getPositiony(), bed.getPositionz() + 50.0)
      akActor.setAngle(0.0, 0.0, 0.0)
      akActor.setAngle(0.0, 0.0, bed.getAngleZ())
      Utility.wait(1.0)
      blackScreen.PopTo(fadeIn)
      Utility.wait(5.0)
    endif
  endif
  if interface == "sexlab"
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      position = positionChooser(0, analWeight, oralWeight)
    else
      position = positionChooser(vaginalWeight, analWeight, oralWeight)
    endif
    position = SexLabInterface.haveSexWithPlayer(akActor, position)
  elseif interface == "flowergirls"
    position = FlowerGirlsInterface.haveSexWithPlayer(akActor,positionChooser(vaginalWeight, analWeight, oralWeight))
  else
    position = positionChooser(vaginalWeight, analWeight, oralWeight)
    haveSexSFW()
  endif
  return position
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

function payBeggar(Actor beggar)
  Int minBonus = maxInt(0, ((beggar.getActorValue("Speechcraft") * fMinSpeechBegBonusMult) As Int) + 1)
  Int maxBonus = maxInt(0, ((beggar.getActorValue("Speechcraft") * fMaxSpeechBegBonusMult) As Int) + 1)
  minBonus = minInt(minBonus,maxBonus)
  maxBonus = maxInt(minBonus,maxBonus)
  int begPayMin = minInt(fBegPayMin As Int, fBegPayMax As Int)
  int begPayMax = maxInt(fBegPayMin As Int, fBegPayMax As Int)
  Int totalPay = maxInt(0, Utility.randomInt(begPayMin, BegPayMax) + Utility.randomInt(minBonus, maxBonus))
  beggar.Additem(gold, maxInt(0, totalPay))
endfunction

function payDibel(Actor Dibel, int position)
  Int minBonus = maxInt(0, ((Dibel.getActorValue("Speechcraft") * fMinSpeechDibelBonusMult) As Int) + 1)
  Int maxBonus = maxInt(0, ((Dibel.getActorValue("Speechcraft") * fMaxSpeechDibelBonusMult) As Int) + 1)
  minBonus = minInt(minBonus,maxBonus)
  maxBonus = maxInt(minBonus,maxBonus)
  int positionReward = 0
  if position == 0
    positionReward = fDibelVagPay As Int
  elseif position == 1
    positionReward = fDibelAnalPay As Int
  elseif position == 2
    positionReward = fDibelOralPay As Int
  endif
  Int totalPay = positionReward + Utility.randomInt(minBonus, maxBonus)
  Dibel.Additem(gold, maxInt(0, totalPay))
endfunction

function payWhore(actor whore, int position)
  Int minBonus = maxInt(0, ((whore.getActorValue("Speechcraft") * fMinSpeechWhoreBonusMult) As Int) + 1)
  Int maxBonus = maxInt(0, ((whore.getActorValue("Speechcraft") * fMaxSpeechWhoreBonusMult) As Int) + 1)
  minBonus = minInt(minBonus,maxBonus)
  maxBonus = maxInt(minBonus,maxBonus)
  int positionReward = 0
  if position == 0
    positionReward = fWhoreVagPay As Int
  elseif position == 1
    positionReward = fWhoreAnalPay As Int
  elseif position == 2
    positionReward = fWhoreOralPay As Int
  endif
  Int totalPay = positionReward + Utility.randomInt(minBonus, maxBonus)
  whore.Additem(gold, maxInt(0, totalPay))
endfunction

function playerBegTo(Actor akActor, Bool bPay=True)
  if akActor
    customerBeggarSpell.Cast(akActor, akActor)
  endif
  if bPay
    payBeggar(player)
  endif
  setChance()
endfunction

function playerPracticeDibelArtWith(Actor akActor, bool bAccept=true)
  setChance()
  if akActor
    customerSpell.Cast(akActor, akActor)
    if !bAccept
      return
    endif
    Int position = haveSex(akActor, sGetCurAnimInteface(), fDibelVagChance As Int, fDibelAnalChance As Int, fDibelOralChance As Int)
    if position > -1
      payDibel(player, position)
    endif
  endif
endfunction

String function sGetCurAnimInteface()
  Int interf = MCMScript.iGetCurAnimInterface()
  if interf == 0
    return "sexlab"
  elseif interf == 1
    return "flowergirls"
  endif
  return ""
endfunction

function setChance()
  WhoreFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iWhoreSpeechDifficulty))
  DibelFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iDibelSpeechDifficulty))
  BeggarFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iBeggarSpeechDifficulty))
endfunction


Bool Function bIsLicensesActive()
  return Game.IsPluginInstalled("Licenses.esp")
endfunction

Int function positionChooser(int vaginalWeight = 50, int AnalWeight = 50, int oralWeight = 50)
  if (vaginalWeight < 1) && (AnalWeight < 1) && (oralWeight < 1)
    return -1
  endif
  int[] cumulWeight = Utility.createIntArray(4)
  Bool[] positionFlag = Utility.createBoolArray(3)
  positionFlag[0] = (vaginalWeight > 0)
  positionFlag[1] = (AnalWeight > 0)
  positionFlag[2] = (oralWeight > 0)
  cumulWeight[0] = 0
  cumulWeight[1] = vaginalWeight
  cumulWeight[2] = AnalWeight + vaginalWeight
  cumulWeight[3] = oralWeight + AnalWeight + vaginalWeight
  int x = utility.randomInt(0,cumulWeight[3])
  int i = 0
  while i < cumulWeight.Length
    i = i + 1
    if positionFlag[i - 1] && (x <= cumulWeight[i])
      return (i - 1)
    endIf
  endWhile
  return -1
endfunction

Bool Function bCheckPapyrusUtil()
  return papyrusutil.GetVersion() > 31
EndFunction
