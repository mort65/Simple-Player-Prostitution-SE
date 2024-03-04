Scriptname zzzmrt_sp_mcm_qst_script extends SKI_ConfigBase

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
Int property iAnimInterface auto Hidden
Int Property iWhoreSpeechDifficulty=3 Auto Hidden
Int Property iDibelSpeechDifficulty=2 Auto Hidden
Int Property iBeggarSpeechDifficulty=4 Auto Hidden

String settings_path = "..\\simple-prostitution\\user-settings"

Int flag

event OnConfigInit()
  ModName = "Simple Prostitution"
  initPages()
  loadSettingsAtStart()
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
    _AddHeaderOption("$MRT_SP_HEAD_DEBUG")
    _AddToggleOptionST("MOD_TOGGLE", "$MRT_SP_MOD_TOGGLE", MainScript.bModEnabled)
    if MainScript.bIsPapyrusUtilActive && jsonutil.JsonExists(settings_path)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf
    _AddTextOptionST("LOAD_USER_SETTING_TXT", "$MRT_SP_LOAD_SETTING", "$go", flag)
    if MainScript.bIsPapyrusUtilActive
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf
    _AddTextOptionST("SAVE_USER_SETTING_TXT", "$MRT_SP_Save_SETTING", "$go", flag)    
    SetCursorPosition(1)
    flag = OPTION_FLAG_DISABLED
    _AddTextOptionST("DEBUG_MOD_VERSION_TXT", "Simple Prostitution v" + MainScript.getCurrentVersion(), "", flag)
    addEmptyOption()
    _AddTextOptionST("DEBUG_PAPYRUSUTIL_CHECK_TXT", "$papyrusutil", MainScript.bIsPapyrusUtilActive As String, flag)
    _AddTextOptionST("DEBUG_SEXLAB_CHECK_TXT", "$sexlab", MainScript.bIsSexlabActive As String, flag)
    _AddTextOptionST("DEBUG_FLOWERGIRLS_CHECK_TXT", "$flowergirls", MainScript.bIsFlowerGirlsActive As String, flag)
    _AddTextOptionST("DEBUG_LICENSES_CHECK_TXT", "$licenses", MainScript.bIsLicensesActive() As String, flag)
  elseif (page == "$MRT_SP_PAGE_INTEGRATION")
    SetTitleText("$MRT_SP_PAGE_INTEGRATION")
    _AddHeaderOption("$MRT_SP_HEAD_INTEGRATION")
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
    _AddToggleOptionST("WHORE_NEED_LICENSE_TOGGLE", "$MRT_SP_WHORE_NEED_LICENSE_TOGGLE", MainScript.bWhoreNeedLicense, flag)
    if MainScript.bModEnabled && MainScript.bDibelEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("DIBEL_NEED_LICENSE_TOGGLE", "$MRT_SP_DIBEL_NEED_LICENSE_TOGGLE", MainScript.bDibelNeedLicense, flag)
  elseif (page== "$MRT_SP_PAGE_BEGGING")
    SetTitleText("$MRT_SP_PAGE_BEGGING")
    _AddHeaderOption("$MRT_SP_HEAD_BEG")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("BEGGING_TOGGLE", "$MRT_SP_BEGGING_TOGGLE", MainScript.bBeggingEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bBeggingEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("BEGGING_CLOTHING_TOGGLE", "$MRT_SP_BEGGING_CLOTHING_TOGGLE", MainScript.bBeggingClothing, flag)
    _AddToggleOptionST("BEG_POOR_HELP_TOGGLE", "$MRT_SP_BEG_POOR_HELP_TOGGLE", MainScript.bPoorHelpBeggar, flag)
    _AddToggleOptionST("BEG_GUARD_HELP_TOGGLE", "$MRT_SP_BEG_GUARD_HELP_TOGGLE", MainScript.bGuardHelpBeggar, flag)
    AddSliderOptionST("BEG_PAY_MIN_SLIDER", "$MRT_SP_BEG_PAY_MIN_SLIDER1", MainScript.fBegPayMin, "$MRT_SP_BEG_PAY_MIN_SLIDER2", flag)
    AddSliderOptionST("BEG_PAY_MAX_SLIDER", "$MRT_SP_BEG_PAY_MAX_SLIDER1", MainScript.fBegPayMax, "$MRT_SP_BEG_PAY_MAX_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MIN_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER1", MainScript.fMinSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MAX_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER1", MainScript.fMaxSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER2", flag)
    AddMenuOptionST("BEG_ACCEPT_DIFFICULTY_MENU", "$MRT_SP_BEG_ACCEPT_DIFFICULTY_MENU", sGetSpeechDifficultyArr()[iBeggarSpeechDifficulty], flag)
  elseif (page == "$MRT_SP_PAGE_PROSTITUTION")
    SetTitleText("$MRT_SP_PAGE_PROSTITUTION")
    _AddHeaderOption("$MRT_SP_HEAD_WHORE")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("WHORE_TOGGLE", "$MRT_SP_WHORE_TOGGLE", MainScript.bWhoreEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bWhoreEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("WHORE_CLOTHING_TOGGLE", "$MRT_SP_WHORE_CLOTHING_TOGGLE", MainScript.bWhoreClothing, flag)
    _AddToggleOptionST("BED_TELEPORT_TOGGLE", "$MRT_SP_BED_TELEPORT_TOGGLE", MainScript.bTeleportToBed, flag)
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
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("DIBEL_TOGGLE", "$MRT_SP_DIBEL_TOGGLE", MainScript.bDibelEnabled, flag)
    if (MainScript.bModEnabled && MainScript.bDibelEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("DIBEL_AGENT_TOGGLE", "$MRT_SP_DIBEL_AGENT_TOGGLE", MainScript.bDibelAgent, flag)
    _AddToggleOptionST("DIBEL_CROWN_TOGGLE", "$MRT_SP_DIBEL_CROWN_TOGGLE", MainScript.bDibelCrown, flag)
    _AddToggleOptionST("DIBEL_NAKED_TOGGLE", "$MRT_SP_DIBEL_NAKED_TOGGLE", MainScript.bDibelNaked, flag)
    AddSliderOptionST("DIBEL_ORAL_CHANCE_SLIDER", "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER1", MainScript.fDibelOralChance, "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_ANAL_CHANCE_SLIDER", "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER1", MainScript.fDibelAnalChance, "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_VAG_CHANCE_SLIDER", "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER1", MainScript.fDibelVagChance, "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_ORAL_PAY_SLIDER", "$MRT_SP_DIBEL_ORAL_PAY_SLIDER1", MainScript.fDibelOralPay, "$MRT_SP_DIBEL_ORAL_PAY_SLIDER2", flag)
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
    _SetMenuOptionValueST(sGetAnimInerfaceArr()[iAnimInterface], True)
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
    _SetMenuOptionValueST(sGetSpeechDifficultyArr()[iWhoreSpeechDifficulty], True)
    MainScript.setChance()
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
    iBeggarSpeechDifficulty = index
    _SetMenuOptionValueST(sGetSpeechDifficultyArr()[iBeggarSpeechDifficulty], True)
    MainScript.setChance()
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iBeggarSpeechDifficulty)
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
    _SetMenuOptionValueST(sGetSpeechDifficultyArr()[iDibelSpeechDifficulty], True)
    MainScript.setChance()
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

state BEG_POOR_HELP_TOGGLE
  event OnDefaultST()
    MainScript.bPoorHelpBeggar = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_POOR_HELP_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bPoorHelpBeggar = !MainScript.bPoorHelpBeggar
    ForcePageReset()
  endevent
endstate

state BEG_GUARD_HELP_TOGGLE
  event OnDefaultST()
    MainScript.bGuardHelpBeggar = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_GUARD_HELP_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bGuardHelpBeggar = !MainScript.bGuardHelpBeggar
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
    _SetSliderOptionValueST(MainScript.fBegPayMax, "$MRT_SP_BEG_PAY_MAX_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fBegPayMin, "$MRT_SP_BEG_PAY_MIN_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fDibelAnalPay, "$MRT_SP_DIBEL_ANAL_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fDibelAnalChance, "$MRT_SP_DIBEL_ANAL_CHANCE_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fDibelOralPay, "$MRT_SP_DIBEL_ORAL_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fDibelOralChance, "$MRT_SP_DIBEL_ORAL_CHANCE_SLIDER2")
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
    MainScript.fDibelVagPay = value
    _SetSliderOptionValueST(MainScript.fDibelVagPay, "$MRT_SP_DIBEL_VAG_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fDibelVagChance, "$MRT_SP_DIBEL_VAG_CHANCE_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMaxSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMinSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMaxSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MAX_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMinSpeechDibelBonusMult, "$MRT_SP_SPEECH_DIBEL_BONUS_MIN_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMaxSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MAX_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fMinSpeechWhoreBonusMult, "$MRT_SP_SPEECH_WHORE_BONUS_MIN_MULT_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreAnalPay, "$MRT_SP_WHORE_ANAL_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreAnalChance, "$MRT_SP_WHORE_ANAL_CHANCE_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreOralPay, "$MRT_SP_WHORE_ORAL_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreOralChance, "$MRT_SP_WHORE_ORAL_CHANCE_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreVagPay, "$MRT_SP_WHORE_VAG_PAY_SLIDER2")
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
    _SetSliderOptionValueST(MainScript.fWhoreVagChance, "$MRT_SP_WHORE_VAG_CHANCE_SLIDER2")
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

state SAVE_USER_SETTING_TXT
  function OnSelectST()
    if jsonutil.JsonExists(settings_path)
      if !ShowMessage("Do you want to overwrite existing user settings?", true, "$Accept", "$Cancel")
        return 
      endIf
    endIf
    if saveUserSettingsPapyrus()
      ShowMessage("User settings saved successfully.", false, "$Accept", "$Cancel")
    else
      ShowMessage("Failed to save user settings.", false, "$Accept", "$Cancel")
    endIf
    ForcePageReset()
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SAVE_SETTING")
  endFunction
endState

state LOAD_USER_SETTING_TXT
  function OnSelectST()
    if ShowMessage("Do you want to load user settings?", true, "$Accept", "$Cancel")
      if loadUserSettingsPapyrus()
        ShowMessage("User settings loaded successfully.", false, "$Accept", "$Cancel")
      else
        ShowMessage("Failed to load user settings.", false, "$Accept", "$Cancel")
      endIf
    endIf
  endFunction

  function OnHighlightST()
    if jsonutil.JsonExists(settings_path)
      SetInfoText("$MRT_SP_DESC_LOAD_SETTING_ON")
    else
      SetInfoText("$MRT_SP_DESC_LOAD_SETTING_OFF")
    endIf
  endFunction
endState

Bool function loadUserSettingsPapyrus()
  if !jsonutil.IsGood(settings_path)
    ShowMessage("SimpleProstitution: Can't load User Settings. Errors: {" + jsonutil.getErrors(settings_path) + "}", true, "$Accept", "$Cancel")
    return false
  endIf
  MainScript.bWhoreNeedLicense = jsonutil.GetPathIntValue(settings_path, "bWhoreNeedLicense", MainScript.bWhoreNeedLicense as Int)
  MainScript.bDibelNeedLicense = jsonutil.GetPathIntValue(settings_path, "bDibelNeedLicense", MainScript.bDibelNeedLicense as Int)
  MainScript.bBeggingEnabled = jsonutil.GetPathIntValue(settings_path, "bBeggingEnabled", MainScript.bBeggingEnabled as Int)
  MainScript.bBeggingClothing = jsonutil.GetPathIntValue(settings_path, "bBeggingClothing", MainScript.bBeggingClothing as Int)
  MainScript.bPoorHelpBeggar = jsonutil.GetPathIntValue(settings_path, "bPoorHelpBeggar", MainScript.bPoorHelpBeggar as Int)
  MainScript.bGuardHelpBeggar = jsonutil.GetPathIntValue(settings_path, "bGuardHelpBeggar", MainScript.bGuardHelpBeggar as Int)
  MainScript.bWhoreEnabled = jsonutil.GetPathIntValue(settings_path, "bWhoreEnabled", MainScript.bWhoreEnabled as Int)
  MainScript.bWhoreClothing = jsonutil.GetPathIntValue(settings_path, "bWhoreClothing", MainScript.bWhoreClothing as Int)
  MainScript.bTeleportToBed = jsonutil.GetPathIntValue(settings_path, "bTeleportToBed", MainScript.bTeleportToBed as Int)
  MainScript.bDibelEnabled = jsonutil.GetPathIntValue(settings_path, "bDibelEnabled", MainScript.bDibelEnabled as Int)
  MainScript.bDibelAgent = jsonutil.GetPathIntValue(settings_path, "bDibelAgent", MainScript.bDibelAgent as Int)
  MainScript.bDibelCrown = jsonutil.GetPathIntValue(settings_path, "bDibelCrown", MainScript.bDibelCrown as Int)
  MainScript.bDibelNaked = jsonutil.GetPathIntValue(settings_path, "bDibelNaked", MainScript.bDibelNaked as Int)

  iBeggarSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  iWhoreSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  iDibelSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)

  MainScript.fBegPayMin = jsonutil.GetPathFloatValue(settings_path, "fBegPayMin", MainScript.fBegPayMin)
  MainScript.fBegPayMax = jsonutil.GetPathFloatValue(settings_path, "fBegPayMax", MainScript.fBegPayMax)
  MainScript.fWhoreOralPay = jsonutil.GetPathFloatValue(settings_path, "fWhoreOralPay", MainScript.fWhoreOralPay)
  MainScript.fWhoreAnalPay = jsonutil.GetPathFloatValue(settings_path, "fWhoreAnalPay", MainScript.fWhoreAnalPay)
  MainScript.fWhoreVagPay = jsonutil.GetPathFloatValue(settings_path, "fWhoreVagPay", MainScript.fWhoreVagPay)
  MainScript.fDibelOralPay = jsonutil.GetPathFloatValue(settings_path, "fDibelOralPay", MainScript.fDibelOralPay)
  MainScript.fDibelAnalPay = jsonutil.GetPathFloatValue(settings_path, "fDibelAnalPay", MainScript.fDibelAnalPay)
  MainScript.fDibelVagPay = jsonutil.GetPathFloatValue(settings_path, "fDibelVagPay", MainScript.fDibelVagPay)
  MainScript.fWhoreOralChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreOralChance", MainScript.fWhoreOralChance)
  MainScript.fWhoreAnalChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreAnalChance", MainScript.fWhoreAnalChance)
  MainScript.fWhoreVagChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreVagChance", MainScript.fWhoreVagChance)
  MainScript.fDibelOralChance = jsonutil.GetPathFloatValue(settings_path, "fDibelOralChance", MainScript.fDibelOralChance)
  MainScript.fDibelAnalChance = jsonutil.GetPathFloatValue(settings_path, "fDibelAnalChance", MainScript.fDibelAnalChance)
  MainScript.fDibelVagChance = jsonutil.GetPathFloatValue(settings_path, "fDibelVagChance", MainScript.fDibelVagChance)
  MainScript.fMinSpeechBegBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMinSpeechBegBonusMult", MainScript.fMinSpeechBegBonusMult)
  MainScript.fMaxSpeechBegBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMaxSpeechBegBonusMult", MainScript.fMaxSpeechBegBonusMult)
  MainScript.fMinSpeechWhoreBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMinSpeechWhoreBonusMult", MainScript.fMinSpeechWhoreBonusMult)
  MainScript.fMaxSpeechWhoreBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMaxSpeechWhoreBonusMult", MainScript.fMaxSpeechWhoreBonusMult)
  MainScript.fMinSpeechDibelBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMinSpeechDibelBonusMult", MainScript.fMinSpeechDibelBonusMult)
  MainScript.fMaxSpeechDibelBonusMult = jsonutil.GetPathFloatValue(settings_path, "fMaxSpeechDibelBonusMult", MainScript.fMaxSpeechDibelBonusMult)

  ForcePageReset()
  return true

endFunction

Bool function saveUserSettingsPapyrus()
  jsonutil.SetPathIntValue(settings_path, "bWhoreNeedLicense", MainScript.bWhoreNeedLicense as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelNeedLicense", MainScript.bDibelNeedLicense as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggingEnabled", MainScript.bBeggingEnabled as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggingClothing", MainScript.bBeggingClothing as Int)
  jsonutil.SetPathIntValue(settings_path, "bPoorHelpBeggar", MainScript.bPoorHelpBeggar as Int)
  jsonutil.SetPathIntValue(settings_path, "bGuardHelpBeggar", MainScript.bGuardHelpBeggar as Int)
  jsonutil.SetPathIntValue(settings_path, "bWhoreEnabled", MainScript.bWhoreEnabled as Int)
  jsonutil.SetPathIntValue(settings_path, "bWhoreClothing", MainScript.bWhoreClothing as Int)
  jsonutil.SetPathIntValue(settings_path, "bTeleportToBed", MainScript.bTeleportToBed as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelEnabled", MainScript.bDibelEnabled as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelAgent", MainScript.bDibelAgent as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelCrown", MainScript.bDibelCrown as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelNaked", MainScript.bDibelNaked as Int)
    
  
  jsonutil.SetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)
  

  jsonutil.SetPathFloatValue(settings_path, "fBegPayMin", MainScript.fBegPayMin)
  jsonutil.SetPathFloatValue(settings_path, "fBegPayMax", MainScript.fBegPayMax)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreOralPay", MainScript.fWhoreOralPay)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreAnalPay", MainScript.fWhoreAnalPay)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreVagPay", MainScript.fWhoreVagPay)
  jsonutil.SetPathFloatValue(settings_path, "fDibelOralPay", MainScript.fDibelOralPay)
  jsonutil.SetPathFloatValue(settings_path, "fDibelAnalPay", MainScript.fDibelAnalPay)
  jsonutil.SetPathFloatValue(settings_path, "fDibelVagPay", MainScript.fDibelVagPay)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreOralChance", MainScript.fWhoreOralChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreAnalChance", MainScript.fWhoreAnalChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreVagChance", MainScript.fWhoreVagChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelOralChance", MainScript.fDibelOralChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelAnalChance", MainScript.fDibelAnalChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelVagChance", MainScript.fDibelVagChance)
  jsonutil.SetPathFloatValue(settings_path, "fMinSpeechBegBonusMult", MainScript.fMinSpeechBegBonusMult)
  jsonutil.SetPathFloatValue(settings_path, "fMaxSpeechBegBonusMult", MainScript.fMaxSpeechBegBonusMult)
  jsonutil.SetPathFloatValue(settings_path, "fMinSpeechWhoreBonusMult", MainScript.fMinSpeechWhoreBonusMult)
  jsonutil.SetPathFloatValue(settings_path, "fMaxSpeechWhoreBonusMult", MainScript.fMaxSpeechWhoreBonusMult)
  jsonutil.SetPathFloatValue(settings_path, "fMinSpeechDibelBonusMult", MainScript.fMinSpeechDibelBonusMult)
  jsonutil.SetPathFloatValue(settings_path, "fMaxSpeechDibelBonusMult", MainScript.fMaxSpeechDibelBonusMult)


  if !jsonutil.Save(settings_path, false)
    debug.Trace("SimpleProstitution: Error saving user settings.", 0)
    return false
  endIf
  return true
