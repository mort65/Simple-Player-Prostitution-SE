Scriptname zzzmrt_sp_main_qst_script extends Quest Conditional

GlobalVariable property BeggarFailureChance auto
GlobalVariable property DibelFailureChance auto
zzzmrt_sp_flowergirls_interface property FlowerGirlsInterface auto
zzzmrt_sp_sexlab_interface property SexLabInterface auto
zzzmrt_sp_ostim_interface property OStimInterface auto
Quest Property OStimInterfaceQst Auto
Quest Property FlowerGirlsInterfaceQst Auto
Quest Property SexLabInterfaceQst Auto
zzzmrt_sp_mcm_qst_script property MCMScript auto
ReferenceAlias property Owner auto
GlobalVariable property WhoreFailureChance auto
Message property InterfaceMenu auto
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
Bool property bIsOStimActive=False auto Hidden Conditional
Bool property bModEnabled=True auto Hidden Conditional
Bool property bTeleportToBed=False auto Hidden Conditional
Bool property bWhoreClothing=False auto Hidden Conditional
Bool property bWhoreEnabled=True auto Hidden Conditional
Bool property bWhoreNeedLicense=True auto Hidden Conditional
Bool Property bIsPapyrusUtilActive=False Auto Hidden Conditional
Bool Property bDibelAllowAggressive=True Auto Hidden Conditional
Bool Property bWhoreAllowAggressive=True Auto Hidden Conditional
Bool Property bTryAllInterfaces=True Auto Hidden Conditional
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
Float Property fWhoreOwnerShare = 0.0 auto Hidden Conditional
Int Property iCurrentOwnerSeptims = 0 Auto Hidden Conditional
GlobalVariable property currentOwnerSeptimDisplay auto Conditional

ImageSpaceModifier property fadeIn auto
ImageSpaceModifier property fadeOut auto
ImageSpaceModifier property fastFadeOut auto
MiscObject property gold auto
Actor property player auto
Faction property whoreFaction auto

function shutDown()
  currentAllowedLocations.Revert()
  player.removeFromFaction(whoreFaction)
EndFunction

function AllowProstitution(Actor akOwner)
  if akOwner && akOwner.GetCurrentLocation()
    currentAllowedLocations.Revert()
    currentAllowedLocations.AddForm(akOwner.GetCurrentLocation() As Form)
    if !player.IsInFaction(whoreFaction)
      player.AddToFaction(whoreFaction)
    endif
    if Owner.getActorReference() && (Owner.getActorReference().GetCurrentLocation() != akOwner.GetCurrentLocation())
      iCurrentOwnerSeptims = 0
      currentOwnerSeptimDisplay.SetValueInt(0)
      UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    endIf
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
    Int position = haveSex(akCustomer, sGetCurAnimInteface(), fWhoreVagChance As Int, fWhoreAnalChance As Int, fWhoreOralChance As Int, bWhoreAllowAggressive, bAllPosAllowed(fWhoreVagChance, fWhoreAnalChance, fWhoreOralChance))
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

