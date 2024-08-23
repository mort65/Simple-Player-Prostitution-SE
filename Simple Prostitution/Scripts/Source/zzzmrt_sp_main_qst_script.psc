Scriptname zzzmrt_sp_main_qst_script extends Quest Conditional

import zzzmrt_sp_utility

GlobalVariable property BeggarFailureChance auto
GlobalVariable property DibelFailureChance auto
GlobalVariable Property BeggarNoSexOfferChance Auto
zzzmrt_sp_flowergirls_interface property FlowerGirlsInterface auto
zzzmrt_sp_sexlab_interface property SexLabInterface auto
zzzmrt_sp_ostim_interface property OStimInterface auto
zzzmrt_sp_licenses_interface property LicensesInterface auto
zzzmrt_sp_ddi_interface property DDI_Interface auto
Quest Property OStimInterfaceQst Auto
Quest Property FlowerGirlsInterfaceQst Auto
Quest Property SexLabInterfaceQst Auto
Quest Property LicensesInterfaceQst Auto
zzzmrt_sp_mcm_qst_script property MCMScript auto
zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto
Quest Property ApproachMonitorQst Auto
ReferenceAlias property Owner auto
ReferenceAlias property whoreCustomerAlias auto
ReferenceAlias property whoreCustomerAlias2 auto
ReferenceAlias property whoreCustomerAlias3 auto
ReferenceAlias property whoreCustomerAlias4 auto
ReferenceAlias property dibelCustomerAlias auto
ReferenceAlias property dibelCustomerAlias2 auto
ReferenceAlias property dibelCustomerAlias3 auto
ReferenceAlias property dibelCustomerAlias4 auto
GlobalVariable property WhoreFailureChance auto
ReferenceAlias property Assaulter auto
Message property InterfaceMenu auto
Message Property DibelOfferMenu Auto
Message Property DibelOfferMenu_InsufficientMark Auto
Message Property DibelOfferMenu_Skills Auto
Message Property DibelOfferMenu_Skills_Combat Auto
Message Property DibelOfferMenu_Skills_Magic Auto
Message Property DibelOfferMenu_Skills_Stealth Auto
Message Property DibelOfferMenu_Confirm_Skill Auto
Message Property DibelOfferMenu_Confirm_Health Auto
Message Property DibelOfferMenu_Confirm_Stamina Auto
Message Property DibelOfferMenu_Confirm_Magicka Auto
Message Property DibelOfferMenu_Confirm_Perk Auto
Message Property DibelOfferMenu_Confirm_CarryWeight Auto
Message Property DibelOfferMenu_Confirm_DDKey Auto
Message Property DibelOfferMenu_DDKEy_Changed Auto
Message Property DibelOfferMenu_Skill_Changed Auto
Message Property DibelOfferMenu_Perk_Changed Auto
Message Property DibelOfferMenu_Health_Changed Auto
Message Property DibelOfferMenu_Stamina_Changed Auto
Message Property DibelOfferMenu_Magicka_Changed Auto
Message Property DibelOfferMenu_CarryWeight_Changed Auto
Message Property DibelOfferMenu_Attributes Auto
Message Property Confirm_RemoveDibelRewards_Message Auto
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
Bool Property bIsPyramidUtilsOK=False Auto Hidden Conditional
Bool Property bDibelAllowAggressive=True Auto Hidden Conditional
Bool Property bWhoreAllowAggressive=True Auto Hidden Conditional
Bool Property bTryAllInterfaces=True Auto Hidden Conditional
Bool Property bIsDDIntegrationActive=False Auto Hidden Conditional
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Formlist property alwaysAllowedLocations auto
Formlist property whoreCustomerList Auto
Formlist property dibelCustomerList Auto
Formlist Property currentCustomerList Auto
Spell property customerBeggarSpell auto
Spell property customerSpell auto
Spell property StaggerSpell Auto
Spell property ParalyzeSpell Auto
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
Float property fMaxSpeechBegBonusMult=0.5 auto Hidden Conditional
Float property fMaxSpeechDibelBonusMult=1.5 auto Hidden Conditional
Float property fMaxSpeechWhoreBonusMult=1.2 auto Hidden Conditional
Float property fMinSpeechBegBonusMult=0.0 auto Hidden Conditional
Float property fMinSpeechDibelBonusMult=0.8 auto Hidden Conditional
Float property fMinSpeechWhoreBonusMult=0.6 auto Hidden Conditional
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
Int[] property iWhorePositions auto Hidden Conditional
Int[] property iDibelPositions auto Hidden Conditional
Int[] Property iPositions Auto Hidden Conditional
keyword[] property forbidenArmorKeywords auto hidden Conditional
Int property iTotalWhoreCustomers = 0 auto Hidden Conditional
Int property iTotalDibelCustomers = 0 auto Hidden Conditional
Bool property bSexAfterOffering = True Auto Hidden Conditional
Bool Property bBeggingMaleSexOffer = False Auto Hidden Conditional
Bool Property bBeggingFemaleSexOffer = False Auto Hidden Conditional
Float Property fBeggarSexOfferChance = 0.0 Auto Hidden Conditional
Bool Property bFemaleCustomerApproach = True Auto Hidden Conditional
Bool Property bMaleCustomerApproach = True Auto Hidden Conditional
Float Property fCustomerApproachChance = 50.0 Auto Hidden Conditional

Faction Property DibelCustomerFaction Auto
Faction Property WhoreCustomerFaction Auto


Int Property iPaidGoldCustomer1 = 0 Auto Hidden Conditional
Int Property iPaidGoldCustomer2 = 0 Auto Hidden Conditional
Int Property iPaidGoldCustomer3 = 0 Auto Hidden Conditional
Int Property iPaidGoldCustomer4 = 0 Auto Hidden Conditional
Int Property iPaidGoldAllCustomers = 0 Auto Hidden Conditional

Int Property iPaidGoldDibelCustomer1 = 0 Auto Hidden Conditional
Int Property iPaidGoldDibelCustomer2 = 0 Auto Hidden Conditional
Int Property iPaidGoldDibelCustomer3 = 0 Auto Hidden Conditional
Int Property iPaidGoldDibelCustomer4 = 0 Auto Hidden Conditional
Int Property iPaidGoldAllDibelCustomers = 0 Auto Hidden Conditional

Int Property iWhoringRejectResult = 0 Auto Hidden Conditional

Float property fBeggarRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float Property fBeggingMaleRapistChance = 0.0 Auto Hidden Conditional
Float Property fBeggingFemaleRapistChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional

Float property fWhoreRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fWhoreRejectMaleRapeChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleRapeChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleReportChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleReportChance = 0.0 Auto Hidden Conditional

Float property fDibelRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDibelRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDibelRejectMaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleReportChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleReportChance = 0.0 Auto Hidden Conditional

Int property iCustomerApproachTimer = 3 Auto Hidden Conditional
Bool property bDibelCustomerApproach = False Auto Hidden Conditional
Bool property isDibel = False Auto Hidden Conditional ;for starting customer approach and checking dibel license
Bool property isWhore = False Auto Hidden Conditional ;for starting customer approach
Int Property iTotalCustomerPaidGold = 0 Auto Hidden Conditional
Bool property bRejectAssaultRape = False Auto Hidden Conditional
Bool property bRejectAssaultTheft = False Auto Hidden Conditional
Bool property bOnlyInteriorApproach = False Auto Hidden Conditional
Bool property bOnlyWhoreClothingApproach = False Auto Hidden Conditional
FormList Property whoreClothingList Auto

Formlist Property raceList Auto
Formlist Property vampireRacelist Auto

Formlist property snitchers auto
Formlist property extraOwners auto 
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
MiscObject Property dibelMark Auto
Actor property player auto
Faction property whoreFaction auto
Faction Property DibellaMerchant Auto
Actor Property DibellaMerchantNPC Auto
Int Property iPosition = -1 Auto Hidden Conditional
Int Property iWhorePosition = -1 Auto Hidden Conditional
Int Property iDibelPosition = -1 Auto Hidden Conditional
Quest property STD_Quest Auto
zzzmrt_sp_std_qst_script property STD_Script Auto
Keyword Property ProstituteClothing_kwd Auto
Keyword Property prostituteManager_KWD Auto
Keyword Property prostituteLocation_KWD Auto
Keyword Property stdHealer_KWD Auto
Keyword Property BeggarClothing_kwd Auto
Keyword Property ClothingBody_kwd Auto
Keyword Property ArmorCuirass_kwd Auto
associationType Property spouse  Auto
Quest Property pimpTracker Auto
Float Property fWhoreMarkChance = 0.0 Auto Hidden Conditional
Float Property fDibelMarkChance = 1.0 Auto Hidden Conditional
Float Property fAttributeCost = 1.0 Auto Hidden Conditional
Float Property fCarryWeightCost = 1.0 Auto Hidden Conditional
Float Property fAttributeIncrement = 10.0 Auto Hidden Conditional
Float Property fCarryWeightIncrement = 20.0 Auto Hidden Conditional
Float Property fSkillLevelCost = 1.0 Auto Hidden Conditional
Float Property fSkillLevelIncrement = 1.0 Auto Hidden Conditional
Float Property fPerkPointCost = 5.0 Auto Hidden Conditional
Float Property fPerkPointIncrement = 1.0 Auto Hidden Conditional
Float Property fDDKeyCost = 1.0 Auto Hidden Conditional
Float Property fDDKeyIncrement = 5.0 Auto Hidden Conditional
Actor property angryWhoreCustomer Auto Hidden Conditional
Actor property angryDibelCustomer Auto Hidden Conditional
Magiceffect property customerEffect Auto
Magiceffect property beggarCustomerEffect Auto

Bool bWhoreAnimEnded = False
Bool bDibelAnimEnded = False
Bool Property bLastBeggingSucceed = False Auto Hidden Conditional
Int Property iWhorePartners = 0 Auto Hidden Conditional
Int Property iDibelPartners = 0 Auto Hidden Conditional
Actor[] property origCustomersArr Auto Hidden Conditional
Bool property bIsBusy = False Auto Hidden Conditional

