Scriptname zzzmrt_sp_mcm_qst_script extends SKI_ConfigBase

import zzzmrt_sp_utility

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
Int property iAnimInterface auto Hidden
Int Property iWhoreSpeechDifficulty = 3 Auto Hidden
Int Property iDibelSpeechDifficulty = 2 Auto Hidden
Int Property iBeggarSpeechDifficulty = 4 Auto Hidden
Int Property iAnimInterfaceMethod = 0 Auto Hidden
Int Property iWhoreStatRace = 0 Auto Hidden
Int Property iDibelStatRace = 0 Auto Hidden

Bool Property bDibelOralPerkRewardReceived = False Auto Hidden
Bool Property bDibelAnalPerkRewardReceived = False Auto Hidden
Bool Property bDibelVaginalPerkRewardReceived = False Auto Hidden

Bool Property bWhoreOralPerkRewardReceived = False Auto Hidden
Bool Property bWhoreAnalPerkRewardReceived = False Auto Hidden
Bool Property bWhoreVaginalPerkRewardReceived = False Auto Hidden

Int Property iTotalHealthRecieved = 0 Auto Hidden
Int Property iTotalMagickaRecieved = 0 Auto Hidden
Int Property iTotalStaminaRecieved = 0 Auto Hidden
Int Property iTotalSkillLevelRecieved = 0 Auto Hidden
Int Property iTotalPerkPointRecieved = 0 Auto Hidden
Int Property iTotalDDKeyRecieved = 0 Auto Hidden
Int Property iTotalCarryWeightRecieved = 0 Auto Hidden
Int Property iTotalOfferedMarks = 0 Auto Hidden
Int Property iTotalRefundableOfferedMarks = 0 Auto Hidden

String settings_path = "..\\simple-prostitution\\user-settings"
String data_path = "..\\simple-prostitution\\user-data"

Int flag

event OnConfigInit()
  ModName = "Simple Prostitution"
  initPages()
  loadSettingsAtStart()
  Mainscript.setVars()
endevent

