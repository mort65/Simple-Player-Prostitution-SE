Scriptname zzzmrt_sp_mcm_qst_script extends SKI_ConfigBase

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
Int property iAnimInterface auto Hidden
Int Property iWhoreSpeechDifficulty=3 Auto Hidden
Int Property iDibelSpeechDifficulty=2 Auto Hidden
Int Property iBeggerSpeechDifficulty=4 Auto Hidden

Int flag

event OnConfigInit()
  ModName = "Simple Prostitution"
  initPages()
endevent

function initPages()
  Pages = new String[4]
  pages[0] = "$MRT_SP_PAGE_PROSTITUTION"
  pages[1] = "$MRT_SP_PAGE_BEGGING"
  pages[2] = "$MRT_SP_PAGE_INTEGRATION"
  pages[3] = "$MRT_SP_PAGE_DEBUG"
endfunction

event OnGameReload()
  Parent.OnGameReload()
endevent

event OnPageReset(String page)
  initPages()
  flag = OPTION_FLAG_NONE
  SetCursorFillMode(TOP_TO_BOTTOM)
  if (page == "$MRT_SP_PAGE_DEBUG")
    SetTitleText("$MRT_SP_PAGE_DEBUG")
    AddHeaderOption("$MRT_SP_HEAD_DEBUG")
    AddToggleOptionST("MOD_TOGGLE", "$MRT_SP_MOD_TOGGLE", MainScript.bModEnabled)
    SetCursorPosition(3)
    flag = OPTION_FLAG_DISABLED
    AddTextOptionST("DEBUG_MOD_VERSION_TXT", "Simple Prostitution v" + MainScript.getCurrentVersion(), "", flag)
    AddTextOptionST("DEBUG_SEXLAB_CHECK_TXT", "$sexlab", MainScript.bIsSexlabActive As String, flag)
    AddTextOptionST("DEBUG_FLOWERGIRLS_CHECK_TXT", "$flowergirls", MainScript.bIsFlowerGirlsActive As String, flag)
    AddTextOptionST("DEBUG_LICENSES_CHECK_TXT", "$licenses", MainScript.bIsLicensesActive() As String, flag)
  elseif (page == "$MRT_SP_PAGE_INTEGRATION")
    SetTitleText("$MRT_SP_PAGE_INTEGRATION")
    AddHeaderOption("$MRT_SP_HEAD_INTEGRATION")
    if MainScript.bModEnabled && MainScript.bBeggingEnabled && (iGetCurAnimInterface() > -1)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddMenuOptionST("ANIM_INTERFACE_MENU", "$MRT_SP_ANIM_INTERFACE_MENU", sGetAnimInerfaceArr()[iAnimInterface], flag)
    if MainScript.bModEnabled && MainScript.bWhoreEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("WHORE_NEED_LICENSE_TOGGLE", "$MRT_SP_WHORE_NEED_LICENSE_TOGGLE", MainScript.bWhoreNeedLicense, flag)
    if MainScript.bModEnabled && MainScript.bDibelEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("DIBEL_NEED_LICENSE_TOGGLE", "$MRT_SP_DIBEL_NEED_LICENSE_TOGGLE", MainScript.bDibelNeedLicense, flag)
  elseif (page== "$MRT_SP_PAGE_BEGGING")
    SetTitleText("$MRT_SP_PAGE_BEGGING")
    AddHeaderOption("$MRT_SP_HEAD_BEG")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("BEGGING_TOGGLE", "$MRT_SP_BEGGING_TOGGLE", MainScript.bBeggingEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bBeggingEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("BEGGING_CLOTHING_TOGGLE", "$MRT_SP_BEGGING_CLOTHING_TOGGLE", MainScript.bBeggingClothing, flag)
    AddSliderOptionST("BEG_PAY_MIN_SLIDER", "$MRT_SP_BEG_PAY_MIN_SLIDER1", MainScript.fBegPayMin, "$MRT_SP_BEG_PAY_MIN_SLIDER2", flag)
    AddSliderOptionST("BEG_PAY_MAX_SLIDER", "$MRT_SP_BEG_PAY_MAX_SLIDER1", MainScript.fBegPayMax, "$MRT_SP_BEG_PAY_MAX_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MIN_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER1", MainScript.fMinSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MAX_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER1", MainScript.fMaxSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER2", flag)
    AddMenuOptionST("BEG_ACCEPT_DIFFICULTY_MENU", "$MRT_SP_BEG_ACCEPT_DIFFICULTY_MENU", sGetSpeechDifficultyArr()[iBeggerSpeechDifficulty], flag)
  elseif (page == "$MRT_SP_PAGE_PROSTITUTION")
    SetTitleText("$MRT_SP_PAGE_PROSTITUTION")
    AddHeaderOption("$MRT_SP_HEAD_WHORE")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("WHORE_TOGGLE", "$MRT_SP_WHORE_TOGGLE", MainScript.bWhoreEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bWhoreEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("WHORE_CLOTHING_TOGGLE", "$MRT_SP_WHORE_CLOTHING_TOGGLE", MainScript.bWhoreClothing, flag)
    AddToggleOptionST("BED_TELEPORT_TOGGLE", "$MRT_SP_BED_TELEPORT_TOGGLE", MainScript.bTeleportToBed, flag)
    AddSliderOptionST("WHORE_ORAL_CHANCE_SLIDER", "$MRT_SP_WHORE_ORAL_CHANCE_SLIDER1", MainScript.fWhoreOralChance, "$MRT_SP_WHORE_ORAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("WHORE_ANAL_CHANCE_SLIDER", "$MRT_SP_WHORE_ANAL_CHANCE_SLIDER1", MainScript.fWhoreAnalChance, "$MRT_SP_WHORE_ANAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("WHORE_VAG_CHANCE_SLIDER", "$MRT_SP_WHORE_VAG_CHANCE_SLIDER1", MainScript.fWhoreVagChance, "$MRT_SP_WHORE_VAG_CHANCE_SLIDER2", flag)
    AddSliderOptionST("WHORE_ORAL_PAY_SLIDER", "$MRT_SP_WHORE_ORAL_PAY_SLIDER1", MainScript.fWhoreOralPay, "$MRT_SP_WHORE_ORAL_PAY_SLIDER2", flag)
    AddSliderOptionST("WHORE_ANAL_PAY_SLIDER", "$MRT_SP_WHORE_ANAL_PAY_SLIDER1", MainScript.fWhoreAnalPay, "$MRT_SP_WHORE_ANAL_PAY_SLIDER2", flag)
    AddSliderOptionST("WHORE_VAG_PAY_SLIDER", "$MRT_SP_WHORE_VAG_PAY_SLIDER1", MainScript.fWhoreVagPay, "$MRT_SP_WHORE_VAG_PAY_SLIDER2", flag)
    AddSliderOptionST("SPEECH_WHORE_BONUS_MIN_MULT_SLIDER", "$MRT_SP_SPEECH_WHORE_BONUS_MIN_MULT_SLIDER1", MainScript.fMinSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MIN_MULT_SLIDER2", flag)
    AddSliderOptionST("SPEECH_WHORE_BONUS_MAX_MULT_SLIDER", "$MRT_SP_SPEECH_WHORE_BONUS_MAX_MULT_SLIDER1", MainScript.fMaxSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MAX_MULT_SLIDER2", flag)
    AddMenuOptionST("WHORE_ACCEPT_DIFFICULTY_MENU", "$MRT_SP_WHORE_ACCEPT_DIFFICULTY_MENU", sGetSpeechDifficultyArr()[iWhoreSpeechDifficulty], flag)
    SetCursorPosition(1)
    AddHeaderOption("$MRT_SP_HEAD_DIBEL")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("DIBEL_TOGGLE", "$MRT_SP_DIBEL_TOGGLE", MainScript.bDibelEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bDibelEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddToggleOptionST("DIBEL_AGENT_TOGGLE", "$MRT_SP_DIBEL_AGENT_TOGGLE", MainScript.bDibelAgent, flag)
    AddToggleOptionST("DIBEL_CROWN_TOGGLE", "$MRT_SP_DIBEL_CROWN_TOGGLE", MainScript.bDibelCrown, flag)
    AddToggleOptionST("DIBEL_NAKED_TOGGLE", "$MRT_SP_DIBEL_NAKED_TOGGLE", MainScript.bDibelNaked, flag)
    AddSliderOptionST("DIBEL_ORAL_CHANCE_SLIDER", "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER1", MainScript.fDibelOralPay, "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_ANAL_CHANCE_SLIDER", "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER1", MainScript.fDibelAnalChance, "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_VAG_CHANCE_SLIDER", "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER1", MainScript.fDibelVagChance, "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_ORAL_PAY_SLIDER", "$MRT_SP_DIBEL_ORAL_PAY_SLIDER1", MainScript.fDibelOralChance, "$MRT_SP_DIBEL_ORAL_PAY_SLIDER2", flag)
    AddSliderOptionST("DIBEL_ANAL_PAY_SLIDER", "$MRT_SP_DIBEL_ANAL_PAY_SLIDER1", MainScript.fDibelAnalPay, "$MRT_SP_DIBEL_ANAL_PAY_SLIDER2", flag)
    AddSliderOptionST("DIBEL_VAG_PAY_SLIDER", "$MRT_SP_DIBEL_VAG_PAY_SLIDER1", MainScript.fDibelVagPay, "$MRT_SP_DIBEL_VAG_PAY_SLIDER2", flag)
    AddSliderOptionST("SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER", "$MRT_SP_SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER1", MainScript.fMinSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER2", flag)
    AddSliderOptionST("SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER", "$MRT_SP_SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER1", MainScript.fMaxSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER2", flag)
    AddMenuOptionST("DIBEL_ACCEPT_DIFFICULTY_MENU", "$MRT_SP_DIBEL_ACCEPT_DIFFICULTY_MENU", sGetSpeechDifficultyArr()[iDibelSpeechDifficulty], flag)
  endif
endevent

event OnVersionUpdate(Int version)
  if (version >= 100 && CurrentVersion < 100)
    Debug.Trace(self + ": Updating script to version " + 100)
  endif
endevent

String[] function sGetAnimInerfaceArr()
  Int i = 0
  String[] sAnimInterfaces
  if MainScript.bIsSexlabActive
    i += 1
  endif
  if MainScript.bIsFlowerGirlsActive
    i += 1
  endif
  if i == 0
    sAnimInterfaces = new String[1]
    sAnimInterfaces[0] = ""
    iAnimInterface = 0
    return sAnimInterfaces
  endif
  sAnimInterfaces = Utility.CreateStringArray(i)
  i = 0
  if MainScript.bIsSexlabActive
    sAnimInterfaces[i] = "$sexlab"
    i += 1
  endif
  if MainScript.bIsFlowerGirlsActive
    sAnimInterfaces[i] = "$flowergirls"
    i += 1
  endif
  if iAnimInterface > (sAnimInterfaces.length - 1)
    iAnimInterface = 0
  endif
  return sAnimInterfaces
endfunction

string[] Function sGetSpeechDifficultyArr()
	String[] sSpeechDifficulties = Utility.CreateStringArray(7)
  sSpeechDifficulties[0] = "$MRT_SP_SpeechDiff_Disabled"
	sSpeechDifficulties[1] = "$MRT_SP_SpeechDiff_VeryEasy"
	sSpeechDifficulties[2] = "$MRT_SP_SpeechDiff_Easy"
	sSpeechDifficulties[3] = "$MRT_SP_SpeechDiff_Average"
	sSpeechDifficulties[4] = "$MRT_SP_SpeechDiff_Hard"
	sSpeechDifficulties[5] = "$MRT_SP_SpeechDiff_Harder"
	sSpeechDifficulties[6] = "$MRT_SP_SpeechDiff_VeryHard"
	return sSpeechDifficulties
EndFunction

Int function iGetCurAnimInterface()
  String[] interfs = sGetAnimInerfaceArr()
  if interfs[iAnimInterface] == "$sexlab"
    return 0
  elseif interfs[iAnimInterface] == "$flowergirls"
    return 1
  endif
  return -1
endfunction

state ANIM_INTERFACE_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_ANIM_INTERFACE_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iAnimInterface = index
    SetMenuOptionValueST(sGetAnimInerfaceArr()[iAnimInterface], True)
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iAnimInterface)
    SetMenuDialogOptions(sGetAnimInerfaceArr())
  endevent
endstate

state WHORE_ACCEPT_DIFFICULTY_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ACCEPT_DIFFICULTY_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iWhoreSpeechDifficulty = index
    SetMenuOptionValueST(sGetSpeechDifficultyArr()[iWhoreSpeechDifficulty], True)
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iWhoreSpeechDifficulty)
    SetMenuDialogDefaultIndex(3)
    SetMenuDialogOptions(sGetSpeechDifficultyArr())
  endevent
endstate

state BEG_ACCEPT_DIFFICULTY_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_ACCEPT_DIFFICULTY_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iBeggerSpeechDifficulty = index
    SetMenuOptionValueST(sGetSpeechDifficultyArr()[iBeggerSpeechDifficulty], True)
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iBeggerSpeechDifficulty)
    SetMenuDialogDefaultIndex(4)
    SetMenuDialogOptions(sGetSpeechDifficultyArr())
  endevent
endstate

state DIBEL_ACCEPT_DIFFICULTY_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ACCEPT_DIFFICULTY_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iDibelSpeechDifficulty = index
    SetMenuOptionValueST(sGetSpeechDifficultyArr()[iDibelSpeechDifficulty], True)
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iDibelSpeechDifficulty)
    SetMenuDialogDefaultIndex(2)
    SetMenuDialogOptions(sGetSpeechDifficultyArr())
  endevent
endstate

state BEGGING_CLOTHING_TOGGLE
  event OnDefaultST()
    MainScript.bBeggingClothing = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEGGING_CLOTHING_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bBeggingClothing = !MainScript.bBeggingClothing
    ForcePageReset()
  endevent
endstate

state BEGGING_TOGGLE
  event OnDefaultST()
    MainScript.bBeggingEnabled = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEGGING_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bBeggingEnabled = !MainScript.bBeggingEnabled
    ForcePageReset()
  endevent
endstate

state BEG_PAY_MAX_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_PAY_MAX_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBegPayMin = value
    SetSliderOptionValueST(MainScript.fBegPayMax, "$MRT_SP_BEG_PAY_MAX_SLIDER2")
  endevent
	
	event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fBegPayMax)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
  
endstate

state BEG_PAY_MIN_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_PAY_MIN_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBegPayMin = value
    SetSliderOptionValueST(MainScript.fBegPayMin, "$MRT_SP_BEG_PAY_MIN_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fBegPayMin)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state DIBEL_AGENT_TOGGLE
  event OnDefaultST()
    MainScript.bDibelAgent = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_AGENT_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelAgent = !MainScript.bDibelAgent
    ForcePageReset()
  endevent
endstate

state DIBEL_ANAL_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ANAL_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelAnalPay = value
    SetSliderOptionValueST(MainScript.fDibelAnalPay, "$MRT_SP_DIBEL_ANAL_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fDibelAnalPay)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state DIBEL_ANAL_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ANAL_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelAnalChance = value
    SetSliderOptionValueST(MainScript.fDibelAnalChance, "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelAnalChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state DIBEL_CROWN_TOGGLE
  event OnDefaultST()
    MainScript.bDibelCrown = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_CROWN_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelCrown = !MainScript.bDibelCrown
    ForcePageReset()
  endevent
endstate

state DIBEL_NAKED_TOGGLE
  event OnDefaultST()
    MainScript.bDibelNaked = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_NAKED_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelNaked = !MainScript.bDibelNaked
    ForcePageReset()
  endevent
endstate

state DIBEL_ORAL_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ORAL_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelOralPay = value
    SetSliderOptionValueST(MainScript.fDibelOralPay, "$MRT_SP_DIBEL_ORAL_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fDibelOralPay)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state DIBEL_ORAL_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ORAL_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelOralChance = value
    SetSliderOptionValueST(MainScript.fDibelOralChance, "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelOralChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state DIBEL_TOGGLE
  event OnDefaultST()
    MainScript.bDibelEnabled = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelEnabled = !MainScript.bDibelEnabled
    ForcePageReset()
  endevent
endstate

state DIBEL_VAG_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_VAG_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelAnalPay = value
    SetSliderOptionValueST(MainScript.fDibelVagPay, "$MRT_SP_DIBEL_VAG_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fDibelVagPay)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state DIBEL_VAG_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_VAG_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelVagChance = value
    SetSliderOptionValueST(MainScript.fDibelVagChance, "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelVagChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state MOD_TOGGLE
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_MOD_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bModEnabled = !MainScript.bModEnabled
    ForcePageReset()
  endevent
endstate

state SPEECH_BEG_BONUS_MAX_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_BEG_BONUS_MAX_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMaxSpeechBegBonusMult = value
    SetSliderOptionValueST(MainScript.fMaxSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER2")
  endevent
 
  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMaxSpeechBegBonusMult)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state SPEECH_BEG_BONUS_MIN_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_BEG_BONUS_MIN_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMinSpeechBegBonusMult = value
    SetSliderOptionValueST(MainScript.fMinSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMinSpeechBegBonusMult)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMaxSpeechDibelBonusMult = value
    SetSliderOptionValueST(MainScript.fMaxSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMaxSpeechDibelBonusMult)
		SetSliderDialogDefaultValue(1.50)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMinSpeechDibelBonusMult = value
    SetSliderOptionValueST(MainScript.fMinSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMinSpeechDibelBonusMult)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state SPEECH_WHORE_BONUS_MAX_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_WHORE_BONUS_MAX_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMaxSpeechWhoreBonusMult = value
    SetSliderOptionValueST(MainScript.fMaxSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MAX_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMaxSpeechWhoreBonusMult)
		SetSliderDialogDefaultValue(1.10)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state SPEECH_WHORE_BONUS_MIN_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_WHORE_BONUS_MIN_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fMinSpeechWhoreBonusMult = value
    SetSliderOptionValueST(MainScript.fMinSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MIN_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fMinSpeechWhoreBonusMult)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.1)
	endEvent
endstate

state WHORE_ANAL_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ANAL_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreAnalPay = value
    SetSliderOptionValueST(MainScript.fWhoreAnalPay, "$MRT_SP_WHORE_ANAL_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fWhoreAnalPay)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state WHORE_ANAL_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ANAL_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreAnalChance = value
    SetSliderOptionValueST(MainScript.fWhoreAnalChance, "$MRT_SP_WHORE_ANAL_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreAnalChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state WHORE_CLOTHING_TOGGLE
  event OnDefaultST()
    MainScript.bWhoreClothing = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_CLOTHING_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreClothing = !MainScript.bWhoreClothing
    ForcePageReset()
  endevent
endstate

State WHORE_NEED_LICENSE_TOGGLE
  event OnDefaultST()
    MainScript.bWhoreNeedLicense = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_NEED_LICENSE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreNeedLicense = !MainScript.bWhoreNeedLicense
    ForcePageReset()
  endevent
EndState

State DIBEL_NEED_LICENSE_TOGGLE
  event OnDefaultST()
    MainScript.bDibelNeedLicense = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_NEED_LICENSE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelNeedLicense = !MainScript.bDibelNeedLicense
    ForcePageReset()
  endevent
EndState

state BED_TELEPORT_TOGGLE
  event OnDefaultST()
    MainScript.bTeleportToBed = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BED_TELEPORT_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bTeleportToBed = !MainScript.bTeleportToBed
    ForcePageReset()
  endevent
endstate

state WHORE_ORAL_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ORAL_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreOralPay = value
    SetSliderOptionValueST(MainScript.fWhoreOralPay, "$MRT_SP_WHORE_ORAL_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fWhoreOralPay)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state WHORE_ORAL_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ORAL_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreOralChance = value
    SetSliderOptionValueST(MainScript.fWhoreOralChance, "$MRT_SP_WHORE_ORAL_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreOralChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state WHORE_TOGGLE
  event OnDefaultST()
    MainScript.bWhoreEnabled = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreEnabled = !MainScript.bWhoreEnabled
    ForcePageReset()
  endevent
endstate

state WHORE_VAG_PAY_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_VAG_PAY_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreVagPay = value
    SetSliderOptionValueST(MainScript.fWhoreVagPay, "$MRT_SP_WHORE_VAG_PAY_SLIDER2")
  endevent

  event OnSliderOpenST()
		SetSliderDialogStartValue(MainScript.fWhoreVagPay)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent
endstate

state WHORE_VAG_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_VAG_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreVagChance = value
    SetSliderOptionValueST(MainScript.fWhoreVagChance, "$MRT_SP_WHORE_VAG_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreVagChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

State DEBUG_MOD_VERSION_TXT
endstate

State DEBUG_SEXLAB_CHECK_TXT
endstate

State DEBUG_FLOWERGIRLS_CHECK_TXT
endstate

State DEBUG_LICENSES_CHECK_TXT
endstate