Int Property iRejectAcceptChance = 0 Auto Hidden Conditional
Int Property iRejectReportChance = 0 Auto Hidden Conditional
Int Property iRejectTheftChance = 0 Auto Hidden Conditional
Int Property iRejectAssaultChance = 0 Auto Hidden Conditional
Int Property iRejectSlaveryChance = 0 Auto Hidden Conditional
Int Property iRejectRapeChance = 0 Auto Hidden Conditional

Bool Property bDibelRejectTheftOnlyGold = True Auto Hidden Conditional
Bool Property bWhoreRejectTheftOnlyGold = True Auto Hidden Conditional
Bool Property bBeggarRejectTheftOnlyGold = True Auto Hidden Conditional

Bool property bRejectTheftOnlyGold = True Auto Hidden Conditional

Bool property bDibelReject = False Auto Hidden Conditional
Bool property bBeggarReject = False Auto Hidden Conditional

Package Property drawWeapon  Auto 

function shutDown()
  stopApproach()
  snitchDetector.stop()
  ApproachMonitorQst.stop()
  STD_Script.cureActorSTDs(player, False)
  STD_Quest.Stop()
  if pimpTracker.isRunning()
    pimpTracker.setstage(10)
  endif
  currentAllowedLocations.Revert()
  player.removeFromFaction(whoreFaction)
  owner.clear()
  clearCustomer()
  clearPositions()
  dibelSnitch = None
  whoreSnitch = None
  bIsBusy = False
  isDibel = false
  isWhore = false
  GoToState("")
EndFunction

Function SetVars()
  if bWhoreEnabled
    player.AddToFaction(whoreFaction)
  else
    player.RemoveFromFaction(whoreFaction)
  endif
  if !DibellaMerchantNPC.IsInFaction(DibellaMerchant)
    DibellaMerchantNPC.AddToFaction(DibellaMerchant)
  endif
  setGlobalVaues()
  if fWhoreOwnerShare > 0.0
    pimpTracker.start()
  endif
  startCalcSTDCurePrice()
  RegisterForEvents()
  checkCurrentLocation()
  if !ApproachMonitorScr
    ApproachMonitorScr = ApproachMonitorQst as zzzmrt_sp_appr_monitor_qst_script
  endif
  if !ApproachMonitorQst.isRunning()
    ApproachMonitorQst.start()
  endif
  ApproachMonitorScr.updateApproach(False)
EndFunction

Function RegisterForEvents()
  RegisterForModEvent("AnimationEnding", "on_spp_sexlab_Sex_Ending")
  RegisterForModEvent("HookAnimationEnd", "on_spp_sexlab_Sex_End")
  RegisterForModEvent("ostim_end", "on_spp_ostim_Sex_End")
EndFunction

function startInfectingPlayer(String curState, Int numNPC = 1)
  int handle = ModEvent.Create("SPP_InfectPlayerWithSTD")
  ModEvent.PushForm(handle, self as Quest)
  ModEvent.PushString(handle, curState)
  ModEvent.PushInt(handle, numNPC)
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
    isWhore = true
    if (Owner.getActorReference() != None) && (Owner.getActorReference() != akOwner)
      iCurrentOwnerSeptims = 0
      currentOwnerSeptimDisplay.SetValueInt(0)
      UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    endIf
    Owner.ForceRefTo(akOwner)
    setGlobalVaues()
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
    if (Owner.getActorReference() != None) && (iCurrentOwnerSeptims - payment) > 0
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
  clearWhoreCustomers()
  currentAllowedLocations.Revert()
EndFunction

function playerBegTo(Actor akActor, Bool bPay=True)
  bLastBeggingSucceed = bPay
  if akActor
    customerBeggarSpell.Cast(akActor, akActor)
  endif
  if bPay
    payBeggar(player)
    persuade(fBeggarPersuasionXPMult)
  endif
  setGlobalVaues()
endfunction

Float function getBaseVersion()
  return 1.0
endfunction

Float function getCurrentVersion()
  return getBaseVersion() + 0.30
endfunction

Function persuade(Float fSpeechSkillMult)
  if fSpeechSkillMult <= 0.0
    return
  endif
  Game.AdvanceSkill("Speechcraft", fSpeechSkillMult * player.GetActorValue("Speechcraft"))
  ;Game.IncrementStat("Persuasions")
endFunction


Bool function bRandomSexWithPlayer(Actor akActor, Bool bAggressive = False)
  if !akActor
    return False
  endif
  string interface = sGetCurAnimInteface()
  if interface == "sexlab"
    if bIsSexlabActive
      return SexLabInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
    endif
  elseif interface == "ostim"
    if bIsOstimActive
      return OStimInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
    endif   
  elseif interface == "flowergirls"
    if bIsFlowerGirlsActive
      if FlowerGirlsInterface.bHaveRandomSexWithPlayer(akActor)
        registerForSingleUpdate(1.0)
        return True
      endif
    endif
  else
    Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
    FastFadeOut.Apply()
    Utility.Wait(1.0)
    FastFadeOut.PopTo(BlackScreen)
    if akActor != player
      akActor.EnableAI(False)
    endif
    Utility.Wait(5.0)
    akActor.EnableAI(True)
    BlackScreen.PopTo(FadeIn)
    Game.EnablePlayerControls()
    registerForSingleUpdate(1.0)
    return True
  endif
  return False
endFunction

int function haveSex(Actor akActor, String interface, Bool bAllowAggressive = False, Bool bAllowAll = False)
  if !akActor
    return -1
  endif
  (akActor as ObjectReference).MoveToIfUnloaded(player as ObjectReference)
  int result = -1
  if interface == "sexlab"
    result = playerSexSL(akActor, bAllowAggressive, bAllowAll)
  elseif interface == "ostim"
    result = playerSexOS(akActor, bAllowAggressive, bAllowAll)
  elseif interface == "flowergirls"
    result = playerSexFG(akActor)
  else
    result = playerSexSFW(akActor)
  endif
  if (result < 0)
    if bTryAllInterfaces && iGetCurTotalAnimInterfaces() > 1
      Debug.trace("Simple Prostitution: retrying with other interfaces.")
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
      Debug.trace("Simple Prostitution: couldn't find any suitable animation.")
      result = playerSexSFW(akActor)
    endIf
  endif
  return result
endfunction


Actor[] function formListToActorArray(FormList actorList)
Actor[] actors
int iSize =  actorList.GetSize()
if iSize == 1
  actors = new Actor[1]
elseif iSize == 2
  actors = new Actor[2]
elseif iSize == 3
  actors = new Actor[3]
elseif iSize >= 4
  actors = new Actor[4]
else
  return actors
endif
int i = 0
while i < iSize
  actors[i] = actorList.GetAt(i) as Actor
  i += 1
endWhile
return actors
endFunction

Bool Function bHaveGroupSex(String interface, Bool bAllowAggressive = False, Bool bAllowAll = False)
  if !currentCustomerList.GetSize()
    return false
  endif
  Bool bResult = False
  actor[] Partners = formListToActorArray(currentCustomerList)
  int iIndex = partners.Length
  while iIndex > 0
    iIndex -= 1
    (Partners[iIndex] as ObjectReference).MoveToIfUnloaded(player as ObjectReference)
  endWhile
  utility.wait(0.2)
  if interface == ""
    Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
    FastFadeOut.Apply()
    Utility.Wait(1.0)
    FastFadeOut.PopTo(BlackScreen)
    iIndex = partners.Length
    while iIndex > 0
      iIndex -= 1
      if partners[iIndex] != player
        partners[iIndex].EnableAI(False)
      endif
    endWhile
    Utility.Wait(5.0)
    iIndex = partners.Length
    while iIndex > 0
      iIndex -= 1
      partners[iIndex].EnableAI(True)
    endWhile
    BlackScreen.PopTo(FadeIn)
    Game.EnablePlayerControls()
    registerForSingleUpdate(1.0)
    return True
  else
    bResult = False
    while !bResult && (currentCustomerList.GetSize() > 0)
      if (currentCustomerList.GetSize() == 1) && (currentCustomerList.GetAt(0) as Actor) && (origCustomersArr.Find(currentCustomerList.GetAt(0) as Actor) > -1)
        iIndex = origCustomersArr.Find(currentCustomerList.GetAt(0) as Actor)
        iPosition = iPositions[iIndex]
        if iPosition < 0
          iPosition = randInt(0,2)
        endif
        int iResult = haveSex(currentCustomerList.GetAt(0) as Actor, interface, bAllowAggressive, bAllowAll)
        iPositions[iIndex] = iResult
        bResult = (iResult > -1)
      else
        if interface == "sexlab"
          bResult = playerGroupSexSL(partners ,bAllowAggressive)
          if !bResult
            if bTryAllInterfaces
              bResult = playerGroupSexOS(partners ,bAllowAggressive)
              if !bResult
                bResult = playerGroupSexFG(partners)
              endif
            endif
            if !bResult
              currentCustomerList.RemoveAddedForm(currentCustomerList.GetAt(currentCustomerList.GetSize() - 1))
              partners = formListToActorArray(currentCustomerList)
            endif
          endif
        elseif interface == "ostim"
          bResult = playerGroupSexOS(partners ,bAllowAggressive)
          if !bResult
            if bTryAllInterfaces
              bResult = playerGroupSexSL(partners ,bAllowAggressive)
              if !bResult
                bResult = playerGroupSexFG(partners)
              endif
            endif
            if !bResult
              currentCustomerList.RemoveAddedForm(currentCustomerList.GetAt(currentCustomerList.GetSize() - 1))
              partners = formListToActorArray(currentCustomerList)
            endif
          endif
        elseif interface == "flowergirls"
          bResult = playerGroupSexFG(partners)
          if !bResult
            if bTryAllInterfaces
              bResult = playerGroupSexOS(partners ,bAllowAggressive)
              if !bResult
                bResult = playerGroupSexSL(partners)
              endif
            endif
            if !bResult
              currentCustomerList.RemoveAddedForm(currentCustomerList.GetAt(currentCustomerList.GetSize() - 1))
              partners = formListToActorArray(currentCustomerList)
            endif
          endif
        endif
      endif
    endwhile
    return bResult
  endif