function initPages()
  Pages = new String[6]
  pages[0] = "$MRT_SP_PAGE_PROSTITUTION"
  pages[1] = "$MRT_SP_PAGE_BEGGING"
  pages[2] = "$MRT_SP_PAGE_STD"
  pages[3] = "$MRT_SP_PAGE_INTEGRATION"
  pages[4] = "$MRT_SP_PAGE_STATS"
  pages[5] = "$MRT_SP_PAGE_DEBUG"
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
    addEmptyOption()
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
    if MainScript.bIsPO3ExtenderActive && Mainscript.bIsPapyrusUtilActive
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf
    _AddTextOptionST("LOAD_USER_DATA_TXT", "$MRT_SP_LOAD_DATA", "$go", flag)
    if MainScript.bIsPO3ExtenderActive
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_DEBUG_CLOTHING")
    Armor chestArmor = (MainScript.Player.GetWornForm(0x00000004) As Armor)
    if chestArmor
      _AddTextOptionST("WHORE_TAG_CLOTH_NAME_TXT", shortenString(chestArmor.GetName(), 32), "", OPTION_FLAG_DISABLED) 
      If chestArmor.HasKeyword(MainScript.ProstituteClothing_kwd)
        _AddTextOptionST("WHORE_TAG_CHEST_CLOTH_TXT", "$MRT_SP_WHORE_TAG_CHEST_CLOTH_ON", "", flag) 
      else 
        _AddTextOptionST("WHORE_TAG_CHEST_CLOTH_TXT", "$MRT_SP_WHORE_TAG_CHEST_CLOTH_OFF", "", flag) 
      endif
      If chestArmor.HasKeyword(MainScript.BeggarClothing_kwd)
        _AddTextOptionST("BEG_TAG_CHEST_CLOTH_TXT", "$MRT_SP_BEG_TAG_CHEST_CLOTH_ON", "", flag) 
      else 
        _AddTextOptionST("BEG_TAG_CHEST_CLOTH_TXT", "$MRT_SP_BEG_TAG_CHEST_CLOTH_OFF", "", flag) 
      endif
    else
      _addTextOptionST("WHORE_TAG_CHEST_CLOTH_TXT", "$MRT_SP_WHORE_TAG_CHEST_CLOTH_OFF", "", OPTION_FLAG_DISABLED) 
      _AddTextOptionST("BEG_TAG_CHEST_CLOTH_TXT", "$MRT_SP_BEG_TAG_CHEST_CLOTH_OFF", "", OPTION_FLAG_DISABLED) 
    endif
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_DEBUG_LOCATION")
    Cell cel = MainScript.Player.GetParentCell()
    Location loc = MainScript.Player.GetCurrentLocation()
    if loc && cel
      _AddTextOptionST("WHORE_TAG_LOC_NAME_TXT", shortenString(loc.GetName(), 32), "", OPTION_FLAG_DISABLED) 
      if cel.IsInterior()
        if loc.HasKeyword(Mainscript.prostituteLocation_KWD)
          _AddTextOptionST("WHORE_TAG_LOC_TXT", "$MRT_SP_WHORE_TAG_LOC_ON", "", flag) 
        else
          _AddTextOptionST("WHORE_TAG_LOC_TXT", "$MRT_SP_WHORE_TAG_LOC_OFF", "", flag) 
        endif
      else
        _AddTextOptionST("WHORE_TAG_LOC_TXT", "$MRT_SP_WHORE_TAG_LOC_ERR", "", OPTION_FLAG_DISABLED) 
      endif
    else
      _AddTextOptionST("WHORE_TAG_LOC_TXT", "$MRT_SP_WHORE_TAG_LOC_OFF", "", OPTION_FLAG_DISABLED) 
    Endif
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_DEBUG_NPC")
    Actor npc = Game.GetCurrentCrosshairRef() As Actor
    if !npc
      npc = Game.GetCurrentConsoleRef() As Actor
    endif
    if npc && (npc != MainScript.player)
      _AddTextOptionST("WHORE_TAG_NPC_NAME_TXT", shortenString(npc.GetBaseObject().GetName(), 32), "", OPTION_FLAG_DISABLED) 
      if Mainscript.bCanPimp(npc)
        if npc.HasKeyword(Mainscript.prostituteManager_KWD)
          _AddTextOptionST("WHORE_TAG_OWNER_TXT", "$MRT_SP_WHORE_TAG_OWNER_ON", "", flag) 
        else
          _AddTextOptionST("WHORE_TAG_OWNER_TXT", "$MRT_SP_WHORE_TAG_OWNER_OFF", "", flag) 
        endif
      else
        _AddTextOptionST("WHORE_TAG_OWNER_TXT", "$MRT_SP_WHORE_TAG_OWNER_ERR", "", OPTION_FLAG_DISABLED)
      endif
      if Mainscript.bCanHeal(npc)
        if npc.HasKeyword(Mainscript.stdHealer_KWD)
          _AddTextOptionST("WHORE_TAG_HEALER_TXT", "$MRT_SP_WHORE_TAG_HEALER_ON", "", flag) 
        else
          _AddTextOptionST("WHORE_TAG_HEALER_TXT", "$MRT_SP_WHORE_TAG_HEALER_OFF", "", flag) 
        endif
      else
        _AddTextOptionST("WHORE_TAG_HEALER_TXT", "$MRT_SP_WHORE_TAG_HEALER_ERR", "", OPTION_FLAG_DISABLED) 
      endif
    else
      _AddTextOptionST("WHORE_TAG_OWNER_TXT", "$MRT_SP_WHORE_TAG_OWNER_OFF", "", OPTION_FLAG_DISABLED)
      _AddTextOptionST("WHORE_TAG_HEALER_TXT", "$MRT_SP_WHORE_TAG_HEALER_OFF", "", OPTION_FLAG_DISABLED) 
    endif

    SetCursorPosition(1)
    flag = OPTION_FLAG_DISABLED
    _AddTextOptionST("DEBUG_MOD_VERSION_TXT", "Simple Prostitution v" + MainScript.getCurrentVersion(), "", flag)
    addEmptyOption()
    _AddTextOptionST("DEBUG_PAPYRUSUTIL_CHECK_TXT", "$papyrusutil", MainScript.bIsPapyrusUtilActive As String, flag)
     _AddTextOptionST("DEBUG_PO3EXTENDER_CHECK_TXT", "$po3extender", MainScript.bIsPO3ExtenderActive As String, flag)
    _AddTextOptionST("DEBUG_SEXLAB_CHECK_TXT", "$sexlab", MainScript.bIsSexlabActive As String, flag)
    _AddTextOptionST("DEBUG_FLOWERGIRLS_CHECK_TXT", "$flowergirls", MainScript.bIsFlowerGirlsActive As String, flag)
    _AddTextOptionST("DEBUG_OSTIM_CHECK_TXT", "$ostim_sa", MainScript.bIsOstimActive As String, flag)
    _AddTextOptionST("DEBUG_LICENSES_CHECK_TXT", "$licenses", MainScript.bIsLicensesActive As String, flag)
  elseif (page == "$MRT_SP_PAGE_STATS")
    Mainscript.initStatArrs()
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    SetTitleText("$MRT_SP_PAGE_STATS")
    _AddHeaderOption("$MRT_SP_HEAD_WHORE_TOTAL_STATS")
    _AddTextOptionST("STAT_WHORE_ORAL_TXT", "$MRT_SP_STAT_ORAL",  sGetSexStatText(2, False, False), flag)
    _AddTextOptionST("STAT_WHORE_ANAL_TXT", "$MRT_SP_STAT_ANAL",  sGetSexStatText(1, False, False), flag)
    _AddTextOptionST("STAT_WHORE_VAGINAL_TXT", "$MRT_SP_STAT_VAGINAL",  sGetSexStatText(0, False, False), flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_WHORE_RACE_STATS")
    AddMenuOptionST("STAT_WHORE_RACE_MENU", "$MRT_SP_WHORE_RACE_STAT_MENU", sGetRaceNameArr()[iWhoreStatRace], flag)
    _AddTextOptionST("STAT_WHORE_RACE_ORAL_TXT", "$MRT_SP_STAT_ORAL", sGetSexStatText(2, True, False), flag)
    _AddTextOptionST("STAT_WHORE_RACE_ANAL_TXT", "$MRT_SP_STAT_ANAL", sGetSexStatText(1, True, False), flag)
    _AddTextOptionST("STAT_WHORE_RACE_VAGINAL_TXT", "$MRT_SP_STAT_VAGINAL", sGetSexStatText(0, True, False), flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_WHORE_REWARD_STATS")
    if MainScript.bModEnabled && !bWhoreOralPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddTextOptionST("STAT_WHORE_ORAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_ORAL", sGetStatRewardText(2, False), flag)
     if MainScript.bModEnabled && !bWhoreAnalPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif   
    _AddTextOptionST("STAT_WHORE_ANAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_ANAL", sGetStatRewardText(1, False), flag)
     if MainScript.bModEnabled && !bWhoreVaginalPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif      
    _AddTextOptionST("STAT_WHORE_VAGINAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_VAGINAL", sGetStatRewardText(0, False), flag)
    SetCursorPosition(1)
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL_TOTAL_STATS")
    _AddTextOptionST("STAT_DIBEL_ORAL_TXT", "$MRT_SP_STAT_ORAL", sGetSexStatText(2, False, True), flag)
    _AddTextOptionST("STAT_DIBEL_ANAL_TXT", "$MRT_SP_STAT_ANAL",  sGetSexStatText(1, False, True), flag)
    _AddTextOptionST("STAT_DIBEL_VAGINAL_TXT", "$MRT_SP_STAT_VAGINAL",  sGetSexStatText(0, False, True), flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL_RACE_STATS")
    AddMenuOptionST("STAT_DIBEL_RACE_MENU", "$MRT_SP_DIBEL_RACE_STAT_MENU", sGetRaceNameArr()[iDibelStatRace], flag)
    _AddTextOptionST("STAT_DIBEL_RACE_ORAL_TXT", "$MRT_SP_STAT_ORAL", sGetSexStatText(2, True, True), flag)
    _AddTextOptionST("STAT_DIBEL_RACE_ANAL_TXT", "$MRT_SP_STAT_ANAL", sGetSexStatText(1, True, True), flag)
    _AddTextOptionST("STAT_DIBEL_RACE_VAGINAL_TXT", "$MRT_SP_STAT_VAGINAL", sGetSexStatText(0, True, True), flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL_REWARD_STATS")
     if MainScript.bModEnabled && !bDibelOralPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif 
    _AddTextOptionST("STAT_DIBEL_ORAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_ORAL", sGetStatRewardText(2, True), flag)
     if MainScript.bModEnabled && !bDibelAnalPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif 
    _AddTextOptionST("STAT_DIBEL_ANAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_ANAL", sGetStatRewardText(1, True), flag)
     if MainScript.bModEnabled && !bDibelVaginalPerkRewardReceived
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif 
    _AddTextOptionST("STAT_DIBEL_VAGINAL_PERK_REWARD_TXT", "$MRT_SP_PERK_REWARD_VAGINAL", sGetStatRewardText(0, True), flag)
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
    _AddToggleOptionST("BEGGING_CLOTHING_TOGGLE", "$MRT_SP_BEGGING_CLOTHING_TOGGLE", MainScript.bBeggingClothing, flag)
    _AddToggleOptionST("BEG_POOR_HELP_TOGGLE", "$MRT_SP_BEG_POOR_HELP_TOGGLE", MainScript.bPoorHelpBeggar, flag)
    _AddToggleOptionST("BEG_GUARD_HELP_TOGGLE", "$MRT_SP_BEG_GUARD_HELP_TOGGLE", MainScript.bGuardHelpBeggar, flag)
    AddSliderOptionST("BEG_PAY_MIN_SLIDER", "$MRT_SP_BEG_PAY_MIN_SLIDER1", MainScript.fBegPayMin, "$MRT_SP_BEG_PAY_MIN_SLIDER2", flag)
    AddSliderOptionST("BEG_PAY_MAX_SLIDER", "$MRT_SP_BEG_PAY_MAX_SLIDER1", MainScript.fBegPayMax, "$MRT_SP_BEG_PAY_MAX_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MIN_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER1", MainScript.fMinSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MIN_MULT_SLIDER2", flag)
    AddSliderOptionST("SPEECH_BEG_BONUS_MAX_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER1", MainScript.fMaxSpeechBegBonusMult, "$MRT_SP_SPEECH_BEG_BONUS_MAX_MULT_SLIDER2", flag)
    AddMenuOptionST("BEG_ACCEPT_DIFFICULTY_MENU", "$MRT_SP_BEG_ACCEPT_DIFFICULTY_MENU", sGetSpeechDifficultyArr()[iBeggarSpeechDifficulty], flag)
    AddSliderOptionST("SPEECH_BEG_XP_MULT_SLIDER", "$MRT_SP_SPEECH_BEG_XP_MULT_SLIDER1", MainScript.fBeggarPersuasionXPMult, "$MRT_SP_SPEECH_BEG_XP_MULT_SLIDER2", flag)
    SetCursorPosition(1)
    _AddHeaderOption("$MRT_SP_HEAD_BEG_WHORE")
    AddSliderOptionST("BEG_SEX_OFFER_SLIDER", "$MRT_SP_BEG_SEX_OFFER_SLIDER1", MainScript.fBeggarSexOfferChance, "$MRT_SP_BEG_SEX_OFFER_SLIDER2", flag)
    _AddToggleOptionST("BEGGING_MALE_SEX_OFFER_TOGGLE", "$MRT_SP_BEGGING_MALE_SEX_OFFER_TOGGLE", MainScript.bBeggingMaleSexOffer, flag)
    _AddToggleOptionST("BEGGING_FEMALE_SEX_OFFER_TOGGLE", "$MRT_SP_BEGGING_FEMALE_SEX_OFFER_TOGGLE", MainScript.bBeggingFemaleSexOffer, flag)
    AddSliderOptionST("BEG_MALE_RAPE_SLIDER", "$MRT_SP_BEG_MALE_RAPE_SLIDER1", MainScript.fBeggingMaleRapistChance, "$MRT_SP_BEG_MALE_RAPE_SLIDER2", flag)
    AddSliderOptionST("BEG_FEMALE_RAPE_SLIDER", "$MRT_SP_BEG_FEMALE_RAPE_SLIDER1", MainScript.fBeggingFemaleRapistChance, "$MRT_SP_BEG_FEMALE_RAPE_SLIDER2", flag)
  elseif (page == "$MRT_SP_PAGE_STD")
    SetTitleText("$MRT_SP_PAGE_STD")
    _AddHeaderOption("$MRT_SP_HEAD_STD")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    AddSliderOptionST("CURE_NORMAL_COST_SLIDER", "$MRT_SP_CURE_NORMAL_COST_SLIDER1", MainScript.fCureNormalDiseaseCost, "$MRT_SP_CURE_NORMAL_COST_SLIDER2", flag)
    AddSliderOptionST("CURE_STDI_COST_SLIDER", "$MRT_SP_CURE_STDI_COST_SLIDER1", MainScript.fCureSTDICost, "$MRT_SP_CURE_STDI_COST_SLIDER2", flag)
    AddSliderOptionST("CURE_STDII_COST_SLIDER", "$MRT_SP_CURE_STDII_COST_SLIDER1", MainScript.fCureSTDIICost, "$MRT_SP_CURE_STDII_COST_SLIDER2", flag)
    AddSliderOptionST("CURE_STDIII_COST_SLIDER", "$MRT_SP_CURE_STDIII_COST_SLIDER1", MainScript.fCureSTDIIICost, "$MRT_SP_CURE_STDIII_COST_SLIDER2", flag)
    AddSliderOptionST("CURE_STDIV_COST_SLIDER", "$MRT_SP_CURE_STDIV_COST_SLIDER1", MainScript.fCureSTDIVCost, "$MRT_SP_CURE_STDIV_COST_SLIDER2", flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_STD_NORMAL")
    AddSliderOptionST("NORMAL_STD_INFECT_CHANCE_SLIDER", "$MRT_SP_NORMAL_STD_INFECT_CHANCE_SLIDER1", MainScript.fNormalSTDInfectChance, "$MRT_SP_NORMAL_STD_INFECT_CHANCE_SLIDER2", flag)
    AddSliderOptionST("NORMAL_STD_PROGRESS_CHANCE_SLIDER", "$MRT_SP_NORMAL_STD_PROGRESS_CHANCE_SLIDER1", MainScript.fNormalSTDProgressChance, "$MRT_SP_NORMAL_STD_PROGRESS_CHANCE_SLIDER2", flag)
    _AddToggleOptionST("NORMAL_ALLOW_MULTIPLE_STD_TOGGLE", "$MRT_SP_NORMAL_ALLOW_MULTIPLE_STD_TOGGLE", MainScript.bNormalAllowMultipleSTDs, flag)
    SetCursorPosition(1)
    _AddHeaderOption("$MRT_SP_HEAD_STD_WHORE")
    AddSliderOptionST("WHORE_STD_INFECT_CHANCE_SLIDER", "$MRT_SP_WHORE_STD_INFECT_CHANCE_SLIDER1", MainScript.fWhoreSTDInfectChance, "$MRT_SP_WHORE_STD_INFECT_CHANCE_SLIDER2", flag)
    AddSliderOptionST("WHORE_STD_PROGRESS_CHANCE_SLIDER", "$MRT_SP_WHORE_STD_PROGRESS_CHANCE_SLIDER1", MainScript.fWhoreSTDProgressChance, "$MRT_SP_WHORE_STD_PROGRESS_CHANCE_SLIDER2", flag)
    _AddToggleOptionST("WHORE_ALLOW_MULTIPLE_STD_TOGGLE", "$MRT_SP_WHORE_ALLOW_MULTIPLE_STD_TOGGLE", MainScript.bWhoreAllowMultipleSTDs, flag)
    addEmptyOption()
    _AddHeaderOption("$MRT_SP_HEAD_STD_DIBEL")
    AddSliderOptionST("DIBEL_STD_INFECT_CHANCE_SLIDER", "$MRT_SP_DIBEL_STD_INFECT_CHANCE_SLIDER1", MainScript.fDibelSTDInfectChance, "$MRT_SP_DIBEL_STD_INFECT_CHANCE_SLIDER2", flag)
    AddSliderOptionST("DIBEL_STD_PROGRESS_CHANCE_SLIDER", "$MRT_SP_DIBEL_STD_PROGRESS_CHANCE_SLIDER1", MainScript.fDibelSTDProgressChance, "$MRT_SP_DIBEL_STD_PROGRESS_CHANCE_SLIDER2", flag)
    _AddToggleOptionST("DIBEL_ALLOW_MULTIPLE_STD_TOGGLE", "$MRT_SP_DIBEL_ALLOW_MULTIPLE_STD_TOGGLE", MainScript.bDibelAllowMultipleSTDs, flag)
  elseif (page == "$MRT_SP_PAGE_PROSTITUTION")
    SetTitleText("$MRT_SP_PAGE_PROSTITUTION")
    _AddHeaderOption("$MRT_SP_HEAD_WHORE")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("WHORE_TOGGLE", "$MRT_SP_WHORE_TOGGLE", MainScript.bWhoreEnabled, flag)
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
    AddSliderOptionST("SPEECH_WHORE_XP_MULT_SLIDER", "$MRT_SP_SPEECH_WHORE_XP_MULT_SLIDER1", MainScript.fWhorePersuasionXPMult, "$MRT_SP_SPEECH_WHORE_XP_MULT_SLIDER2", flag)
    AddSliderOptionST("WHORE_MARK_CHANCE_SLIDER", "$MRT_SP_WHORE_MARK_CHANCE_SLIDER1", Mainscript.fWhoreMarkChance, "$MRT_SP_WHORE_MARK_CHANCE_SLIDER2", flag)
    SetCursorPosition(1)
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddToggleOptionST("DIBEL_TOGGLE", "$MRT_SP_DIBEL_TOGGLE", MainScript.bDibelEnabled, flag)
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
    AddSliderOptionST("SPEECH_DIBEL_XP_MULT_SLIDER", "$MRT_SP_SPEECH_DIBEL_XP_MULT_SLIDER1", MainScript.fDibelPersuasionXPMult, "$MRT_SP_SPEECH_DIBEL_XP_MULT_SLIDER2", flag)
    AddSliderOptionST("DIBEL_MARK_CHANCE_SLIDER", "$MRT_SP_DIBEL_MARK_CHANCE_SLIDER1", Mainscript.fDibelMarkChance, "$MRT_SP_DIBEL_MARK_CHANCE_SLIDER2", flag)
    addEmptyOption()
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddHeaderOption("$MRT_SP_HEAD_DIBEL_REWARDS")
    AddSliderOptionST("ATTRIBUTE_COST_SLIDER", "$MRT_SP_ATTRIBUTE_COST_SLIDER1", Mainscript.fAttributeCost, "$MRT_SP_ATTRIBUTE_COST_SLIDER2", flag)
    AddSliderOptionST("ATTRIBUTE_REWARD_SLIDER", "$MRT_SP_ATTRIBUTE_REWARD_SLIDER1", Mainscript.fAttributeIncrement, "$MRT_SP_ATTRIBUTE_REWARD_SLIDER2", flag)
    AddSliderOptionST("CARRYWEIGHT_COST_SLIDER", "$MRT_SP_CARRYWEIGHT_COST_SLIDER1", Mainscript.fCarryWeightCost, "$MRT_SP_CARRYWEIGHT_COST_SLIDER2", flag)
    AddSliderOptionST("CARRYWEIGHT_REWARD_SLIDER", "$MRT_SP_CARRYWEIGHT_REWARD_SLIDER1", Mainscript.fCarryWeightIncrement, "$MRT_SP_CARRYWEIGHT_REWARD_SLIDER2", flag)
    AddSliderOptionST("SKILL_COST_SLIDER", "$MRT_SP_SKILL_COST_SLIDER1", Mainscript.fSkillLevelCost, "$MRT_SP_SKILL_COST_SLIDER2", flag)
    AddSliderOptionST("SKILL_REWARD_SLIDER", "$MRT_SP_SKILL_REWARD_SLIDER1", Mainscript.fSkillLevelIncrement, "$MRT_SP_SKILL_REWARD_SLIDER2", flag)
    AddSliderOptionST("PERK_COST_SLIDER", "$MRT_SP_PERK_COST_SLIDER1", Mainscript.fPerkPointCost, "$MRT_SP_PERK_COST_SLIDER2", flag)
    AddSliderOptionST("PERK_REWARD_SLIDER", "$MRT_SP_PERK_REWARD_SLIDER1", Mainscript.fPerkPointIncrement, "$MRT_SP_PERK_REWARD_SLIDER2", flag)
    AddSliderOptionST("DDKEY_COST_SLIDER", "$MRT_SP_DDKEY_COST_SLIDER1", Mainscript.fDDKeyCost, "$MRT_SP_DDKEY_COST_SLIDER2", flag)
    AddSliderOptionST("DDKEY_REWARD_SLIDER", "$MRT_SP_DDKEY_REWARD_SLIDER1", Mainscript.fDDKeyIncrement, "$MRT_SP_DDKEY_REWARD_SLIDER2", flag)    
    AddToggleOptionST("SEX_AFTER_OFFERING_TOGGLE","$MRT_SP_SEX_AFTER_OFFERING_TOGGLE", Mainscript.bSexAfterOffering, flag)
    addEmptyOption()
    if MainScript.bModEnabled && (iTotalRefundableOfferedMarks > 0)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddTextOptionST("REWARDS_REMOVE_TXT", "$MRT_SP_REWARDS_REMOVE_TXT",  "", flag)
  endif
endevent

event OnVersionUpdate(Int version)
  if (version >= 100 && CurrentVersion < 100)
    Debug.Trace(self + ": Updating script to version " + 100)
  endif
endevent

  Event OnConfigClose()
    if MainScript.fWhoreOwnerShare > 0.0 && !Mainscript.pimpTracker.isRunning()
      Mainscript.pimpTracker.start()
    endif
  endEvent

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
    sAnimInterfaces[0] = "$MRT_SP_ANIM_INERFACE_NONE"
    iAnimInterface = 0
    return sAnimInterfaces
  endif
  sAnimInterfaces = Utility.CreateStringArray(i + 1)
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
  sAnimInterfaces[i] = "$MRT_SP_ANIM_INERFACE_NONE"
  if iAnimInterface > (sAnimInterfaces.length - 1)
    iAnimInterface = 0
  endif
  return sAnimInterfaces
endfunction

String[] function sGetRaceNameArr()
  ;Races: ArgonianRace, BretonRace, DarkElfRace, HighElfRace, ImperialRace, KhajiitRace, NordRace, OrcRace, RedguardRace, WoodElfRace, other
  String[] sRaceNames = Utility.CreateStringArray(11)
  sRaceNames[0] = "$MRT_SP_RACES_Argonian"
  sRaceNames[1] = "$MRT_SP_RACES_Breton"
  sRaceNames[2] = "$MRT_SP_RACES_DarkElf"
  sRaceNames[3] = "$MRT_SP_RACES_HighElf"
  sRaceNames[4] = "$MRT_SP_RACES_Imperial"
  sRaceNames[5] = "$MRT_SP_RACES_Khajiit"
  sRaceNames[6] = "$MRT_SP_RACES_Nord"
  sRaceNames[7] = "$MRT_SP_RACES_Orc"
  sRaceNames[8] = "$MRT_SP_RACES_Redguard"
  sRaceNames[9] = "$MRT_SP_RACES_WoodElf"
  sRaceNames[10] = "$MRT_SP_RACES_OTHER"
  return sRaceNames
EndFunction

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

State STAT_WHORE_RACE_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_WHORE_RACE_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iWhoreStatRace = index
    _SetMenuOptionValueST(sGetRaceNameArr()[iWhoreStatRace], True)
    ForcePageReset()
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iWhoreStatRace)
    SetMenuDialogOptions(sGetRaceNameArr())
  endevent
endState

State STAT_DIBEL_RACE_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_DIBEL_RACE_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iDibelStatRace = index
    _SetMenuOptionValueST(sGetRaceNameArr()[iDibelStatRace], True)
    ForcePageReset()
  endevent

  event OnMenuOpenST()
    SetMenuDialogStartIndex(iDibelStatRace)
    SetMenuDialogOptions(sGetRaceNameArr())
  endevent
endState


state WHORE_ACCEPT_DIFFICULTY_MENU
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ACCEPT_DIFFICULTY_MENU")
  endevent

  event OnMenuAcceptST(int index)
    iWhoreSpeechDifficulty = index
    _SetMenuOptionValueST(sGetSpeechDifficultyArr()[iWhoreSpeechDifficulty], True)
    MainScript.setGlobalVaues()
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
    MainScript.setGlobalVaues()
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
    MainScript.setGlobalVaues()
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

State BEGGING_MALE_SEX_OFFER_TOGGLE
    event OnDefaultST()
    MainScript.bBeggingMaleSexOffer = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEGGING_MALE_SEX_OFFER_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bBeggingMaleSexOffer = !MainScript.bBeggingMaleSexOffer
    ForcePageReset()
  endevent
EndState

State BEGGING_FEMALE_SEX_OFFER_TOGGLE
    event OnDefaultST()
    MainScript.bBeggingFemaleSexOffer = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEGGING_FEMALE_SEX_OFFER_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bBeggingFemaleSexOffer = !MainScript.bBeggingFemaleSexOffer
    ForcePageReset()
  endevent
EndState

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

State SEX_AFTER_OFFERING_TOGGLE
  event OnDefaultST()
    MainScript.bSexAfterOffering = True
    ForcePageReset()
  endevent
  
  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SEX_AFTER_OFFERING_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bSexAfterOffering = !MainScript.bSexAfterOffering
    ForcePageReset()
  endevent
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
    ShowMessage("Please close the MCM menu.", False)
    Utility.wait(0.5)
    if MainScript.bModEnabled
      MainQuest.Start()
      loadSettingsAtStart()
      Mainscript.setVars()
      Debug.Notification("Simple Prostitution enabled.")
    else
      MainScript.ShutDown()
      MainQuest.Stop()
      Debug.Notification("Simple Prostitution disabled.")
    endif
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
		SetSliderDialogDefaultValue(0.5)
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

state SPEECH_DIBEL_XP_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_DIBEL_XP_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelPersuasionXPMult = value
    _SetSliderOptionValueST(MainScript.fDibelPersuasionXPMult, "$MRT_SP_SPEECH_DIBEL_XP_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelPersuasionXPMult)
    SetSliderDialogDefaultValue(0)
    SetSliderDialogRange(0, 200)
    SetSliderDialogInterval(1)
  endEvent
endstate

state SPEECH_WHORE_XP_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_WHORE_XP_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhorePersuasionXPMult = value
    _SetSliderOptionValueST(MainScript.fWhorePersuasionXPMult, "$MRT_SP_SPEECH_WHORE_XP_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhorePersuasionXPMult)
    SetSliderDialogDefaultValue(0)
    SetSliderDialogRange(0, 200)
    SetSliderDialogInterval(1)
  endEvent
endstate

state SPEECH_BEG_XP_MULT_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SPEECH_BEG_XP_MULT_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBeggarPersuasionXPMult = value
    _SetSliderOptionValueST(MainScript.fBeggarPersuasionXPMult, "$MRT_SP_SPEECH_BEG_XP_MULT_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggarPersuasionXPMult)
    SetSliderDialogDefaultValue(0)
    SetSliderDialogRange(0, 200)
    SetSliderDialogInterval(1)
  endEvent
endstate


state BEG_SEX_OFFER_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_SEX_OFFER_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBeggarSexOfferChance = value
    _SetSliderOptionValueST(MainScript.fBeggarSexOfferChance, "$MRT_SP_BEG_SEX_OFFER_SLIDER2")
    MainScript.setGlobalVaues()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggarSexOfferChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state BEG_MALE_RAPE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_MALE_RAPE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBeggingMaleRapistChance = value
    _SetSliderOptionValueST(MainScript.fBeggingMaleRapistChance, "$MRT_SP_BEG_MALE_RAPE_SLIDER2")
    MainScript.setGlobalVaues()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggingMaleRapistChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state BEG_FEMALE_RAPE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_FEMALE_RAPE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fBeggingFemaleRapistChance = value
    _SetSliderOptionValueST(MainScript.fBeggingFemaleRapistChance, "$MRT_SP_BEG_FEMALE_RAPE_SLIDER2")
    MainScript.setGlobalVaues()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggingFemaleRapistChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endState


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
		SetSliderDialogDefaultValue(0.8)
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
		SetSliderDialogDefaultValue(1.20)
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
		SetSliderDialogDefaultValue(0.6)
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

state NORMAL_STD_INFECT_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_NORMAL_STD_INFECT_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fNormalSTDInfectChance = value
    _SetSliderOptionValueST(MainScript.fNormalSTDInfectChance, "$MRT_SP_NORMAL_STD_INFECT_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fNormalSTDInfectChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state NORMAL_STD_PROGRESS_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_NORMAL_STD_PROGRESS_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fNormalSTDProgressChance = value
    _SetSliderOptionValueST(MainScript.fNormalSTDProgressChance, "$MRT_SP_NORMAL_STD_PROGRESS_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fNormalSTDProgressChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state NORMAL_ALLOW_MULTIPLE_STD_TOGGLE
  event OnDefaultST()
    MainScript.bNormalAllowMultipleSTDs = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_NORMAL_ALLOW_MULTIPLE_STD_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bNormalAllowMultipleSTDs = !MainScript.bNormalAllowMultipleSTDs
    ForcePageReset()
  endevent
endstate

state WHORE_STD_INFECT_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_STD_INFECT_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreSTDInfectChance = value
    _SetSliderOptionValueST(MainScript.fWhoreSTDInfectChance, "$MRT_SP_WHORE_STD_INFECT_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreSTDInfectChance)
    SetSliderDialogDefaultValue(5.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state WHORE_STD_PROGRESS_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_STD_PROGRESS_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fWhoreSTDProgressChance = value
    _SetSliderOptionValueST(MainScript.fWhoreSTDProgressChance, "$MRT_SP_WHORE_STD_PROGRESS_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreSTDProgressChance)
    SetSliderDialogDefaultValue(25.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state DIBEL_STD_INFECT_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_STD_INFECT_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelSTDInfectChance = value
    _SetSliderOptionValueST(MainScript.fDibelSTDInfectChance, "$MRT_SP_DIBEL_STD_INFECT_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelSTDInfectChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state DIBEL_STD_PROGRESS_CHANCE_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_STD_PROGRESS_CHANCE_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDibelSTDProgressChance = value
    _SetSliderOptionValueST(MainScript.fDibelSTDProgressChance, "$MRT_SP_DIBEL_STD_PROGRESS_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelSTDProgressChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endstate

state WHORE_ALLOW_MULTIPLE_STD_TOGGLE
  event OnDefaultST()
    MainScript.bWhoreAllowMultipleSTDs = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_ALLOW_MULTIPLE_STD_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bWhoreAllowMultipleSTDs = !MainScript.bWhoreAllowMultipleSTDs
    ForcePageReset()
  endevent
endstate

state DIBEL_ALLOW_MULTIPLE_STD_TOGGLE
  event OnDefaultST()
    MainScript.bDibelAllowMultipleSTDs = False
    ForcePageReset()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_ALLOW_MULTIPLE_STD_TOGGLE")
  endevent

  event OnSelectST()
    MainScript.bDibelAllowMultipleSTDs = !MainScript.bDibelAllowMultipleSTDs
    ForcePageReset()
  endevent
endstate

state CURE_NORMAL_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CURE_NORMAL_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCureNormalDiseaseCost = value
    _SetSliderOptionValueST(MainScript.fCureNormalDiseaseCost, "$MRT_SP_CURE_NORMAL_COST_SLIDER2")
    Mainscript.startCalcSTDCurePrice()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCureNormalDiseaseCost)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 1000)
    SetSliderDialogInterval(10)
  endEvent
endstate

state CURE_STDI_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CURE_STDI_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCureSTDICost = value
    _SetSliderOptionValueST(MainScript.fCureSTDICost, "$MRT_SP_CURE_STDI_COST_SLIDER2")
    Mainscript.startCalcSTDCurePrice()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCureSTDICost)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 1000)
    SetSliderDialogInterval(10)
  endEvent
endstate

state CURE_STDII_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CURE_STDII_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCureSTDIICost = value
    _SetSliderOptionValueST(MainScript.fCureSTDIICost, "$MRT_SP_CURE_STDII_COST_SLIDER2")
    Mainscript.startCalcSTDCurePrice()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCureSTDIICost)
    SetSliderDialogDefaultValue(150.0)
    SetSliderDialogRange(0, 1000)
    SetSliderDialogInterval(10)
  endEvent
endstate

state CURE_STDIII_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CURE_STDIII_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCureSTDIIICost = value
    _SetSliderOptionValueST(MainScript.fCureSTDIIICost, "$MRT_SP_CURE_STDIII_COST_SLIDER2")
    Mainscript.startCalcSTDCurePrice()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCureSTDIIICost)
    SetSliderDialogDefaultValue(200.0)
    SetSliderDialogRange(0, 1000)
    SetSliderDialogInterval(10)
  endEvent
endstate

state CURE_STDIV_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CURE_STDIV_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCureSTDIVCost = value
    _SetSliderOptionValueST(MainScript.fCureSTDIVCost, "$MRT_SP_CURE_STDIV_COST_SLIDER2")
    Mainscript.startCalcSTDCurePrice()
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCureSTDIVCost)
    SetSliderDialogDefaultValue(300.0)
    SetSliderDialogRange(0, 1000)
    SetSliderDialogInterval(10)
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

state WHORE_MARK_CHANCE_SLIDER
    event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_MARK_CHANCE_SLIDER")
  endevent
  
  event OnSliderAcceptST(float value)
    MainScript.fWhoreMarkChance = value
    _SetSliderOptionValueST(MainScript.fWhoreMarkChance, "$MRT_SP_WHORE_MARK_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fWhoreMarkChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state DIBEL_MARK_CHANCE_SLIDER
    event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DIBEL_MARK_CHANCE_SLIDER")
  endevent
  
  event OnSliderAcceptST(float value)
    MainScript.fDibelMarkChance = value
    _SetSliderOptionValueST(MainScript.fDibelMarkChance, "$MRT_SP_DIBEL_MARK_CHANCE_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDibelMarkChance)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  endEvent
endState


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

state ATTRIBUTE_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_ATTRIBUTE_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fAttributeCost = value
    _SetSliderOptionValueST(MainScript.fAttributeCost, "$MRT_SP_ATTRIBUTE_COST_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fAttributeCost)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state ATTRIBUTE_REWARD_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_ATTRIBUTE_REWARD_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fAttributeIncrement = value
    _SetSliderOptionValueST(MainScript.fAttributeIncrement, "$MRT_SP_ATTRIBUTE_REWARD_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fAttributeIncrement)
    SetSliderDialogDefaultValue(10.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state CARRYWEIGHT_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CARRYWEIGHT_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCarryWeightCost = value
    _SetSliderOptionValueST(MainScript.fCarryWeightCost, "$MRT_SP_CARRYWEIGHT_COST_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCarryWeightCost)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state CARRYWEIGHT_REWARD_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_CARRYWEIGHT_REWARD_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fCarryWeightIncrement = value
    _SetSliderOptionValueST(MainScript.fCarryWeightIncrement, "$MRT_SP_CARRYWEIGHT_REWARD_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fCarryWeightIncrement)
    SetSliderDialogDefaultValue(20.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state PERK_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_PERK_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fPerkPointCost = value
    _SetSliderOptionValueST(MainScript.fPerkPointCost, "$MRT_SP_PERK_COST_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fPerkPointCost)
    SetSliderDialogDefaultValue(5.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state PERK_REWARD_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_PERK_REWARD_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fPerkPointIncrement = value
    _SetSliderOptionValueST(MainScript.fPerkPointIncrement, "$MRT_SP_PERK_REWARD_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fPerkPointIncrement)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state DDKEY_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DDKEY_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDDKeyCost = value
    _SetSliderOptionValueST(MainScript.fDDKeyCost, "$MRT_SP_DDKEY_COST_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDDKeyCost)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state DDKEY_REWARD_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_DDKEY_REWARD_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fDDKeyIncrement = value
    _SetSliderOptionValueST(MainScript.fDDKeyIncrement, "$MRT_SP_DDKEY_REWARD_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fDDKeyIncrement)
    SetSliderDialogDefaultValue(5.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state SKILL_COST_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SKILL_COST_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fSkillLevelCost = value
    _SetSliderOptionValueST(MainScript.fSkillLevelCost, "$MRT_SP_SKILL_COST_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fSkillLevelCost)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

state SKILL_REWARD_SLIDER
  event OnDefaultST()
  endevent

  event OnHighlightST()
    SetInfoText("$MRT_SP_DESC_SKILL_REWARD_SLIDER")
  endevent

  event OnSliderAcceptST(float value)
    MainScript.fSkillLevelIncrement = value
    _SetSliderOptionValueST(MainScript.fSkillLevelIncrement, "$MRT_SP_SKILL_REWARD_SLIDER2")
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fSkillLevelIncrement)
    SetSliderDialogDefaultValue(1.0)
    SetSliderDialogRange(1, 100)
    SetSliderDialogInterval(1)
  endEvent
endState

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

State STAT_WHORE_ORAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_ORAL_TXT")
  endFunction
EndState

State STAT_WHORE_ANAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_ANAL_TXT")
  endFunction
EndState

State STAT_WHORE_VAGINAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_VAGINAL_TXT")
  endFunction
EndState

State STAT_WHORE_RACE_ORAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_ORAL_TXT")
  endFunction
EndState

State STAT_WHORE_RACE_ANAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_ANAL_TXT")
  endFunction
EndState

State STAT_WHORE_RACE_VAGINAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_VAGINAL_TXT")
  endFunction
EndState

State STAT_DIBEL_ORAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_ORAL_TXT")
  endFunction
EndState

State STAT_DIBEL_ANAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_ANAL_TXT")
  endFunction
EndState

State STAT_DIBEL_VAGINAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_VAGINAL_TXT")
  endFunction
EndState

State STAT_DIBEL_RACE_ORAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_ORAL_TXT")
  endFunction
EndState

State STAT_DIBEL_RACE_ANAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_ANAL_TXT")
  endFunction
EndState

State STAT_DIBEL_RACE_VAGINAL_TXT
  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_RACE_VAGINAL_TXT")
  endFunction
EndState

State STAT_WHORE_ORAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bWhoreOralPerkRewardReceived && MainScript.bCanReceiveReward(2, False)
      Game.AddPerkPoints(1)
      bWhoreOralPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_WHORE_ORAL_PERK_REWARD_TXT")
  endFunction
EndState

State STAT_WHORE_ANAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bWhoreAnalPerkRewardReceived && MainScript.bCanReceiveReward(1, False)
      Game.AddPerkPoints(1)
      bWhoreAnalPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_WHORE_ANAL_PERK_REWARD_TXT")
  endFunction
EndState

State STAT_WHORE_VAGINAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bWhoreVaginalPerkRewardReceived && MainScript.bCanReceiveReward(0, False)
      Game.AddPerkPoints(1)
      bWhoreVaginalPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_WHORE_VAGINAL_PERK_REWARD_TXT")
  endFunction
EndState

State STAT_DIBEL_ORAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bDibelOralPerkRewardReceived && MainScript.bCanReceiveReward(2, True)
      Game.AddPerkPoints(1)
      bDibelOralPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_DIBEL_ORAL_PERK_REWARD_TXT")
  endFunction
EndState

State STAT_DIBEL_ANAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bDibelAnalPerkRewardReceived && MainScript.bCanReceiveReward(1, True)
      Game.AddPerkPoints(1)
      bDibelAnalPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_DIBEL_ANAL_PERK_REWARD_TXT")
  endFunction
EndState

State STAT_DIBEL_VAGINAL_PERK_REWARD_TXT
  function OnSelectST()
    if !bDibelVaginalPerkRewardReceived && MainScript.bCanReceiveReward(0, True)
      Game.AddPerkPoints(1)
      bDibelVaginalPerkRewardReceived = True
      ForcePageReset()
    endif 
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_STAT_DIBEL_VAGINAL_PERK_REWARD_TXT")
  endFunction
EndState

State WHORE_TAG_CHEST_CLOTH_TXT
  function OnSelectST()
    if MainScript.bIsPO3ExtenderActive
      Armor chestArmor = (MainScript.Player.GetWornForm(0x00000004) As Armor)
      if chestArmor 
        if chestArmor.HasKeyword(MainScript.ProstituteClothing_kwd)
          PO3_SKSEFunctions.RemoveKeywordOnForm(chestArmor, MainScript.ProstituteClothing_kwd)
          deleteData_WhoreClothing_KWD(chestArmor)
        else
          PO3_SKSEFunctions.AddKeywordToForm(chestArmor, MainScript.ProstituteClothing_kwd)
          saveData_WhoreClothing_KWD(chestArmor)
        endif
        ForcePageReset()
	  endif	
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TAG_CHEST_CLOTH_TXT")
  endFunction
EndState

State BEG_TAG_CHEST_CLOTH_TXT
  function OnSelectST()
    if MainScript.bIsPO3ExtenderActive
      Armor chestArmor = (MainScript.Player.GetWornForm(0x00000004) As Armor)
      if chestArmor 
        if chestArmor.HasKeyword(MainScript.BeggarClothing_kwd)
          PO3_SKSEFunctions.RemoveKeywordOnForm(chestArmor, MainScript.BeggarClothing_kwd)
          deleteData_BeggarClothing_KWD(chestArmor)
        else
          PO3_SKSEFunctions.AddKeywordToForm(chestArmor, MainScript.BeggarClothing_kwd)
          saveData_BeggarClothing_KWD(chestArmor)
        endif
        ForcePageReset()
      endif 
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_BEG_TAG_CHEST_CLOTH_TXT")
  endFunction
EndState

State WHORE_TAG_LOC_TXT
  function OnSelectST()
    if MainScript.bIsPO3ExtenderActive
      Cell cel = MainScript.Player.GetParentCell()
      Location loc = MainScript.Player.GetCurrentLocation()
      if loc && cel && cel.IsInterior()
        if loc.HasKeyword(Mainscript.prostituteLocation_KWD)
          PO3_SKSEFunctions.RemoveKeywordOnForm(loc, Mainscript.prostituteLocation_KWD)
          deleteData_WhoreLocation_KWD(loc)
        else
          PO3_SKSEFunctions.AddKeywordToForm(loc, Mainscript.prostituteLocation_KWD)
          saveData_WhoreLocation_KWD(loc)
        endif
        MainScript.checkCurrentLocation()
        ForcePageReset()
      endif
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TAG_LOC_TXT")
  endFunction
EndState

State WHORE_TAG_OWNER_TXT
  function OnSelectST()
    if MainScript.bIsPO3ExtenderActive
      Actor npc = Game.GetCurrentCrosshairRef() As Actor
      if !npc
        npc = Game.GetCurrentConsoleRef() As Actor
      endif
      if npc && Mainscript.bCanPimp(npc)
        if npc.HasKeyword(Mainscript.prostituteManager_KWD)
          PO3_SKSEFunctions.RemoveKeywordFromRef(npc, Mainscript.prostituteManager_KWD)
          deleteData_WhoreManager_KWD(npc)
        else
          PO3_SKSEFunctions.AddKeywordToRef(npc, Mainscript.prostituteManager_KWD)
          saveData_WhoreManager_KWD(npc)
        endif
        ForcePageReset()
      endif
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TAG_OWNER_TXT")
  endFunction
EndState

State WHORE_TAG_HEALER_TXT
  function OnSelectST()
    if MainScript.bIsPO3ExtenderActive
      Actor npc = Game.GetCurrentCrosshairRef() As Actor
      if !npc
        npc = Game.GetCurrentConsoleRef() As Actor
      endif
      if npc && Mainscript.bCanHeal(npc)
        if npc.HasKeyword(Mainscript.stdHealer_KWD)
          PO3_SKSEFunctions.RemoveKeywordFromRef(npc, Mainscript.stdHealer_KWD)
          deleteData_STDHealer_KWD(npc)
        else
          PO3_SKSEFunctions.AddKeywordToRef(npc, Mainscript.stdHealer_KWD)
          saveData_STDHealer_KWD(npc)
        endif
        ForcePageReset()
      endif
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_WHORE_TAG_HEALER_TXT")
  endFunction
EndState

State REWARDS_REMOVE_TXT
  function OnSelectST()
    ForceCloseMenu()
    Utility.wait(0.5)
    if MainScript.Confirm_RemoveDibelRewards_Message.Show(iTotalRefundableOfferedMarks as Int) == 0
      removeDibelRewards()
    endif
  endFunction

  function OnHighlightST()
    SetInfoText("$MRT_SP_DESC_REWARDS_REMOVE_TXT")
  endFunction
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

state LOAD_USER_DATA_TXT
  function OnSelectST()
    if ShowMessage("Do you want to load saved data?", true, "$Accept", "$Cancel")
      if loadUserDataPapyrus()
        ForcePageReset()
        ShowMessage("User data loaded successfully.", false, "$Accept", "$Cancel")
      else
        ShowMessage("Failed to load user data.", false, "$Accept", "$Cancel")
      endIf
    endIf
  endFunction

  function OnHighlightST()
    if jsonutil.JsonExists(settings_path)
      SetInfoText("$MRT_SP_DESC_LOAD_DATA_ON")
    else
      SetInfoText("$MRT_SP_DESC_LOAD_DATA_OFF")
    endIf
  endFunction
endState

Bool function loadUserSettingsPapyrus(Bool bSilence = False)
  if !jsonutil.IsGood(settings_path)
    !bSilence && ShowMessage("SimpleProstitution: Can't load User Settings. Errors: {" + jsonutil.getErrors(settings_path) + "}", true, "$Accept", "$Cancel")
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
  MainScript.bDibelAllowMultipleSTDs = jsonutil.GetPathIntValue(settings_path, "bDibelAllowMultipleSTDs", MainScript.bDibelAllowMultipleSTDs as Int)
  MainScript.bWhoreAllowMultipleSTDs = jsonutil.GetPathIntValue(settings_path, "bWhoreAllowMultipleSTDs", MainScript.bWhoreAllowMultipleSTDs as Int)
  MainScript.bNormalAllowMultipleSTDs = jsonutil.GetPathIntValue(settings_path, "bNormalAllowMultipleSTDs", MainScript.bNormalAllowMultipleSTDs as Int)
  MainScript.bSexAfterOffering = jsonutil.GetPathIntValue(settings_path, "bSexAfterOffering", MainScript.bSexAfterOffering as Int)
  MainScript.bBeggingFemaleSexOffer = jsonutil.GetPathIntValue(settings_path, "bBeggingFemaleSexOffer", MainScript.bBeggingFemaleSexOffer as Int)
  MainScript.bBeggingMaleSexOffer = jsonutil.GetPathIntValue(settings_path, "bBeggingMaleSexOffer", MainScript.bBeggingMaleSexOffer as Int)

  
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
  Mainscript.fBeggarPersuasionXPMult = jsonutil.GetPathFloatValue(settings_path, "fBeggarPersuasionXPMult", MainScript.fBeggarPersuasionXPMult)
  Mainscript.fWhorePersuasionXPMult = jsonutil.GetPathFloatValue(settings_path, "fWhorePersuasionXPMult", MainScript.fWhorePersuasionXPMult)
  Mainscript.fDibelPersuasionXPMult = jsonutil.GetPathFloatValue(settings_path, "fDibelPersuasionXPMult", MainScript.fDibelPersuasionXPMult)
  MainScript.fWhoreMarkChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreMarkChance", MainScript.fWhoreMarkChance)
  MainScript.fDibelMarkChance = jsonutil.GetPathFloatValue(settings_path, "fDibelMarkChance", MainScript.fDibelMarkChance)
  MainScript.fAttributeCost = jsonutil.GetPathFloatValue(settings_path, "fAttributeCost", MainScript.fAttributeCost)
  MainScript.fAttributeIncrement = jsonutil.GetPathFloatValue(settings_path, "fAttributeIncrement", MainScript.fAttributeIncrement)
  MainScript.fCarryWeightCost = jsonutil.GetPathFloatValue(settings_path, "fCarryWeightCost", MainScript.fCarryWeightCost)
  MainScript.fCarryWeightIncrement = jsonutil.GetPathFloatValue(settings_path, "fCarryWeightIncrement", MainScript.fCarryWeightIncrement)
  MainScript.fSkillLevelCost = jsonutil.GetPathFloatValue(settings_path, "fSkillLevelCost", MainScript.fSkillLevelCost)
  MainScript.fSkillLevelIncrement = jsonutil.GetPathFloatValue(settings_path, "fSkillLevelIncrement", MainScript.fSkillLevelIncrement)
  MainScript.fPerkPointCost = jsonutil.GetPathFloatValue(settings_path, "fPerkPointCost", MainScript.fPerkPointCost)
  MainScript.fPerkPointIncrement = jsonutil.GetPathFloatValue(settings_path, "fPerkPointIncrement", MainScript.fPerkPointIncrement)
  MainScript.fDDKeyCost = jsonutil.GetPathFloatValue(settings_path, "fDDKeyCost", MainScript.fDDKeyCost)
  MainScript.fDDKeyIncrement = jsonutil.GetPathFloatValue(settings_path, "fDDKeyIncrement", MainScript.fDDKeyIncrement)
  MainScript.fBeggingFemaleRapistChance = jsonutil.GetPathFloatValue(settings_path, "fBeggingFemaleRapistChance", MainScript.fBeggingFemaleRapistChance) 
  MainScript.fBeggingMaleRapistChance = jsonutil.GetPathFloatValue(settings_path, "fBeggingMaleRapistChance", MainScript.fBeggingMaleRapistChance)
  MainScript.fBeggarSexOfferChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarSexOfferChance", MainScript.fBeggarSexOfferChance)

  MainScript.fCureNormalDiseaseCost = jsonutil.GetPathFloatValue(settings_path, "fCureNormalDiseaseCost", MainScript.fCureNormalDiseaseCost) 
  MainScript.fCureSTDICost = jsonutil.GetPathFloatValue(settings_path, "fCureSTDICost", MainScript.fCureSTDICost)
  MainScript.fCureSTDIICost = jsonutil.GetPathFloatValue(settings_path, "fCureSTDIICost", MainScript.fCureSTDIICost)
  MainScript.fCureSTDIIICost = jsonutil.GetPathFloatValue(settings_path, "fCureSTDIIICost", MainScript.fCureSTDIIICost)
  MainScript.fCureSTDIVCost = jsonutil.GetPathFloatValue(settings_path, "fCureSTDIVCost", MainScript.fCureSTDIVCost)
  MainScript.fWhoreSTDProgressChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreSTDProgressChance", MainScript.fWhoreSTDProgressChance)
  MainScript.fDibelSTDProgressChance = jsonutil.GetPathFloatValue(settings_path, "fDibelSTDProgressChance", MainScript.fDibelSTDProgressChance)
  MainScript.fNormalSTDProgressChance = jsonutil.GetPathFloatValue(settings_path, "fNormalSTDProgressChance", MainScript.fNormalSTDProgressChance)
  MainScript.fWhoreSTDInfectChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreSTDInfectChance", MainScript.fWhoreSTDInfectChance)
  MainScript.fDibelSTDInfectChance = jsonutil.GetPathFloatValue(settings_path, "fDibelSTDInfectChance", MainScript.fDibelSTDInfectChance)
  MainScript.fNormalSTDInfectChance = jsonutil.GetPathFloatValue(settings_path, "fNormalSTDInfectChance", MainScript.fNormalSTDInfectChance)

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
  jsonutil.SetPathIntValue(settings_path, "bDibelAllowMultipleSTDs", MainScript.bDibelAllowMultipleSTDs as Int)
  jsonutil.SetPathIntValue(settings_path, "bWhoreAllowMultipleSTDs", MainScript.bWhoreAllowMultipleSTDs as Int)
  jsonutil.SetPathIntValue(settings_path, "bNormalAllowMultipleSTDs", MainScript.bNormalAllowMultipleSTDs as Int)
  jsonutil.SetPathIntValue(settings_path, "bSexAfterOffering", MainScript.bSexAfterOffering as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggingFemaleSexOffer", MainScript.bBeggingFemaleSexOffer as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggingMaleSexOffer", MainScript.bBeggingMaleSexOffer as Int)
 
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
  jsonutil.SetPathFloatValue(settings_path, "fBeggarPersuasionXPMult", MainScript.fBeggarPersuasionXPMult)
  jsonutil.SetPathFloatValue(settings_path, "fWhorePersuasionXPMult", MainScript.fWhorePersuasionXPMult)
  jsonutil.SetPathFloatValue(settings_path, "fDibelPersuasionXPMult", MainScript.fDibelPersuasionXPMult)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreMarkChance", MainScript.fWhoreMarkChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelMarkChance", MainScript.fDibelMarkChance)
  jsonutil.SetPathFloatValue(settings_path, "fAttributeCost", MainScript.fAttributeCost)
  jsonutil.SetPathFloatValue(settings_path, "fAttributeIncrement", MainScript.fAttributeIncrement)
  jsonutil.SetPathFloatValue(settings_path, "fCarryWeightCost", MainScript.fCarryWeightCost)
  jsonutil.SetPathFloatValue(settings_path, "fCarryWeightIncrement", MainScript.fCarryWeightIncrement)
  jsonutil.SetPathFloatValue(settings_path, "fSkillLevelCost", MainScript.fSkillLevelCost)
  jsonutil.SetPathFloatValue(settings_path, "fSkillLevelIncrement", MainScript.fSkillLevelIncrement)
  jsonutil.SetPathFloatValue(settings_path, "fPerkPointCost", MainScript.fPerkPointCost)
  jsonutil.SetPathFloatValue(settings_path, "fPerkPointIncrement", MainScript.fPerkPointIncrement)
  jsonutil.SetPathFloatValue(settings_path, "fDDKeyCost", MainScript.fDDKeyCost)
  jsonutil.SetPathFloatValue(settings_path, "fDDKeyIncrement", MainScript.fDDKeyIncrement)
  jsonutil.SetPathFloatValue(settings_path, "fBeggingFemaleRapistChance", MainScript.fBeggingFemaleRapistChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggingMaleRapistChance", MainScript.fBeggingMaleRapistChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarSexOfferChance", MainScript.fBeggarSexOfferChance)

  jsonutil.SetPathFloatValue(settings_path, "fCureNormalDiseaseCost", MainScript.fCureNormalDiseaseCost)
  jsonutil.SetPathFloatValue(settings_path, "fCureSTDICost", MainScript.fCureSTDICost)
  jsonutil.SetPathFloatValue(settings_path, "fCureSTDIICost", MainScript.fCureSTDIICost)
  jsonutil.SetPathFloatValue(settings_path, "fCureSTDIIICost", MainScript.fCureSTDIIICost)
  jsonutil.SetPathFloatValue(settings_path, "fCureSTDIVCost", MainScript.fCureSTDIVCost)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreSTDProgressChance", MainScript.fWhoreSTDProgressChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelSTDProgressChance", MainScript.fDibelSTDProgressChance)
  jsonutil.SetPathFloatValue(settings_path, "fNormalSTDProgressChance", MainScript.fNormalSTDProgressChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreSTDInfectChance", MainScript.fWhoreSTDInfectChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelSTDInfectChance", MainScript.fDibelSTDInfectChance)
  jsonutil.SetPathFloatValue(settings_path, "fNormalSTDInfectChance", MainScript.fNormalSTDInfectChance)
  
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
    debug.Trace("Simple Prostitution: Error saving user settings.", 0)
    return false
  endIf
  return true
endFunction

function loadSettingsAtStart()
  MainScript.bIsPapyrusUtilActive = MainScript.bCheckPapyrusUtil()
  if MainScript.bIsPapyrusUtilActive
    if jsonutil.JsonExists(settings_path)
      loadUserSettingsPapyrus(true)
    endIf
    Mainscript.bIsPO3ExtenderActive = Mainscript.bCheckPO3Extender()
    if Mainscript.bIsPO3ExtenderActive
      if jsonutil.JsonExists(data_path)
        loadUserDataPapyrus(true)
      endif
    endif
    return 
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

string Function getInputTags(string sTags, Bool bReqAll, int iMaxLen = 10)
  if sTags
    return shortenString(sTags, iMaxLen) + " RequireAll=" + ((bReqAll As Int) As String)
  endif
  return ""
endFunction


Function saveData_WhoreLocation_KWD(Location akLoc)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListAdd(data_path, "ProstituteLocation_KWD", akLoc, False)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function saveData_WhoreClothing_KWD(Armor akArmor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListAdd(data_path, "ProstituteClothing_KWD", akArmor, False)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function saveData_BeggarClothing_KWD(Armor akArmor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListAdd(data_path, "BeggarClothing_KWD", akArmor, False)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function saveData_WhoreManager_KWD(Actor akActor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListAdd(data_path, "ProstituteManager_KWD", akActor, False)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function saveData_STDHealer_KWD(Actor akActor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListAdd(data_path, "STDHealer_KWD", akActor, False)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function deleteData_WhoreLocation_KWD(Location akLoc)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListRemove(data_path, "ProstituteLocation_KWD", akLoc, True)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function deleteData_WhoreClothing_KWD(Armor akArmor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListRemove(data_path, "ProstituteClothing_KWD", akArmor, True)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function deleteData_BeggarClothing_KWD(Armor akArmor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListRemove(data_path, "BeggarClothing_KWD", akArmor, True)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function deleteData_WhoreManager_KWD(Actor akActor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListRemove(data_path, "ProstituteManager_KWD", akActor, True)
    JsonUtil.Save(data_path)
  endif
EndFunction

Function deleteData_STDHealer_KWD(Actor akActor)
  if Mainscript.bIsPapyrusUtilActive
    JsonUtil.FormListRemove(data_path, "STDHealer_KWD", akActor, True)
    JsonUtil.Save(data_path)
  endif
EndFunction


Bool Function loadUserDataPapyrus(Bool bSilence = False)
  if !Mainscript.bIsPapyrusUtilActive || !Mainscript.bIsPO3ExtenderActive
    return False
  endif
  if !jsonutil.JsonExists(data_path)
    return False
  endif
  if !jsonutil.IsGood(data_path)
    !bSilence && ShowMessage("SimpleProstitution: Can't load data. Errors: {" + jsonutil.getErrors(data_path) + "}", true, "$Accept", "$Cancel")
    return false
  endif
  Form[] arr
  int iIndex
  arr = JsonUtil.FormListToArray(data_path, "ProstituteLocation_KWD")
  iIndex = arr.Length
  While iIndex > 0
    iIndex -= 1
    if arr[iIndex] as Location   
      PO3_SKSEFunctions.AddKeywordToForm(arr[iIndex], Mainscript.prostituteLocation_KWD)
    endif
  endWhile
  arr = JsonUtil.FormListToArray(data_path, "ProstituteClothing_KWD")
  iIndex = arr.Length
  While iIndex > 0
    iIndex -= 1
    if arr[iIndex] as Armor   
      PO3_SKSEFunctions.AddKeywordToForm(arr[iIndex], MainScript.ProstituteClothing_kwd)
    endif
  endWhile
  arr = JsonUtil.FormListToArray(data_path, "BeggarClothing_KWD")
  iIndex = arr.Length
  While iIndex > 0
    iIndex -= 1
    if arr[iIndex] as Armor   
      PO3_SKSEFunctions.AddKeywordToForm(arr[iIndex], MainScript.BeggarClothing_kwd)
    endif
  endWhile
  arr = JsonUtil.FormListToArray(data_path, "ProstituteManager_KWD")
  iIndex = arr.Length
  While iIndex > 0
    iIndex -= 1
    if arr[iIndex] as Actor   
      PO3_SKSEFunctions.AddKeywordToRef(arr[iIndex] as Actor, MainScript.prostituteManager_KWD)
    endif
  endWhile
  arr = JsonUtil.FormListToArray(data_path, "STDHealer_KWD")
  iIndex = arr.Length
  While iIndex > 0
    iIndex -= 1
    if arr[iIndex] as Actor   
      PO3_SKSEFunctions.AddKeywordToRef(arr[iIndex] as Actor, MainScript.stdHealer_KWD)
    endif
  endWhile
  return true
endFunction

String Function sGetSexStatText(Int iPos, Bool bRace, Bool bDibel = False)
  int iTotal = 0
  Int iCount = 0
  if bRace
    Int[] arr
    if bDibel
      if iPos == 0
        arr = MainScript.iDibelVaginalStatArr 
        iCount = arr[iDibelStatRace]
      elseif iPos == 1
        arr = MainScript.iDibelAnalStatArr
        iCount = arr[iDibelStatRace]
      elseif iPos == 2
        arr = MainScript.iDibelOralStatArr
        iCount = arr[iDibelStatRace]
      endif
    else
      if iPos == 0
        arr = MainScript.iWhoreVaginalStatArr 
        iCount = arr[iWhoreStatRace]
      elseif iPos == 1
        arr = MainScript.iWhoreAnalStatArr 
        iCount = arr[iWhoreStatRace]
      elseif iPos == 2
        arr = MainScript.iWhoreOralStatArr
        iCount = arr[iWhoreStatRace]
      endif
    endif
    if arr
      int iIndex = arr.Length
      while iIndex > 0
        iIndex -= 1
        iTotal = iTotal + arr[iIndex]
      endWhile
    endif
  else
    if bDibel
      iCount = Mainscript.iTotalDibelStats[iPos]
      iTotal = Mainscript.iTotalDibelStats[0] + Mainscript.iTotalDibelStats[1] + Mainscript.iTotalDibelStats[2]
    else
      iCount = Mainscript.iTotalWhoreStats[iPos]
      iTotal = Mainscript.iTotalWhoreStats[0] + Mainscript.iTotalWhoreStats[1] + Mainscript.iTotalWhoreStats[2]
    endif
  endif
  if iTotal == 0
    return "0 (0%)"
  endif
  return iCount + " (" + (((iCount as Float / iTotal as Float) * 100.0) As Int) + "%)"
EndFunction

String Function sGetStatRewardText(Int iPos, Bool bDibel = False)
  Bool bCanReceiveReward = Mainscript.bCanReceiveReward(iPos, bDibel)
  String sProgress = ((Mainscript.iRewardProgress(iPos, bDibel) as Float * 100.0) as Int) + "%"
  if bDibel
    if iPos == 2
      if bDibelOralPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    elseif iPos == 1
      if bDibelAnalPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    elseif iPos == 0
      if bDibelVaginalPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    endif
  else
    if iPos == 2
      if bWhoreOralPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    elseif iPos == 1
      if bWhoreAnalPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    elseif iPos == 0
      if bWhoreVaginalPerkRewardReceived
        return "$MRT_SP_PERK_REWARD_END"
      elseif bCanReceiveReward
        return "$MRT_SP_PERK_REWARD_ON"
      else
        return sProgress
      endif
    endif
  endif

EndFunction

Function removeDibelRewards()
  if iTotalRefundableOfferedMarks < 1
	  return
	endif
	actor player = MainScript.player
  if iTotalHealthRecieved > 0
    Player.RestoreActorValue("Health", iTotalHealthRecieved)
    Player.SetActorValue("Health", maxFloat(1.0, Player.GetBaseActorValue("Health") - iTotalHealthRecieved))
    iTotalHealthRecieved = 0
  endif
  if iTotalMagickaRecieved > 0
    Player.RestoreActorValue("Magicka", iTotalMagickaRecieved)
    Player.SetActorValue("Magicka", maxFloat(1.0,Player.GetBaseActorValue("Magicka") - iTotalMagickaRecieved))
    iTotalMagickaRecieved = 0
  endif
  if iTotalStaminaRecieved > 0
    Player.RestoreActorValue("Stamina", iTotalStaminaRecieved)
    Player.SetActorValue("Stamina", maxFloat(1.0, Player.GetBaseActorValue("Stamina") - iTotalStaminaRecieved))
    iTotalStaminaRecieved = 0
  endif
  if iTotalCarryWeightRecieved > 0
    Player.ModActorValue("CarryWeight", -iTotalCarryWeightRecieved)
    iTotalCarryWeightRecieved = 0
  endif
  player.Additem(MainScript.dibelMark, iTotalRefundableOfferedMarks)
  iTotalOfferedMarks -= iTotalRefundableOfferedMarks
  iTotalRefundableOfferedMarks = 0
EndFunction

function ForceCloseMenu()
  ;ForcePageReset()
  UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.ConfigPanelClose") ; mcm
  UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu") ; quest journal
  Utility.Wait(0.5)
endfunction

