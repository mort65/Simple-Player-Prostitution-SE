Scriptname zzzmrt_sp_main_qst_script extends Quest Conditional

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

ImageSpaceModifier property fadeIn auto
ImageSpaceModifier property fadeOut auto
ImageSpaceModifier property fastFadeOut auto
MiscObject property gold auto
Actor property player auto
Faction property whoreFaction auto
Faction Property DibellaMerchant Auto
Actor Property DibellaMerchantNPC Auto

Bool Property bFindingSnitch = False Auto Hidden Conditional
Bool Property bSceneRunning = False Auto Hidden Conditional
Int Property iPosition = -1 Auto Hidden Conditional

function shutDown()
  stopSnitchFinder()
  snitchDetector.stop()
  currentAllowedLocations.Revert()
  player.removeFromFaction(whoreFaction)
  owner.clear()
  clearWhoreCustomer()
  clearDibelCustomer()
  iPosition = -1
  bSceneRunning = False
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
EndFunction

Event OnInit()
  registerForSingleUpdate(5.0) 
EndEvent

event onUpdate()
  if bSceneRunning
    if bFindingSnitch
      stopSnitchFinder()
    endif
    bSceneRunning = false
    return
  endif
  While (!FlowerGirlsInterface.bChecked || !SexLabInterface.bChecked || !OStimInterface.bChecked || !LicensesInterface.bChecked)
    utility.wait(0.2)
  endWhile
  Debug.Notification("Simple Prostitution started.")
EndEvent

Event OnUpdateGameTime()
  ;Debug.trace("Simple Prostitution: OnUpdateGameTime triggered.")
  if !bFindingSnitch
    snitch()
  endif
endEvent

event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
  if HasPlayer && bSceneRunning
    ;Debug.trace("Simple Prostitution: on_spp_sexlab_Sex_End triggered.")
    if bFindingSnitch
      stopSnitchFinder()
    endif
    bSceneRunning = false
  endif
EndEvent

Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
  if bSceneRunning
    ;Debug.trace("Simple Prostitution: on_spp_ostim_Sex_End triggered.")
    if bFindingSnitch
      stopSnitchFinder()
    endif
    bSceneRunning = false
  endif
endEvent

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
    Debug.Trace("Simple Player Prostitution: Work allowed in " + currentAllowedLocations.GetAt(0) + " that's owned by " + akOwner)
  endif
endfunction

function ProstitutePlayerTo(Actor akCustomer, bool bAccept=true)
  setChance()
  if akCustomer
    customerSpell.Cast(akCustomer, akCustomer)
    if !bAccept
      if isSnitchOK(whoreSnitch)
        stopSnitchFinder()
      elseif !playerHasWhoreLicense()
        checkWhoreSnitch(akCustomer)
      endif
      return
    endif
    currentPartner = akCustomer
    if isSnitchOK(whoreSnitch)
      stopSnitchFinder()
    elseif !playerHasWhoreLicense()
      startSnitchFinder(false)
    endif
    clearWhoreCustomer()
    haveSex(akCustomer, sGetCurAnimInteface(), bWhoreAllowAggressive, bAllPosAllowed(fWhoreVagChance, fWhoreAnalChance, fWhoreOralChance))
  endif
  iPosition = -1
endfunction

Float function getBaseVersion()
  return 1.0
endfunction

Float function getCurrentVersion()
  return getBaseVersion() + 0.11
endfunction

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

function stopSnitchFinder()
  bFindingSnitch = False
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
    endif
  endIf
  if iPosition > -1
    dibelCustomerAlias.ForceRefTo(akActor)
    akActor.EvaluatePackage()
  endif
EndFunction

Function clearWhoreCustomer()
  Actor whoreCustomer = whoreCustomerAlias.getActorReference()
  if whoreCustomer
    whoreCustomerAlias.Clear()
    whoreCustomer.EvaluatePackage()
  endif
EndFunction

Function clearDibelCustomer()
  Actor dibelCustomer = dibelCustomerAlias.getActorReference()
  if dibelCustomer
    dibelCustomerAlias.Clear()
    dibelCustomer.EvaluatePackage()
  endif
EndFunction

int Function playerSexSL(Actor akActor, Bool bAllowAggressive= False, Bool bAllowAll = False)
  if !bIsSexlabActive || (iPosition < 0)
    return -1
  endif
  int result = SexLabInterface.haveSexWithPlayer(akActor, iPosition, sGetExtraTagsArr("sexlab"), bGetRegAllTagsArr("sexlab"), bAllowAggressive, bAllowAll)
  if result > -1
     bSceneRunning = true
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
    bSceneRunning = true
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
    bSceneRunning = true
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
  return iPosition
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
  Owner.clear()
  clearWhoreCustomer()
  clearDibelCustomer()
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
      if isSnitchOK(dibelSnitch)
        stopSnitchFinder()
      elseif !playerHasDibelLicence()
        checkDibelSnitch(akActor)
      endif
      return
    endif
    clearDibelCustomer()
    currentPartner = akActor
    if isSnitchOK(dibelSnitch)
      stopSnitchFinder()
    elseif !playerHasDibelLicence()
      startSnitchFinder(true)
    endif
    haveSex(akActor, sGetCurAnimInteface(), bDibelAllowAggressive, bAllPosAllowed(fDibelVagChance,fDibelAnalChance,fDibelOralChance))
  endif
  iPosition = -1
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