EndFunction

Bool Function playerGroupSexOS(Actor[] akActors, Bool bAllowAggressive= False)
  if !bIsOstimActive
    return False
  endif
  if OStimInterface.bHaveGroupSexWithPlayer(akActors, bAllowAggressive)
    RegisterForModEvent("ostim_end", "on_spp_ostim_Sex_End")
    return True
  endif
  return False
EndFunction

Bool Function playerGroupSexFG(Actor[] akActors)
  if !bIsFlowerGirlsActive
    return False
  endif
  if FlowerGirlsInterface.bHaveGroupSexWithPlayer(akActors)
    registerForSingleUpdate(1.0)
    return true
  endif
  return False
EndFunction

Bool Function playerGroupSexSL(Actor[] akActors, Bool bAllowAggressive= False)
  if !bIsSexlabActive
    return False
  endif
  if SexLabInterface.bHaveGroupSexWithPlayer(akActors, bAllowAggressive)
   RegisterForModEvent("AnimationEnding", "on_spp_sexlab_Sex_Ending")
   RegisterForModEvent("HookAnimationEnd", "on_spp_sexlab_Sex_End")
   return True
 endif
 return False
EndFunction

function startSnitchFinder(Bool bCheckDibel)
  int handle = ModEvent.Create("SPP_StartFindSnitch")
  ModEvent.PushForm(handle, self as Quest)
  ModEvent.PushBool(handle, bCheckDibel)
  ModEvent.Send(Handle)
EndFunction

