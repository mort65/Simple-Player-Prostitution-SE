Scriptname zzzmrt_sp_main_qst_script extends Quest Conditional

import zzzmrt_sp_utility

GlobalVariable property BeggarFailureChance auto
GlobalVariable property DibelFailureChance auto
zzzmrt_sp_flowergirls_interface property FlowerGirlsInterface auto
zzzmrt_sp_sexlab_interface property SexLabInterface auto
zzzmrt_sp_ostim_interface property OStimInterface auto
zzzmrt_sp_licenses_interface property LicensesInterface auto
Quest Property OStimInterfaceQst Auto
Quest Property FlowerGirlsInterfaceQst Auto
Quest Property SexLabInterfaceQst Auto
Quest Property LicensesInterfaceQst Auto
zzzmrt_sp_mcm_qst_script property MCMScript auto
ReferenceAlias property Owner auto
ReferenceAlias property whoreCustomerAlias auto
ReferenceAlias property dibelCustomerAlias auto
GlobalVariable property WhoreFailureChance auto
;FavorDialogueScript Property DialogueFavorGeneric  Auto 
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
Bool Property bIsLicensesActive=False Auto Hidden Conditional
Bool property bModEnabled=True auto Hidden Conditional
Bool property bWhoreClothing=False auto Hidden Conditional
Bool property bWhoreEnabled=True auto Hidden Conditional
Bool property bWhoreNeedLicense=True auto Hidden Conditional
Bool Property bIsPapyrusUtilActive=False Auto Hidden Conditional
Bool Property bIsPO3ExtenderActive=False Auto Hidden Conditional
Bool Property bDibelAllowAggressive=True Auto Hidden Conditional
Bool Property bWhoreAllowAggressive=True Auto Hidden Conditional
Bool Property bTryAllInterfaces=True Auto Hidden Conditional
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Formlist property alwaysAllowedLocations auto
Spell property customerBeggarSpell auto
Spell property customerSpell auto
Float Property fCureNormalDiseaseCost = 100.0 Auto Hidden Conditional
Float Property fCureSTDICost = 100.0 Auto Hidden Conditional
Float Property fCureSTDIICost = 150.0 Auto Hidden Conditional
Float Property fCureSTDIIICost = 200.0 Auto Hidden Conditional
Float Property fCureSTDIVCost = 300.0 Auto Hidden Conditional
Float Property fWhoreSTDProgressChance = 25.0 Auto Hidden Conditional
Float Property fWhoreSTDInfectChance = 5.0 Auto Hidden Conditional
Bool Property bWhoreAllowMultipleSTDs = false Auto Hidden Conditional
Float Property fDibelSTDProgressChance = 0.0 Auto Hidden Conditional
Float Property fDibelSTDInfectChance = 0.0 Auto Hidden Conditional
Bool Property bDibelAllowMultipleSTDs = false Auto Hidden Conditional
Float Property fNormalSTDProgressChance = 0.0 Auto Hidden Conditional
Float Property fNormalSTDInfectChance = 0.0 Auto Hidden Conditional
Bool Property bNormalAllowMultipleSTDs = false Auto Hidden Conditional
Float Property fBeggarPersuasionXPMult = 0.0 Auto Hidden Conditional
Float Property fDibelPersuasionXPMult = 0.0 Auto Hidden Conditional
Float Property fWhorePersuasionXPMult = 0.0 Auto Hidden Conditional
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

String Property sExtraTags_SL_Oral_MF = "" auto Hidden Conditional
String Property sExtraTags_SL_Oral_MM = "" auto Hidden Conditional
String Property sExtraTags_SL_Oral_FF = "" auto Hidden Conditional
String Property sExtraTags_SL_Anal_MF = "" auto Hidden Conditional
String Property sExtraTags_SL_Anal_MM = "" auto Hidden Conditional
String Property sExtraTags_SL_Anal_FF = "" auto Hidden Conditional
String Property sExtraTags_SL_Vaginal_MF = "" auto Hidden Conditional
String Property sExtraTags_SL_Vaginal_FF = "" auto Hidden Conditional

String Property sExtraTags_OS_Oral_MF = "" auto Hidden Conditional
String Property sExtraTags_OS_Oral_MM = "" auto Hidden Conditional
String Property sExtraTags_OS_Oral_FF = "" auto Hidden Conditional
String Property sExtraTags_OS_Anal_MF = "" auto Hidden Conditional
String Property sExtraTags_OS_Anal_MM = "" auto Hidden Conditional
String Property sExtraTags_OS_Anal_FF = "" auto Hidden Conditional
String Property sExtraTags_OS_Vaginal_MF = "" auto Hidden Conditional
String Property sExtraTags_OS_Vaginal_FF = "" auto Hidden Conditional

