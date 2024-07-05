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
ReferenceAlias property whoreCustomerAlias2 auto
ReferenceAlias property whoreCustomerAlias3 auto
ReferenceAlias property whoreCustomerAlias4 auto
ReferenceAlias property dibelCustomerAlias auto
ReferenceAlias property dibelCustomerAlias2 auto
ReferenceAlias property dibelCustomerAlias3 auto
ReferenceAlias property dibelCustomerAlias4 auto
GlobalVariable property WhoreFailureChance auto
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
Bool Property bDibelAllowAggressive=True Auto Hidden Conditional
Bool Property bWhoreAllowAggressive=True Auto Hidden Conditional
Bool Property bTryAllInterfaces=True Auto Hidden Conditional
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Formlist property alwaysAllowedLocations auto
Formlist property whoreCustomerList Auto
Formlist property dibelCustomerList Auto
Formlist Property currentCustomerList Auto
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
Int[] property iWhorePositions auto Hidden Conditional
Int[] property iDibelPositions auto Hidden Conditional
Int[] Property iPositions Auto Hidden Conditional
Int property iTotalWhoreCustomers = 0 auto Hidden Conditional
Int property iTotalDibelCustomers = 0 auto Hidden Conditional

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
associationType Property spouse  auto
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

Bool bWhoreAnimEnded = False ;
Bool bDibelAnimEnded = False
Int Property iWhorePartners = 0 Auto Hidden Conditional
Int Property iDibelPartners = 0 Auto Hidden Conditional
Actor[] property origCustomersArr Auto Hidden Conditional
Bool property bIsBusy = False Auto Hidden Conditional

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
  clearPositions()
  dibelSnitch = None
  whoreSnitch = None
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
  return getBaseVersion() + 0.20
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
    Utility.Wait(5.0)
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
    result = haveSexSFW()
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
      result = haveSexSFW()
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
    Utility.Wait(5.0)
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
          iPosition = utility.randomint(0,2)
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

Function setWhoreCustomer(Actor akActor, Bool bPay = False)
  customerSpell.Cast(akActor, akActor)
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iWhorePosition = positionChooser(0, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    else
      iWhorePosition = positionChooser(fWhoreVagChance as Int, fWhoreAnalChance as Int, fWhoreOralChance as Int)
    endif
    if iWhorePosition > -1
      payWhore(player, iWhorePosition)
      persuade(fWhorePersuasionXPMult)
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
    elseif whoreCustomerList.GetSize() == 1
      whoreCustomerAlias2.ForceRefTo(akActor)
      iWhorePositions[1] = iWhorePosition
    elseif whoreCustomerList.GetSize() == 2
      whoreCustomerAlias3.ForceRefTo(akActor)
      iWhorePositions[2] = iWhorePosition
    elseif whoreCustomerList.GetSize() == 3
      whoreCustomerAlias4.ForceRefTo(akActor)
      iWhorePositions[3] = iWhorePosition
    endif
    akActor.EvaluatePackage()
    whoreCustomerList.AddForm(akActor)
    iTotalWhoreCustomers = whoreCustomerList.GetSize()
  endif
EndFunction

Function setDibelCustomer(Actor akActor, bool bPay = true )
  customerSpell.Cast(akActor, akActor)
  if bPay
    if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
      iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
    else
      iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
    endif
    if iDibelPosition > -1
      payDibel(player, iDibelPosition)
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
    elseif dibelCustomerList.GetSize() == 1
      dibelCustomerAlias2.ForceRefTo(akActor)
      iDibelPositions[1] = iDibelPosition
    elseif dibelCustomerList.GetSize() == 2
      dibelCustomerAlias3.ForceRefTo(akActor)
      iDibelPositions[2] = iDibelPosition
    elseif dibelCustomerList.GetSize() == 3
      dibelCustomerAlias4.ForceRefTo(akActor)
      iDibelPositions[3] = iDibelPosition
    endif
    akActor.EvaluatePackage()
    dibelCustomerList.AddForm(akActor)
    iTotalDibelCustomers = dibelCustomerList.GetSize()
  endif
EndFunction

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
  registerForSingleUpdate(1.0)
  return iPosition
endfunction

function payBeggar(Actor beggar, Bool bBonus = True)
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

function setGlobalVaues()
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
    if !LicensesInterface.bFlagWhoreViolation()
      if snitch.getcrimefaction()
        if !player.GetCurrentLocation() || !player.GetCurrentLocation().HasKeywordstring("loctypejail")
          snitch.getcrimefaction().ModCrimeGold(50)
        endIf
      endif
    endif
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
    if utility.randomInt(0,99) < fChance as Int
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
    if bIsBusy
      return
    endif
    bIsBusy = True
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
    if bIsBusy
      return
    endif
    bIsBusy = True
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
    While (!FlowerGirlsInterface.bChecked || !SexLabInterface.bChecked || !OStimInterface.bChecked || !LicensesInterface.bChecked)
      Utility.wait(0.2)
    endWhile
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

Bool function GetDibellanRewards(Int aiMessage=0, Int aiButton=0)
  int iMarkCount = player.getItemCount(dibelMark)
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
      elseif aiButton == 4 ;Exit
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
    if !bRandomSexWithPlayer(akActor)
      GoToState("")
    endIf
    return
  endif
  GoToState("")
  return
EndFunction