Function setWhoreCustomer(Actor akActor, Bool bPay = False, Bool bPersuaded = True)
  int iPayment = 0
  customerSpell.Cast(akActor, akActor)
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iWhorePosition = positionChooser(0, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    else
      iWhorePosition = positionChooser(fWhoreVagChance as Int, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    endif
    if iWhorePosition > -1
      iPayment = payWhore(player, iWhorePosition)
      if bPersuaded
        persuade(fWhorePersuasionXPMult)
      endif
    endif
  endIf
  if iWhorePositions.length != 4
    iWhorePositions = new int[4]
    iWhorePositions[0] = -1
    iWhorePositions[1] = -1
    iWhorePositions[2] = -1
    iWhorePositions[3] = -1
  endif
  if iWhorePosition > -1
    if whoreCustomerList.GetSize() == 0
      whoreCustomerAlias.ForceRefTo(akActor)
      iWhorePositions[0] = iWhorePosition
      iPaidGoldCustomer1 = iPayment
      iPaidGoldAllCustomers += iPaidGoldCustomer1 
    elseif whoreCustomerList.GetSize() == 1
      whoreCustomerAlias2.ForceRefTo(akActor)
      iWhorePositions[1] = iWhorePosition
      iPaidGoldCustomer2 = iPayment
      iPaidGoldAllCustomers += iPaidGoldCustomer2
    elseif whoreCustomerList.GetSize() == 2
      whoreCustomerAlias3.ForceRefTo(akActor)
      iWhorePositions[2] = iWhorePosition
      iPaidGoldCustomer3 = iPayment
      iPaidGoldAllCustomers += iPaidGoldCustomer3
    elseif whoreCustomerList.GetSize() == 3
      whoreCustomerAlias4.ForceRefTo(akActor)
      iWhorePositions[3] = iWhorePosition
      iPaidGoldCustomer4 = iPayment
      iPaidGoldAllCustomers += iPaidGoldCustomer4
    endif
    akActor.EvaluatePackage()
    whoreCustomerList.AddForm(akActor)
    iTotalWhoreCustomers = whoreCustomerList.GetSize()
  endif
EndFunction

Function setDibelCustomer(Actor akActor, bool bPay = true )
  customerSpell.Cast(akActor, akActor)
  int iPayment = 0
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
    else
      iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
    endif
    if iDibelPosition > -1
      iPayment = payDibel(player, iDibelPosition)
      persuade(fDibelPersuasionXPMult)
    endif
  endIf
  if iDibelPositions.length != 4
    iDibelPositions = new int[4]
    iDibelPositions[0] = -1
    iDibelPositions[1] = -1
    iDibelPositions[2] = -1
    iDibelPositions[3] = -1
  endif
  if iDibelPosition > -1
    if dibelCustomerList.GetSize() == 0
      dibelCustomerAlias.ForceRefTo(akActor)
      iDibelPositions[0] = iDibelPosition
      iPaidGoldDibelCustomer1 = iPayment
    elseif dibelCustomerList.GetSize() == 1
      dibelCustomerAlias2.ForceRefTo(akActor)
      iDibelPositions[1] = iDibelPosition
      iPaidGoldDibelCustomer2 = iPayment
    elseif dibelCustomerList.GetSize() == 2
      dibelCustomerAlias3.ForceRefTo(akActor)
      iDibelPositions[2] = iDibelPosition
      iPaidGoldDibelCustomer3 = iPayment
    elseif dibelCustomerList.GetSize() == 3
      dibelCustomerAlias4.ForceRefTo(akActor)
      iDibelPositions[3] = iDibelPosition
      iPaidGoldDibelCustomer4 = iPayment
    endif
    akActor.EvaluatePackage()
    dibelCustomerList.AddForm(akActor)
    iTotalDibelCustomers = dibelCustomerList.GetSize()
  endif
EndFunction

Function setRejectingCustomerResult(Actor akActor, Bool bDibel = False, Bool bBeggar = False, Bool bApproach = False)
  bIsBusy = true
  int iRand 
  bRejectAssaultRape = False
  bRejectAssaultTheft = False
  Bool bFemaleNPC = akActor.GetLeveledActorBase().GetSex()
  iRejectAcceptChance = 0
  iRejectReportChance = 0
  iRejectTheftChance = 0
  iRejectAssaultChance = 0
  iRejectSlaveryChance = 0
  iRejectRapeChance = 0
  if bDibel
    if bFemaleNPC
      iRejectAcceptChance = fDibelRejectFemaleAcceptChance as Int
      iRejectReportChance = fDibelRejectFemaleReportChance as Int
      iRejectTheftChance = fDibelRejectFemaleTheftChance as Int
      iRejectAssaultChance = fDibelRejectFemaleAssaultChance as Int
      iRejectSlaveryChance = fDibelRejectFemaleSlaveryChance as Int
      iRejectRapeChance = fDibelRejectFemaleRapeChance as Int
    else
      iRejectAcceptChance = fDibelRejectMaleAcceptChance as Int
      iRejectReportChance = fDibelRejectMaleReportChance as Int
      iRejectTheftChance = fDibelRejectMaleTheftChance as Int
      iRejectAssaultChance = fDibelRejectMaleAssaultChance as Int
      iRejectSlaveryChance = fDibelRejectMaleSlaveryChance as Int
      iRejectRapeChance = fDibelRejectMaleRapeChance as Int
    endif
    bRejectTheftOnlyGold = bDibelRejectTheftOnlyGold
  elseif bBeggar
    if bFemaleNPC
      iRejectAcceptChance = fBeggarRejectFemaleAcceptChance as Int
      iRejectReportChance = 0
      iRejectTheftChance = fBeggarRejectFemaleTheftChance as Int
      iRejectAssaultChance = fBeggarRejectFemaleAssaultChance as Int
      iRejectSlaveryChance = fBeggarRejectFemaleSlaveryChance as Int
      iRejectRapeChance = fBeggingFemaleRapistChance as Int
    else
      iRejectAcceptChance = fBeggarRejectMaleAcceptChance as Int
      iRejectReportChance = 0
      iRejectTheftChance = fBeggarRejectMaleTheftChance as Int
      iRejectAssaultChance = fBeggarRejectMaleAssaultChance as Int
      iRejectSlaveryChance = fBeggarRejectMaleSlaveryChance as Int
      iRejectRapeChance = fBeggingMaleRapistChance as Int
    endif
    bRejectTheftOnlyGold = bBeggarRejectTheftOnlyGold
  else
    if bFemaleNPC
      iRejectAcceptChance = fWhoreRejectFemaleAcceptChance as Int
      iRejectReportChance = fWhoreRejectFemaleReportChance as Int
      iRejectTheftChance = fWhoreRejectFemaleTheftChance as Int
      iRejectAssaultChance = fWhoreRejectFemaleAssaultChance as Int
      iRejectSlaveryChance = fWhoreRejectFemaleSlaveryChance as Int
      iRejectRapeChance = fWhoreRejectFemaleRapeChance as Int
    else
      iRejectAcceptChance = fWhoreRejectMaleAcceptChance as Int
      iRejectReportChance = fWhoreRejectMaleReportChance as Int
      iRejectTheftChance = fWhoreRejectMaleTheftChance as Int
      iRejectAssaultChance = fWhoreRejectMaleAssaultChance as Int
      iRejectSlaveryChance = fWhoreRejectMaleSlaveryChance as Int
      iRejectRapeChance = fWhoreRejectMaleRapeChance as Int
    endif
    bRejectTheftOnlyGold = bWhoreRejectTheftOnlyGold
  endif

  if akActor.isGuard()
    iRejectTheftChance = 0
    iRejectAssaultChance = 0
    iRejectSlaveryChance = 0
    iRejectRapeChance = 0
  endif

  if !bCanAssault(akActor)
    iRejectAssaultChance = 0
    iRejectSlaveryChance = 0  
  endif

  if bApproach
    iRejectReportChance = 0
  endif
  
  int[] resultWeights = new int[7]
  resultWeights[0] = iRejectAcceptChance
  resultWeights[1] = iRejectReportChance
  resultWeights[2] = iRejectTheftChance
  resultWeights[3] = iRejectAssaultChance
  resultWeights[4] = iRejectSlaveryChance
  resultWeights[5] = iRejectRapeChance
  resultWeights[6] = minInt(iRejectRapeChance,iRejectTheftChance)
  iRand = weightedRandInt(resultWeights)

  if (iRand == 3) ;Assault
    bRejectAssaultRape = (randInt(0, 99) < iRejectRapeChance)
    bRejectAssaultTheft = (randInt(0, 99) < iRejectTheftChance)
  elseif (iRand == 4) ;Slavery
    bRejectAssaultTheft = (randInt(0, 99) < iRejectTheftChance)
  endif

  if iRand > 0
    iWhoringRejectResult = iRand
  else
    iWhoringRejectResult = 0
  endif
  bDibelReject = bDibel
  bBeggarReject = bBeggar
  bIsBusy = false
endfunction

Function rejectCusomer(Actor akCustomer)
  bIsBusy = true
  int iWhatToDo
  if bDibelReject
    if dibelCustomerAlias.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldDibelCustomer1
    endif
    if dibelCustomerAlias2.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldDibelCustomer2
    endif
    if dibelCustomerAlias3.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldDibelCustomer3
    endif
    if dibelCustomerAlias4.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldDibelCustomer4
    endif
  elseif bBeggarReject
    iTotalCustomerPaidGold = player.getItemCount(Gold)
  else
    if whoreCustomerAlias.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldCustomer1
    endif
    if whoreCustomerAlias2.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldCustomer2
    endif
    if whoreCustomerAlias3.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldCustomer3
    endif
    if whoreCustomerAlias4.getActorReference()
      iTotalCustomerPaidGold += iPaidGoldCustomer4
    endif
  endif
  iWhatToDo = iWhoringRejectResult
  if bDibelReject && akCustomer.IsInFaction(DibelCustomerFaction)
    clearDibelCustomers()
    clearDibelPositions()
  elseif !bBeggarReject && akCustomer.IsInFaction(WhoreCustomerFaction)
    clearWhoreCustomers() 
    clearWhorePositions()
  endif   
  if (iWhatToDo == 0)
    if !bBeggarReject
      player.removeItem(gold, iTotalCustomerPaidGold, false, akCustomer)
    endif
  elseif iWhatToDo == 1
    if bDibelReject
      if !isSnitchOK(angryDibelCustomer)
        angryDibelCustomer = akCustomer
      endif
    elseif !bBeggarReject
      if !isSnitchOK(angryWhoreCustomer)
        angryWhoreCustomer = akCustomer
      endif
    endif
  elseif iWhatToDo == 2
    if akCustomer.IsOnMount()
      akCustomer.Dismount()
      Utility.wait(3.0)
    endif
    debug.sendanimationevent(akCustomer, "idleforcedefaultstate")
    utility.wait(1.0)
    akCustomer.DrawWeapon()
    utility.wait(0.5)
    StaggerSpell.Cast(player)
    stealFromPlayer(akCustomer)
  elseif (iWhatToDo == 3 || iWhatToDo == 4)
    AssaultPlayer(akCustomer, (iWhatToDo == 4), bRejectAssaultRape, bRejectAssaultTheft)
  elseif iWhatToDo == 5
    rapePlayer(akCustomer)
  elseif iWhatToDo == 6
    if akCustomer.IsOnMount()
      akCustomer.Dismount()
      Utility.wait(3.0)
    endif
    debug.sendanimationevent(akCustomer, "idleforcedefaultstate")
    utility.wait(1.0)
    akCustomer.DrawWeapon()
    utility.wait(0.5)
    StaggerSpell.Cast(player)
    stealFromPlayer(akCustomer)
    Utility.wait(0.5)
    rapePlayer(akCustomer)
  endif
  bIsBusy = false
EndFunction

Function AssaultPlayer(Actor akAssaulter, Bool bEnslave = false, Bool bRape = false, Bool bSteal = false)
  Debug.SetGodMode(true)
  Game.setPlayerAiDriven(true)
  if akAssaulter.IsOnMount()
    akAssaulter.Dismount()
    Utility.wait(3.0)
  endif
  debug.sendanimationevent(akAssaulter, "idleforcedefaultstate")
  utility.wait(1.0)
  akAssaulter.SetDontMove(true)
  Bool bRobbed = False
  if bSteal && randInt(0,1)
    akAssaulter.DrawWeapon()
    utility.wait(0.5)
    StaggerSpell.Cast(player)
    stealFromPlayer(akAssaulter)
    bRobbed = true
  endif
  utility.wait(0.5)
  Assaulter.ForceRefTo(akAssaulter)
  bIsPapyrusUtilActive && ActorUtil.AddPackageOverride(akAssaulter as Actor, drawWeapon, 1)
  (akAssaulter as Actor).EvaluatePackage()
  Player.setposition(akAssaulter.GetPositionX() + 75 * math.sin(akAssaulter.GetAngleZ()), akAssaulter.GetPositionY() + 75 * math.cos(akAssaulter.GetAngleZ()), akAssaulter.GetPositionZ())
  Player.SetAngle(akAssaulter.GetAngleX(), akAssaulter.GetAngleY(), akAssaulter.GetAngleZ() + 180)
  utility.wait(0.5)
  if !akAssaulter.isWeaponDrawn()
    akAssaulter.DrawWeapon()
  endif
  form weap
  if bEnslave
    weap = akAssaulter.GetEquippedObject(1)
    if weap
      akAssaulter.UnequipItemEx(weap, 1)
    endif
  endif
  utility.wait(1.5)
  Debug.sendAnimationEvent(akAssaulter, "attackStart")
  float fwaitedTime = 0.0
  While !akAssaulter.GetAnimationVariableBool("IsAttacking") && (fWaitedTime < 12.0)
   Debug.sendAnimationEvent(akAssaulter, "attackStart")
   utility.wait(0.2)
   fWaitedTime += 0.2
  endWhile
  utility.wait(0.5)
  player.PushActorAway(player, 0)
  player.SetActorValue("Paralysis", 0)
  ;ParalyzeSpell.Cast(player)
  utility.wait(4.0)
  String sAnimInterface
  if bRape
    sAnimInterface = sGetCurAnimInteface(true)
  endif
  Bool bBlackScreen = False
  if sAnimInterface == "flowergirls"
  elseif sAnimInterface == "ask"
  else
    FastFadeOut.Apply()
    Utility.Wait(1.0)
    FastFadeOut.PopTo(BlackScreen)
    bBlackScreen = true
  endif
  if weap
    akAssaulter.equipItemEx(weap, 1)
  endif
  akAssaulter.SetDontMove(false)
  Assaulter.Clear()
  bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(akAssaulter as Actor, drawWeapon)
  (akAssaulter as Actor).EvaluatePackage()
  utility.wait(5.0)
  if player.GetActorValue("paralysis")
    if player.GetActorValue("paralysis")
      player.ForceActorValue("paralysis", 0)
    endif
  endif
  if bSteal && !bRobbed
    stealFromPlayer(akAssaulter)
  endif
  if !bEnslave && bRape && sAnimInterface
    Game.setPlayerAiDriven(false)
    player.SetDontMove(true)
    utility.wait(4.0)
    player.SetDontMove(false)
    rapePlayer(akAssaulter)
    utility.wait(8.0)
  else
    utility.wait(4.0)
  endif
  if bEnslave
    Game.setPlayerAiDriven(false)
    utility.wait(4.0)
    player.SetDontMove(false)
    Debug.SetGodMode(false)
    sendModEvent("SSLV Entry")
    if bBlackScreen
      BlackScreen.PopTo(FadeIn)
    endif
  else
    Float fOldHP = player.GetActorValue("Health")
    Float fNewHP = maxFloat(40.0, ((player.GetBaseActorValue("Health") * 0.5) - 10.0))
    if fOldHP > fNewHP
      player.DamageActorValue("Health", fOldHP - fNewHP)
    else
      player.RestoreActorValue("Health", fNewHP - fOldHP)
    endif
    Game.setPlayerAiDriven(false)
    player.SetDontMove(false)
    Debug.SetGodMode(false)
    if bBlackScreen
      BlackScreen.PopTo(FadeIn)
    endif
  endif
endFunction

Bool Function stealFromPlayer(Actor Thief)
  Int iGoldToRemove = 0
  Form itemToRob
  Int iMaxGold = player.getItemCount(Gold)
  Bool bRobbed = False 
  if iTotalCustomerPaidGold < iMaxGold
    iGoldToRemove = randInt(iTotalCustomerPaidGold, iMaxGold)
  else
    iGoldToRemove = iMaxGold   
  endif
  if iGoldToRemove > 0
    player.removeItem(gold, iGoldToRemove, false, Thief)
    Debug.trace("Simple Prostitution: " + Thief + " : " + Thief.GetBaseObject().GetName() + " stole " + iGoldToRemove + " septim.")
    bRobbed = true
  endif
  Form[] QuestItemsArr
  if !bRejectTheftOnlyGold && ((randInt(0,99) < iRejectTheftChance) || (iGoldToRemove < iTotalCustomerPaidGold))
    itemToRob = player.GetWornForm(Armor.GetMaskForSlot(32))
    if itemToRob && !hasInvalidKeyword(itemToRob) && (itemToRob.GetGoldValue() > 0)
      player.removeItem(itemToRob, 1, false, Thief)
      Debug.trace("Simple Prostitution: " + Thief + " : " + Thief.GetBaseObject().GetName() + " stole " + itemToRob)
      bRobbed = true
    else
      if bIsPapyrusUtilActive
        QuestItemsArr = PO3_SKSEFunctions.GetQuestItems(player As ObjectReference)
      else
        return bRobbed
      endif
      itemToRob = None
      int iIndex = 30
      while iIndex < 60
        if (iIndex != 50) && (iIndex != 51) && (iIndex != 32) ;50=DecapitateHead 51=Decapitate 61=FX01
          itemToRob = player.GetWornForm(Armor.GetMaskForSlot(iIndex))
          if (itemToRob As Armor) && itemToRob.GetName()
            if (QuestItemsArr.Find(itemToRob) > -1)
            elseif itemToRob.HasKeywordString("zad_inventorydevice")
            elseif itemToRob.HasKeywordString("zzzmoa_ignoreitem")
            elseif itemToRob.HasKeywordString("sos_underwear")
            elseif itemToRob.HasKeywordString("zbfworndevice")
            elseif itemToRob.HasKeywordString("zad_questitem")
            elseif itemToRob.HasKeywordString("zad_lockable")
            elseif itemToRob.HasKeywordString("sos_genitals")
            elseif itemToRob.HasKeywordString("toystoy")
            else
             if itemToRob.GetGoldValue() > 0
               player.removeItem(itemToRob, 1, false, Thief)
               Debug.trace("Simple Prostitution: " + Thief + " stole " + itemToRob)
               bRobbed = true
             elseif !itemToRob.HasKeywordString("ostimnostrip") && !itemToRob.HasKeywordString("sexlabnostrip")
               player.UnequipItemSlot(iIndex)
               utility.wait(0.5)
             endif
           endif
         endif
       EndIf
       iIndex += 1
     endWhile
   endif
   if !bRejectTheftOnlyGold && !bRobbed ||  (randInt(0,99) < iRejectTheftChance)
     if bIsPyramidUtilsOK && bIsPapyrusUtilActive
       keyword[] forbidenkw
       form[] items = PyramidUtils.GetItemsByKeyword(player, forbidenkw)
       if forbidenArmorKeywords.length != 8
        forbidenArmorKeywords = new keyword[8]
        forbidenArmorKeywords[0] = keyword.GetKeyword("zad_inventorydevice")
        forbidenArmorKeywords[1] = keyword.GetKeyword("zzzmoa_ignoreitem")
        forbidenArmorKeywords[2] = keyword.GetKeyword("sos_underwear")
        forbidenArmorKeywords[3] = keyword.GetKeyword("zbfworndevice")
        forbidenArmorKeywords[4] = keyword.GetKeyword("zad_questitem")
        forbidenArmorKeywords[5] = keyword.GetKeyword("zad_lockable")
        forbidenArmorKeywords[6] = keyword.GetKeyword("sos_genitals")
        forbidenArmorKeywords[7] = keyword.GetKeyword("toystoy")
      endif
      forbidenkw = forbidenArmorKeywords
      items = PyramidUtils.FilterFormsByKeyword(items, forbidenkw, false, true)
      items = PyramidUtils.FilterFormsByGoldValue(items, 1)
      Int iVal
      int j
      int i = 0
      itemToRob = None ;check 10 random items and 10 sequenced items
      int iLen = items.Length
      int m = minInt(iLen, 10)
      int k = randInt(0, iLen - 1)
      while (i < m )
        j = randInt(0, iLen - 1) 
        if items[j] && (QuestItemsArr.find(items[j]) < 0) && (player.getItemCount(items[j]) > 0)
          if items[j].GetGoldValue() > iVal
            itemToRob = items[j]
            iVal = items[j].GetGoldValue()
          endif
        endif
        if (k < iLen) && (k != j)
          if items[k] && (QuestItemsArr.find(items[k]) < 0) && (player.getItemCount(items[k]) > 0)
            if items[k].GetGoldValue() > iVal
              itemToRob = items[k]
              iVal = items[k].GetGoldValue()
            endif
          endif
        endif
        i += 1
        k += 1
      endwhile
      if iVal > 0
        player.removeItem(itemToRob, 1, false, thief)
        Debug.trace("Simple Prostitution: " + Thief + " : " + Thief.GetBaseObject().GetName() + " stole " + itemToRob)
        bRobbed = true
      endif
    endif
  endif
EndIf
return bRobbed
EndFunction

Bool Function hasInvalidKeyword(Form kItem)
  if kItem.HasKeywordString("vendornosale")
    return true
  endif
  if kItem.HasKeywordString("magicdisallowenchanting")
    return true
  endif
  if kItem.HasKeywordString("sos_underwear")
    return true
  endif
  if kItem.HasKeywordString("sos_genitals")
    return true
  endif
  if kItem.HasKeywordString("zad_questitem")
    return true
  endif
  if kItem.HasKeywordString("zad_lockable")
    return true
  endif 
  if kItem.HasKeywordString("zad_inventorydevice")
    return true
  endif 
  if kItem.HasKeywordString("zbfworndevice")
    return true
  endif 
  if kItem.HasKeywordString("toystoy")
    return true
  endif 
  return False
endfunction

function ProstitutePlayerTo(Actor akCustomer, bool bAccept=true)
  setGlobalVaues()
  if akCustomer
    customerSpell.Cast(akCustomer, akCustomer)
    if !bAccept
      if !isSnitchOK(whoreSnitch) && !playerHasWhoreLicense()
        checkSnitch(akCustomer, false, false)
      endif
      return
    endif
    endDialogueWithPlayer(akCustomer as ObjectReference)
    GoToState("Whoring")
  else
    clearWhorePositions()
  endif
endfunction

function playerPracticeDibelArtWith(Actor akActor, bool bAccept=true)
  setGlobalVaues()
  if akActor
    customerSpell.Cast(akActor, akActor)
    if !bAccept
      if !isSnitchOK(dibelSnitch) && !playerHasDibelLicence()
        checkSnitch(akActor)
      endif
      return
    endif
    endDialogueWithPlayer(akActor as ObjectReference)
    GoToState("Dibeling")
  else
    clearDibelPositions()
  endif
endfunction

Function clearCustomer()
  Actor Customer = dibelCustomerAlias.getActorReference()
  if Customer
    dibelCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias2.getActorReference()
  if Customer
    dibelCustomerAlias2.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias3.getActorReference()
  if Customer
    dibelCustomerAlias3.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias4.getActorReference()
  if Customer
    dibelCustomerAlias4.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias.getActorReference()
  if Customer
    whoreCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias2.getActorReference()
  if Customer
    whoreCustomerAlias2.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias3.getActorReference()
  if Customer
    whoreCustomerAlias3.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias4.getActorReference()
  if Customer
    whoreCustomerAlias4.Clear()
    Customer.EvaluatePackage()
  endif
  whoreCustomerList.revert()
  dibelCustomerList.Revert()
  iTotalWhoreCustomers = 0
  iTotalDibelCustomers = 0
EndFunction

Function clearDibelCustomers()
  Actor Customer = dibelCustomerAlias.getActorReference()
  if Customer
    dibelCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias2.getActorReference()
  if Customer
    dibelCustomerAlias2.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias3.getActorReference()
  if Customer
    dibelCustomerAlias3.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = dibelCustomerAlias4.getActorReference()
  if Customer
    dibelCustomerAlias4.Clear()
    Customer.EvaluatePackage()
  endif
  dibelCustomerList.Revert()
  iTotalDibelCustomers = 0
  iPaidGoldDibelCustomer1 = 0
  iPaidGoldDibelCustomer2 = 0
  iPaidGoldDibelCustomer3 = 0
  iPaidGoldDibelCustomer4 = 0
  iPaidGoldAllDibelCustomers = 0
EndFunction

Function clearWhoreCustomers()
  Actor Customer = whoreCustomerAlias.getActorReference()
  if Customer
    whoreCustomerAlias.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias2.getActorReference()
  if Customer
    whoreCustomerAlias2.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias3.getActorReference()
  if Customer
    whoreCustomerAlias3.Clear()
    Customer.EvaluatePackage()
  endif
  Customer = whoreCustomerAlias4.getActorReference()
  if Customer
    whoreCustomerAlias4.Clear()
    Customer.EvaluatePackage()
  endif
  whoreCustomerList.revert()
  iTotalWhoreCustomers = 0
  iPaidGoldCustomer1 = 0
  iPaidGoldCustomer2 = 0
  iPaidGoldCustomer3 = 0
  iPaidGoldCustomer4 = 0
  iPaidGoldAllCustomers = 0
EndFunction

function clearPositions()
  iPosition = -1
  iWhorePosition = -1
  iDibelPosition = -1
  clearWhorePositions()
  clearDibelPositions()
endFunction

function clearWhorePositions()
  iPosition = -1
  iWhorePosition = -1
  int i = iWhorePositions.Length
  while i > 0
    i -= 1
    iWhorePositions[i] = -1
  endWhile
endFunction

function clearDibelPositions()
  iPosition = -1
  iDibelPosition = -1
  int i = iDibelPositions.Length
  while i > 0
    i -= 1
    iDibelPositions[i] = -1
  endWhile
endFunction


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
    registerForSingleUpdate(1.0)
  endif
  return result
EndFunction

int function playerSexSFW(Actor akActor = None)
  if iPosition < 0
    return -1
  endif
  Game.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=False, abLooking=False, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=False, aiDisablePOVType=0)
  FastFadeOut.Apply()
  Utility.Wait(1.0)
  FastFadeOut.PopTo(BlackScreen)
  if akActor && (akActor != player)
    akActor.EnableAI(False)
  endif
  Utility.Wait(5.0)
  if akActor
    akActor.EnableAI(True)
  endif
  BlackScreen.PopTo(FadeIn)
  Game.EnablePlayerControls()
  registerForSingleUpdate(1.0)
  return iPosition
endfunction

Int function payBeggar(Actor beggar, Bool bBonus = True)
  Int minBonus = 0
  Int maxBonus = 0
  if bBonus
   minBonus = maxInt(0, ((beggar.getActorValue("Speechcraft") * fMinSpeechBegBonusMult) As Int) + 1)
   maxBonus = maxInt(0, ((beggar.getActorValue("Speechcraft") * fMaxSpeechBegBonusMult) As Int) + 1)
   minBonus = minInt(minBonus,maxBonus)
   maxBonus = maxInt(minBonus,maxBonus)
 endif
 int begPayMin = minInt(fBegPayMin As Int, fBegPayMax As Int)
 int begPayMax = maxInt(fBegPayMin As Int, fBegPayMax As Int)
 Int totalPay = maxInt(0, randInt(begPayMin, BegPayMax) + randInt(minBonus, maxBonus))
 totalPay = maxInt(0, totalPay)
 beggar.Additem(gold, totalPay)
 return totalPay
endfunction

Int function payDibel(Actor Dibel, int position)
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
  Int totalPay = positionReward + randInt(minBonus, maxBonus)
  totalPay = maxInt(0, totalPay)
  Dibel.Additem(gold, totalPay)
  return totalPay
endfunction

Int function payWhore(actor whore, int position)
  if !isWhoringAllowedInCurrentLocation
    return payBeggar(whore, True)
  endif
  int totalPay = 0
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
  totalPay = maxInt(0, positionReward + randInt(minBonus, maxBonus))
  if (fWhoreOwnerShare > 0.0) && Owner.getReference() &&  (Owner.getReference().getParentCell() == whore.getParentCell())
    iCurrentOwnerSeptims = iCurrentOwnerSeptims + totalPay
    currentOwnerSeptimDisplay.SetValueInt(iCurrentOwnerSeptims)
    UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    pimpTracker.UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
    Debug.Notification(totalPay + " septim added to " + Owner.getActorReference().getLeveledActorBase().getName())
  elseif isWhoringAlwaysAllowedInCurrentLocation || (Owner.getReference() && (Owner.getReference().getParentCell() == whore.getParentCell()))
   whore.Additem(gold, totalPay)
 else
  totalPay = payBeggar(whore, True)
endif
return totalPay
endfunction

String function sGetCurAnimInteface(Bool bDontAsk = False)
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
      return intefs[randInt(0, len - 1)]
    elseif MCMScript.iAnimInterfaceMethod == 1 ;ask
      if bDontAsk
        return "ask"
      else
        interf = InterfaceMenu.Show()
      endif
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

function setGlobalVaues()
  WhoreFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iWhoreSpeechDifficulty))
  DibelFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iDibelSpeechDifficulty))
  BeggarFailureChance.SetValueInt(maxInt(0, 16 * MCMScript.iBeggarSpeechDifficulty))
  BeggarNoSexOfferChance.SetValueInt(maxInt(0, (100.0 - fBeggarSexOfferChance) as Int))
  ;NotFemaleCustomerApproach.SetValueInt(maxInt(0, (100.0 - fFemaleCustomerApproachChance) as Int))
  ;NotMaleCustomerApproach.SetValueInt(maxInt(0, (100.0 - fMaleCustomerApproachChance) as Int))