Bool Property bExtraTags_SL_Oral_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Oral_MM_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Oral_FF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Anal_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Anal_MM_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Anal_FF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Vaginal_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_SL_Vaginal_FF_ALL = false auto Hidden Conditional

Bool Property bExtraTags_OS_Oral_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Oral_MM_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Oral_FF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Anal_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Anal_MM_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Anal_FF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Vaginal_MF_ALL = false auto Hidden Conditional
Bool Property bExtraTags_OS_Vaginal_FF_ALL = false auto Hidden Conditional
Int Property iTotalRaces = 11 Auto Hidden Conditional
Int[] property iWhoreOralStatArr Auto Hidden Conditional
Int[] property iWhoreAnalStatArr Auto Hidden Conditional
Int[] property iWhoreVaginalStatArr Auto Hidden Conditional
Int[] property iDibelOralStatArr Auto Hidden Conditional
Int[] property iDibelAnalStatArr Auto Hidden Conditional
Int[] property iDibelVaginalStatArr Auto Hidden Conditional
Int[] property iTotalWhoreStats Auto Hidden Conditional
Int[] property iTotalDibelStats Auto Hidden Conditional

Formlist Property raceList Auto
Formlist Property vampireRacelist Auto

Formlist property snitchers auto
Formlist property extraOwners auto 
Actor Property currentPartner Auto Hidden Conditional
Quest Property SnitchDetector Auto 
ReferenceAlias property SnitchRef1 auto
ReferenceAlias property SnitchRef2 auto
Actor Property whoreSnitch Auto Hidden Conditional
Actor Property dibelSnitch Auto Hidden Conditional
Float Property fCitizenReportChance = 10.0 Auto Hidden Conditional
Float Property fGuardReportChance = 90.0 Auto Hidden Conditional
Bool Property isWhoringAllowedInCurrentLocation = False Auto Hidden Conditional
Bool Property isWhoringAlwaysAllowedInCurrentLocation = False Auto Hidden Conditional
ImageSpaceModifier property fadeIn auto
ImageSpaceModifier property fadeOut auto
ImageSpaceModifier property fastFadeOut auto
MiscObject property gold auto
Actor property player auto
Faction property whoreFaction auto
Faction Property DibellaMerchant Auto
Actor Property DibellaMerchantNPC Auto
Int Property iPosition = -1 Auto Hidden Conditional
Quest property STD_Quest Auto
zzzmrt_sp_std_qst_script property STD_Script Auto
Keyword Property ProstituteClothing_kwd Auto
Keyword Property prostituteManager_KWD Auto
Keyword Property prostituteLocation_KWD Auto
Keyword Property stdHealer_KWD Auto
Keyword Property BeggarClothing_kwd Auto
associationType Property spouse  auto
Quest Property pimpTracker Auto

function shutDown()
  snitchDetector.stop()
  STD_Script.cureActorSTDs(player, False)
  STD_Quest.Stop()
  if pimpTracker.isRunning()
    pimpTracker.setstage(10)
  endif
  currentAllowedLocations.Revert()
  player.removeFromFaction(whoreFaction)
  owner.clear()
  clearCustomer()
  iPosition = -1
  dibelSnitch = None
  whoreSnitch = None
EndFunction

Function SetVars()
  if bWhoreEnabled
    player.AddToFaction(whoreFaction)
  else
    player.RemoveFromFaction(whoreFaction)
  endif
  setChance()
  if fWhoreOwnerShare > 0.0
    pimpTracker.start()
  endif
  startCalcSTDCurePrice()
EndFunction

Function RegisterForEvents()
  RegisterForModEvent("AnimationEnding", "on_spp_sexlab_Sex_Ending")
  RegisterForModEvent("HookAnimationEnd", "on_spp_sexlab_Sex_End")
  RegisterForModEvent("ostim_end", "on_spp_ostim_Sex_End")
EndFunction

function startInfectingPlayer(String curState)
  int handle = ModEvent.Create("SPP_InfectPlayerWithSTD")
  ModEvent.PushForm(handle, self as Quest)
  ModEvent.PushString(handle, curState)
  ModEvent.Send(Handle)
EndFunction

function startCalcSTDCurePrice()
  int handle = ModEvent.Create("SPP_CalcPlayerSTDCurePrice")
  ModEvent.PushForm(handle, self as Quest)
  ModEvent.Send(Handle)
EndFunction

