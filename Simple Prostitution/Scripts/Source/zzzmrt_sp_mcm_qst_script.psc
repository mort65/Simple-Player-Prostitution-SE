Scriptname zzzmrt_sp_mcm_qst_script extends SKI_ConfigBase

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
Int property iAnimInterface auto Hidden
Int Property iWhoreSpeechDifficulty=3 Auto Hidden
Int Property iDibelSpeechDifficulty=2 Auto Hidden
Int Property iBeggarSpeechDifficulty=4 Auto Hidden
Int Property iAnimInterfaceMethod = 0 Auto Hidden

String settings_path = "..\\simple-prostitution\\user-settings"

Int flag

event OnConfigInit()
  ModName = "Simple Prostitution"
  initPages()
  loadSettingsAtStart()
  Mainscript.setVars()
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
    _AddTextOptionST("DEBUG_OSTIM_CHECK_TXT", "$ostim_sa", MainScript.bIsOstimActive As String, flag)
    _AddTextOptionST("DEBUG_LICENSES_CHECK_TXT", "$licenses", MainScript.bIsLicensesActive As String, flag)
  elseif (page == "$MRT_SP_PAGE_INTEGRATION")
    SetTitleText("$MRT_SP_PAGE_INTEGRATION")
    _AddHeaderOption("$MRT_SP_HEAD_INTEGRATION_INTERFACE")
    if MainScript.bModEnabled && (MainScript.iGetCurTotalAnimInterfaces() > 1)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddMenuOptionST("ANIM_INTERFACE_METHOD_MENU", "$MRT_SP_ANIM_INTERFACE_METHOD_MENU", sGetAnimInerfaceMethodArr()[iAnimInterfaceMethod], flag)
    if MainScript.bModEnabled && (MainScript.iGetCurTotalAnimInterfaces() > 0) && (iAnimInterfaceMethod == 0)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddMenuOptionST("ANIM_INTERFACE_MENU", "$MRT_SP_ANIM_INTERFACE_MENU", sGetAnimInerfaceArr()[iAnimInterface], flag)
    if MainScript.bModEnabled && (MainScript.iGetCurTotalAnimInterfaces() > 0)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("TRY_ALL_INTERFACES_TOGGLE", "$MRT_SP_TRY_ALL_INTERFACES_TOGGLE", MainScript.bTryAllInterfaces, flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_EXTRATAGS_SEXLAB")
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddInputOptionST("EXTRATAGS_SEXLAB_ORAL_MF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ORAL_MF_INPUT", getInputTags(MainScript.sExtraTags_SL_Oral_MF, MainScript.bExtraTags_SL_Oral_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_ORAL_FF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ORAL_FF_INPUT", getInputTags(MainScript.sExtraTags_SL_Oral_FF, MainScript.bExtraTags_SL_Oral_FF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_ORAL_MM_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ORAL_MM_INPUT", getInputTags(MainScript.sExtraTags_SL_Oral_MM, MainScript.bExtraTags_SL_Oral_MM_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_ANAL_MF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ANAL_MF_INPUT", getInputTags(MainScript.sExtraTags_SL_ANAL_MF, MainScript.bExtraTags_SL_ANAL_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_ANAL_FF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ANAL_FF_INPUT", getInputTags(MainScript.sExtraTags_SL_ANAL_FF, MainScript.bExtraTags_SL_ANAL_FF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_ANAL_MM_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_ANAL_MM_INPUT", getInputTags(MainScript.sExtraTags_SL_ANAL_MM, MainScript.bExtraTags_SL_ANAL_MM_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_VAGINAL_MF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_VAGINAL_MF_INPUT", getInputTags(MainScript.sExtraTags_SL_VAGINAL_MF, MainScript.bExtraTags_SL_VAGINAL_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_SEXLAB_VAGINAL_FF_INPUT", "$MRT_SP_EXTRATAGS_SEXLAB_VAGINAL_FF_INPUT", getInputTags(MainScript.sExtraTags_SL_VAGINAL_FF, MainScript.bExtraTags_SL_VAGINAL_FF_All, 13), flag)   
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_EXTRATAGS_OSTIM")
    AddInputOptionST("EXTRATAGS_OSTIM_ORAL_MF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ORAL_MF_INPUT", getInputTags(MainScript.sExtraTags_OS_Oral_MF, MainScript.bExtraTags_OS_Oral_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_ORAL_FF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ORAL_FF_INPUT", getInputTags(MainScript.sExtraTags_OS_Oral_FF, MainScript.bExtraTags_OS_Oral_FF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_ORAL_MM_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ORAL_MM_INPUT", getInputTags(MainScript.sExtraTags_OS_Oral_MM, MainScript.bExtraTags_OS_Oral_MM_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_ANAL_MF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ANAL_MF_INPUT", getInputTags(MainScript.sExtraTags_OS_Anal_MF, MainScript.bExtraTags_OS_Anal_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_ANAL_FF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ANAL_FF_INPUT", getInputTags(MainScript.sExtraTags_OS_Anal_FF, MainScript.bExtraTags_OS_Anal_FF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_ANAL_MM_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_ANAL_MM_INPUT", getInputTags(MainScript.sExtraTags_OS_Anal_MM, MainScript.bExtraTags_OS_Anal_MM_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_VAGINAL_MF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_VAGINAL_MF_INPUT", getInputTags(MainScript.sExtraTags_OS_VAGINAL_MF, MainScript.bExtraTags_OS_VAGINAL_MF_All, 13), flag)
    AddInputOptionST("EXTRATAGS_OSTIM_VAGINAL_FF_INPUT", "$MRT_SP_EXTRATAGS_OSTIM_VAGINAL_FF_INPUT", getInputTags(MainScript.sExtraTags_OS_VAGINAL_FF, MainScript.bExtraTags_OS_VAGINAL_FF_All, 13), flag)
    addEmptyOption()
    SetCursorPosition(1)
    _AddHeaderOption("$MRT_SP_HEAD_INTEGRATION_LICENSE")
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
    if MainScript.bModEnabled && (MainScript.bDibelEnabled || MainScript.bWhoreEnabled) 
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddSliderOptionST("CITIZEN_REPORT_CHANCE_SLIDER", "$MRT_SP_CITIZEN_REPORT_CHANCE_SLIDER1", MainScript.fCitizenReportChance, "$MRT_SP_CITIZEN_REPORT_CHANCE_SLIDER2", flag)
    AddSliderOptionST("GUARD_REPORT_CHANCE_SLIDER", "$MRT_SP_GUARD_REPORT_CHANCE_SLIDER1", MainScript.fGuardReportChance, "$MRT_SP_GUARD_REPORT_CHANCE_SLIDER2", flag)
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
    _AddToggleOptionST("WHORE_ALLOW_AGGRESSIVE_TOGGLE", "$MRT_SP_WHORE_ALLOW_AGGRESSIVE_TOGGLE", MainScript.bWhoreAllowAggressive, flag)
    AddSliderOptionST("WHORE_OWNER_SHARE_SLIDER", "$MRT_SP_WHORE_OWNER_SHARE_SLIDER1", MainScript.fWhoreOwnerShare, "$MRT_SP_WHORE_OWNER_SHARE_SLIDER2", flag)
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
    _AddToggleOptionST("DIBEL_ALLOW_AGGRESSIVE_TOGGLE", "$MRT_SP_DIBEL_ALLOW_AGGRESSIVE_TOGGLE", MainScript.bDIBELAllowAggressive, flag)
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

String[] function sGetAnimInerfaceMethodArr()
  String[] sAnimInterfaceMethods = new String[3]
  sAnimInterfaceMethods[0] = "$menu"
  sAnimInterfaceMethods[1] = "$ask"
  sAnimInterfaceMethods[2] = "$random"
  return sAnimInterfaceMethods
endFunction

String[] function sGetAnimInerfaceArr()
  Int i = 0
  String[] sAnimInterfaces
  if MainScript.bIsOstimActive
    i += 1
  endif
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
  if MainScript.bIsOstimActive
    sAnimInterfaces[i] = "$ostim_sa"
    i += 1
  endif
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
  if interfs[iAnimInterface] == "$ostim_sa"
    return 0
  elseif interfs[iAnimInterface] == "$sexlab"
    return 1
  elseif interfs[iAnimInterface] == "$flowergirls"
    return 2
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

state ANIM_INTERFACE_METHOD_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_ANIM_INTERFACE_METHOD_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iAnimInterfaceMethod = index
    _SetMenuOptionValueST(sGetAnimInerfaceMethodArr()[iAnimInterfaceMethod], True)
    ForcePageReset()
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iAnimInterfaceMethod)
    SetMenuDialogOptions(sGetAnimInerfaceMethodArr())
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
    MainScript.fBegPayMax = value
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

State CITIZEN_REPORT_CHANCE_SLIDER
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CITIZEN_REPORT_CHANCE_SLIDER")
  endevent
  event OnSliderAcceptST(float value)
    MainScript.fCitizenReportChance = value
    _SetSliderOptionValueST(MainScript.fCitizenReportChance, "$MRT_SP_CITIZEN_REPORT_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCitizenReportChance)
    SetSliderDialogDefaultValue(10.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
EndState

State GUARD_REPORT_CHANCE_SLIDER
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_GUARD_REPORT_CHANCE_SLIDER")
  endevent
  event OnSliderAcceptST(float value)
    MainScript.fGuardReportChance = value
    _SetSliderOptionValueST(MainScript.fGuardReportChance, "$MRT_SP_GUARD_REPORT_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fGuardReportChance)
    SetSliderDialogDefaultValue(90.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
EndState

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
	if MainScript.bModEnabled
      ShowMessage("Please close the MCM menu.", False)
      Utility.wait(0.5)
      MainQuest.Start()
      loadSettingsAtStart()
      Mainscript.setVars()
      Debug.Notification("Simple Prostitution enabled.")
	else
	  MainScript.ShutDown()
	  MainQuest.Stop()
	endif
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

state WHORE_ALLOW_AGGRESSIVE_TOGGLE
  event OnDefaultST()
    MainScript.bWhoreAllowAggressive = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ALLOW_AGGRESSIVE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreAllowAggressive = !MainScript.bWhoreAllowAggressive
    ForcePageReset()
  endevent
endstate

state Dibel_ALLOW_AGGRESSIVE_TOGGLE
  event OnDefaultST()
    MainScript.bDibelAllowAggressive = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_Dibel_ALLOW_AGGRESSIVE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelAllowAggressive = !MainScript.bDibelAllowAggressive
    ForcePageReset()
  endevent
endstate


state TRY_ALL_INTERFACES_TOGGLE
  event OnDefaultST()
    MainScript.bTryAllInterfaces = True
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_TRY_ALL_INTERFACES_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bTryAllInterfaces = !MainScript.bTryAllInterfaces
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

state WHORE_OWNER_SHARE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_OWNER_SHARE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreOwnerShare = value
    _SetSliderOptionValueST(MainScript.fWhoreOwnerShare, "$MRT_SP_WHORE_OWNER_SHARE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreOwnerShare)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
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
    Mainscript.player.AddToFaction(Mainscript.whoreFaction)
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreEnabled = !MainScript.bWhoreEnabled
    if MainScript.bWhoreEnabled
      Mainscript.player.AddToFaction(Mainscript.whoreFaction)
    else
      Mainscript.player.RemoveFromFaction(Mainscript.whoreFaction)
    endif
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

State EXTRATAGS_SEXLAB_ORAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Oral_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Oral_MF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Oral_MF_ALL = true
      else
        MainScript.bExtraTags_SL_Oral_MF_ALL = False
      endIf
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ORAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_ORAL_MM_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Oral_MM)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Oral_MM = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Oral_MM_ALL = true
      else
        MainScript.bExtraTags_SL_Oral_MM_ALL = False
      endIf
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ORAL_MM_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_ORAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Oral_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Oral_FF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Oral_FF_ALL = true
      else
        MainScript.bExtraTags_SL_Oral_FF_ALL = False
      endIf
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ORAL_FF_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_ANAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Anal_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Anal_MF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Anal_MF_ALL = true
      else
        MainScript.bExtraTags_SL_Anal_MF_ALL = False
      endIf
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ANAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_ANAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_ANAL_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_ANAL_FF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Anal_FF_ALL = true
      else
        MainScript.bExtraTags_SL_Anal_FF_ALL = False
      endIf
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ANAL_FF_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_ANAL_MM_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Anal_MM)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Anal_MM = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Anal_MM_ALL = true
      else
        MainScript.bExtraTags_SL_Anal_MM_ALL = False
      endIf      
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_ANAL_MM_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_VAGINAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Vaginal_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Vaginal_MF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_VAGINAL_MF_ALL = true
      else
        MainScript.bExtraTags_SL_VAGINAL_MF_ALL = False
      endIf   
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_VAGINAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_SEXLAB_VAGINAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_SL_Vaginal_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_SL_Vaginal_FF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_SL_Vaginal_FF_ALL = true
      else
        MainScript.bExtraTags_SL_Vaginal_FF_ALL = False
      endIf  
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_SEXLAB_VAGINAL_FF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ORAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Oral_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Oral_MF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Oral_MF_ALL = true
      else
        MainScript.bExtraTags_OS_Oral_MF_ALL = False
      endIf  
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ORAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ORAL_MM_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Oral_MM)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Oral_MM = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Oral_MM_ALL = true
      else
        MainScript.bExtraTags_OS_Oral_MM_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ORAL_MM_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ORAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Oral_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Oral_FF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Oral_FF_ALL = true
      else
        MainScript.bExtraTags_OS_Oral_FF_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ORAL_FF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ANAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_ANAL_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Anal_MF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Anal_MF_ALL = true
      else
        MainScript.bExtraTags_OS_Anal_MF_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ANAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ANAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Anal_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Anal_FF = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Anal_FF_ALL = true
      else
        MainScript.bExtraTags_OS_Anal_FF_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ANAL_FF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_ANAL_MM_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Anal_MM)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Anal_MM = str
      if str && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Anal_MM_ALL = true
      else
        MainScript.bExtraTags_OS_Anal_MM_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_ANAL_MM_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_VAGINAL_MF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_Vaginal_MF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_Vaginal_MF = str
      if Text && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Vaginal_MF_ALL = true
      else
        MainScript.bExtraTags_OS_Vaginal_MF_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_VAGINAL_MF_INPUT")
  endevent
EndState

State EXTRATAGS_OSTIM_VAGINAL_FF_INPUT
  event OnInputOpenST()
    SetInputDialogStartText(MainScript.sExtraTags_OS_VAGINAL_FF)
  endEvent

  event OnInputAcceptST(string Text)
    String str = sTrimTags(Text)
    If StringUtil.GetLength(str) > 30
      ShowMessage("Text is too long, 30 Characters Maximum", false)
    else
      MainScript.sExtraTags_OS_VAGINAL_FF = str
      if Text && ShowMessage("All tags required?", true, "$Yes", "$No")
        MainScript.bExtraTags_OS_Vaginal_FF_ALL = true
      else
        MainScript.bExtraTags_OS_Vaginal_FF_ALL = False
      endif
      ForcePageReset()
    endif
  endEvent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_EXTRATAGS_OSTIM_VAGINAL_FF_INPUT")
  endevent
EndState

State DEBUG_MOD_VERSION_TXT
endstate

State DEBUG_SEXLAB_CHECK_TXT
endstate

State DEBUG_FLOWERGIRLS_CHECK_TXT
endstate

State DEBUG_LICENSES_CHECK_TXT
endstate

State DEBUG_OSTIM_CHECK_TXT
endState

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
        Mainscript.setVars()
		    ForcePageReset()
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
  MainScript.bDibelEnabled = jsonutil.GetPathIntValue(settings_path, "bDibelEnabled", MainScript.bDibelEnabled as Int)
  MainScript.bDibelAgent = jsonutil.GetPathIntValue(settings_path, "bDibelAgent", MainScript.bDibelAgent as Int)
  MainScript.bDibelCrown = jsonutil.GetPathIntValue(settings_path, "bDibelCrown", MainScript.bDibelCrown as Int)
  MainScript.bDibelNaked = jsonutil.GetPathIntValue(settings_path, "bDibelNaked", MainScript.bDibelNaked as Int)
  MainScript.bWhoreAllowAggressive = jsonutil.GetPathIntValue(settings_path, "bWhoreAllowAggressive", MainScript.bWhoreAllowAggressive as Int)
  MainScript.bDibelAllowAggressive = jsonutil.GetPathIntValue(settings_path, "bDibelAllowAggressive", MainScript.bDibelAllowAggressive as Int)
  MainScript.bTryAllInterfaces = jsonutil.GetPathIntValue(settings_path, "bTryAllInterfaces", MainScript.bTryAllInterfaces as Int)
  MainScript.bExtraTags_SL_Oral_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Oral_MF_ALL", MainScript.bExtraTags_SL_Oral_MF_ALL as Int)
  MainScript.bExtraTags_SL_Oral_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Oral_FF_ALL", MainScript.bExtraTags_SL_Oral_FF_ALL as Int)
  MainScript.bExtraTags_SL_Oral_MM_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Oral_MM_ALL", MainScript.bExtraTags_SL_Oral_MM_ALL as Int)
  MainScript.bExtraTags_SL_Anal_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Anal_MF_ALL", MainScript.bExtraTags_SL_Anal_MF_ALL as Int)
  MainScript.bExtraTags_SL_Anal_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Anal_FF_ALL", MainScript.bExtraTags_SL_Anal_FF_ALL as Int)
  MainScript.bExtraTags_SL_Anal_MM_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Anal_MM_ALL", MainScript.bExtraTags_SL_Anal_MM_ALL as Int) 
  MainScript.bExtraTags_SL_Vaginal_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Vaginal_MF_ALL", MainScript.bExtraTags_SL_Vaginal_MF_ALL as Int)
  MainScript.bExtraTags_SL_Vaginal_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_SL_Vaginal_FF_ALL", MainScript.bExtraTags_SL_Vaginal_FF_ALL as Int)
  MainScript.bExtraTags_OS_Oral_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Oral_MF_ALL", MainScript.bExtraTags_OS_Oral_MF_ALL as Int)
  MainScript.bExtraTags_OS_Oral_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Oral_FF_ALL", MainScript.bExtraTags_OS_Oral_FF_ALL as Int)
  MainScript.bExtraTags_OS_Oral_MM_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Oral_MM_ALL", MainScript.bExtraTags_OS_Oral_MM_ALL as Int)
  MainScript.bExtraTags_OS_Anal_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Anal_MF_ALL", MainScript.bExtraTags_OS_Anal_MF_ALL as Int)
  MainScript.bExtraTags_OS_Anal_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Anal_FF_ALL", MainScript.bExtraTags_OS_Anal_FF_ALL as Int)
  MainScript.bExtraTags_OS_Anal_MM_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Anal_MM_ALL", MainScript.bExtraTags_OS_Anal_MM_ALL as Int) 
  MainScript.bExtraTags_OS_Vaginal_MF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Vaginal_MF_ALL", MainScript.bExtraTags_OS_Vaginal_MF_ALL as Int)
  MainScript.bExtraTags_OS_Vaginal_FF_ALL = jsonutil.GetPathIntValue(settings_path, "bExtraTags_OS_Vaginal_FF_ALL", MainScript.bExtraTags_OS_Vaginal_FF_ALL as Int)
  
  iBeggarSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  iWhoreSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  iDibelSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)
  iAnimInterfaceMethod = jsonutil.GetPathIntValue(settings_path, "iAnimInterfaceMethod", iAnimInterfaceMethod)

  MainScript.fWhoreOwnerShare = jsonutil.GetPathFloatValue(settings_path, "fWhoreOwnerShare", MainScript.fWhoreOwnerShare)
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
  MainScript.fCitizenReportChance = jsonutil.GetPathFloatValue(settings_path, "fCitizenReportChance", MainScript.fCitizenReportChance)
  MainScript.fGuardReportChance = jsonutil.GetPathFloatValue(settings_path, "fGuardReportChance", MainScript.fGuardReportChance)

  MainScript.sExtraTags_SL_Oral_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Oral_MF", MainScript.sExtraTags_SL_Oral_MF)
  MainScript.sExtraTags_SL_Oral_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Oral_FF", MainScript.sExtraTags_SL_Oral_FF)
  MainScript.sExtraTags_SL_Oral_MM = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Oral_MM", MainScript.sExtraTags_SL_Oral_MM)
  MainScript.sExtraTags_SL_Anal_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Anal_MF", MainScript.sExtraTags_SL_Anal_MF)
  MainScript.sExtraTags_SL_Anal_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Anal_FF", MainScript.sExtraTags_SL_Anal_FF)
  MainScript.sExtraTags_SL_Anal_MM = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Anal_MM", MainScript.sExtraTags_SL_Anal_MM)
  MainScript.sExtraTags_SL_Vaginal_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Vaginal_MF", MainScript.sExtraTags_SL_Vaginal_MF)
  MainScript.sExtraTags_SL_Vaginal_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_SL_Vaginal_FF", MainScript.sExtraTags_SL_Vaginal_FF) 
  MainScript.sExtraTags_OS_Oral_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Oral_MF", MainScript.sExtraTags_OS_Oral_MF)
  MainScript.sExtraTags_OS_Oral_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Oral_FF", MainScript.sExtraTags_OS_Oral_FF)
  MainScript.sExtraTags_OS_Oral_MM = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Oral_MM", MainScript.sExtraTags_OS_Oral_MM)
  MainScript.sExtraTags_OS_Anal_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Anal_MF", MainScript.sExtraTags_OS_Anal_MF)
  MainScript.sExtraTags_OS_Anal_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Anal_FF", MainScript.sExtraTags_OS_Anal_FF)
  MainScript.sExtraTags_OS_Anal_MM = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Anal_MM", MainScript.sExtraTags_OS_Anal_MM)
  MainScript.sExtraTags_OS_Vaginal_MF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Vaginal_MF", MainScript.sExtraTags_OS_Vaginal_MF)
  MainScript.sExtraTags_OS_Vaginal_FF = jsonutil.GetPathStringValue(settings_path, "sExtraTags_OS_Vaginal_FF", MainScript.sExtraTags_OS_Vaginal_FF)
  
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
  jsonutil.SetPathIntValue(settings_path, "bDibelEnabled", MainScript.bDibelEnabled as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelAgent", MainScript.bDibelAgent as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelCrown", MainScript.bDibelCrown as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelNaked", MainScript.bDibelNaked as Int)
  jsonutil.SetPathIntValue(settings_path, "bWhoreAllowAggressive", MainScript.bWhoreAllowAggressive as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelAllowAggressive", MainScript.bDibelAllowAggressive as Int)
  jsonutil.SetPathIntValue(settings_path, "bTryAllInterfaces", MainScript.bTryAllInterfaces as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Oral_MF_ALL", MainScript.bExtraTags_SL_Oral_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Oral_FF_ALL", MainScript.bExtraTags_SL_Oral_FF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Oral_MM_ALL", MainScript.bExtraTags_SL_Oral_MM_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Anal_MF_ALL", MainScript.bExtraTags_SL_Anal_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Anal_FF_ALL", MainScript.bExtraTags_SL_Anal_FF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Anal_MM_ALL", MainScript.bExtraTags_SL_Anal_MM_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Vaginal_MF_ALL", MainScript.bExtraTags_SL_Vaginal_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_SL_Vaginal_FF_ALL", MainScript.bExtraTags_SL_Vaginal_FF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Oral_MF_ALL", MainScript.bExtraTags_OS_Oral_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Oral_FF_ALL", MainScript.bExtraTags_OS_Oral_FF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Oral_MM_ALL", MainScript.bExtraTags_OS_Oral_MM_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Anal_MF_ALL", MainScript.bExtraTags_OS_Anal_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Anal_FF_ALL", MainScript.bExtraTags_OS_Anal_FF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Anal_MM_ALL", MainScript.bExtraTags_OS_Anal_MM_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Vaginal_MF_ALL", MainScript.bExtraTags_OS_Vaginal_MF_ALL as Int)
  jsonutil.SetPathIntValue(settings_path, "bExtraTags_OS_Vaginal_FF_ALL", MainScript.bExtraTags_OS_Vaginal_FF_ALL as Int)
 
  jsonutil.SetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iAnimInterfaceMethod", iAnimInterfaceMethod)
  
  jsonutil.SetPathFloatValue(settings_path, "fWhoreOwnerShare", MainScript.fWhoreOwnerShare)
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
  jsonutil.SetPathFloatValue(settings_path, "fCitizenReportChance", MainScript.fCitizenReportChance)
  jsonutil.SetPathFloatValue(settings_path, "fGuardReportChance", MainScript.fGuardReportChance)

  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Oral_MF", MainScript.sExtraTags_SL_Oral_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Oral_FF", MainScript.sExtraTags_SL_Oral_FF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Oral_MM", MainScript.sExtraTags_SL_Oral_MM)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Anal_MF", MainScript.sExtraTags_SL_Anal_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Anal_FF", MainScript.sExtraTags_SL_Anal_FF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Anal_MM", MainScript.sExtraTags_SL_Anal_MM)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Vaginal_MF", MainScript.sExtraTags_SL_Vaginal_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_SL_Vaginal_FF", MainScript.sExtraTags_SL_Vaginal_FF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Oral_MF", MainScript.sExtraTags_OS_Oral_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Oral_FF", MainScript.sExtraTags_OS_Oral_FF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Oral_MM", MainScript.sExtraTags_OS_Oral_MM)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Anal_MF", MainScript.sExtraTags_OS_Anal_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Anal_FF", MainScript.sExtraTags_OS_Anal_FF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Anal_MM", MainScript.sExtraTags_OS_Anal_MM)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Vaginal_MF", MainScript.sExtraTags_OS_Vaginal_MF)
  jsonutil.SetPathStringValue(settings_path, "sExtraTags_OS_Vaginal_FF", MainScript.sExtraTags_OS_Vaginal_FF)

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

String function shortenString(String sString, Int iLimit) Global
  Int iLen = StringUtil.GetLength(sString)
  if iLimit < 4
    if iLimit < 1
      return sString
    endif
    if iLen > iLimit
      return StringUtil.Substring(sString, 0, iLimit)
    endif
    return sString
  elseif iLen < 4
    return sString
  endif
  if iLen > iLimit
    return StringUtil.Substring(sString, 0, len=iLimit - 3) + "..."
  endif
  return sString
endfunction

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


String Function sTrimTags(string StrInput)
  int i = 0
  String strOutput = ""
  string sChar = ""
  while i < stringUtil.GetLength(StrInput)
    sChar = stringUtil.GetNthChar(StrInput, i)
    if (sChar == ",") || (sChar == ";") || (sChar == " ")
      if i > 0
        if (stringUtil.GetNthChar(StrInput, i - 1) != ";") && (stringUtil.GetNthChar(StrInput, i - 1) != ",") && (stringUtil.GetNthChar(StrInput, i - 1) != " ")
          strOutput += ","
        endif
      endif
    else
      strOutput += sChar
    endif
    i += 1
  endWhile
  if stringUtil.GetLength(strOutput) > 0
    While (stringUtil.GetLength(strOutput) > 0) && (stringUtil.GetNthChar(strOutput, 0) == ",")
      strOutput = stringUtil.Substring(strOutput,1)
    endWhile 
    While (stringUtil.GetLength(strOutput) > 0) && (stringUtil.GetNthChar(strOutput, stringUtil.GetLength(strOutput) - 1) == ",")
      strOutput = stringUtil.Substring(strOutput, 0, stringUtil.GetLength(strOutput) - 1)
    endWhile  
  endif
  if strOutput == ","
    strOutput == ""
  endif
  return strOutput
endFunction

String Function BoolAsIntToStr(Bool bBool)
  return (bBool As Int) As String
endFunction

string Function getInputTags(string sTags, Bool bReqAll, int iMaxLen = 10)
  if sTags
    return shortenString(sTags, iMaxLen) + " RequireAll=" + BoolAsIntToStr(bReqAll)
  endif
  return ""
endFunction