endfunction

Int function positionChooser(int vaginalWeight = 50, int AnalWeight = 50, int oralWeight = 50)
  if (vaginalWeight < 1) && (AnalWeight < 1) && (oralWeight < 1)
    return -1
  endif
  int[] cumulWeight = Utility.createIntArray(3)
  cumulWeight[0] = vaginalWeight
  cumulWeight[1] = AnalWeight + vaginalWeight
  cumulWeight[2] = oralWeight + AnalWeight + vaginalWeight
  int x = randInt(1,cumulWeight[2])
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
  return papyrusutil.GetVersion() >= 40
EndFunction

Bool Function bCheckPO3Extender()
  int[] version = PO3_SKSEFunctions.GetPapyrusExtenderVersion()
  if version && (version.length == 3) && (version[0] > 4)
    return True
  endif
  return false
EndFunction

Bool Function bCheckPyramidUtils()
  return PyramidUtils.GetVersion() >= 0.002002
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
    if (randInt(0,999) / 10.0) < fGuardReportChance as int
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
  elseif ((randInt(0,999) / 10.0) < fCitizenReportChance as int)
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
  if whoreCustomerlist.hasform(npc)
    return false
  endif
  if dibelCustomerlist.hasform(npc)
    return false
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
  if (owner.getActorReference() != None) && (npc == owner.getActorReference())
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
  return (isDibel && !bDibelNeedLicense) || (!bWhoreNeedLicense || LicensesInterface.bHasWhoreLicense())
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
  if !isSnitchOK(angryWhoreCustomer)
    angryWhoreCustomer = None
  endif
  if !isSnitchOK(angryDibelCustomer)
    angryDibelCustomer = None
  endif
  if bIsLicensesActive
    if whoreSnitch
      if !inSameCell(player, whoreSnitch)
        snitch = whoreSnitch
        whoreSnitch = None
        dibelSnitch = None
      endif
    elseif dibelSnitch
      if !inSameCell(player, whoreSnitch)
        snitch = dibelSnitch
        whoreSnitch = None
        dibelSnitch = None
      endif
    endif
  endif
  if (whoreSnitch || dibelSnitch) || (!snitch && (angryWhoreCustomer || angryDibelCustomer)) ;Snitches can't report so checking angry customers
    if angryWhoreCustomer && !inSameCell(player, angryWhoreCustomer)
      snitch = angryWhoreCustomer
    elseif angryDibelCustomer && !inSameCell(player, angryDibelCustomer)
      snitch = angryDibelCustomer
    else
      RegisterForSingleUpdateGameTime(randInt(8,14) As Float)
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
    if ((snitch == angryDibelCustomer) || (snitch == angryWhoreCustomer)) || !LicensesInterface.bFlagWhoreViolation()
      if snitch.getcrimefaction()
        if !player.GetCurrentLocation() || !player.GetCurrentLocation().HasKeywordstring("loctypejail")
          snitch.getcrimefaction().ModCrimeGold(50)
        endIf
      endif
    endif
    whoreSnitch = None
    dibelSnitch = None
    angryDibelCustomer = None
    angryWhoreCustomer = None
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
      if !bSnitchFound && (snitchRef1.GetActorReference() != None)
        bSnitchFound = checkSnitch(snitchRef1.GetActorReference(), false, bCheckDibel)
        (snitchRef1.GetActorReference() != None) && snitchers.addform(snitchRef1.GetActorReference())
      endif
      if !bSnitchFound && (snitchRef2.GetActorReference() != None)
        bSnitchFound = checkSnitch(snitchRef2.GetActorReference(), false, bCheckDibel)
        (snitchRef2.GetActorReference() != None) && snitchers.addform(snitchRef2.GetActorReference())
      endif
      iIndex += 1
    endWhile
  else
    utility.Wait(3.0)
  endif
  While !snitchDetector.isRunning()
    utility.wait(0.2)
  endWhile
  if (snitchRef1.GetActorReference() != None)
    if !bSnitchFound
      bSnitchFound = checkSnitch(snitchRef1.GetActorReference(), false, bCheckDibel)
      (snitchRef1.GetActorReference() != None) && snitchers.addform(snitchRef1.GetActorReference())
    endif
  endif
  if (snitchRef2.GetActorReference() != None)
    if !bSnitchFound
      bSnitchFound = checkSnitch(snitchRef2.GetActorReference(), false, bCheckDibel)
      (snitchRef2.GetActorReference() != None) && snitchers.addform(snitchRef2.GetActorReference())
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