function AllowProstitution(Actor akOwner)
  if akOwner && akOwner.GetCurrentLocation()
    currentAllowedLocations.Revert()
    currentAllowedLocations.AddForm(akOwner.GetCurrentLocation() As Form)
    isWhoringAllowedInCurrentLocation = True
    if !player.IsInFaction(whoreFaction)
      player.AddToFaction(whoreFaction)
    endif
    if Owner.getActorReference() && (Owner.getActorReference() != akOwner)
      iCurrentOwnerSeptims = 0
      currentOwnerSeptimDisplay.SetValueInt(0)
      UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    endIf
    Owner.ForceRefTo(akOwner)
    setChance()
    SetStage(10)
    if pimpTracker.isrunning()
      pimpTracker.setstage(10)
      while pimpTracker.isRunning()
        utility.wait(0.2)
      endwhile
    endif
    if fWhoreOwnerShare > 0.0
      pimpTracker.start()
    endif
    Debug.Trace("Simple Prostitution: Work allowed in " + currentAllowedLocations.GetAt(0) + " that's owned by " + akOwner)
    Debug.Notification("Prostitution enabled for current location.")
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
  if pimpTracker.isrunning()
    pimpTracker.setstage(15)
  endif
  Owner.clear()
  clearCustomer()
  currentAllowedLocations.Revert()
EndFunction

function playerBegTo(Actor akActor, Bool bPay=True)
  if akActor
    customerBeggarSpell.Cast(akActor, akActor)
  endif
  if bPay
    payBeggar(player)
    persuade(fBeggarPersuasionXPMult)
  endif
  setChance()
endfunction

function ProstitutePlayerTo(Actor akCustomer, bool bAccept=true)
  setChance()
  if akCustomer
    customerSpell.Cast(akCustomer, akCustomer)
    if !bAccept
      if !isSnitchOK(whoreSnitch) && !playerHasWhoreLicense()
        checkSnitch(akCustomer, false, false)
      endif
      return
    endif
    currentPartner = akCustomer
    GoToState("Whoring")
  else
    iPosition = -1
  endif
endfunction

function playerPracticeDibelArtWith(Actor akActor, bool bAccept=true)
  setChance()
  if akActor
    customerSpell.Cast(akActor, akActor)
    if !bAccept
      if !isSnitchOK(dibelSnitch) && !playerHasDibelLicence()
        checkSnitch(akActor)
      endif
      return
    endif
    currentPartner = akActor
    GoToState("Dibeling")
  else
    iPosition = -1
  endif
endfunction

Float function getBaseVersion()
  return 1.0
endfunction

Float function getCurrentVersion()
  return getBaseVersion() + 0.16
endfunction

Function persuade(Float fSpeechSkillMult)
  if fSpeechSkillMult <= 0.0
    return
  endif
  Game.AdvanceSkill("Speechcraft", fSpeechSkillMult * player.GetActorValue("Speechcraft"))
  ;Game.IncrementStat("Persuasions")
endFunction