endFunction

function loadSettingsAtStart()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  if MainScript.bIsPapyrusUtilActive
    if jsonutil.JsonExists(settings_path)
      loadUserSettingsPapyrus()
      return 
    endIf
  endIf
endFunction

function _AddHeaderOption(string a_text, int a_flags=0)
  AddHeaderOption(a_text, a_flags)
endfunction

function _AddTextOptionST(string stateName, string text, string value, int flags = 0)
  AddTextOptionST(stateName, text, value, flags)
endfunction

function _SetMenuOptionValueST(string value, bool noUpdate = false, string stateName = "")
  SetMenuOptionValueST(value, noUpdate, stateName)
endfunction

function _SetOptionFlagsST(int flags, bool noUpdate = false, string stateName = "")
  SetOptionFlagsST(flags, noUpdate, stateName)
endfunction

function  _SetSliderOptionValueST(float value, string formatString = "{0}", bool noUpdate = false, string stateName = "")
  SetSliderOptionValueST(value, formatString, noUpdate, stateName)
endfunction

function _SetTextOptionValueST(string value, bool noUpdate = false, string stateName = "")
  SetTextOptionValueST(value, noUpdate, stateName)
endfunction

function _AddToggleOptionST(string stateName, string text, bool checked, int flags = 0)
  AddToggleOptionST(stateName, text, checked, flags)
endFunction