Float Function iRewardProgress(Int iPos, Bool bDibel = False)
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
  Int count = 0
  if arr 
    Int raceIndex = iTotalRaces - 1 ;last race is other races
    while raceIndex > 0
      raceIndex -= 1
      if arr[raceIndex] > 0
        count += 1
      endif
    endWhile
    return (count as Float / (iTotalRaces - 1) as Float)
  endif
  return 0.0
EndFunction

function addDibelMarkToPlayer(float fChance, int iNumPartners = 1)
  Int iAmount = 0
  int iIndex = iNumPartners
  while iIndex > 0
    iIndex -= 1
    if (randInt(0,999) / 10.0) < fChance as Int
      iAmount += 1 
    endif
  endWhile
  if iAmount > 0
    player.Additem(dibelMark, iAmount)
  endif
endFunction

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
    startInfectingPlayer(getState(), actorList.Length - 1)
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
      StartInfectingplayer(getState(), actorList.Length - 1)
    endif
  endif
endEvent

State Dibeling
  Event OnBeginState()
    bIsBusy = True
    isDibel = true
    if !isSnitchOK(dibelSnitch) && !playerHasDibelLicence()
      startSnitchFinder(true)
    endif
    origCustomersArr=formListToActorArray(dibelCustomerlist)
    Bool bResult = False
    int i = 0
    while (getState() == "Dibeling") && (dibelCustomerlist.GetSize() > 0)
      currentCustomerList.revert()
      i = 0
      while i < dibelCustomerlist.GetSize()
        if (dibelCustomerlist.getAt(i) as Actor) && !(dibelCustomerlist.getAt(i) as Actor).isDead()
          currentCustomerList.AddForm(dibelCustomerlist.getAt(i) as Actor)
        else
          dibelCustomerlist.RemoveAddedForm(dibelCustomerlist.getAt(i))
        endif
        i += 1
      endWhile
      if dibelCustomerlist.GetSize() > 0
        iPositions = iDibelPositions
        bResult = bHaveGroupSex(sGetCurAnimInteface(), bDibelAllowAggressive, bAllPosAllowed(fDibelVagChance,fDibelAnalChance,fDibelOralChance))
        if bResult
          i = 0
          int j = 0
          iDibelPartners = 0
          Actor partner
          while i < currentCustomerList.GetSize()
            partner = currentCustomerList.getAt(i) as Actor
            j = origCustomersArr.find(partner)
            if j > -1
              updateHistory(partner, iDibelPositions[j], True)
              iDibelPositions[j] = -1
              dibelCustomerlist.RemoveAddedForm(partner)
              iDibelPartners += 1
            endif
            i += 1
          endWhile
          currentCustomerList.revert()
          bDibelAnimEnded = False
          while !bDibelAnimEnded && (getState() == "Dibeling")
            utility.wait(0.2)
          endWhile
          utility.wait(3.0)
        else
          GoToState("")
        endif
      endif
    endWhile
    clearDibelCustomers()
    clearDibelPositions()
  EndEvent

  Event OnEndState()
    bIsBusy = False
  endEvent

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
      startInfectingPlayer(GetState(), iDibelPartners)
      bDibelAnimEnded = true
      if dibelCustomerlist.GetSize() == 0
        GoToState("")
      endif
      iDibelPartners = 0
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
    startInfectingPlayer(GetState(), iDibelPartners)
    bDibelAnimEnded = true
    if dibelCustomerlist.GetSize() == 0
      GoToState("")
    endif
    iDibelPartners = 0
  EndEvent
  
  event onUpdate()
    addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
    startInfectingPlayer(GetState(), iDibelPartners)
    bDibelAnimEnded = true
    if dibelCustomerlist.GetSize() == 0
      GoToState("")
    endif
    iDibelPartners = 0
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent
  
  function snitch()
  EndFunction

  Function offerDibelMarks(Actor akActor)
  endFunction