int function haveSex(Actor akActor, String interface, Bool bAllowAggressive = False, Bool bAllowAll = False)
  if !akActor
    return -1
  endif
  int result = -1
  if interface == "sexlab"
    result = playerSexSL(akActor, bAllowAggressive, bAllowAll)
  elseif interface == "ostim"
    result = playerSexOS(akActor, bAllowAggressive, bAllowAll)
  elseif interface == "flowergirls"
    result = playerSexFG(akActor)
  else
    result = haveSexSFW()
  endif
  if (result < 0)
    if bTryAllInterfaces && iGetCurTotalAnimInterfaces() > 1
      Debug.trace("SimpleProstitution: retrying with other interfaces.")
      if interface == "sexlab"
        result = playerSexOS(akActor, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexFG(akActor)
        endif
      elseIf interface == "ostim"
        result = playerSexSL(akActor, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexFG(akActor)
        endif
      elseif interface == "flowergirls"
        result = playerSexOS(akActor, bAllowAggressive, bAllowAll)
        if result < 0
          result = playerSexSL(akActor, bAllowAggressive, bAllowAll)
        endif
      endif
    endif
    if result < 0
      Debug.trace("SimpleProstitution: couldn't find any suitable animation.")
      result = haveSexSFW()
    endIf
  endif
  return result
endfunction

function startSnitchFinder(Bool bCheckDibel)
  int handle = ModEvent.Create("SPP_StartFindSnitch")
  ModEvent.PushForm(handle, self as Quest)
  ModEvent.PushBool(handle, bCheckDibel)
  ModEvent.Send(Handle)
EndFunction

Function setWhoreCustomer(Actor akActor, Bool bPay = False)
  customerSpell.Cast(akActor, akActor)
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iPosition = positionChooser(0, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    else
      iPosition = positionChooser(fWhoreVagChance as Int, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    endif
    if iPosition > -1
      payWhore(player, iPosition)
      persuade(fWhorePersuasionXPMult)
    endif
  endIf
  if iPosition > -1
    whoreCustomerAlias.ForceRefTo(akActor)
    akActor.EvaluatePackage()
  endif
EndFunction

Function setDibelCustomer(Actor akActor, bool bPay = true )
  customerSpell.Cast(akActor, akActor)
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
    else
      iPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
    endif
    if iPosition > -1
      payDibel(player, iPosition)
      persuade(fDibelPersuasionXPMult)
    endif
  endIf
  if iPosition > -1
    dibelCustomerAlias.ForceRefTo(akActor)
    akActor.EvaluatePackage()
  endif
EndFunction

Function clearCustomer()
  Actor Customer = dibelCustomerAlias.getActorReference()
  if Customer
    dibelCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias.getActorReference()
  if Customer
    whoreCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
EndFunction


int Function playerSexSL(Actor akActor, Bool bAllowAggressive= False, Bool bAllowAll = False)
  if !bIsSexlabActive || (iPosition < 0)
    return -1
  endif
  int result = SexLabInterface.haveSexWithPlayer(akActor, iPosition, sGetExtraTagsArr("sexlab"), bGetRegAllTagsArr("sexlab"), bAllowAggressive, bAllowAll)
  if result > -1
     RegisterForModEvent("AnimationEnding", "on_spp_sexlab_Sex_Ending")
     RegisterForModEvent("HookAnimationEnd", "on_spp_sexlab_Sex_End")
  endif
  return result
EndFunction

int Function playerSexOS(Actor akActor, Bool bAllowAggressive= False, Bool bAllowAll = False)
  if !bIsOstimActive || (iPosition < 0)
    return -1
  endif
  int result = OStimInterface.haveSexWithPlayer(akActor, iPosition, sGetExtraTagsArr("ostim"), bGetRegAllTagsArr("ostim"), bAllowAggressive, bAllowAll)
  if result > -1
    RegisterForModEvent("ostim_end", "on_spp_ostim_Sex_End")
  endif
  return result
EndFunction

int Function playerSexFG(Actor akActor)
  if !bIsFlowerGirlsActive || (iPosition < 0)
    return -1
  endif
  int result = FlowerGirlsInterface.haveSexWithPlayer(akActor, iPosition)
  if result > -1
    registerForSingleUpdate(60.0)
  endif
  return result
EndFunction

int function haveSexSFW()
  if iPosition < 0
    return -1
  endif
  Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
  FastFadeOut.Apply()
  Utility.Wait(1.0)
  FastFadeOut.PopTo(BlackScreen)
  Utility.Wait(5.0)
  BlackScreen.PopTo(FadeIn)
  Game.EnablePlayerControls()
  registerForSingleUpdate(5.0)
  return iPosition
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
    pimpTracker.UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    Debug.Notification(totalPay + " septim added to " + Owner.getActorReference().getLeveledActorBase().getName())
  else
    whore.Additem(gold, maxInt(0, totalPay))
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

Int function positionChooser(int vaginalWeight = 50, int AnalWeight = 50, int oralWeight = 50)
  if (vaginalWeight < 1) && (AnalWeight < 1) && (oralWeight < 1)
    return -1
  endif
  int[] cumulWeight = Utility.createIntArray(3)
  cumulWeight[0] = vaginalWeight
  cumulWeight[1] = AnalWeight + vaginalWeight
  cumulWeight[2] = oralWeight + AnalWeight + vaginalWeight
  int x = utility.randomInt(1,cumulWeight[2])
  int i = 0
  while i < cumulWeight.Length
    if x <= cumulWeight[i]
      return i
    endIf
    i += 1
  endWhile
  return -1
endfunction

Bool Function bCheckPapyrusUtil()
  return papyrusutil.GetVersion() > 31
EndFunction

Bool Function bCheckPO3Extender()
  int[] version = PO3_SKSEFunctions.GetPapyrusExtenderVersion()
  if version || PO3_SKSEFunctions.GenerateRandomInt(1, 2)
    return True
  endif
  return false
EndFunction

Bool Function bAllPosAllowed(Float fVagChance, Float fAnalChance, Float fOralChance)
  return ((fVagChance > 0.0) && (fAnalChance > 0.0) && (fOralChance > 0.0))
EndFunction


bool[] Function bGetRegAllTagsArr(String sInterface)
  bool[] bReqAllArr = Utility.createBoolArray(8)
  if sInterface == "sexlab"
    bReqAllArr[0] = bExtraTags_SL_Oral_MF_ALL
    bReqAllArr[1] = bExtraTags_SL_Oral_FF_ALL
    bReqAllArr[2] = bExtraTags_SL_Oral_MM_ALL    
    bReqAllArr[3] = bExtraTags_SL_Anal_MF_ALL
    bReqAllArr[4] = bExtraTags_SL_Anal_FF_ALL
    bReqAllArr[5] = bExtraTags_SL_Anal_MM_ALL
    bReqAllArr[6] = bExtraTags_SL_Vaginal_MF_ALL
    bReqAllArr[7] = bExtraTags_SL_Vaginal_FF_ALL
  elseif sInterface == "ostim"
    bReqAllArr[0] = bExtraTags_OS_Oral_MF_ALL
    bReqAllArr[1] = bExtraTags_OS_Oral_FF_ALL
    bReqAllArr[2] = bExtraTags_OS_Oral_MM_ALL    
    bReqAllArr[3] = bExtraTags_OS_Anal_MF_ALL
    bReqAllArr[4] = bExtraTags_OS_Anal_FF_ALL
    bReqAllArr[5] = bExtraTags_OS_Anal_MM_ALL
    bReqAllArr[6] = bExtraTags_OS_Vaginal_MF_ALL
    bReqAllArr[7] = bExtraTags_OS_Vaginal_FF_ALL
  endif
  return bReqAllArr
EndFunction

string[] Function sGetExtraTagsArr(String sInterface)
  string[] sTagsArr = Utility.createStringArray(8)
  if sInterface == "sexlab"
    sTagsArr[0] = sExtraTags_SL_Oral_MF
    sTagsArr[1] = sExtraTags_SL_Oral_FF
    sTagsArr[2] = sExtraTags_SL_Oral_MM
    sTagsArr[3] = sExtraTags_SL_Anal_MF
    sTagsArr[4] = sExtraTags_SL_Anal_FF
    sTagsArr[5] = sExtraTags_SL_Anal_MM
    sTagsArr[6] = sExtraTags_SL_Vaginal_MF
    sTagsArr[7] = sExtraTags_SL_Vaginal_FF
  elseif sInterface == "ostim"
    sTagsArr[0] = sExtraTags_OS_Oral_MF
    sTagsArr[1] = sExtraTags_OS_Oral_FF
    sTagsArr[2] = sExtraTags_OS_Oral_MM
    sTagsArr[3] = sExtraTags_OS_Anal_MF
    sTagsArr[4] = sExtraTags_OS_Anal_FF
    sTagsArr[5] = sExtraTags_OS_Anal_MM
    sTagsArr[6] = sExtraTags_OS_Vaginal_MF
    sTagsArr[7] = sExtraTags_OS_Vaginal_FF
  endif
  return sTagsArr
EndFunction



Bool Function checkSnitch(Actor npc, Bool bCompleteCheck = False, Bool bDibel = False)
  Actor Snitch
  if bDibel
    if playerHasDibelLicence()
      dibelSnitch = None
      return True
    endif
    Snitch = dibelSnitch
  else
    if playerHasWhoreLicense()
      whoreSnitch = None
      return True
    endif
    Snitch = whoreSnitch
  Endif

  if !npc || (npc == player) || (Snitch && !Snitch.isDead())
    Return True
  endif
  
  if npc.isGuard()
    if utility.RandomInt(0,99) < fGuardReportChance as int
      if bCanSnitch(npc, bCompleteCheck)
        if bDibel
          dibelSnitch = npc
        else
          whoreSnitch = npc
        endif
        Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player.")
        Return True
      endif
    endif
  elseif (utility.RandomInt(0,99) < fCitizenReportChance as int)
    if bCanSnitch(npc, bCompleteCheck)
      if bDibel
        dibelSnitch = npc
      else
        whoreSnitch = npc
      endif
      Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player.")
      Return True
    endif
  endif
  Return False
EndFunction

Bool function bCanSnitch(Actor npc, Bool bComplete = true)
  if !npc
    return False
  endif
  if npc.isDead()
    return false
  endif
  if npc == currentPartner
    return False
  endif
  if snitchers.hasform(npc)
    return False
  endif
  
  if !bComplete
    return True
  endif
 ;SnitchDetector checks these conditions:
  if !npc.GetCrimeFaction()
    return False
  endif
  if owner.getActorReference() && (npc == owner.getActorReference())
    return false
  endif
  if !npc.HasKeywordString("actortypenpc")
    return False
  endif
  if npc.HasKeywordString("prostitutemanager_kwd")
      return False
  endif
  if extraOwners.hasform(npc)
    return False
  endif
  if npc.HasFamilyRelationship(player)
    return false
  endif
  if npc.GetRelationshipRank(player) > 0
    return false
  endif
  if npc.isPlayerTeammate()
    return false
  endif
  if npc.IsCommandedActor()
    return False
  endif
  if npc.GetDistance(player) > 384.0 && !npc.HasLos(player)
    return False
  endif
  return True
EndFunction

function updateCrimeGold(faction crimeFaction, int crimeFine)
  if crimeFaction
    crimeFaction.SetCrimeGoldViolent(crimeFaction.GetCrimeGoldNonViolent() + crimeFine)
  endif
endfunction

Bool function isSnitchOK(actor snitch)
  return snitch && !snitch.isDead()
endfunction

Bool Function inSameCell(Actor actor1, Actor actor2)
  if !actor1.getParentCell() || !actor2.getParentCell()
    return false
  endif
  return (actor1.getParentCell() == actor2.getParentCell())
EndFunction


Bool function playerHasWhoreLicense()
  return !bWhoreNeedLicense || LicensesInterface.bHasWhoreLicense()
EndFunction

Bool Function playerHasDibelLicence()
  return !bDibelNeedLicense || LicensesInterface.bHasWhoreLicense()
EndFunction

function snitch()
  actor snitch = None
  If playerHasWhoreLicense() || !isSnitchOK(whoreSnitch)
    whoreSnitch = None
  endif
  If playerHasDibelLicence() || !isSnitchOK(dibelSnitch)
    dibelSnitch = None
  endif
  if bIsLicensesActive
    if whoreSnitch
      if inSameCell(player, whoreSnitch)
        RegisterForSingleUpdateGameTime(Utility.RandomInt(8,14) As Float)
      else
        snitch = whoreSnitch
        whoreSnitch = None
        dibelSnitch = None
      endif
    elseif dibelSnitch
      if inSameCell(player, whoreSnitch)
        RegisterForSingleUpdateGameTime(Utility.RandomInt(8,14) As Float)
      else
        snitch = dibelSnitch
        whoreSnitch = None
        dibelSnitch = None
      endif
    endif
  endif
  if snitch
    String msg
    if snitch.GetBaseObject().GetName()
      msg = "Simple Prostitution: " + snitch.GetBaseObject().GetName() + " reported you."
    else
      msg = "Simple Prostitution: Someone reported you."
    endif
    Debug.Trace(msg + " (" + snitch + ")")
    Debug.Notification(msg)
    LicensesInterface.setWhoreViolation()
  endif
endfunction


Bool Function findSnitch(Bool bCheckDibel = False)
  Bool bSnitchFound = false
  SnitchDetector.start()
  If bIsPapyrusUtilActive
    Actor[] actors = MiscUtil.ScanCellNPCs(player, radius = 3000.0, HasKeyword = none, IgnoreDead = true)
    actor npc = None
    int iIndex = 0
    while (GetState() != "") && (iIndex < actors.Length) && !bSnitchFound
      npc = actors[iIndex]
      bSnitchFound = checkSnitch(npc, true, bCheckDibel)
      actors[iIndex] && snitchers.addform(actors[iIndex])
      if !bSnitchFound && snitchRef1.GetActorReference()
        bSnitchFound = checkSnitch(snitchRef1.GetActorReference(), false, bCheckDibel)
        snitchRef1.GetActorReference() && snitchers.addform(snitchRef1.GetActorReference())
      endif
      if !bSnitchFound && snitchRef2.GetActorReference()
        bSnitchFound = checkSnitch(snitchRef2.GetActorReference(), false, bCheckDibel)
        snitchRef2.GetActorReference() && snitchers.addform(snitchRef2.GetActorReference())
      endif
      iIndex += 1
    endWhile
  else
    utility.Wait(3.0)
  endif
  While !snitchDetector.isRunning()
    utility.wait(0.2)
  endWhile
  if snitchRef1.GetActorReference()
    if !bSnitchFound
      bSnitchFound = checkSnitch(snitchRef1.GetActorReference(), false, bCheckDibel)
      snitchRef1.GetActorReference() && snitchers.addform(snitchRef1.GetActorReference())
    endif
  endif
  if snitchRef2.GetActorReference()
    if !bSnitchFound
      bSnitchFound = checkSnitch(snitchRef2.GetActorReference(), false, bCheckDibel)
      snitchRef2.GetActorReference() && snitchers.addform(snitchRef2.GetActorReference())
    endif
  endif
  snitchDetector.stop()
  return bSnitchFound
endfunction


Bool Function isWhoringAllowedInLocation(Location loc)
  if !loc
    return False
  endif
  if currentAllowedLocations.hasform(loc)
    return True
  endif
  if isWhoringAlwaysAllowedInLocation(loc)
    return True
  endif
  return false
EndFunction

Bool Function isWhoringAlwaysAllowedInLocation(Location loc)
  if !loc
    return False
  endif
  if alwaysAllowedLocations.hasform(loc)
    return True
  endif
  if loc.HasKeyword(prostituteLocation_KWD)
    return true
  endif
  return false
EndFunction

Function checkCurrentLocation()
  location loc = player.GetCurrentLocation()
  isWhoringAlwaysAllowedInCurrentLocation = isWhoringAlwaysAllowedInLocation(loc)
  isWhoringAllowedInCurrentLocation = isWhoringAllowedInLocation(loc)
EndFunction


Bool Function bCanPimp(Actor npc)
  if !npc
    return False
  endif
  if npc.ischild()
    return False
  endif
  if npc.isDead()
    return False
  endif
  if !npc.HasKeywordstring("actortypenpc")
    return False
  endif
  if npc == player
    return false
  endif
  if npc.HasFamilyRelationship(player)
    return False
  endif
  return true
EndFunction

Bool Function bCanHeal(Actor npc)
  if !npc
    return False
  endif
  if npc.ischild()
    return False
  endif
  if npc.isDead()
    return False
  endif
  if !npc.HasKeywordstring("actortypenpc")
    return False
  endif
  if npc == player
    return false
  endif
  return true
EndFunction


Function updateHistory(Actor partner, int iPos, Bool bDibel = False)
  if !Partner || !Partner.getRace() || (iPos < 0) || (iPos > 2)
    return
  endif
  ;Races: ArgonianRace, BretonRace, DarkElfRace, HighElfRace, ImperialRace, KhajiitRace, NordRace, OrcRace, RedguardRace, WoodElfRace
  ;Position: Vaginal, Anal, Oral
  initStatArrs()
  Race partnerRace = Partner.getRace()
  if !partnerRace
    return
  endif
  Int raceIndex = iTotalRaces - 1 ;last race is other races
  int iIndex = raceIndex
  while (iIndex > 0) && (raceIndex == (iTotalRaces - 1))
    iIndex -= 1
    if (partnerRace == raceList.GetAt(iIndex) as Race) || (partnerRace == vampireRacelist.GetAt(iIndex) as Race)
      raceIndex = iIndex
    endif
  endWhile
  if (raceIndex > -1) && (raceIndex < iTotalRaces)
    if iPos == 2
      if bDibel
        iDibelOralStatArr[raceIndex] = iDibelOralStatArr[raceIndex] + 1
      else
        iWhoreOralStatArr[raceIndex] = iWhoreOralStatArr[raceIndex] + 1
      endif
    elseif iPos == 1
      if bDibel
        iDibelAnalStatArr[raceIndex] = iDibelAnalStatArr[raceIndex] + 1
      else
        iWhoreAnalStatArr[raceIndex] = iWhoreAnalStatArr[raceIndex] + 1
      endif
    elseif iPos == 0
      if bDibel
        iDibelVaginalStatArr[raceIndex] = iDibelVaginalStatArr[raceIndex] + 1
      else
        iWhoreVaginalStatArr[raceIndex] = iWhoreVaginalStatArr[raceIndex] + 1
      endif
    endif
    if bDibel
      iTotalDibelStats[iPos] = iTotalDibelStats[iPos] + 1
    else
      iTotalWhoreStats[iPos] = iTotalWhoreStats[iPos] + 1
    endif
  endif 
EndFunction

Function initStatArrs()
  iWhoreOralStatArr = initIntArray(iWhoreOralStatArr, iTotalRaces)
  iWhoreAnalStatArr = initIntArray(iWhoreAnalStatArr, iTotalRaces)
  iWhoreVaginalStatArr = initIntArray(iWhoreVaginalStatArr, iTotalRaces)
  iDibelOralStatArr = initIntArray(iDibelOralStatArr, iTotalRaces)
  iDibelAnalStatArr = initIntArray(iDibelAnalStatArr, iTotalRaces)
  iDibelVaginalStatArr = initIntArray(iDibelVaginalStatArr, iTotalRaces)
  iTotalWhoreStats = initIntArray(iTotalWhoreStats, 3)
  iTotalDibelStats = initIntArray(iTotalDibelStats, 3)
EndFunction

Bool Function bCanReceiveReward(Int iPos, Bool bDibel = False)
  Int[] arr
  if bDibel
    if iPos == 2
      arr = iDibelOralStatArr
    elseif iPos == 1
      arr = iDibelAnalStatArr
    elseif iPos == 0
      arr = iDibelVaginalStatArr
    endif
  else
    if iPos == 2
      arr = iWhoreOralStatArr
    elseif iPos == 1
      arr = iWhoreAnalStatArr
    elseif iPos == 0
      arr = iWhoreVaginalStatArr
    endif
  endif
  if arr 
    Int raceIndex = iTotalRaces - 1 ;last race is other races
    while raceIndex > 0
      raceIndex -= 1
      if arr[raceIndex] < 1
        return False
      endif
    endWhile
    return True
  endif
  return False
EndFunction

Event OnInit()
EndEvent

event onUpdate()
EndEvent

Event OnUpdateGameTime()
  ;Debug.trace("Simple Prostitution: OnUpdateGameTime triggered.")
  snitch()
endEvent

Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  ;Debug.trace("Simple Prostitution: on_spp_sexlab_Sex_Ending triggered. state=" + getState())
  actor[] actorList = SexLabInterface.HookActors(argString)
  Bool hasplayer = SexLabInterface.HasPlayer(argString)
  if hasplayer && actorList.Length > 1
    if actorList.Length == 2 && player.hasAssociation(spouse)
      int i = 2
      while i > 0
        i -= 1
        if actorList[i] && (actorList[i] != player) && player.HasAssociation(spouse, actorList[i])
          return
        endif
      endWhile
    endif
    startInfectingPlayer(getState())
  endif
EndEvent

event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
  ;Debug.trace("Simple Prostitution: on_spp_sexlab_Sex_End triggered. state=" + getState())
EndEvent

Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
  ;Debug.trace("Simple Prostitution: on_spp_ostim_Sex_End triggered. state=" + getState())
  actor[] actorList = OStimInterface.getActors()
  if actorList.Length > 1
    Bool hasPlayer = False
    Bool hasSpouse = False
    int i = actorList.Length
    while i > 0
      i -= 1
      if actorList[i]
        if actorList[i] == player
          hasPlayer = true
        elseif player.HasAssociation(spouse, actorList[i])
          hasSpouse = true
        endif
      endif
    endWhile
    if hasPlayer
      if actorList.Length == 2 && hasSpouse
        return
      endif
      StartInfectingplayer(getState())
    endif
  endif
endEvent

State Dibeling
  Event OnBeginState()
    int result = -1
    clearCustomer()
    if !isSnitchOK(dibelSnitch) && !playerHasDibelLicence()
      startSnitchFinder(true)
    endif
    result = haveSex(currentPartner, sGetCurAnimInteface(), bDibelAllowAggressive, bAllPosAllowed(fDibelVagChance,fDibelAnalChance,fDibelOralChance))
    updateHistory(currentPartner, result, True)
    iPosition = -1
    if result < 0
      GoToState("")
    endif
  EndEvent

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      startInfectingPlayer(GetState())
      GoToState("")
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    startInfectingPlayer(GetState())
    GoToState("")
  EndEvent
  
  event onUpdate()
      startInfectingPlayer(GetState())
      GoToState("")
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent
  
  function snitch()
  EndFunction

EndState

State Whoring
  Event OnBeginState()
    int result = -1
    if !isSnitchOK(whoreSnitch) && !playerHasWhoreLicense()
      startSnitchFinder(false)
    endif
    clearCustomer()
    result = haveSex(currentPartner, sGetCurAnimInteface(), bWhoreAllowAggressive, bAllPosAllowed(fWhoreVagChance, fWhoreAnalChance, fWhoreOralChance))
    updateHistory(currentPartner, result, False)
    iPosition = -1
    if result < 0
      GoToState("")
    endif
  EndEvent

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      startInfectingPlayer(GetState())
      GoToState("")
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    startInfectingPlayer(GetState())
    GoToState("")
  EndEvent
  
  event onUpdate()
      startInfectingPlayer(GetState())
      GoToState("")
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent
  
  function snitch()
  EndFunction

EndState

Auto State Init
  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
  EndEvent

  Event onInit()
    registerForSingleUpdate(5.0) 
  EndEvent

  event onUpdate()
    GoToState("")
  endEvent
  
  event OnEndState()
    While (!FlowerGirlsInterface.bChecked || !SexLabInterface.bChecked || !OStimInterface.bChecked || !LicensesInterface.bChecked)
      Utility.wait(0.2)
    endWhile
    ;Debug.Trace("Simple Prostitution started.")
    Debug.Notification("Simple Prostitution started.")
  endevent

  function snitch()
  EndFunction
EndState