Bool Function checkDibelSnitch(Actor npc, Bool bCompleteCheck = False)
  if playerHasDibelLicence()
    dibelSnitch = None
    stopSnitchFinder()
    return False
  endif
  if !npc || (npc == player) || (dibelSnitch && !dibelSnitch.isDead())
    Return False
  endif
  if npc.isGuard()
    if utility.RandomInt(1,100) <=  fGuardReportChance as int
      if bCanSnitch(npc, bCompleteCheck)
        dibelSnitch = npc
        Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player for dibellan arts.")
        Return True
      endif
    endif
  elseif (utility.RandomInt(1,100) <=  fCitizenReportChance as int)
  	if bCanSnitch(npc, bCompleteCheck)
      dibelSnitch = npc
      Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player for dibellan arts.")
      Return True
  	endif
  endif
  Return False
EndFunction

Bool Function checkWhoreSnitch(Actor npc, Bool bCompleteCheck = False)
  if playerHasWhoreLicense()
    whoreSnitch = None
    stopSnitchFinder()
    return False
  endif
  if !npc || (npc == player) || (whoreSnitch && !whoreSnitch.isDead())
    Return False
  endif
  if npc.isGuard()
    if utility.RandomInt(1,100) <=  fGuardReportChance as int
      if bCanSnitch(npc, bCompleteCheck)
        whoreSnitch = npc
        Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player for prostituton.")
        RegisterForSingleUpdateGameTime(Utility.RandomInt(8,14) As Float)
        return True
      endif
    endif
  elseif (utility.RandomInt(1,100) <=  fCitizenReportChance as int)
    if bCanSnitch(npc, bCompleteCheck)
      whoreSnitch = npc
      Debug.Trace("Simple Prostitution: " + npc.GetBaseObject().GetName() + " (" + npc + ") wants to snitch on player for prostituton.")
      RegisterForSingleUpdateGameTime(Utility.RandomInt(8,14) As Float)
      return True
    endif
  endif
  return False
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


Function findSnitch(Bool bCheckDibel = False)
  SnitchDetector.start()
  If bIsPapyrusUtilActive
    Actor[] actors = MiscUtil.ScanCellNPCs(player, radius = 3000.0, HasKeyword = none, IgnoreDead = true)
    actor npc = None
    int iIndex = 0
    while bFindingSnitch && (iIndex < actors.Length)
      npc = actors[iIndex]
      if bCheckDibel
        bFindingSnitch = !checkDibelSnitch(npc, true)
      else
        bFindingSnitch = !checkWhoreSnitch(npc, true)
      endif
      actors[iIndex] && snitchers.addform(actors[iIndex])
      if bFindingSnitch && snitchRef1.GetActorReference()
        if bCheckDibel
          bFindingSnitch = !checkDibelSnitch(snitchRef1.GetActorReference(), false)
        else
          bFindingSnitch = !checkWhoreSnitch(snitchRef1.GetActorReference(), false)
        endif
      snitchRef1.GetActorReference() && snitchers.addform(snitchRef1.GetActorReference())
      endif
      if bFindingSnitch && snitchRef2.GetActorReference()
        if bCheckDibel
          bFindingSnitch = !checkDibelSnitch(snitchRef2.GetActorReference(), false)
        else
          bFindingSnitch = !checkWhoreSnitch(snitchRef2.GetActorReference(), false)
        endif
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
    if bFindingSnitch
      if bCheckDibel
        bFindingSnitch = !checkDibelSnitch(snitchRef1.GetActorReference(), false)
      else
        bFindingSnitch = !checkWhoreSnitch(snitchRef1.GetActorReference(), false)
      endif
      snitchRef1.GetActorReference() && snitchers.addform(snitchRef1.GetActorReference())
    endif
  endif
  if snitchRef2.GetActorReference()
    if bFindingSnitch
      if bCheckDibel
        bFindingSnitch = !checkDibelSnitch(snitchRef2.GetActorReference(), false)
      else
        bFindingSnitch = !checkWhoreSnitch(snitchRef2.GetActorReference(), false)
      endif
      snitchRef2.GetActorReference() && snitchers.addform(snitchRef2.GetActorReference())
    endif
  endif
  snitchDetector.stop()
endfunction