EndState

State Whoring
  Event OnBeginState()
    bIsBusy = True
    isWhore = True
    if !isSnitchOK(whoreSnitch) && !playerHasWhoreLicense()
      startSnitchFinder(false)
    endif
    origCustomersArr=formListToActorArray(whoreCustomerlist)
    Bool bResult = False
    int i = 0
    while (getState() == "Whoring") && (whoreCustomerlist.GetSize() > 0)
      currentCustomerList.revert()
      i = 0
      while i < whoreCustomerlist.GetSize()
        if (whoreCustomerlist.getAt(i) as Actor) && !(whoreCustomerlist.getAt(i) as Actor).isDead()
          currentCustomerList.AddForm(whoreCustomerlist.getAt(i) as Actor)
        else
          whoreCustomerlist.RemoveAddedForm(whoreCustomerlist.getAt(i))
        endif
        i += 1
      endWhile
      if (whoreCustomerlist.GetSize() > 0)
        iPositions = iWhorePositions
        bResult = bHaveGroupSex(sGetCurAnimInteface(), bWhoreAllowAggressive, bAllPosAllowed(fWhoreVagChance,fWhoreAnalChance,fWhoreOralChance))
        if bResult
          i = 0
          int j = 0
          actor partner
          iWhorePartners = 0
          while i < currentCustomerList.GetSize()
            partner = currentCustomerList.getAt(i) as Actor
            j = origCustomersArr.find(partner)
            if j > -1
              updateHistory(partner, iWhorePositions[j], False)
              iWhorePositions[j] = -1
              whoreCustomerlist.RemoveAddedForm(partner)
              iWhorePartners += 1
            endif
            i += 1
          endWhile
          currentCustomerList.revert()
          bWhoreAnimEnded = False
          while !bWhoreAnimEnded && (getState() == "Whoring")
            utility.wait(0.2)
          endWhile
          utility.wait(3.0)
        else
          GoToState("")
        endif
      endif
    endWhile
    clearWhoreCustomers()
    clearWhorePositions()
  EndEvent

  Event OnEndState()
    bIsBusy = False
  EndEvent

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
      startInfectingPlayer(GetState(), iWhorePartners)
      bWhoreAnimEnded = true
      if whoreCustomerlist.GetSize() == 0
        GoToState("")
      endif
      iWhorePartners = 0
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
    startInfectingPlayer(GetState(), iWhorePartners)
    bWhoreAnimEnded = true
    if whoreCustomerlist.GetSize() == 0
      GoToState("")
    endif
    iWhorePartners = 0
  EndEvent
  
  event onUpdate()
    addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
    startInfectingPlayer(GetState(), iWhorePartners)
    bWhoreAnimEnded = true
    if whoreCustomerlist.GetSize() == 0
      GoToState("")
    endif
    iWhorePartners = 0
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent
  
  function snitch()
  EndFunction

  Function offerDibelMarks(Actor akActor)
  endFunction

EndState

Auto State Init
  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
  EndEvent

  Event onInit()
    bIsBusy = True
    registerForSingleUpdate(5.0) 
  EndEvent

  event onUpdate()
    GoToState("")
  endEvent
  
  event OnEndState()
    While (!FlowerGirlsInterface.bChecked || !SexLabInterface.bChecked || !OStimInterface.bChecked || !LicensesInterface.bChecked || !DDI_Interface.bChecked)
      Utility.wait(0.2)
    endWhile
    if !ApproachMonitorQst.isRunning()
      ApproachMonitorQst.start()
    endif
    ;Debug.Trace("Simple Prostitution started.")
    Debug.Notification("Simple Prostitution started.")
    bIsBusy = False
  endevent

  function snitch()
  EndFunction

  Function offerDibelMarks(Actor akActor)
  endFunction
EndState

State offeringToDibella

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      STD_Script.cureActorSTDs(player, False)
      GoToState("")
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    STD_Script.cureActorSTDs(player, False)
    GoToState("")
  EndEvent
  
  event onUpdate()
    STD_Script.cureActorSTDs(player, False)
    GoToState("")
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent
  
  function snitch()
  EndFunction
  
  Function offerDibelMarks(Actor akActor)
  endFunction
EndState

State raped

  Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
  EndEvent
  
  event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
    if HasPlayer
      startInfectingPlayer("", 1)
      GoToState("")
    endif
  endEvent
  
  Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
    startInfectingPlayer("", 1)
    GoToState("")
  EndEvent
  
  event onUpdate()
    startInfectingPlayer("", 1)
    GoToState("")
  endEvent
  
  event OnUpdateGameTime()
    RegisterForSingleUpdateGameTime(1.0)
  endEvent

  event OnEndState()
    bIsBusy = false
  endEvent
  
  function snitch()
  EndFunction
  
  Function offerDibelMarks(Actor akActor)
  endFunction

  Function rapePlayer(Actor akAggressor)
  endFunction

EndState