int function haveSex(Actor akActor, String interface, int vaginalWeight = 50, int analWeight=50, int oralWeight = 50, Bool bAllowAggressive = False, Bool bAllowAll = False)
  if !akActor
    return -1
  endif
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
  int result = -1
  if interface == "sexlab"
    result = playerSexSL(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
  elseif interface == "ostim"
    result = playerSexOS(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
  elseif interface == "flowergirls"
    result = playerSexFG(akActor, vaginalWeight, analWeight, oralWeight)
  else
    result = haveSexSFW(vaginalWeight, analWeight, oralWeight)
  endif
  if (result < 0)
    if bTryAllInterfaces && iGetCurTotalAnimInterfaces() > 1
      Debug.trace("SimpleProstitution: retrying with other interfaces.")
      if interface == "sexlab"
        result = playerSexOS(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexFG(akActor, vaginalWeight, analWeight, oralWeight)
        endif
      elseIf interface == "ostim"
        result = playerSexSL(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexFG(akActor, vaginalWeight, analWeight, oralWeight)
        endif
      elseif interface == "flowergirls"
        result = playerSexOS(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexSL(akActor, vaginalWeight, analWeight, oralWeight, bAllowAggressive, bAllowAll)
        endif
      endif
    endif
    if result < 0
      Debug.trace("SimpleProstitution: couldn't find any suitable animation.")
      result = haveSexSFW(vaginalWeight, analWeight, oralWeight)
    endIf
  endif
  return result
endfunction

int Function playerSexSL(Actor akActor, int vaginalWeight = 50, int analWeight=50, int oralWeight = 50, Bool bAllowAggressive= False, Bool bAllowAll = False)
  if !bIsSexlabActive
    return -1
  endif
  int position
  if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
    position = positionChooser(0, analWeight, oralWeight)
  else
    position = positionChooser(vaginalWeight, analWeight, oralWeight)
  endif
  return SexLabInterface.haveSexWithPlayer(akActor, position, bAllowAggressive, bAllowAll)
EndFunction

int Function playerSexOS(Actor akActor, int vaginalWeight = 50, int analWeight=50, int oralWeight = 50, Bool bAllowAggressive= False, Bool bAllowAll = False)
  if !bIsOstimActive
    return -1
  endif
  int position
  if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
    position = positionChooser(0, analWeight, oralWeight)
  else
    position = positionChooser(vaginalWeight, analWeight, oralWeight)
  endif
  return OStimInterface.haveSexWithPlayer(akActor, position, bAllowAggressive, bAllowAll)
EndFunction

int Function playerSexFG(Actor akActor, int vaginalWeight = 50, int analWeight=50, int oralWeight = 50)
  if !bIsFlowerGirlsActive
    return -1
  endif
  int position = positionChooser(vaginalWeight, analWeight, oralWeight)
  return FlowerGirlsInterface.haveSexWithPlayer(akActor, position)
EndFunction

int function haveSexSFW(int vaginalWeight = 50, int analWeight=50, int oralWeight = 50)
  int position = positionChooser(vaginalWeight, analWeight, oralWeight)
  if position < 0
    return -1
  endif
  Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
  FastFadeOut.Apply()
  Utility.Wait(1.0)
  FastFadeOut.PopTo(BlackScreen)
  Utility.Wait(5.0)
  BlackScreen.PopTo(FadeIn)
  Game.EnablePlayerControls()
  return position
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
  Int totalPay = maxInt(0, positionReward + Utility.randomInt(minBonus, maxBonus))
  if (fWhoreOwnerShare > 0.0) && Owner.getReference() &&  (Owner.getReference().getParentCell() == whore.getParentCell())
    iCurrentOwnerSeptims = iCurrentOwnerSeptims + totalPay
    currentOwnerSeptimDisplay.SetValueInt(iCurrentOwnerSeptims)
    UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    Debug.Notification(totalPay + " septim added to the Inn owner: " + Owner.getActorReference().getLeveledActorBase().getName())
  else
    whore.Additem(gold, maxInt(0, totalPay))
  endif
endfunction

Function ownerPayWhore(Actor whore)
  if iCurrentOwnerSeptims > 0
    int payment = maxInt(0, ((iCurrentOwnerSeptims as float) * ((100.0 - fWhoreOwnerShare) / 100.0)) as int)
    whore.Additem(gold, payment)
    if Owner.getActorReference() && (iCurrentOwnerSeptims - payment) > 0
      Owner.getActorReference().Additem(gold,(iCurrentOwnerSeptims - payment))
    endIf
    iCurrentOwnerSeptims = 0
    currentOwnerSeptimDisplay.SetValueInt(0)
    UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
  endIf
  ;Owner.ForceRefTo(None)
  currentAllowedLocations.Revert()
EndFunction

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
    Int position = haveSex(akActor, sGetCurAnimInteface(), fDibelVagChance As Int, fDibelAnalChance As Int, fDibelOralChance As Int, bDibelAllowAggressive, bAllPosAllowed(fDibelVagChance,fDibelAnalChance,fDibelOralChance))
    if position > -1
      payDibel(player, position)
    endif
  endif
endfunction

String function sGetCurAnimInteface()
  Int interf = MCMScript.iGetCurAnimInterface()
  if iGetCurTotalAnimInterfaces() > 1
    if MCMScript.iAnimInterfaceMethod == 2 ;random
      int len = iGetCurTotalAnimInterfaces()
      string[] intefs = Utility.CreateStringArray(len)
      int i = 0
      if bIsOstimActive
        intefs[i] = "ostim"
        i +=1
      endIf
      if bIsSexlabActive
        intefs[i] = "sexlab"
        i +=1
      endIf
      if bIsFlowerGirlsActive
        intefs[i] = "flowergirls"
      endIf
      return intefs[Utility.randomInt(0, len - 1)]
    elseif MCMScript.iAnimInterfaceMethod == 1 ;ask
      interf = InterfaceMenu.Show()
    EndIf
  endif
  if interf == 0
    return "ostim"
  elseif interf == 1
    return "sexlab"
  elseif interf == 2
    return "flowergirls"
  endif
  return ""
endfunction

Int function iGetCurTotalAnimInterfaces()
  Int num = 0
  if bIsOstimActive
    num += 1
  endif
  if bIsSexlabActive
    num += 1
  endif
  if bIsFlowerGirlsActive
    num += 1
  endif
  return num
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

Bool Function bAllPosAllowed(Float fVagChance, Float fAnalChance, Float fOralChance)
  return ((fVagChance > 0.0) && (fAnalChance > 0.0) && (fOralChance > 0.0))
EndFunction