Bool function GetDibellanRewards(Int aiMessage=0, Int aiButton=0)
  int iMarkCount = player.getItemCount(dibelMark)
  utility.wait(0.5)
  Bool bTraded = False
  While true
    if aiButton == -1
    elseif aiMessage == 0 ;Top
      aiButton = DibelOfferMenu.Show(iMarkCount, player.GetActorValue("CarryWeight") as Int)
      if aiButton == -1
      elseif aiButton == 0 ;Attribute
        if iMarkCount < fAttributeCost as Int
          DibelOfferMenu_InsufficientMark.Show(fAttributeCost as Int, iMarkCount)
          aiMessage = 0
        else
          aiMessage = 1
        endif
      elseif aiButton == 1 ;CarryWeight
        if iMarkCount < fCarryWeightCost as Int
          DibelOfferMenu_InsufficientMark.Show(fCarryWeightCost as Int, iMarkCount)
          aiMessage = 0
        elseif DibelOfferMenu_Confirm_CarryWeight.Show(fCarryWeightCost as Int, fCarryWeightIncrement as Int) == 0
          player.ModActorValue("CarryWeight", fCarryWeightIncrement as Int)
          MCMScript.iTotalCarryWeightRecieved += fCarryWeightIncrement as Int
          player.removeItem(dibelMark, fCarryWeightCost as Int)
          MCMScript.iTotalRefundableOfferedMarks += fCarryWeightCost as Int
          MCMScript.iTotalOfferedMarks += fCarryWeightCost as Int
          iMarkCount = player.getItemCount(dibelMark)
          DibelOfferMenu_CarryWeight_Changed.Show(fCarryWeightIncrement as Int)
          bTraded = True
          if iMarkCount < fCarryWeightCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 2 ;skill level
        if iMarkCount < fSkillLevelCost as Int
          DibelOfferMenu_InsufficientMark.Show(fSkillLevelCost as Int, iMarkCount)
          aiMessage = 0
        else
          aiMessage = 2
        endif
      elseif aiButton == 3 ;perk point
        if iMarkCount < fPerkPointCost as Int
          DibelOfferMenu_InsufficientMark.Show(fPerkPointCost as Int, iMarkCount)
          aiMessage = 0
        elseif DibelOfferMenu_Confirm_Perk.Show(fPerkPointCost as Int, fPerkPointIncrement as Int) == 0
          Game.AddPerkPoints(fPerkPointIncrement as Int)
          MCMScript.iTotalPerkPointRecieved += fPerkPointIncrement as Int
          player.removeItem(dibelMark, fPerkPointCost as Int)
          ;MCMScript.iTotalRefundableOfferedMarks += fPerkPointCost as Int
          MCMScript.iTotalOfferedMarks += fPerkPointCost as Int
          iMarkCount = player.getItemCount(dibelMark)
          DibelOfferMenu_Perk_Changed.Show(fPerkPointIncrement as Int)
          bTraded = True
          if iMarkCount < fPerkPointCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 4 ;DD key
        if iMarkCount < fDDKeyCost as Int
          DibelOfferMenu_InsufficientMark.Show(fDDKeyCost as Int, iMarkCount)
          aiMessage = 0
        elseif DibelOfferMenu_Confirm_DDKey.Show(fDDKeyCost as Int, fDDKeyIncrement as Int) == 0
          int iTotal = DDI_Interface.iAddRandomDDKeyToRef(player, fDDKeyIncrement as Int)
          if iTotal > 0
            MCMScript.iTotalDDKeyRecieved += iTotal
            player.removeItem(dibelMark, fDDKeyCost as Int)
            MCMScript.iTotalOfferedMarks += fDDKeyCost as Int
            iMarkCount = player.getItemCount(dibelMark)
            DibelOfferMenu_DDKEy_Changed.Show(iTotal as Int)
            bTraded = True
            if iMarkCount < fDDKeyCost as Int
              aiMessage = 0
            endif
          else
            aiMessage = 0
          endif
        endif
      elseif aiButton == 5 ;Exit
        return bTraded
      endif
    elseif aiMessage == 1 ;Attribute Menu
      aiButton = DibelOfferMenu_Attributes.Show(player.GetActorValue("Health") as Int, player.GetActorValue("Magicka") as Int, player.GetActorValue("Stamina") as Int)
      if aiButton == -1
      elseif (aiButton == 0) || (aiButton == 1) || (aiButton == 2)
       if iMarkCount < fAttributeCost as Int
        DibelOfferMenu_InsufficientMark.Show(fAttributeCost as Int, iMarkCount)
        aiMessage = 0 ;Top
      elseif aiButton == 0 ;Health
        if DibelOfferMenu_Confirm_Health.Show(fAttributeCost as Int, fAttributeIncrement as Int) == 0
          player.SetActorValue("Health", player.GetBaseActorValue("Health") + fAttributeIncrement as Int)
          MCMScript.iTotalHealthRecieved += fAttributeIncrement as Int
          player.removeItem(dibelMark, fAttributeCost as Int)
          MCMScript.iTotalRefundableOfferedMarks += fAttributeCost as Int
          MCMScript.iTotalOfferedMarks += fAttributeCost as Int
          iMarkCount = player.getItemCount(dibelMark)
          DibelOfferMenu_Health_Changed.Show(fAttributeIncrement as Int)
          bTraded = True
          if iMarkCount < fAttributeCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 1 ;Magicka
        if DibelOfferMenu_Confirm_Magicka.Show(fAttributeCost as Int, fAttributeIncrement as Int) == 0
          player.SetActorValue("Magicka", player.GetBaseActorValue("Magicka") + fAttributeIncrement as Int)
          MCMScript.iTotalMagickaRecieved += fAttributeIncrement as Int
          player.removeItem(dibelMark, fAttributeCost as Int)
          MCMScript.iTotalRefundableOfferedMarks += fAttributeCost as Int
          MCMScript.iTotalOfferedMarks += fAttributeCost as Int
          iMarkCount = player.getItemCount(dibelMark)
          DibelOfferMenu_Magicka_Changed.Show(fAttributeIncrement as Int)
          bTraded = True
          if iMarkCount < fAttributeCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 2 ;Stamina
        if DibelOfferMenu_Confirm_Stamina.Show(fAttributeCost as Int, fAttributeIncrement as Int) == 0
          player.SetActorValue("Stamina", player.GetBaseActorValue("Stamina") + fAttributeIncrement as Int)
          MCMScript.iTotalStaminaRecieved += fAttributeIncrement as Int
          player.removeItem(dibelMark, fAttributeCost as Int)
          MCMScript.iTotalRefundableOfferedMarks += fAttributeCost as Int
          MCMScript.iTotalOfferedMarks += fAttributeCost as Int
          iMarkCount = player.getItemCount(dibelMark)
          DibelOfferMenu_Stamina_Changed.Show(fAttributeIncrement as Int)
          bTraded = True
          if iMarkCount < fAttributeCost as Int
            aiMessage = 0
          endif
        endif
      endif  
    elseif aiButton == 3 ;Back
      aiMessage = 0 ;Top
    elseif aiButton == 4 ;Exit
      return bTraded
    endif
  elseif aiMessage == 2 ;Skills Type Menu
    if iMarkCount < fSkillLevelCost as Int
      DibelOfferMenu_InsufficientMark.Show(fSkillLevelCost as Int, iMarkCount)
      aiMessage = 0
    else
      aiButton = DibelOfferMenu_Skills.Show()
      if aiButton == -1
      elseif aiButton == 0 ;Combat Skills
        aiMessage = 3
      elseif aiButton == 1 ;Magic Skills
        aiMessage = 4
      elseif aiButton == 2 ;Stealth Skills
        aiMessage = 5
      elseif aiButton == 3 ;Back
        aiMessage = 0 ;Top
      elseif aiButton == 4 ;Exit
        return bTraded
      endIf
    endif
  elseif aiMessage == 3 ;Combat Skills Menu
    if iMarkCount < fSkillLevelCost as Int
      DibelOfferMenu_InsufficientMark.Show(fSkillLevelCost as Int, iMarkCount)
      aiMessage = 0
    else
      aiButton = DibelOfferMenu_Skills_Combat.Show(player.GetActorValue("Marksman") as Int, player.GetActorValue("Block") as Int, player.GetActorValue("HeavyArmor") as Int, player.GetActorValue("OneHanded") as Int, player.GetActorValue("Smithing") as Int, player.GetActorValue("TwoHanded") as Int)
      if aiButton == -1
      elseif aiButton < 6
        if DibelOfferMenu_Confirm_Skill.Show(fSkillLevelCost as Int, fSkillLevelIncrement as Int) == 0
          if aiButton == 0
            IncrementSkillLevel("Marksman")
          elseif aiButton == 1
            IncrementSkillLevel("Block")
          elseif aiButton == 2
            IncrementSkillLevel("HeavyArmor")
          elseif aiButton == 3
            IncrementSkillLevel("OneHanded")
          elseif aiButton == 4
            IncrementSkillLevel("Smithing")
          elseif aiButton == 5
            IncrementSkillLevel("TwoHanded")
          endif
          iMarkCount = player.getItemCount(dibelMark)
          bTraded = True
          if iMarkCount < fSkillLevelCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 6 ;Back
        aiMessage = 2 ;;Skills Type Menu
      elseif aiButton == 7 ;Exit
        return bTraded
      endif
    endif
  elseif aiMessage == 4 ;Magic Skills Menu
    if iMarkCount < fSkillLevelCost as Int
      DibelOfferMenu_InsufficientMark.Show(fSkillLevelCost as Int, iMarkCount)
      aiMessage = 0
    else
      aiButton = DibelOfferMenu_Skills_Magic.Show(player.GetActorValue("Alteration") as Int, player.GetActorValue("Conjuration") as Int, player.GetActorValue("Destruction") as Int, player.GetActorValue("Enchanting") as Int, player.GetActorValue("Illusion") as Int, player.GetActorValue("Restoration") as Int)
      if aiButton == -1
      elseif aiButton < 6
        if DibelOfferMenu_Confirm_Skill.Show(fSkillLevelCost as Int, fSkillLevelIncrement as Int) == 0
          if aiButton == 0
            IncrementSkillLevel("Alteration")
          elseif aiButton == 1
            IncrementSkillLevel("Conjuration")
          elseif aiButton == 2
            IncrementSkillLevel("Destruction")
          elseif aiButton == 3
            IncrementSkillLevel("Enchanting")
          elseif aiButton == 4
            IncrementSkillLevel("Illusion")
          elseif aiButton == 5
            IncrementSkillLevel("Restoration")
          endif
          iMarkCount = player.getItemCount(dibelMark)
          bTraded = True
          if iMarkCount < fSkillLevelCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 6 ;Back
        aiMessage = 2 ;;Skills Type Menu
      elseif aiButton == 7 ;Exit
        return bTraded
      endif
    endif
  elseif aiMessage == 5 ;Stealth Skills Menu
    if iMarkCount < fSkillLevelCost as Int
      DibelOfferMenu_InsufficientMark.Show(fSkillLevelCost as Int, iMarkCount)
      aiMessage = 0
    else
      aiButton = DibelOfferMenu_Skills_Stealth.Show(player.GetActorValue("Alchemy") as Int, player.GetActorValue("LightArmor") as Int, player.GetActorValue("Lockpicking") as Int, player.GetActorValue("Pickpocket") as Int, player.GetActorValue("Sneak") as Int, player.GetActorValue("Speechcraft") as Int)
      if aiButton == -1
      elseif aiButton < 6
        if DibelOfferMenu_Confirm_Skill.Show(fSkillLevelCost as Int, fSkillLevelIncrement as Int) == 0
          if aiButton == 0
            IncrementSkillLevel("Alchemy")
          elseif aiButton == 1
            IncrementSkillLevel("LightArmor")
          elseif aiButton == 2
            IncrementSkillLevel("Lockpicking")
          elseif aiButton == 3
            IncrementSkillLevel("Pickpocket")
          elseif aiButton == 4
            IncrementSkillLevel("Sneak")
          elseif aiButton == 5
            IncrementSkillLevel("Speechcraft")
          endif
          iMarkCount = player.getItemCount(dibelMark)
          bTraded = True
          if iMarkCount < fSkillLevelCost as Int
            aiMessage = 0
          endif
        endif
      elseif aiButton == 6 ;Back
        aiMessage = 2 ;;Skills Type Menu
      elseif aiButton == 7 ;Exit
        return bTraded
      endif
    endif
  endif
endWhile
EndFunction

Function IncrementSkillLevel(String sSkillName)
  Game.IncrementSkillBy(sSkillName, fSkillLevelIncrement as Int)
  MCMScript.iTotalSkillLevelRecieved += fSkillLevelIncrement as Int
  player.removeItem(dibelMark, fSkillLevelCost as Int)
  ;MCMScript.iTotalRefundableOfferedMarks += fSkillLevelCost as Int
  MCMScript.iTotalOfferedMarks += fSkillLevelCost as Int
  utility.wait(0.5)
  DibelOfferMenu_Skill_Changed.Show(fSkillLevelIncrement as Int)
EndFunction

Function offerDibelMarks(Actor akActor)
  gotostate("offeringToDibella")
  if GetDibellanRewards()
    utility.wait(1.0)
    if (!bSexAfterOffering || !bRandomSexWithPlayer(akActor))
      STD_Script.cureActorSTDs(player, False)
      GoToState("")
    endIf
    return
  endif
  GoToState("")
  return
EndFunction


Function rapePlayer(Actor akAggressor)
  bIsBusy = True
  gotostate("raped")
  if !bRandomSexWithPlayer(akAggressor, True)
    GoToState("")
  endIf
  return
EndFunction

Int function randInt(int iMin, int iMax)
  if bIsPO3ExtenderActive
    return PO3_SKSEFunctions.GenerateRandomInt(iMin, iMax)
  else
    return utility.randomInt(iMin, iMin)
  endif
endFunction

Float function randFloat(float fMin, float fMax)
  if bIsPO3ExtenderActive
    return PO3_SKSEFunctions.GenerateRandomFloat(fMin, fMax)
  else
    return utility.randomFloat(fMin, fMin)
  endif
endFunction

Bool function bCanAssault(Actor akActor)
  if !akActor
  elseif akActor.IsFlying()
  elseif akActor.IsSwimming()
  elseif akActor.isGuard()
  elseif akActor.GetRelationshipRank(player) > 0
  else
    return true
  endif
  return false
endFunction

Function stopApproach()
  ApproachMonitorScr.stopApproach()
EndFunction

Bool function isActorHavingSex(Actor akActor)
  if OStimInterface.IsActorActive(akActor)
  elseif SexLabInterface.IsActorActive(akActor)
  elseif FlowerGirlsInterface.IsActorActive(akActor)
  else
    return False
  endif
  return true
EndFunction