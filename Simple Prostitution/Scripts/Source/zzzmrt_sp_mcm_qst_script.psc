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

Bool setModVars = false

String settings_path = "..\\simple-prostitution\\user-settings"
String data_path = "..\\simple-prostitution\\user-data"

Int flag

event OnConfigInit()
  ModName = "Simple Prostitution"
  initPages()
endevent

function initPages()
  Pages = new String[9]
  pages[0] = "$MRT_SP_PAGE_GENERAL"
  pages[1] = "$MRT_SP_PAGE_PROSTITUTION"
  pages[2] = "$MRT_SP_PAGE_DIBEL"
  pages[3] = "$MRT_SP_PAGE_BEGGING"
  pages[4] = "$MRT_SP_PAGE_DD"
  pages[5] = "$MRT_SP_PAGE_STD"
  pages[6] = "$MRT_SP_PAGE_INTEGRATION"
  pages[7] = "$MRT_SP_PAGE_STATS"
  pages[8] = "$MRT_SP_PAGE_DEBUG"
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
    _AddTextOptionST("DEBUG_PAPYRUSUTIL_CHECK_TXT", "PapyrusUtil v3+", MainScript.bIsPapyrusUtilActive As String, flag)
    _AddTextOptionST("DEBUG_PYRAMIDUTILS_CHECK_TXT", "Pyramid Utils v2.0.5+", MainScript.bIsPyramidUtilsOK As String, flag)
    _AddTextOptionST("DEBUG_PO3EXTENDER_CHECK_TXT", "PO3 Papyrus Extender v5+", MainScript.bIsPO3ExtenderActive As String, flag)
    _AddTextOptionST("DEBUG_SEXLAB_CHECK_TXT", "$sexlab", MainScript.bIsSexlabActive As String, flag)
    _AddTextOptionST("DEBUG_FLOWERGIRLS_CHECK_TXT", "$flowergirls", MainScript.bIsFlowerGirlsActive As String, flag)
    _AddTextOptionST("DEBUG_OSTIM_CHECK_TXT", "$ostim_sa", MainScript.bIsOstimActive As String, flag)
    _AddTextOptionST("DEBUG_LICENSES_CHECK_TXT", "$licenses", MainScript.bIsLicensesActive As String, flag)
    _AddTextOptionST("DEBUG_DDI_CHECK_TXT", "$DDIntegration", MainScript.bIsDDIntegrationActive As String, flag)
    _AddTextOptionST("DEBUG_DDX_CHECK_TXT", "$DDExpansion", MainScript.bIsDDExpansionActive As String, flag)
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
  elseif (page == "$MRT_SP_PAGE_BEGGING")
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
    if MainScript.bModEnabled && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf   
    OID_BEG_DD_CHANCE = AddSliderOption("$MRT_SP_BEG_DD_CHANCE_SLIDER1", MainScript.fBeggarDeviceChance, "$MRT_SP_BEG_DD_CHANCE_SLIDER2", flag)
    OID_BEG_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_BEG_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iBeggarEntrapmentLevel], flag)
    SetCursorPosition(1)
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    _AddHeaderOption("$MRT_SP_HEAD_BEG_WHORE")
    AddSliderOptionST("BEG_SEX_OFFER_SLIDER", "$MRT_SP_BEG_SEX_OFFER_SLIDER1", MainScript.fBeggarSexOfferChance, "$MRT_SP_BEG_SEX_OFFER_SLIDER2", flag)
    _AddToggleOptionST("BEGGING_MALE_SEX_OFFER_TOGGLE", "$MRT_SP_BEGGING_MALE_SEX_OFFER_TOGGLE", MainScript.bBeggingMaleSexOffer, flag)
    _AddToggleOptionST("BEGGING_FEMALE_SEX_OFFER_TOGGLE", "$MRT_SP_BEGGING_FEMALE_SEX_OFFER_TOGGLE", MainScript.bBeggingFemaleSexOffer, flag)
    OID_BEG_ONLY_LICENSED_SEX_OFFER = AddToggleOption("$MRT_SP_BEG_ONLY_LICENSED_SEX_OFFER", MainScript.bOnlyLicensedBeggarSexOffer, flag)
    OID_BEG_ONLY_INTERIOR_SEX_OFFER = AddToggleOption("$MRT_SP_BEG_ONLY_INTERIOR_SEX_OFFER", MainScript.bOnlyInteriorBeggarOfferSex, flag)
    OID_BEG_GUARDS_SEX_OFFER = AddToggleOption("$MRT_SP_BEG_GUARDS_SEX_OFFER", MainScript.bBeggarGuardsSexOffer, flag)
    OID_BEG_ELDER_SEX_OFFER = AddToggleOption("$MRT_SP_BEG_ELDER_SEX_OFFER", MainScript.bBeggarElderSexOffer, flag)
    AddEmptyOption()
    beggarRejectOptions(flag)

  elseif (page == "$MRT_SP_PAGE_DD")
    SetTitleText("$MRT_SP_PAGE_DD")
    _AddHeaderOption("$MRT_SP_HEAD_DD")
    if (MainScript.bModEnabled && MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    DD_Options(flag)
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
  elseIf page == "$MRT_SP_PAGE_DIBEL"
    SetTitleText("$MRT_SP_PAGE_DIBEL")
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
    if MainScript.bModEnabled && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf  
    OID_DIBEL_DD_CHANCE = AddSliderOption("$MRT_SP_DIBEL_DD_CHANCE_SLIDER1", MainScript.fDibelDeviceChance, "$MRT_SP_DIBEL_DD_CHANCE_SLIDER2", flag)
    OID_DIBEL_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_DIBEL_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iDibelEntrapmentLevel], flag)
    SetCursorPosition(1)
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
    AddEmptyOption()
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    dibelRejectOptions(flag)
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
    if MainScript.bModEnabled && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endIf
    OID_WHORE_DD_CHANCE = AddSliderOption("$MRT_SP_WHORE_DD_CHANCE_SLIDER1", MainScript.fWhoreDeviceChance, "$MRT_SP_WHORE_DD_CHANCE_SLIDER2", flag)
    OID_WHORE_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_WHORE_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iWhoreEntrapmentLevel], flag)
    SetCursorPosition(1)
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    whoreRejectOptions(flag)
  elseif page == "$MRT_SP_PAGE_GENERAL"
    SetTitleText("$MRT_SP_PAGE_GENERAL")
    _AddHeaderOption("$MRT_SP_HEAD_GENERAL")
    if (MainScript.bModEnabled)
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    approachOptions(flag)
    AddEmptyOption()
    OID_CRIME_BOUNTY = AddSliderOption("$MRT_SP_CRIME_BOUNTY_SLIDER1", MainScript.iCrimeBounty, "$MRT_SP_CRIME_BOUNTY_SLIDER2", flag)
    SetCursorPosition(1)
    if MainScript.bModEnabled
      flag = OPTION_FLAG_NONE
    else
      flag = OPTION_FLAG_DISABLED
    endif
    defaultRejectOptions(flag)
  endif
endevent

event OnVersionUpdate(Int version)
  if (version >= 100 && CurrentVersion < 100)
    Debug.Trace(self + ": Updating script to version " + 100)
  endif
endevent

Event OnConfigClose()
  if setModVars
    Mainscript.setVars()
    setModVars = false
  else
    if MainScript.fWhoreOwnerShare > 0.0 && !Mainscript.pimpTracker.isRunning()
      Mainscript.pimpTracker.start()
    endif
  endif
  Mainscript.ApproachMonitorScr.playerHasLicense()
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggingMaleRapistChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
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
  endevent

  event OnSliderOpenST()
    SetSliderDialogStartValue(MainScript.fBeggingFemaleRapistChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
    SetSliderDialogInterval(0.1)
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
        setModVars = true
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
  MainScript.bBeggarRejectTheftOnlyGold = jsonutil.GetPathIntValue(settings_path, "bBeggarRejectTheftOnlyGold", MainScript.bBeggarRejectTheftOnlyGold as Int)
  MainScript.bDefaultRejectTheftOnlyGold = jsonutil.GetPathIntValue(settings_path, "bDefaultRejectTheftOnlyGold", MainScript.bDefaultRejectTheftOnlyGold as Int)  
  MainScript.bDibelRejectTheftOnlyGold = jsonutil.GetPathIntValue(settings_path, "bDibelRejectTheftOnlyGold", MainScript.bDibelRejectTheftOnlyGold as Int) 
  MainScript.bWhoreRejectTheftOnlyGold = jsonutil.GetPathIntValue(settings_path, "bWhoreRejectTheftOnlyGold", MainScript.bWhoreRejectTheftOnlyGold as Int) 
  MainScript.bMaleCustomerApproach = jsonutil.GetPathIntValue(settings_path, "bMaleCustomerApproach", MainScript.bMaleCustomerApproach as Int) 
  MainScript.bFemaleCustomerApproach = jsonutil.GetPathIntValue(settings_path, "bFemaleCustomerApproach", MainScript.bFemaleCustomerApproach as Int)
  MainScript.bOnlyInteriorApproach = jsonutil.GetPathIntValue(settings_path, "bOnlyInteriorApproach", MainScript.bOnlyInteriorApproach as Int)
  MainScript.bOnlyLOSApproach = jsonutil.GetPathIntValue(settings_path, "bOnlyLOSApproach", MainScript.bOnlyLOSApproach as Int)
  MainScript.bOnlyWhoreClothingApproach = jsonutil.GetPathIntValue(settings_path, "bOnlyWhoreClothingApproach", MainScript.bOnlyWhoreClothingApproach as Int)
  MainScript.bOnlyLicensedApproach = jsonutil.GetPathIntValue(settings_path, "bOnlyLicensedApproach", MainScript.bOnlyLicensedApproach as Int)
  MainScript.bOnlyLicensedBeggarSexOffer = jsonutil.GetPathIntValue(settings_path, "bOnlyLicensedBeggarSexOffer", MainScript.bOnlyLicensedBeggarSexOffer as Int)
  MainScript.bOnlyInteriorBeggarOfferSex = jsonutil.GetPathIntValue(settings_path, "bOnlyInteriorBeggarOfferSex", MainScript.bOnlyInteriorBeggarOfferSex as Int)
  MainScript.bGuardsAreCruel = jsonutil.GetPathIntValue(settings_path, "bGuardsAreCruel", MainScript.bGuardsAreCruel as Int)
  MainScript.bBeggarRejectWalkAwayCheck = jsonutil.GetPathIntValue(settings_path, "bBeggarRejectWalkAwayCheck", MainScript.bBeggarRejectWalkAwayCheck as Int)
  MainScript.bGuardsMayApproach = jsonutil.GetPathIntValue(settings_path, "bGuardsMayApproach", MainScript.bGuardsMayApproach as Int)
  MainScript.bBeggarGuardsSexOffer = jsonutil.GetPathIntValue(settings_path, "bBeggarGuardsSexOffer", MainScript.bBeggarGuardsSexOffer as Int)
  MainScript.bEldersMayApproach = jsonutil.GetPathIntValue(settings_path, "bEldersMayApproach", MainScript.bEldersMayApproach as int)
  MainScript.bBeggarElderSexOffer = jsonutil.GetPathIntValue(settings_path, "bBeggarElderSexOffer", MainScript.bBeggarElderSexOffer as int)

  iBeggarSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  iWhoreSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  iDibelSpeechDifficulty = jsonutil.GetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)
  iAnimInterfaceMethod = jsonutil.GetPathIntValue(settings_path, "iAnimInterfaceMethod", iAnimInterfaceMethod)
  
  MainScript.iCustomerApproachTimer = jsonutil.GetPathIntValue(settings_path, "iCustomerApproachTimer", MainScript.iCustomerApproachTimer)
  MainScript.iCrimeBounty = jsonutil.GetPathIntValue(settings_path, "iCrimeBounty", MainScript.iCrimeBounty)
  MainScript.iDefaultRejectEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iDefaultRejectEntrapmentLevel", MainScript.iDefaultRejectEntrapmentLevel)
  MainScript.iDibelRejectEntrapmentLevel = jsonutil.GetPathIntValue(settings_path,  "iDibelRejectEntrapmentLevel", MainScript.iDibelRejectEntrapmentLevel)
  MainScript.iWhoreRejectEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iWhoreRejectEntrapmentLevel", MainScript.iWhoreRejectEntrapmentLevel)
  MainScript.iBeggarRejectEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iBeggarRejectEntrapmentLevel", MainScript.iBeggarRejectEntrapmentLevel)
  MainScript.iWhoreEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iWhoreEntrapmentLevel", MainScript.iWhoreEntrapmentLevel)
  MainScript.iDibelEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iDibelEntrapmentLevel", MainScript.iDibelEntrapmentLevel)
  MainScript.iBeggarEntrapmentLevel = jsonutil.GetPathIntValue(settings_path, "iBeggarEntrapmentLevel", MainScript.iBeggarEntrapmentLevel)

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
  MainScript.fBeggarSexOfferChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarSexOfferChance", MainScript.fBeggarSexOfferChance)
  MainScript.fBeggingFemaleRapistChance = jsonutil.GetPathFloatValue(settings_path, "fBeggingFemaleRapistChance", MainScript.fBeggingFemaleRapistChance) 
  MainScript.fBeggingMaleRapistChance = jsonutil.GetPathFloatValue(settings_path, "fBeggingMaleRapistChance", MainScript.fBeggingMaleRapistChance)
  MainScript.fBeggarRejectMaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleAcceptChance", MainScript.fBeggarRejectMaleAcceptChance)
  MainScript.fBeggarRejectFemaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleAcceptChance", MainScript.fBeggarRejectFemaleAcceptChance)
  MainScript.fBeggarRejectMaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleTheftChance", MainScript.fBeggarRejectMaleTheftChance)
  MainScript.fBeggarRejectFemaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleTheftChance", MainScript.fBeggarRejectFemaleTheftChance) 
  MainScript.fBeggarRejectMaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleAssaultChance", MainScript.fBeggarRejectMaleAssaultChance)
  MainScript.fBeggarRejectFemaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleAssaultChance", MainScript.fBeggarRejectFemaleAssaultChance)
  MainScript.fBeggarRejectMaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleSlaveryChance", MainScript.fBeggarRejectMaleSlaveryChance)
  MainScript.fBeggarRejectFemaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleSlaveryChance", MainScript.fBeggarRejectFemaleSlaveryChance)

  MainScript.fWhoreRejectMaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleAcceptChance", MainScript.fWhoreRejectMaleAcceptChance)
  MainScript.fWhoreRejectFemaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleAcceptChance", MainScript.fWhoreRejectFemaleAcceptChance)
  MainScript.fWhoreRejectMaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleRapeChance", MainScript.fWhoreRejectMaleRapeChance)
  MainScript.fWhoreRejectFemaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleRapeChance", MainScript.fWhoreRejectFemaleRapeChance)
  MainScript.fWhoreRejectMaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleTheftChance", MainScript.fWhoreRejectMaleTheftChance)
  MainScript.fWhoreRejectFemaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleTheftChance", MainScript.fWhoreRejectFemaleTheftChance)
  MainScript.fWhoreRejectMaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleAssaultChance", MainScript.fWhoreRejectMaleAssaultChance)
  MainScript.fWhoreRejectFemaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleAssaultChance", MainScript.fWhoreRejectFemaleAssaultChance)
  MainScript.fWhoreRejectMaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleSlaveryChance", MainScript.fWhoreRejectMaleSlaveryChance)
  MainScript.fWhoreRejectFemaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleSlaveryChance", MainScript.fWhoreRejectFemaleSlaveryChance)
  MainScript.fWhoreRejectMaleReportChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleReportChance", MainScript.fWhoreRejectMaleReportChance)
  MainScript.fWhoreRejectFemaleReportChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleReportChance", MainScript.fWhoreRejectFemaleReportChance)

  MainScript.fDibelRejectMaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleAcceptChance", MainScript.fDibelRejectMaleAcceptChance)
  MainScript.fDibelRejectFemaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleAcceptChance", MainScript.fDibelRejectFemaleAcceptChance)
  MainScript.fDibelRejectMaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleRapeChance", MainScript.fDibelRejectMaleRapeChance)
  MainScript.fDibelRejectFemaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleRapeChance", MainScript.fDibelRejectFemaleRapeChance)
  MainScript.fDibelRejectMaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleTheftChance", MainScript.fDibelRejectMaleTheftChance)
  MainScript.fDibelRejectFemaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleTheftChance", MainScript.fDibelRejectFemaleTheftChance)
  MainScript.fDibelRejectMaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleAssaultChance", MainScript.fDibelRejectMaleAssaultChance)
  MainScript.fDibelRejectFemaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleAssaultChance", MainScript.fDibelRejectFemaleAssaultChance)
  MainScript.fDibelRejectMaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleSlaveryChance", MainScript.fDibelRejectMaleSlaveryChance)
  MainScript.fDibelRejectFemaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleSlaveryChance", MainScript.fDibelRejectFemaleSlaveryChance)
  MainScript.fDibelRejectMaleReportChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleReportChance", MainScript.fDibelRejectMaleReportChance)
  MainScript.fDibelRejectFemaleReportChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleReportChance", MainScript.fDibelRejectFemaleReportChance)
  MainScript.fCustomerApproachChance = jsonutil.GetPathFloatValue(settings_path, "fCustomerApproachChance", MainScript.fCustomerApproachChance)
  MainScript.fMaxApproachDistance = jsonutil.GetPathFloatValue(settings_path, "fMaxApproachDistance", MainScript.fMaxApproachDistance)
  MainScript.fDibelRejectMaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleMurderChance", MainScript.fDibelRejectMaleMurderChance)
  MainScript.fDibelRejectFemaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleMurderChance", MainScript.fDibelRejectFemaleMurderChance)
  MainScript.fWhoreRejectMaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleMurderChance", MainScript.fWhoreRejectMaleMurderChance)
  MainScript.fWhoreRejectFemaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleMurderChance", MainScript.fWhoreRejectFemaleMurderChance)
  MainScript.fBeggarRejectMaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleMurderChance", MainScript.fBeggarRejectMaleMurderChance)
  MainScript.fBeggarRejectFemaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleMurderChance", MainScript.fBeggarRejectFemaleMurderChance)

  MainScript.fDefaultRejectMaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleAcceptChance", MainScript.fDefaultRejectMaleAcceptChance)
  MainScript.fDefaultRejectFemaleAcceptChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleAcceptChance", MainScript.fDefaultRejectFemaleAcceptChance)
  MainScript.fDefaultRejectMaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleRapeChance", MainScript.fDefaultRejectMaleRapeChance)
  MainScript.fDefaultRejectFemaleRapeChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleRapeChance", MainScript.fDefaultRejectFemaleRapeChance)
  MainScript.fDefaultRejectMaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleTheftChance", MainScript.fDefaultRejectMaleTheftChance)
  MainScript.fDefaultRejectFemaleTheftChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleTheftChance", MainScript.fDefaultRejectFemaleTheftChance)
  MainScript.fDefaultRejectMaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleAssaultChance", MainScript.fDefaultRejectMaleAssaultChance)
  MainScript.fDefaultRejectFemaleAssaultChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleAssaultChance", MainScript.fDefaultRejectFemaleAssaultChance)
  MainScript.fDefaultRejectMaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleSlaveryChance", MainScript.fDefaultRejectMaleSlaveryChance)
  MainScript.fDefaultRejectFemaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleSlaveryChance", MainScript.fDefaultRejectFemaleSlaveryChance)
  MainScript.fDefaultRejectMaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleMurderChance", MainScript.fDefaultRejectMaleMurderChance)
  MainScript.fDefaultRejectFemaleMurderChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleMurderChance", MainScript.fDefaultRejectFemaleMurderChance)

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

  MainScript.fDeviousSuitsChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousSuitsChance", MainScript.fDeviousSuitsChance)
  MainScript.fDeviousHeavyRestraintChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousHeavyRestraintChance", MainScript.fDeviousHeavyRestraintChance)
  MainScript.fDeviousBlindfoldChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousBlindfoldChance", MainScript.fDeviousBlindfoldChance)
  MainScript.fDeviousHoodChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousHoodChance", MainScript.fDeviousHoodChance)
  MainScript.fDeviousChastityBrasChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousChastityBrasChance", MainScript.fDeviousChastityBrasChance)
  MainScript.fDeviousChastityBeltCloseChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousChastityBeltCloseChance", MainScript.fDeviousChastityBeltCloseChance)
  MainScript.fDeviousChastityBeltOpenChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousChastityBeltOpenChance", MainScript.fDeviousChastityBeltOpenChance)
  MainScript.fDeviousGagAllChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousGagAllChance", MainScript.fDeviousGagAllChance)
  MainScript.fDeviousGagRingChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousGagRingChance", MainScript.fDeviousGagRingChance)
  MainScript.fDeviousHarnessesChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousHarnessesChance", MainScript.fDeviousHarnessesChance)
  MainScript.fDeviousCorsetChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousCorsetChance", MainScript.fDeviousCorsetChance)
  MainScript.fDeviousBootsChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousBootsChance", MainScript.fDeviousBootsChance)
  MainScript.fDeviousGlovesChance   = jsonutil.GetPathFloatValue(settings_path, "fDeviousGlovesChance", MainScript.fDeviousGlovesChance)
  MainScript.fDeviousCollarChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousCollarChance", MainScript.fDeviousCollarChance)
  MainScript.fDeviousLegCuffChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousLegCuffChance", MainScript.fDeviousLegCuffChance)
  MainScript.fDeviousArmCuffChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousArmCuffChance", MainScript.fDeviousArmCuffChance)
  MainScript.fDeviousVaginalPlugChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousVaginalPlugChance", MainScript.fDeviousVaginalPlugChance)
  MainScript.fDeviousAnalPlugChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousAnalPlugChance", MainScript.fDeviousAnalPlugChance)
  MainScript.fDeviousVaginalPiercingChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousVaginalPiercingChance", MainScript.fDeviousVaginalPiercingChance)
  MainScript.fDeviousNipplePiercingChance = jsonutil.GetPathFloatValue(settings_path, "fDeviousNipplePiercingChance", MainScript.fDeviousNipplePiercingChance)
  MainScript.fDefaultRejectMaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectMaleDeviceChance", MainScript.fDefaultRejectMaleDeviceChance)
  MainScript.fDefaultRejectFemaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fDefaultRejectFemaleDeviceChance", MainScript.fDefaultRejectFemaleDeviceChance)
  MainScript.fWhoreRejectMaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectMaleDeviceChance", MainScript.fWhoreRejectMaleDeviceChance)
  MainScript.fWhoreRejectFemaleSlaveryChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreRejectFemaleSlaveryChance", MainScript.fWhoreRejectFemaleSlaveryChance)
  MainScript.fBeggarRejectMaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectMaleDeviceChance", MainScript.fBeggarRejectMaleDeviceChance)
  MainScript.fBeggarRejectFemaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarRejectFemaleDeviceChance", MainScript.fBeggarRejectFemaleDeviceChance)
  MainScript.fDibelRejectMaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectMaleDeviceChance", MainScript.fDibelRejectMaleDeviceChance)
  MainScript.fDibelRejectFemaleDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fDibelRejectFemaleDeviceChance", MainScript.fDibelRejectFemaleDeviceChance)
  MainScript.fWhoreDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fWhoreDeviceChance", MainScript.fWhoreDeviceChance)
  MainScript.fDibelDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fDibelDeviceChance", MainScript.fDibelDeviceChance)
  MainScript.fBeggarDeviceChance = jsonutil.GetPathFloatValue(settings_path, "fBeggarDeviceChance", MainScript.fBeggarDeviceChance)




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
  jsonutil.SetPathIntValue(settings_path, "bBeggarRejectTheftOnlyGold", MainScript.bBeggarRejectTheftOnlyGold as Int)
  jsonutil.SetPathIntValue(settings_path, "bDefaultRejectTheftOnlyGold", MainScript.bDefaultRejectTheftOnlyGold as Int)
  jsonutil.SetPathIntValue(settings_path, "bDibelRejectTheftOnlyGold", MainScript.bDibelRejectTheftOnlyGold as Int)
  jsonutil.SetPathIntValue(settings_path, "bWhoreRejectTheftOnlyGold", MainScript.bWhoreRejectTheftOnlyGold as Int)
  jsonutil.SetPathIntValue(settings_path, "bMaleCustomerApproach", MainScript.bMaleCustomerApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bFemaleCustomerApproach", MainScript.bFemaleCustomerApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bOnlyWhoreClothingApproach", MainScript.bOnlyWhoreClothingApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bOnlyInteriorApproach", MainScript.bOnlyInteriorApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bOnlyLOSApproach", MainScript.bOnlyLOSApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bOnlyLicensedApproach", MainScript.bOnlyLicensedApproach as Int)  
  jsonutil.SetPathIntValue(settings_path, "bOnlyLicensedBeggarSexOffer", MainScript.bOnlyLicensedBeggarSexOffer as Int)
  jsonutil.SetPathIntValue(settings_path, "bOnlyInteriorBeggarOfferSex", MainScript.bOnlyInteriorBeggarOfferSex as Int)
  jsonutil.SetPathIntValue(settings_path, "bGuardsAreCruel", MainScript.bGuardsAreCruel as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggarRejectWalkAwayCheck", MainScript.bBeggarRejectWalkAwayCheck as Int)
  jsonutil.SetPathIntValue(settings_path, "bGuardsMayApproach", MainScript.bGuardsMayApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggarGuardsSexOffer", MainScript.bBeggarGuardsSexOffer as Int)
  jsonutil.SetPathIntValue(settings_path, "bEldersMayApproach", MainScript.bEldersMayApproach as Int)
  jsonutil.SetPathIntValue(settings_path, "bBeggarElderSexOffer", MainScript.bBeggarElderSexOffer as Int)

  jsonutil.SetPathIntValue(settings_path, "iBeggarSpeechDifficulty", iBeggarSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iWhoreSpeechDifficulty", iWhoreSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iDibelSpeechDifficulty", iDibelSpeechDifficulty)
  jsonutil.SetPathIntValue(settings_path, "iAnimInterfaceMethod", iAnimInterfaceMethod)
  jsonutil.SetPathIntValue(settings_path, "iCustomerApproachTimer", MainScript.iCustomerApproachTimer)
  jsonutil.SetPathIntValue(settings_path, "iCrimeBounty", MainScript.iCrimeBounty)

  jsonutil.SetPathIntValue(settings_path, "iDefaultRejectEntrapmentLevel", MainScript.iDefaultRejectEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iDibelRejectEntrapmentLevel", MainScript.iDibelRejectEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iWhoreRejectEntrapmentLevel", MainScript.iWhoreRejectEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iBeggarRejectEntrapmentLevel", MainScript.iBeggarRejectEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iWhoreEntrapmentLevel", MainScript.iWhoreEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iDibelEntrapmentLevel", MainScript.iDibelEntrapmentLevel)
  jsonutil.SetPathIntValue(settings_path, "iBeggarEntrapmentLevel", MainScript.iBeggarEntrapmentLevel)

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
  jsonutil.SetPathFloatValue(settings_path, "fBeggarSexOfferChance", MainScript.fBeggarSexOfferChance)
  jsonutil.SetPathFloatValue(settings_path, "fCustomerApproachChance", MainScript.fCustomerApproachChance)
  jsonutil.SetPathFloatValue(settings_path, "fMaxApproachDistance", MainScript.fMaxApproachDistance)

  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleAcceptChance", MainScript.fWhoreRejectMaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleAcceptChance", MainScript.fWhoreRejectFemaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleRapeChance", MainScript.fWhoreRejectMaleRapeChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleRapeChance", MainScript.fWhoreRejectFemaleRapeChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleTheftChance", MainScript.fWhoreRejectMaleTheftChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleTheftChance", MainScript.fWhoreRejectFemaleTheftChance)  
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleAssaultChance", MainScript.fWhoreRejectMaleAssaultChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleAssaultChance", MainScript.fWhoreRejectFemaleAssaultChance)   
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleSlaveryChance", MainScript.fWhoreRejectMaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleSlaveryChance", MainScript.fWhoreRejectFemaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleReportChance", MainScript.fWhoreRejectMaleReportChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleReportChance", MainScript.fWhoreRejectFemaleReportChance) 

  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleAcceptChance", MainScript.fDibelRejectMaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleAcceptChance", MainScript.fDibelRejectFemaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleRapeChance", MainScript.fDibelRejectMaleRapeChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleRapeChance", MainScript.fDibelRejectFemaleRapeChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleTheftChance", MainScript.fDibelRejectMaleTheftChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleTheftChance", MainScript.fDibelRejectFemaleTheftChance)  
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleAssaultChance", MainScript.fDibelRejectMaleAssaultChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleAssaultChance", MainScript.fDibelRejectFemaleAssaultChance)   
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleSlaveryChance", MainScript.fDibelRejectMaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleSlaveryChance", MainScript.fDibelRejectFemaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleReportChance", MainScript.fDibelRejectMaleReportChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleReportChance", MainScript.fDibelRejectFemaleReportChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleMurderChance", MainScript.fDibelRejectMaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleMurderChance", MainScript.fDibelRejectFemaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleMurderChance", MainScript.fWhoreRejectMaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleMurderChance", MainScript.fWhoreRejectFemaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleMurderChance", MainScript.fBeggarRejectMaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleMurderChance", MainScript.fBeggarRejectFemaleMurderChance)

  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleAcceptChance", MainScript.fDefaultRejectMaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleAcceptChance", MainScript.fDefaultRejectFemaleAcceptChance)  
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleRapeChance", MainScript.fDefaultRejectMaleRapeChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleRapeChance", MainScript.fDefaultRejectFemaleRapeChance) 
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleTheftChance", MainScript.fDefaultRejectMaleTheftChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleTheftChance", MainScript.fDefaultRejectFemaleTheftChance) 
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleAssaultChance", MainScript.fDefaultRejectMaleAssaultChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleAssaultChance", MainScript.fDefaultRejectFemaleAssaultChance) 
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleSlaveryChance", MainScript.fDefaultRejectMaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleSlaveryChance", MainScript.fDefaultRejectFemaleSlaveryChance) 
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleMurderChance", MainScript.fDefaultRejectMaleMurderChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleMurderChance", MainScript.fDefaultRejectFemaleMurderChance)

  jsonutil.SetPathFloatValue(settings_path, "fBeggingFemaleRapistChance", MainScript.fBeggingFemaleRapistChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggingMaleRapistChance", MainScript.fBeggingMaleRapistChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleAcceptChance", MainScript.fBeggarRejectMaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleAcceptChance", MainScript.fBeggarRejectFemaleAcceptChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleTheftChance", MainScript.fBeggarRejectMaleTheftChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleTheftChance", MainScript.fBeggarRejectFemaleTheftChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleAssaultChance", MainScript.fBeggarRejectMaleAssaultChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleAssaultChance", MainScript.fBeggarRejectFemaleAssaultChance)

  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleSlaveryChance", MainScript.fBeggarRejectMaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleSlaveryChance", MainScript.fBeggarRejectFemaleSlaveryChance)

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

  jsonutil.SetPathFloatValue(settings_path, "fDeviousSuitsChance", MainScript.fDeviousSuitsChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousHeavyRestraintChance", MainScript.fDeviousHeavyRestraintChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousBlindfoldChance", MainScript.fDeviousBlindfoldChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousHoodChance", MainScript.fDeviousHoodChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousChastityBrasChance", MainScript.fDeviousChastityBrasChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousChastityBeltCloseChance", MainScript.fDeviousChastityBeltCloseChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousChastityBeltOpenChance", MainScript.fDeviousChastityBeltOpenChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousGagAllChance", MainScript.fDeviousGagAllChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousGagRingChance", MainScript.fDeviousGagRingChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousHarnessesChance", MainScript.fDeviousHarnessesChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousCorsetChance", MainScript.fDeviousCorsetChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousBootsChance", MainScript.fDeviousBootsChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousGlovesChance", MainScript.fDeviousGlovesChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousCollarChance", MainScript.fDeviousCollarChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousLegCuffChance", MainScript.fDeviousLegCuffChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousArmCuffChance", MainScript.fDeviousArmCuffChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousVaginalPlugChance", MainScript.fDeviousVaginalPlugChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousAnalPlugChance", MainScript.fDeviousAnalPlugChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousVaginalPiercingChance", MainScript.fDeviousVaginalPiercingChance)
  jsonutil.SetPathFloatValue(settings_path, "fDeviousNipplePiercingChance", MainScript.fDeviousNipplePiercingChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectMaleDeviceChance", MainScript.fDefaultRejectMaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fDefaultRejectFemaleDeviceChance", MainScript.fDefaultRejectFemaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectMaleDeviceChance", MainScript.fWhoreRejectMaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreRejectFemaleSlaveryChance", MainScript.fWhoreRejectFemaleSlaveryChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectMaleDeviceChance", MainScript.fBeggarRejectMaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarRejectFemaleDeviceChance", MainScript.fBeggarRejectFemaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectMaleDeviceChance", MainScript.fDibelRejectMaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelRejectFemaleDeviceChance", MainScript.fDibelRejectFemaleDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fWhoreDeviceChance", MainScript.fWhoreDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fDibelDeviceChance", MainScript.fDibelDeviceChance)
  jsonutil.SetPathFloatValue(settings_path, "fBeggarDeviceChance", MainScript.fBeggarDeviceChance)

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


event OnOptionSelect(int option)
  if option == OID_WHORE_REJ_THEFT_ONLYGOLD
    MainScript.bWhoreRejectTheftOnlyGold = !MainScript.bWhoreRejectTheftOnlyGold
    SetToggleOptionValue(option, MainScript.bWhoreRejectTheftOnlyGold)
  elseif option == OID_DIBEL_REJ_THEFT_ONLYGOLD
    MainScript.bDibelRejectTheftOnlyGold = !MainScript.bDibelRejectTheftOnlyGold
    SetToggleOptionValue(option, MainScript.bDibelRejectTheftOnlyGold)
  elseif option == OID_BEG_REJ_THEFT_ONLYGOLD
    MainScript.bBeggarRejectTheftOnlyGold = !MainScript.bBeggarRejectTheftOnlyGold
    SetToggleOptionValue(option, MainScript.bBeggarRejectTheftOnlyGold)
  elseif option == OID_BEG_REJ_WALKAWAY_CHECK
    MainScript.bBeggarRejectWalkAwayCheck = !MainScript.bBeggarRejectWalkAwayCheck
    SetToggleOptionValue(option, MainScript.bBeggarRejectWalkAwayCheck)
  elseif option == OID_BEG_ONLY_INTERIOR_SEX_OFFER
    MainScript.bOnlyInteriorBeggarOfferSex = !MainScript.bOnlyInteriorBeggarOfferSex
    SetToggleOptionValue(option, MainScript.bOnlyInteriorBeggarOfferSex)
  elseif option == OID_BEG_GUARDS_SEX_OFFER
    MainScript.bBeggarGuardsSexOffer = !MainScript.bBeggarGuardsSexOffer
    SetToggleOptionValue(option, MainScript.bBeggarGuardsSexOffer)
  elseif option == OID_BEG_ELDER_SEX_OFFER
    MainScript.bBeggarElderSexOffer = !MainScript.bBeggarElderSexOffer
    SetToggleOptionValue(option, MainScript.bBeggarElderSexOffer)
  elseif option == OID_MALE_CUSTOMER_APPROACH
    MainScript.bMaleCustomerApproach = !MainScript.bMaleCustomerApproach
    SetToggleOptionValue(option, MainScript.bMaleCustomerApproach)
  elseif option == OID_FEMALE_CUSTOMER_APPROACH
    MainScript.bFemaleCustomerApproach = !MainScript.bFemaleCustomerApproach
    SetToggleOptionValue(option, MainScript.bFemaleCustomerApproach)
  elseif option == OID_ONLY_WHORE_CLOTHING_APPROACH
    MainScript.bOnlyWhoreClothingApproach =  !MainScript.bOnlyWhoreClothingApproach
    SetToggleOptionValue(option, MainScript.bOnlyWhoreClothingApproach)
  elseif option == OID_ONLY_INTERIOR_APPROACH
    MainScript.bOnlyInteriorApproach = !MainScript.bOnlyInteriorApproach
    SetToggleOptionValue(option, MainScript.bOnlyInteriorApproach)
  elseif option == OID_ONLY_LOS_APPROACH
    MainScript.bOnlyLOSApproach = !MainScript.bOnlyLOSApproach
    SetToggleOptionValue(option, MainScript.bOnlyLOSApproach)
  elseif option == OID_ONLY_LICENSED_APPROACH
    MainScript.bOnlyLicensedApproach = !MainScript.bOnlyLicensedApproach
    SetToggleOptionValue(option, MainScript.bOnlyLicensedApproach) 
  elseif option == OID_BEG_ONLY_LICENSED_SEX_OFFER
    MainScript.bOnlyLicensedBeggarSexOffer = !MainScript.bOnlyLicensedBeggarSexOffer
    SetToggleOptionValue(option, MainScript.bOnlyLicensedBeggarSexOffer)
  elseif option == OID_DEFAULT_REJ_THEFT_ONLYGOLD
    MainScript.bDefaultRejectTheftOnlyGold = !MainScript.bDefaultRejectTheftOnlyGold
    SetToggleOptionValue(option, MainScript.bDefaultRejectTheftOnlyGold)
  elseif option == OID_CRUEL_GUARDS_APPROACH
    MainScript.bGuardsAreCruel = !MainScript.bGuardsAreCruel
    SetToggleOptionValue(option, MainScript.bGuardsAreCruel)
  elseif option == OID_GUARDS_MAY_APPROACH
    MainScript.bGuardsMayApproach = !MainScript.bGuardsMayApproach
    SetToggleOptionValue(option, MainScript.bGuardsMayApproach)
  elseif option == OID_ELDER_MAY_APPROACH
    MainScript.bEldersMayApproach = !MainScript.bEldersMayApproach
    SetToggleOptionValue(option, MainScript.bEldersMayApproach)
  endif
  ForcePageReset()
EndEvent

event OnOptionDefault(int option)
  if option == OID_WHORE_REJ_THEFT_ONLYGOLD
    MainScript.bWhoreRejectTheftOnlyGold = True
    SetToggleOptionValue(option, MainScript.bWhoreRejectTheftOnlyGold)
  elseif option == OID_DIBEL_REJ_THEFT_ONLYGOLD
    MainScript.bDibelRejectTheftOnlyGold = True
    SetToggleOptionValue(option, MainScript.bDibelRejectTheftOnlyGold)
  elseif option == OID_BEG_REJ_THEFT_ONLYGOLD
    MainScript.bBeggarRejectTheftOnlyGold = True
    SetToggleOptionValue(option, MainScript.bBeggarRejectTheftOnlyGold)
  elseif option == OID_BEG_REJ_WALKAWAY_CHECK
    MainScript.bBeggarRejectWalkAwayCheck = False
    SetToggleOptionValue(option, MainScript.bBeggarRejectWalkAwayCheck)
  elseif option == OID_BEG_ONLY_INTERIOR_SEX_OFFER
    MainScript.bOnlyInteriorBeggarOfferSex = False
    SetToggleOptionValue(option, MainScript.bOnlyInteriorBeggarOfferSex)
  elseif option == OID_BEG_GUARDS_SEX_OFFER
    MainScript.bBeggarGuardsSexOffer = True
    SetToggleOptionValue(option, MainScript.bBeggarGuardsSexOffer)
  elseif option == OID_BEG_ELDER_SEX_OFFER
    MainScript.bBeggarElderSexOffer = True
    SetToggleOptionValue(option, MainScript.bBeggarElderSexOffer)
  elseif option == OID_MALE_CUSTOMER_APPROACH
    MainScript.bMaleCustomerApproach = True
    SetToggleOptionValue(option, MainScript.bMaleCustomerApproach)
  elseif option == OID_FEMALE_CUSTOMER_APPROACH
    MainScript.bFemaleCustomerApproach = True
    SetToggleOptionValue(option, MainScript.bFemaleCustomerApproach)
  elseif option == OID_ONLY_WHORE_CLOTHING_APPROACH
    MainScript.bOnlyWhoreClothingApproach = False
  elseif option == OID_ONLY_INTERIOR_APPROACH
    MainScript.bOnlyInteriorApproach = False
  elseif option == OID_ONLY_LOS_APPROACH
    MainScript.bOnlyLOSApproach = True
  elseif option == OID_ONLY_LICENSED_APPROACH
    MainScript.bOnlyLicensedApproach = True
  elseif option == OID_BEG_ONLY_LICENSED_SEX_OFFER
    MainScript.bOnlyLicensedBeggarSexOffer = True
  elseif option == OID_DEFAULT_REJ_THEFT_ONLYGOLD
    MainScript.bDefaultRejectTheftOnlyGold = True
    SetToggleOptionValue(option, MainScript.bDefaultRejectTheftOnlyGold)
  elseif option == OID_CRUEL_GUARDS_APPROACH
    MainScript.bGuardsAreCruel = True
    SetToggleOptionValue(option, MainScript.bGuardsAreCruel)
  elseif option == OID_GUARDS_MAY_APPROACH
    MainScript.bGuardsMayApproach = true
    SetToggleOptionValue(option, MainScript.bGuardsMayApproach)
  elseif option == OID_ELDER_MAY_APPROACH
    MainScript.bEldersMayApproach = true
    SetToggleOptionValue(option, MainScript.bEldersMayApproach)
  endif
  ForcePageReset()
EndEvent

event OnOptionHighlight(int option)
  if option == OID_BEG_REJ_MALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_ACCEPT_SLIDER")
  elseif option == OID_BEG_REJ_FEMALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_ACCEPT_SLIDER")
  elseif option == OID_BEG_REJ_MALE_THEFT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_THEFT_SLIDER")
  elseif option == OID_BEG_REJ_FEMALE_THEFT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_THEFT_SLIDER")
  elseif option == OID_BEG_REJ_MALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_ASSAULT_SLIDER")
  elseif option == OID_BEG_REJ_FEMALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_ASSAULT_SLIDER")
  elseif option == OID_BEG_REJ_MALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_SLAVERY_SLIDER")
  elseif option == OID_BEG_REJ_FEMALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_SLAVERY_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_ACCEPT_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_ACCEPT_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_REPORT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_REPORT_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_REPORT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_REPORT_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_RAPE
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_RAPE_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_RAPE
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_RAPE_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_THEFT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_THEFT_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_THEFT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_THEFT_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_ASSAULT_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_ASSAULT_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_SLAVERY_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_SLAVERY_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_ACCEPT_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_ACCEPT_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_REPORT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_REPORT_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_REPORT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_REPORT_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_RAPE
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_RAPE_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_RAPE
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_RAPE_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_THEFT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_THEFT_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_THEFT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_THEFT_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_ASSAULT_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_ASSAULT_SLIDER")
  elseif option == OID_DIBEL_REJ_MALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_SLAVERY_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_SLAVERY_SLIDER")
  elseif option == OID_CUSTOMER_APPROACH_INTERVAL
    SetInfoText("$MRT_SP_DESC_CUSTOMER_APPROACH_INTERVAL_SLIDER")
  elseif option == OID_CUSTOMER_APPROACH_CHANCE 
    SetInfoText("$MRT_SP_DESC_CUSTOMER_APPROACH_CHANCE_SLIDER")
  elseif option == OID_MAX_DISTANCE_APPROACH
    SetInfoText("$MRT_SP_DESC_MAX_DISTANCE_APPROACH_SLIDER")
  elseif option == OID_FEMALE_CUSTOMER_APPROACH 
    SetInfoText("$MRT_SP_DESC_FEMALE_CUSTOMER_APPROACH")
  elseif option == OID_MALE_CUSTOMER_APPROACH
    SetInfoText("$MRT_SP_DESC_MALE_CUSTOMER_APPROACH")
  elseif option == OID_BEG_ONLY_INTERIOR_SEX_OFFER
    SetInfoText("$MRT_SP_DESC_BEG_REJ_ONLY_INTERIOR_SEX_OFFER")
  elseif option == OID_BEG_GUARDS_SEX_OFFER
    SetInfoText("$MRT_SP_DESC_BEG_GUARDS_SEX_OFFER")
  elseif option == OID_BEG_REJ_THEFT_ONLYGOLD
    SetInfoText("$MRT_SP_DESC_BEG_REJ_THEFT_ONLYGOLD")
  elseif option == OID_BEG_REJ_WALKAWAY_CHECK
    SetInfoText("$MRT_SP_DESC_BEG_REJ_WALKAWAY_CHECK")
  elseif option == OID_WHORE_REJ_THEFT_ONLYGOLD
	  SetInfoText("$MRT_SP_DESC_WHORE_REJ_THEFT_ONLYGOLD")
  elseif option == OID_DIBEL_REJ_THEFT_ONLYGOLD
   SetInfoText("$MRT_SP_DESC_DIBEL_REJ_THEFT_ONLYGOLD")
  elseif option == OID_ONLY_WHORE_CLOTHING_APPROACH
    SetInfoText("$MRT_SP_DESC_ONLY_WHORE_CLOTHING_APPROACH")
  elseif option == OID_ONLY_INTERIOR_APPROACH
    SetInfoText("$MRT_SP_DESC_ONLY_INTERIOR_APPROACH")
  elseif option == OID_ONLY_LOS_APPROACH
    SetInfoText("$MRT_SP_DESC_ONLY_LOS_APPROACH")
  elseif option == OID_ONLY_LICENSED_APPROACH
    SetInfoText("$MRT_SP_DESC_ONLY_LICENSED_APPROACH_TOGGLE")
  elseif option == OID_BEG_ONLY_LICENSED_SEX_OFFER
    SetInfoText("$MRT_SP_DESC_BEG_ONLY_LICENSED_SEX_OFFER")
  elseif option == OID_CRIME_BOUNTY
    SetInfoText("$MRT_SP_DESC_CRIME_BOUNTY")
  elseif option == OID_DIBEL_REJ_MALE_MURDER
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_MURDER_SLIDER")
  elseif option == OID_DIBEL_REJ_FEMALE_MURDER
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_MURDER_SLIDER")
  elseif option == OID_WHORE_REJ_MALE_MURDER
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_MURDER_SLIDER")
  elseif option == OID_WHORE_REJ_FEMALE_MURDER
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_MURDER_SLIDER")
  elseif option == OID_BEG_REJ_MALE_MURDER
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_MURDER_SLIDER")
  elseif option == OID_BEG_REJ_FEMALE_MURDER
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_MURDER_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_MURDER
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_MURDER_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_MURDER
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_MURDER_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_ACCEPT_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_ACCEPT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_ACCEPT_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_RAPE
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_RAPE_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_RAPE
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_RAPE_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_THEFT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_THEFT_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_THEFT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_THEFT_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_ASSAULT_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_ASSAULT
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_ASSAULT_SLIDER")
  elseif option == OID_DEFAULT_REJ_MALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_SLAVERY_SLIDER")
  elseif option == OID_DEFAULT_REJ_FEMALE_SLAVERY
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_SLAVERY_SLIDER")
  elseif option == OID_DEFAULT_REJ_THEFT_ONLYGOLD
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_THEFT_ONLYGOLD")
  elseif option == OID_CRUEL_GUARDS_APPROACH
    SetInfoText("$MRT_SP_DESC_CRUEL_GUARDS_APPROACH")
  elseif option == OID_GUARDS_MAY_APPROACH
    SetInfoText("$MRT_SP_DESC_GUARDS_MAY_APPROACH")
  
  elseif option == OID_DEVIOUS_VAG_PRC
    SetInfoText("$MRT_SP_DESC_DEVIOUS_VAG_PRC")
  elseif option == OID_DEVIOUS_NIP_PRC
    SetInfoText("$MRT_SP_DESC_DEVIOUS_NIP_PRC")
  elseif option == OID_DEVIOUS_VAG_PLUG
    SetInfoText("$MRT_SP_DESC_DEVIOUS_VAG_PLUG")
  elseif option == OID_DEVIOUS_ANL_PLUG
    SetInfoText("$MRT_SP_DESC_EVIOUS_ANL_PLUG")
  elseif option == OID_DEVIOUS_ARM_CUF
    SetInfoText("$MRT_SP_DESC_DEVIOUS_ARM_CUF")
  elseif option == OID_DEVIOUS_LEG_CUF
    SetInfoText("$MRT_SP_DESC_DEVIOUS_LEG_CUF")
  elseif option == OID_DEVIOUS_COLLAR
    SetInfoText("$MRT_SP_DESC_DEVIOUS_COLLAR")
  elseif option == OID_DEVIOUS_GLOVES
    SetInfoText("$MRT_SP_DESC_DEVIOUS_GLOVES")
  elseif option == OID_DEVIOUS_BOOTS
    SetInfoText("$MRT_SP_DESC_DEVIOUS_BOOTS")
  elseif option == OID_DEVIOUS_CORSET
    SetInfoText("$MRT_SP_DESC_DEVIOUS_CORSET")
  elseif option == OID_DEVIOUS_HARNESS
    SetInfoText("$MRT_SP_DESC_DEVIOUS_HARNESS")
  elseif option == OID_DEVIOUS_GAG_RING
    SetInfoText("$MRT_SP_DESC_DEVIOUS_GAG_RING")
  elseif option == OID_DEVIOUS_GAG_ALL
    SetInfoText("$MRT_SP_DESC_DEVIOUS_GAG_ALL")
  elseif option == OID_DEVIOUS_BELT_OPEN
    SetInfoText("$MRT_SP_DESC_DEVIOUS_BELT_OPEN")
  elseif option == OID_DEVIOUS_BELT_CLOSE
    SetInfoText("$MRT_SP_DESC_DEVIOUS_BELT_CLOSE")
  elseif option == OID_DEVIOUS_BRA
    SetInfoText("$MRT_SP_DESC_DEVIOUS_BRA")
  elseif option == OID_DEVIOUS_HOOD
    SetInfoText("$MRT_SP_DESC_DEVIOUS_HOOD")
  elseif option == OID_DEVIOUS_BLINDFOLD
    SetInfoText("$MRT_SP_DESC_DEVIOUS_BLINDFOLD")
  elseif option == OID_DEVIOUS_HEAVY_RESTRAINT
    SetInfoText("$MRT_SP_DESC_DEVIOUS_HEAVY_RESTRAINT")
  elseif option == OID_DEVIOUS_SUIT
    SetInfoText("$MRT_SP_DESC_DEVIOUS_SUIT")
  elseif option == OID_BEG_ELDER_SEX_OFFER
    SetInfoText("$MRT_SP_DESC_BEG_ELDER_SEX_OFFER")
  elseif option == OID_ELDER_MAY_APPROACH
    SetInfoText("$MRT_SP_DESC_ELDER_MAY_APPROACH")
  elseif option == OID_BEG_REJ_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_BEG_REJ_ENTRAPMENT_LVL_M")
  elseif option == OID_WHORE_REJ_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_ENTRAPMENT_LVL_M")
  elseif option == OID_DIBEL_REJ_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_ENTRAPMENT_LVL_M")
  elseif option == OID_DEFAULT_REJ_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_ENTRAPMENT_LVL_M")
  elseif option == OID_BEG_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_BEG_ENTRAPMENT_LVL_M")
  elseif option == OID_WHORE_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_WHORE_ENTRAPMENT_LVL_M")
  elseif option == OID_DIBEL_ENTRAPMENT_LVL_M
    SetInfoText("$MRT_SP_DESC_DIBEL_ENTRAPMENT_LVL_M")
  elseif option == OID_WHORE_DD_CHANCE
    SetInfoText("$MRT_SP_DESC_WHORE_DD_CHANCE")
  elseif option == OID_DIBEL_DD_CHANCE
    SetInfoText("$MRT_SP_DESC_DIBEL_DD_CHANCE")
  elseif option == OID_BEG_DD_CHANCE
    SetInfoText("$MRT_SP_DESC_BEG_DD_CHANCE")
  elseif option == OID_BEG_REJ_FEMALE_DD
    SetInfoText("$MRT_SP_DESC_BEG_REJ_FEMALE_DD")
  elseif option == OID_BEG_REJ_MALE_DD
    SetInfoText("$MRT_SP_DESC_BEG_REJ_MALE_DD")
  elseif option == OID_WHORE_REJ_FEMALE_DD
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_FEMALE_DD")
  elseif option == OID_WHORE_REJ_MALE_DD
    SetInfoText("$MRT_SP_DESC_WHORE_REJ_MALE_DD")
  elseif option == OID_DIBEL_REJ_FEMALE_DD
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_FEMALE_DD")
  elseif option == OID_DIBEL_REJ_MALE_DD
    SetInfoText("$MRT_SP_DESC_DIBEL_REJ_MALE_DD")
  elseif option == OID_DEFAULT_REJ_FEMALE_DD
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_FEMALE_DD")
  elseif option == OID_DEFAULT_REJ_MALE_DD
    SetInfoText("$MRT_SP_DESC_DEFAULT_REJ_MALE_DD")
	endif
endevent

event OnOptionSliderAccept(int option, float value)
  if option == OID_BEG_REJ_MALE_ACCEPT
    MainScript.fBeggarRejectMaleAcceptChance = value
    SetSliderOptionValue(OID_BEG_REJ_MALE_ACCEPT, MainScript.fBeggarRejectMaleAcceptChance, "$MRT_SP_BEG_REJ_MALE_ACCEPT_SLIDER2")
  elseif option == OID_BEG_REJ_FEMALE_ACCEPT
    MainScript.fBeggarRejectFemaleAcceptChance = value
    SetSliderOptionValue(OID_BEG_REJ_FEMALE_ACCEPT, MainScript.fBeggarRejectFemaleAcceptChance, "$MRT_SP_BEG_REJ_FEMALE_ACCEPT_SLIDER2")
  elseif option == OID_BEG_REJ_MALE_THEFT
    MainScript.fBeggarRejectMaleTheftChance = value
    SetSliderOptionValue(OID_BEG_REJ_MALE_THEFT, MainScript.fBeggarRejectMaleTheftChance, "$MRT_SP_BEG_REJ_MALE_THEFT_SLIDER2")
  elseif option == OID_BEG_REJ_FEMALE_THEFT
    MainScript.fBeggarRejectFemaleTheftChance = value
    SetSliderOptionValue(OID_BEG_REJ_FEMALE_THEFT, MainScript.fBeggarRejectFemaleTheftChance, "$MRT_SP_BEG_REJ_FEMALE_THEFT_SLIDER2")
  elseif option == OID_BEG_REJ_MALE_ASSAULT
    MainScript.fBeggarRejectMaleAssaultChance = value
    SetSliderOptionValue(OID_BEG_REJ_MALE_ASSAULT, MainScript.fBeggarRejectMaleAssaultChance, "$MRT_SP_BEG_REJ_MALE_ASSAULT_SLIDER2")
  elseif option == OID_BEG_REJ_FEMALE_ASSAULT
    MainScript.fBeggarRejectFemaleAssaultChance = value
    SetSliderOptionValue(OID_BEG_REJ_FEMALE_ASSAULT, MainScript.fBeggarRejectFemaleAssaultChance, "$MRT_SP_BEG_REJ_FEMALE_ASSAULT_SLIDER2")
  elseif option == OID_BEG_REJ_MALE_SLAVERY
    MainScript.fBeggarRejectMaleSlaveryChance = value
    SetSliderOptionValue(OID_BEG_REJ_MALE_SLAVERY, MainScript.fBeggarRejectMaleSlaveryChance, "$MRT_SP_BEG_REJ_MALE_SLAVERY_SLIDER2")
  elseif option == OID_BEG_REJ_FEMALE_SLAVERY
    MainScript.fBeggarRejectFemaleSlaveryChance = value
    SetSliderOptionValue(OID_BEG_REJ_FEMALE_SLAVERY, MainScript.fBeggarRejectFemaleSlaveryChance, "$MRT_SP_BEG_REJ_FEMALE_SLAVERY_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_ACCEPT
    MainScript.fWhoreRejectMaleAcceptChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_ACCEPT, MainScript.fWhoreRejectMaleAcceptChance, "$MRT_SP_WHORE_REJ_MALE_ACCEPT_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_ACCEPT
    MainScript.fWhoreRejectFemaleAcceptChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_ACCEPT, MainScript.fWhoreRejectFemaleAcceptChance, "$MRT_SP_WHORE_REJ_FEMALE_ACCEPT_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_REPORT
    MainScript.fWhoreRejectMaleReportChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_REPORT, MainScript.fWhoreRejectMaleReportChance, "$MRT_SP_WHORE_REJ_MALE_REPORT_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_REPORT
    MainScript.fWhoreRejectFemaleReportChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_REPORT, MainScript.fWhoreRejectFemaleReportChance, "$MRT_SP_WHORE_REJ_FEMALE_REPORT_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_RAPE
    MainScript.fWhoreRejectMaleRapeChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_RAPE, MainScript.fWhoreRejectMaleRapeChance, "$MRT_SP_WHORE_REJ_MALE_RAPE_SLIDER2") 
  elseif option == OID_WHORE_REJ_FEMALE_RAPE
    MainScript.fWhoreRejectFemaleRapeChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_RAPE, MainScript.fWhoreRejectFemaleRapeChance, "$MRT_SP_WHORE_REJ_FEMALE_RAPE_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_THEFT
    MainScript.fWhoreRejectMaleTheftChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_THEFT, MainScript.fWhoreRejectMaleTheftChance, "$MRT_SP_WHORE_REJ_MALE_THEFT_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_THEFT
    MainScript.fWhoreRejectFemaleTheftChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_THEFT, MainScript.fWhoreRejectFemaleTheftChance, "$MRT_SP_WHORE_REJ_FEMALE_THEFT_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_ASSAULT
    MainScript.fWhoreRejectMaleAssaultChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_ASSAULT, MainScript.fWhoreRejectMaleAssaultChance, "$MRT_SP_WHORE_REJ_MALE_ASSAULT_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_ASSAULT
    MainScript.fWhoreRejectFemaleAssaultChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_ASSAULT, MainScript.fWhoreRejectFemaleAssaultChance, "$MRT_SP_WHORE_REJ_FEMALE_ASSAULT_SLIDER2")
  elseif option == OID_WHORE_REJ_MALE_SLAVERY
    MainScript.fWhoreRejectMaleSlaveryChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_SLAVERY, MainScript.fWhoreRejectMaleSlaveryChance, "$MRT_SP_WHORE_REJ_MALE_SLAVERY_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_SLAVERY
    MainScript.fWhoreRejectFemaleSlaveryChance = value
    SetSliderOptionValue(OID_WHORE_REJ_FEMALE_SLAVERY, MainScript.fWhoreRejectFemaleSlaveryChance, "$MRT_SP_WHORE_REJ_FEMALE_SLAVERY_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_ACCEPT
    MainScript.fDibelRejectMaleAcceptChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_ACCEPT, MainScript.fDibelRejectMaleAcceptChance, "$MRT_SP_DIBEL_REJ_MALE_ACCEPT_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_ACCEPT
    MainScript.fDibelRejectFemaleAcceptChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_ACCEPT, MainScript.fDibelRejectFemaleAcceptChance, "$MRT_SP_DIBEL_REJ_FEMALE_ACCEPT_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_REPORT
    MainScript.fDibelRejectMaleReportChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_REPORT, MainScript.fDibelRejectMaleReportChance, "$MRT_SP_DIBEL_REJ_MALE_REPORT_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_REPORT
    MainScript.fDibelRejectFemaleReportChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_REPORT, MainScript.fDibelRejectFemaleReportChance, "$MRT_SP_DIBEL_REJ_FEMALE_REPORT_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_RAPE
    MainScript.fDibelRejectMaleRapeChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_RAPE, MainScript.fDibelRejectMaleRapeChance, "$MRT_SP_DIBEL_REJ_MALE_RAPE_SLIDER2")  
  elseif option == OID_DIBEL_REJ_FEMALE_RAPE
    MainScript.fDibelRejectFemaleRapeChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_RAPE, MainScript.fDibelRejectFemaleRapeChance, "$MRT_SP_DIBEL_REJ_FEMALE_RAPE_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_THEFT
    MainScript.fDibelRejectMaleTheftChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_THEFT, MainScript.fDibelRejectMaleTheftChance, "$MRT_SP_DIBEL_REJ_MALE_THEFT_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_THEFT
    MainScript.fDibelRejectFemaleTheftChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_THEFT, MainScript.fDibelRejectFemaleTheftChance, "$MRT_SP_DIBEL_REJ_FEMALE_THEFT_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_ASSAULT
    MainScript.fDibelRejectMaleAssaultChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_ASSAULT, MainScript.fDibelRejectMaleAssaultChance, "$MRT_SP_DIBEL_REJ_MALE_ASSAULT_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_ASSAULT
    MainScript.fDibelRejectFemaleAssaultChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_ASSAULT, MainScript.fDibelRejectFemaleAssaultChance, "$MRT_SP_DIBEL_REJ_FEMALE_ASSAULT_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_SLAVERY
    MainScript.fDibelRejectMaleSlaveryChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_SLAVERY, MainScript.fDibelRejectMaleSlaveryChance, "$MRT_SP_DIBEL_REJ_MALE_SLAVERY_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_SLAVERY
    MainScript.fDibelRejectFemaleSlaveryChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_SLAVERY, MainScript.fDibelRejectFemaleSlaveryChance, "$MRT_SP_DIBEL_REJ_FEMALE_SLAVERY_SLIDER2")
  elseif option == OID_CUSTOMER_APPROACH_INTERVAL
    MainScript.iCustomerApproachTimer = value as Int
    SetSliderOptionValue(OID_CUSTOMER_APPROACH_INTERVAL, MainScript.iCustomerApproachTimer, "$MRT_SP_CUSTOMER_APPROACH_INTERVAL_SLIDER2")
    MainScript.ApproachMonitorScr.updateApproach(False)
  elseif option == OID_CUSTOMER_APPROACH_CHANCE 
    MainScript.fCustomerApproachChance = value
    SetSliderOptionValue(OID_CUSTOMER_APPROACH_CHANCE, MainScript.fCustomerApproachChance, "$MRT_SP_CUSTOMER_APPROACH_CHANCE_SLIDER2")
  elseif option == OID_MAX_DISTANCE_APPROACH 
    MainScript.fMaxApproachDistance = value
    SetSliderOptionValue(OID_MAX_DISTANCE_APPROACH, MainScript.fMaxApproachDistance, "$MRT_SP_MAX_DISTANCE_APPROACH_SLIDER2")  
    MainScript.setGlobalVaues()
  elseif option == OID_CRIME_BOUNTY 
    MainScript.iCrimeBounty = value as Int
    SetSliderOptionValue(OID_CRIME_BOUNTY, MainScript.iCrimeBounty, "$MRT_SP_CRIME_BOUNTY_SLIDER2")
  elseif option == OID_DIBEL_REJ_MALE_MURDER
    MainScript.fDibelRejectMaleMurderChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_MALE_MURDER, MainScript.fDibelRejectMaleMurderChance, "$MRT_SP_DIBEL_REJ_MALE_MURDER_SLIDER2")
  elseif option == OID_DIBEL_REJ_FEMALE_MURDER
    MainScript.fDibelRejectFemaleMurderChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_MURDER, MainScript.fDibelRejectFemaleMurderChance, "$MRT_SP_DIBEL_REJ_FEMALE_MURDER_SLIDER2")  
  elseif option == OID_WHORE_REJ_MALE_MURDER
    MainScript.fWhoreRejectMaleMurderChance = value
    SetSliderOptionValue(OID_WHORE_REJ_MALE_MURDER, MainScript.fWhoreRejectMaleMurderChance, "$MRT_SP_WHORE_REJ_MALE_MURDER_SLIDER2")
  elseif option == OID_WHORE_REJ_FEMALE_MURDER
    MainScript.fWhoreRejectFemaleMurderChance = value
    SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_MURDER, MainScript.fWhoreRejectFemaleMurderChance, "$MRT_SP_WHORE_REJ_FEMALE_MURDER_SLIDER2")
  elseif option == OID_BEG_REJ_MALE_MURDER
    MainScript.fBeggarRejectMaleMurderChance = value
    SetSliderOptionValue(OID_BEG_REJ_MALE_MURDER, MainScript.fBeggarRejectMaleMurderChance, "$MRT_SP_BEG_REJ_MALE_MURDER_SLIDER2")
  elseif option == OID_BEG_REJ_FEMALE_MURDER
    MainScript.fBeggarRejectFemaleMurderChance = value
    SetSliderOptionValue(OID_BEG_REJ_FEMALE_MURDER, MainScript.fBeggarRejectFemaleMurderChance, "$MRT_SP_BEG_REJ_FEMALE_MURDER_SLIDER2")

  elseif option == OID_DEFAULT_REJ_MALE_ACCEPT
    MainScript.fDefaultRejectMaleAcceptChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_ACCEPT, MainScript.fDefaultRejectMaleAcceptChance, "$MRT_SP_BEG_REJ_MALE_ACCEPT_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_ACCEPT
    MainScript.fDefaultRejectFemaleAcceptChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_ACCEPT, MainScript.fDefaultRejectFemaleAcceptChance, "$MRT_SP_BEG_REJ_FEMALE_ACCEPT_SLIDER2")
  elseif option == OID_DEFAULT_REJ_MALE_RAPE
    MainScript.fDefaultRejectMaleRapeChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_RAPE, MainScript.fDefaultRejectMaleRapeChance, "$MRT_SP_DEFAULT_REJ_MALE_RAPE_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_RAPE
    MainScript.fDefaultRejectFemaleRapeChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_RAPE, MainScript.fDefaultRejectFemaleRapeChance, "$MRT_SP_DEFAULT_REJ_FEMALE_RAPE_SLIDER2")  

  elseif option == OID_DEFAULT_REJ_MALE_THEFT
    MainScript.fDefaultRejectMaleTheftChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_THEFT, MainScript.fDefaultRejectMaleTheftChance, "$MRT_SP_BEG_REJ_MALE_THEFT_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_THEFT
    MainScript.fDefaultRejectFemaleTheftChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_THEFT, MainScript.fDefaultRejectFemaleTheftChance, "$MRT_SP_BEG_REJ_FEMALE_THEFT_SLIDER2")  

  elseif option == OID_DEFAULT_REJ_MALE_ASSAULT
    MainScript.fDefaultRejectMaleAssaultChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_ASSAULT, MainScript.fDefaultRejectMaleAssaultChance, "$MRT_SP_BEG_REJ_MALE_ASSAULT_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_ASSAULT
    MainScript.fDefaultRejectFemaleAssaultChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_ASSAULT, MainScript.fDefaultRejectFemaleAssaultChance, "$MRT_SP_BEG_REJ_FEMALE_ASSAULT_SLIDER2")  

  elseif option == OID_DEFAULT_REJ_MALE_SLAVERY
    MainScript.fDefaultRejectMaleSlaveryChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_SLAVERY, MainScript.fDefaultRejectMaleSlaveryChance, "$MRT_SP_BEG_REJ_MALE_SLAVERY_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_SLAVERY
    MainScript.fDefaultRejectFemaleSlaveryChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_SLAVERY, MainScript.fDefaultRejectFemaleSlaveryChance, "$MRT_SP_BEG_REJ_FEMALE_SLAVERY_SLIDER2")

  elseif option == OID_DEFAULT_REJ_MALE_MURDER
    MainScript.fDefaultRejectMaleMurderChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_MALE_MURDER, MainScript.fDefaultRejectMaleMurderChance, "$MRT_SP_BEG_REJ_MALE_MURDER_SLIDER2")
  elseif option == OID_DEFAULT_REJ_FEMALE_MURDER
    MainScript.fDefaultRejectFemaleMurderChance = value
    SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_MURDER, MainScript.fDefaultRejectFemaleMurderChance, "$MRT_SP_BEG_REJ_FEMALE_MURDER_SLIDER2")

  elseif option == OID_DEVIOUS_COLLAR
    MainScript.fDeviousCollarChance = value
    SetSliderOptionValue(OID_DEVIOUS_COLLAR, MainScript.fDeviousCollarChance, "$MRT_SP_DEVIOUS_COLLAR_SLIDER2")
    setModVars = true
  elseif option == OID_DEVIOUS_BRA
    MainScript.fDeviousChastityBrasChance = value
    SetSliderOptionValue(OID_DEVIOUS_BRA, MainScript.fDeviousChastityBrasChance, "$MRT_SP_DEVIOUS_BRA_SLIDER2")
    setModVars = true
  elseif option == OID_DEVIOUS_HOOD
   MainScript.fDeviousHoodChance = value
   SetSliderOptionValue(OID_DEVIOUS_HOOD, MainScript.fDeviousHoodChance, "$MRT_SP_DEVIOUS_HOOD_SLIDER2") 
   setModVars = true   
 elseif option == OID_DEVIOUS_SUIT
   MainScript.fDeviousSuitsChance = value
   SetSliderOptionValue(OID_DEVIOUS_SUIT, MainScript.fDeviousSuitsChance, "$MRT_SP_DEVIOUS_SUIT_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_BOOTS
   MainScript.fDeviousBootsChance = value
   SetSliderOptionValue(OID_DEVIOUS_BOOTS, MainScript.fDeviousBootsChance, "$MRT_SP_DEVIOUS_BOOTS_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_CORSET
   MainScript.fDeviousCorsetChance = value
   SetSliderOptionValue(OID_DEVIOUS_CORSET, MainScript.fDeviousCorsetChance, "$MRT_SP_DEVIOUS_CORSET_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_HARNESS
   MainScript.fDeviousHarnessesChance = value
   SetSliderOptionValue(OID_DEVIOUS_HARNESS, MainScript.fDeviousHarnessesChance, "$MRT_SP_DEVIOUS_HARNESS_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_VAG_PRC
   MainScript.fDeviousVaginalPiercingChance = value
   SetSliderOptionValue(OID_DEVIOUS_VAG_PRC, MainScript.fDeviousVaginalPiercingChance, "$MRT_SP_DEVIOUS_VAG_PRC_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_NIP_PRC
   MainScript.fDeviousNipplePiercingChance = value
   SetSliderOptionValue(OID_DEVIOUS_NIP_PRC, MainScript.fDeviousNipplePiercingChance, "$MRT_SP_DEVIOUS_NIP_PRC_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_ANL_PLUG
   MainScript.fDeviousAnalPlugChance = value
   SetSliderOptionValue(OID_DEVIOUS_ANL_PLUG, MainScript.fDeviousAnalPlugChance, "$MRT_SP_DEVIOUS_ANL_PLUG_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_VAG_PLUG
   MainScript.fDeviousVaginalPlugChance = value
   SetSliderOptionValue(OID_DEVIOUS_VAG_PLUG, MainScript.fDeviousVaginalPlugChance, "$MRT_SP_DEVIOUS_VAG_PLUG_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_ARM_CUF
   MainScript.fDeviousArmCuffChance = value
   SetSliderOptionValue(OID_DEVIOUS_ARM_CUF, MainScript.fDeviousArmCuffChance, "$MRT_SP_DEVIOUS_ARM_CUF_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_LEG_CUF
   MainScript.fDeviousLegCuffChance = value
   SetSliderOptionValue(OID_DEVIOUS_LEG_CUF, MainScript.fDeviousLegCuffChance, "$MRT_SP_DEVIOUS_LEG_CUF_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_GAG_RING
   MainScript.fDeviousGagRingChance = value
   SetSliderOptionValue(OID_DEVIOUS_GAG_RING, MainScript.fDeviousGagRingChance, "$MRT_SP_DEVIOUS_GAG_RING_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_GAG_ALL
   MainScript.fDeviousGagAllChance = value
   SetSliderOptionValue(OID_DEVIOUS_GAG_ALL, MainScript.fDeviousGagAllChance, "$MRT_SP_DEVIOUS_GAG_ALL_SLIDER2")
   setModVars = true
 elseif option == OID_DEVIOUS_HEAVY_RESTRAINT
  MainScript.fDeviousHeavyRestraintChance = value
  SetSliderOptionValue(OID_DEVIOUS_HEAVY_RESTRAINT, MainScript.fDeviousHeavyRestraintChance, "$MRT_SP_DEVIOUS_HEAVY_RESTRAINT_SLIDER2")
  setModVars = true
elseif option == OID_DEVIOUS_BLINDFOLD
  MainScript.fDeviousBlindfoldChance = value
  SetSliderOptionValue(OID_DEVIOUS_BLINDFOLD, MainScript.fDeviousBlindfoldChance, "$MRT_SP_DEVIOUS_BLINDFOLD_SLIDER2")
  setModVars = true
elseif option == OID_DEVIOUS_GLOVES
  MainScript.fDeviousGlovesChance = value
  SetSliderOptionValue(OID_DEVIOUS_GLOVES, MainScript.fDeviousGlovesChance, "$MRT_SP_DEVIOUS_GLOVES_SLIDER2")
  setModVars = true
elseif option == OID_DEVIOUS_BELT_OPEN
  MainScript.fDeviousChastityBeltOpenChance = value
  SetSliderOptionValue(OID_DEVIOUS_BELT_OPEN, MainScript.fDeviousChastityBeltOpenChance, "$MRT_SP_DEVIOUS_BELT_OPEN_SLIDER2")
  setModVars = true
elseif option == OID_DEVIOUS_BELT_CLOSE
  MainScript.fDeviousChastityBeltCloseChance = value
  SetSliderOptionValue(OID_DEVIOUS_BELT_CLOSE, MainScript.fDeviousChastityBeltCloseChance, "$MRT_SP_DEVIOUS_BELT_CLOSE_SLIDER2")
  setModVars = true
elseif option == OID_DEFAULT_REJ_MALE_DD
  MainScript.fDefaultRejectMaleDeviceChance = value
  SetSliderOptionValue(OID_DEFAULT_REJ_MALE_DD, MainScript.fDefaultRejectMaleDeviceChance, "$MRT_SP_DEFAULT_REJ_MALE_DD_SLIDER2")
elseif option == OID_DEFAULT_REJ_FEMALE_DD
  MainScript.fDefaultRejectFemaleDeviceChance = value
  SetSliderOptionValue(OID_DEFAULT_REJ_FEMALE_DD, MainScript.fDefaultRejectFemaleDeviceChance, "$MRT_SP_DEFAULT_REJ_FEMALE_DD_SLIDER2")
elseif option == OID_BEG_REJ_FEMALE_DD
  MainScript.fBeggarRejectFemaleDeviceChance = value
  SetSliderOptionValue(OID_BEG_REJ_FEMALE_DD, MainScript.fBeggarRejectFemaleDeviceChance, "$MRT_SP_BEG_REJ_FEMALE_DD_SLIDER2")
elseif option == OID_BEG_REJ_MALE_DD
  MainScript.fBeggarRejectMaleDeviceChance = value
  SetSliderOptionValue(OID_BEG_REJ_MALE_DD, MainScript.fBeggarRejectMaleDeviceChance, "$MRT_SP_BEG_REJ_MALE_DD_SLIDER2")
elseif option == OID_WHORE_REJ_FEMALE_DD
  MainScript.fWhoreRejectFemaleDeviceChance = value
  SetSliderOptionValue(OID_WHORE_REJ_FEMALE_DD, MainScript.fWhoreRejectFemaleDeviceChance, "$MRT_SP_WHORE_REJ_FEMALE_DD_SLIDER2")
elseif option == OID_WHORE_REJ_MALE_DD
  MainScript.fWhoreRejectMaleDeviceChance = value
  SetSliderOptionValue(OID_WHORE_REJ_MALE_DD, MainScript.fWhoreRejectMaleDeviceChance, "$MRT_SP_WHORE_REJ_MALE_DD_SLIDER2")
elseif option == OID_DIBEL_REJ_FEMALE_DD
  MainScript.fDibelRejectFemaleDeviceChance = value
  SetSliderOptionValue(OID_DIBEL_REJ_FEMALE_DD, MainScript.fDibelRejectFemaleDeviceChance, "$MRT_SP_DIBEL_REJ_FEMALE_DD_SLIDER2")
elseif option == OID_DIBEL_REJ_MALE_DD
  MainScript.fDibelRejectMaleDeviceChance = value
  SetSliderOptionValue(OID_DIBEL_REJ_MALE_DD, MainScript.fDibelRejectMaleDeviceChance, "$MRT_SP_DIBEL_REJ_MALE_DD_SLIDER2")
elseif option == OID_DIBEL_DD_CHANCE
  MainScript.fDibelDeviceChance = value
  SetSliderOptionValue(OID_DIBEL_DD_CHANCE, MainScript.fDibelDeviceChance, "$MRT_SP_DIBEL_DD_CHANCE_SLIDER2")
elseif option == OID_BEG_DD_CHANCE
  MainScript.fBeggarDeviceChance = value
  SetSliderOptionValue(OID_BEG_DD_CHANCE, MainScript.fBeggarDeviceChance, "$MRT_SP_BEG_DD_CHANCE_SLIDER2")
elseif option == OID_DIBEL_DD_CHANCE
  MainScript.fDibelDeviceChance = value
  SetSliderOptionValue(OID_DIBEL_DD_CHANCE, MainScript.fDibelDeviceChance, "$MRT_SP_DIBEL_DD_CHANCE_SLIDER2")
elseif option == OID_WHORE_DD_CHANCE
  MainScript.fWhoreDeviceChance = value
  SetSliderOptionValue(OID_WHORE_DD_CHANCE, MainScript.fWhoreDeviceChance, "$MRT_SP_WHORE_DD_CHANCE_SLIDER2")
endif
ForcePageReset()
EndEvent

event OnOptionSliderOpen(int option)
  if option == OID_BEG_REJ_MALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_MALE_THEFT
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_THEFT
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_MALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_MALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_REPORT
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleReportChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_REPORT
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleReportChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_RAPE
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_RAPE
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_THEFT
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_THEFT
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_REPORT
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleReportChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_REPORT
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleReportChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_RAPE
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_RAPE
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_THEFT
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_THEFT
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_CUSTOMER_APPROACH_INTERVAL
    SetSliderDialogStartValue(MainScript.iCustomerApproachTimer)
    SetSliderDialogDefaultValue(3.0)
    SetSliderDialogRange(0, 48)
    SetSliderDialogInterval(1)
  elseif option == OID_CUSTOMER_APPROACH_CHANCE 
    SetSliderDialogStartValue(MainScript.fCustomerApproachChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(1)
  elseif option == OID_MAX_DISTANCE_APPROACH 
    SetSliderDialogStartValue(MainScript.fMaxApproachDistance)
    SetSliderDialogDefaultValue(5000.0)
    SetSliderDialogRange(500, 5000)
    SetSliderDialogInterval(50)
  elseif option == OID_CRIME_BOUNTY
    SetSliderDialogStartValue(MainScript.iCrimeBounty)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(1, 500)
    SetSliderDialogInterval(1)
  elseif option == OID_DIBEL_REJ_MALE_MURDER
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_MURDER
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_MURDER
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_MURDER
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_MALE_MURDER
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_MURDER
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_ACCEPT
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleAcceptChance)
    SetSliderDialogDefaultValue(100.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_RAPE
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_RAPE
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleRapeChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_THEFT
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_THEFT
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleTheftChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_ASSAULT
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleAssaultChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_SLAVERY
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleSlaveryChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_MURDER
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_MURDER
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleMurderChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_COLLAR
    SetSliderDialogStartValue(MainScript.fDeviousCollarChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_BRA
    SetSliderDialogStartValue(MainScript.fDeviousChastityBrasChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_HOOD
    SetSliderDialogStartValue(MainScript.fDeviousHoodChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_SUIT
    SetSliderDialogStartValue(MainScript.fDeviousSuitsChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_BOOTS
    SetSliderDialogStartValue(MainScript.fDeviousBootsChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_GLOVES
    SetSliderDialogStartValue(MainScript.fDeviousGlovesChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_CORSET
    SetSliderDialogStartValue(MainScript.fDeviousCorsetChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_HARNESS
    SetSliderDialogStartValue(MainScript.fDeviousHarnessesChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_VAG_PRC
    SetSliderDialogStartValue(MainScript.fDeviousVaginalPiercingChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_NIP_PRC
    SetSliderDialogStartValue(MainScript.fDeviousNipplePiercingChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_ANL_PLUG
    SetSliderDialogStartValue(MainScript.fDeviousAnalPlugChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_VAG_PLUG
    SetSliderDialogStartValue(MainScript.fDeviousVaginalPlugChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_ARM_CUF
    SetSliderDialogStartValue(MainScript.fDeviousArmCuffChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_LEG_CUF
    SetSliderDialogStartValue(MainScript.fDeviousLegCuffChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_GAG_RING
    SetSliderDialogStartValue(MainScript.fDeviousGagRingChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_GAG_ALL
    SetSliderDialogStartValue(MainScript.fDeviousGagAllChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_HEAVY_RESTRAINT
    SetSliderDialogStartValue(MainScript.fDeviousHeavyRestraintChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_BLINDFOLD
    SetSliderDialogStartValue(MainScript.fDeviousBlindfoldChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_BELT_OPEN
    SetSliderDialogStartValue(MainScript.fDeviousChastityBeltOpenChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEVIOUS_BELT_CLOSE
    SetSliderDialogStartValue(MainScript.fDeviousChastityBeltCloseChance)
    SetSliderDialogDefaultValue(50.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_FEMALE_DD
    SetSliderDialogStartValue(MainScript.fBeggarRejectFemaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_REJ_MALE_DD
    SetSliderDialogStartValue(MainScript.fBeggarRejectMaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_MALE_DD
    SetSliderDialogStartValue(MainScript.fWhoreRejectMaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_REJ_FEMALE_DD
    SetSliderDialogStartValue(MainScript.fWhoreRejectFemaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_FEMALE_DD
    SetSliderDialogStartValue(MainScript.fDibelRejectFemaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_REJ_MALE_DD
    SetSliderDialogStartValue(MainScript.fDibelRejectMaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_FEMALE_DD
    SetSliderDialogStartValue(MainScript.fDefaultRejectFemaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DEFAULT_REJ_MALE_DD
    SetSliderDialogStartValue(MainScript.fDefaultRejectMaleDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_BEG_DD_CHANCE
    SetSliderDialogStartValue(MainScript.fBeggarDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_WHORE_DD_CHANCE
    SetSliderDialogStartValue(MainScript.fWhoreDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  elseif option == OID_DIBEL_DD_CHANCE
    SetSliderDialogStartValue(MainScript.fDibelDeviceChance)
    SetSliderDialogDefaultValue(0.0)
    SetSliderDialogRange(0, 100)
    SetSliderDialogInterval(0.1)
  endif
EndEvent

event OnOptionMenuOpen(Int option)
  if (option == OID_DEFAULT_REJ_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iDefaultRejectEntrapmentLevel)
    SetMenuDialogDefaultIndex(1)
  elseif (option == OID_BEG_REJ_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iBeggarRejectEntrapmentLevel)
    SetMenuDialogDefaultIndex(1)
  elseif (option == OID_DIBEL_REJ_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iDibelRejectEntrapmentLevel)
    SetMenuDialogDefaultIndex(1)
  elseif (option == OID_WHORE_REJ_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iWhoreRejectEntrapmentLevel)
    SetMenuDialogDefaultIndex(1)
  elseif (option == OID_WHORE_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iWhoreEntrapmentLevel)
    SetMenuDialogDefaultIndex(0)
  elseif (option == OID_DIBEL_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iDibelEntrapmentLevel)
    SetMenuDialogDefaultIndex(0)
  elseif (option == OID_BEG_ENTRAPMENT_LVL_M)
    SetMenuDialogoptions(sGetEntrapmentLevels())
    SetMenuDialogStartIndex(MainScript.iBeggarEntrapmentLevel)
    SetMenuDialogDefaultIndex(0)
  endIf
endevent

event OnOptionMenuAccept(Int option, Int index)
  if (option == OID_DEFAULT_REJ_ENTRAPMENT_LVL_M)
    MainScript.iDefaultRejectEntrapmentLevel = index
    SetMenuOptionValue(OID_DEFAULT_REJ_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iDefaultRejectEntrapmentLevel]) 
  elseif (option == OID_BEG_REJ_ENTRAPMENT_LVL_M)
    MainScript.iBeggarRejectEntrapmentLevel = index
    SetMenuOptionValue(OID_BEG_REJ_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iBeggarRejectEntrapmentLevel])
  elseif (option == OID_DIBEL_REJ_ENTRAPMENT_LVL_M)
    MainScript.iDibelRejectEntrapmentLevel = index
    SetMenuOptionValue(OID_DIBEL_REJ_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iDibelRejectEntrapmentLevel])
  elseif (option == OID_WHORE_REJ_ENTRAPMENT_LVL_M)
    MainScript.iWhoreRejectEntrapmentLevel = index
    SetMenuOptionValue(OID_WHORE_REJ_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iWhoreRejectEntrapmentLevel])
  elseif (option == OID_WHORE_ENTRAPMENT_LVL_M)
    MainScript.iWhoreEntrapmentLevel = index
    SetMenuOptionValue(OID_WHORE_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iWhoreEntrapmentLevel])
  elseif (option == OID_DIBEL_ENTRAPMENT_LVL_M)
    MainScript.iDibelEntrapmentLevel = index
    SetMenuOptionValue(OID_DIBEL_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iDibelEntrapmentLevel])
  elseif (option == OID_BEG_ENTRAPMENT_LVL_M)
    MainScript.iBeggarEntrapmentLevel = index
    SetMenuOptionValue(OID_BEG_ENTRAPMENT_LVL_M, sGetEntrapmentLevels()[MainScript.iBeggarEntrapmentLevel])
  endif
  ;ForcePageReset()
endevent


function beggarRejectOptions(Int iflag)
  int flg = iflag
  _AddHeaderOption("$MRT_SP_HEAD_REJECT")
  OID_BEG_REJ_MALE_ACCEPT = AddSliderOption("$MRT_SP_BEG_REJ_MALE_ACCEPT_SLIDER1", MainScript.fBeggarRejectMaleAcceptChance, "$MRT_SP_BEG_REJ_MALE_ACCEPT_SLIDER2", flg)
  AddSliderOptionST("BEG_MALE_RAPE_SLIDER", "$MRT_SP_BEG_MALE_RAPE_SLIDER1", MainScript.fBeggingMaleRapistChance, "$MRT_SP_BEG_MALE_RAPE_SLIDER2", flg)
  OID_BEG_REJ_MALE_ASSAULT = AddSliderOption("$MRT_SP_BEG_REJ_MALE_ASSAULT_SLIDER1", MainScript.fBeggarRejectMaleAssaultChance, "$MRT_SP_BEG_REJ_MALE_ASSAULT_SLIDER2", flg)
  OID_BEG_REJ_MALE_THEFT = AddSliderOption("$MRT_SP_BEG_REJ_MALE_THEFT_SLIDER1", MainScript.fBeggarRejectMaleTheftChance, "$MRT_SP_BEG_REJ_MALE_THEFT_SLIDER2", flg)
  OID_BEG_REJ_MALE_SLAVERY = AddSliderOption("$MRT_SP_BEG_REJ_MALE_SLAVERY_SLIDER1", MainScript.fBeggarRejectMaleSlaveryChance, "$MRT_SP_BEG_REJ_MALE_SLAVERY_SLIDER2", flg)
  OID_BEG_REJ_MALE_MURDER = AddSliderOption("$MRT_SP_BEG_REJ_MALE_MURDER_SLIDER1", MainScript.fBeggarRejectMaleMurderChance, "$MRT_SP_BEG_REJ_MALE_MURDER_SLIDER2", flg) 
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf   
  OID_BEG_REJ_MALE_DD = AddSliderOption("$MRT_SP_BEG_REJ_MALE_DD_SLIDER1", MainScript.fBeggarRejectMaleDeviceChance, "$MRT_SP_BEG_REJ_MALE_DD_SLIDER2", flg)
  flg = iflag
  AddEmptyOption()
  OID_BEG_REJ_FEMALE_ACCEPT = AddSliderOption( "$MRT_SP_BEG_REJ_FEMALE_ACCEPT_SLIDER1", MainScript.fBeggarRejectFemaleAcceptChance, "$MRT_SP_BEG_REJ_FEMALE_ACCEPT_SLIDER2", flg)
  AddSliderOptionST("BEG_FEMALE_RAPE_SLIDER", "$MRT_SP_BEG_FEMALE_RAPE_SLIDER1", MainScript.fBeggingFemaleRapistChance, "$MRT_SP_BEG_FEMALE_RAPE_SLIDER2", flg)    
  OID_BEG_REJ_FEMALE_ASSAULT = AddSliderOption("$MRT_SP_BEG_REJ_FEMALE_ASSAULT_SLIDER1", MainScript.fBeggarRejectFemaleAssaultChance, "$MRT_SP_BEG_REJ_FEMALE_ASSAULT_SLIDER2", flg)    
  OID_BEG_REJ_FEMALE_THEFT = AddSliderOption("$MRT_SP_BEG_REJ_FEMALE_THEFT_SLIDER1", MainScript.fBeggarRejectFemaleTheftChance, "$MRT_SP_BEG_REJ_FEMALE_THEFT_SLIDER2", flg)
  OID_BEG_REJ_FEMALE_MURDER = AddSliderOption("$MRT_SP_BEG_REJ_FEMALE_MURDER_SLIDER1", MainScript.fBeggarRejectFemaleMurderChance, "$MRT_SP_BEG_REJ_FEMALE_MURDER_SLIDER2", flg) 
  OID_BEG_REJ_FEMALE_SLAVERY = AddSliderOption("$MRT_SP_BEG_REJ_FEMALE_SLAVERY_SLIDER1", MainScript.fBeggarRejectFemaleSlaveryChance, "$MRT_SP_BEG_REJ_FEMALE_SLAVERY_SLIDER2", flg) 
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf    
  OID_BEG_REJ_FEMALE_DD = AddSliderOption("$MRT_SP_BEG_REJ_FEMALE_DD_SLIDER1", MainScript.fBeggarRejectFemaleDeviceChance, "$MRT_SP_BEG_REJ_FEMALE_DD_SLIDER2", flg)
  AddEmptyOption()
  OID_BEG_REJ_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_BEG_REJ_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iBeggarRejectEntrapmentLevel], flg)
  flg = iflag
  OID_BEG_REJ_THEFT_ONLYGOLD = AddToggleOption("$MRT_SP_BEG_REJ_THEFT_ONLYGOLD_TOGGLE", MainScript.bBeggarRejectTheftOnlyGold, flg)
  OID_BEG_REJ_WALKAWAY_CHECK = AddToggleOption("$MRT_SP_BEG_REJ_WALKAWAY_CHECK", MainScript.bBeggarRejectWalkAwayCheck, flg)
EndFunction

function whoreRejectOptions(Int iflag)
  int flg = iflag
  _AddHeaderOption("$MRT_SP_HEAD_REJECT")
  OID_WHORE_REJ_MALE_ACCEPT = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_ACCEPT_SLIDER1", MainScript.fWhoreRejectMaleAcceptChance, "$MRT_SP_WHORE_REJ_MALE_ACCEPT_SLIDER2", flg)
  OID_WHORE_REJ_MALE_RAPE = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_RAPE_SLIDER1", MainScript.fWhoreRejectMaleRapeChance, "$MRT_SP_WHORE_REJ_MALE_RAPE_SLIDER2", flg)
  OID_WHORE_REJ_MALE_ASSAULT = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_ASSAULT_SLIDER1", MainScript.fWhoreRejectMaleAssaultChance, "$MRT_SP_WHORE_REJ_MALE_ASSAULT_SLIDER2", flg)
  OID_WHORE_REJ_MALE_THEFT = AddSliderOption( "$MRT_SP_WHORE_REJ_MALE_THEFT_SLIDER1", MainScript.fWhoreRejectMaleTheftChance, "$MRT_SP_WHORE_REJ_MALE_THEFT_SLIDER2", flg)
  OID_WHORE_REJ_MALE_REPORT = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_REPORT_SLIDER1", MainScript.fWhoreRejectMaleReportChance, "$MRT_SP_WHORE_REJ_MALE_REPORT_SLIDER2", flg)
  OID_WHORE_REJ_MALE_MURDER = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_MURDER_SLIDER1", MainScript.fWhoreRejectMaleMurderChance, "$MRT_SP_WHORE_REJ_MALE_MURDER_SLIDER2", flg) 
  OID_WHORE_REJ_MALE_SLAVERY = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_SLAVERY_SLIDER1", MainScript.fWhoreRejectMaleSlaveryChance, "$MRT_SP_WHORE_REJ_MALE_SLAVERY_SLIDER2", flg)
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf   
  OID_WHORE_REJ_MALE_DD = AddSliderOption("$MRT_SP_WHORE_REJ_MALE_DD_SLIDER1", MainScript.fWhoreRejectMaleDeviceChance, "$MRT_SP_WHORE_REJ_MALE_DD_SLIDER2", flg)
  flg = iflag
  AddEmptyOption()
  OID_WHORE_REJ_FEMALE_ACCEPT = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_ACCEPT_SLIDER1", MainScript.fWhoreRejectFemaleAcceptChance, "$MRT_SP_WHORE_REJ_FEMALE_ACCEPT_SLIDER2", flg)        
  OID_WHORE_REJ_FEMALE_RAPE = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_RAPE_SLIDER1", MainScript.fWhoreRejectFemaleRapeChance, "$MRT_SP_WHORE_REJ_FEMALE_RAPE_SLIDER2", flg)
  OID_WHORE_REJ_FEMALE_ASSAULT = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_ASSAULT_SLIDER1", MainScript.fWhoreRejectFemaleAssaultChance, "$MRT_SP_WHORE_REJ_FEMALE_ASSAULT_SLIDER2", flg)    
  OID_WHORE_REJ_FEMALE_THEFT = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_THEFT_SLIDER1", MainScript.fWhoreRejectFemaleTheftChance, "$MRT_SP_WHORE_REJ_FEMALE_THEFT_SLIDER2", flg)
  OID_WHORE_REJ_FEMALE_REPORT = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_REPORT_SLIDER1", MainScript.fWhoreRejectFemaleReportChance, "$MRT_SP_WHORE_REJ_FEMALE_REPORT_SLIDER2", flg)   
  OID_WHORE_REJ_FEMALE_MURDER = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_MURDER_SLIDER1", MainScript.fWhoreRejectFemaleMurderChance, "$MRT_SP_WHORE_REJ_FEMALE_MURDER_SLIDER2", flg) 
  OID_WHORE_REJ_FEMALE_SLAVERY = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_SLAVERY_SLIDER1", MainScript.fWhoreRejectFemaleSlaveryChance, "$MRT_SP_WHORE_REJ_FEMALE_SLAVERY_SLIDER2", flg) 
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf  
  OID_WHORE_REJ_FEMALE_DD = AddSliderOption("$MRT_SP_WHORE_REJ_FEMALE_DD_SLIDER1", MainScript.fWhoreRejectFemaleDeviceChance, "$MRT_SP_WHORE_REJ_FEMALE_DD_SLIDER2", flg)
  AddEmptyOption()
  OID_WHORE_REJ_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_WHORE_REJ_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iWhoreRejectEntrapmentLevel], flg)
  flg = iflag
  OID_WHORE_REJ_THEFT_ONLYGOLD = AddToggleOption("$MRT_SP_WHORE_REJ_THEFT_ONLYGOLD_TOGGLE", MainScript.bWhoreRejectTheftOnlyGold, flg)
EndFunction

function dibelRejectOptions(Int iflag)
  Int flg = iflag
  _AddHeaderOption("$MRT_SP_HEAD_REJECT")
  OID_DIBEL_REJ_MALE_ACCEPT = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_ACCEPT_SLIDER1", MainScript.fDibelRejectMaleAcceptChance, "$MRT_SP_DIBEL_REJ_MALE_ACCEPT_SLIDER2", flg)
  OID_DIBEL_REJ_MALE_RAPE = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_RAPE_SLIDER1", MainScript.fDibelRejectMaleRapeChance, "$MRT_SP_DIBEL_REJ_MALE_RAPE_SLIDER2", flg)
  OID_DIBEL_REJ_MALE_ASSAULT = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_ASSAULT_SLIDER1", MainScript.fDibelRejectMaleAssaultChance, "$MRT_SP_DIBEL_REJ_MALE_ASSAULT_SLIDER2", flg)
  OID_DIBEL_REJ_MALE_THEFT = AddSliderOption( "$MRT_SP_DIBEL_REJ_MALE_THEFT_SLIDER1", MainScript.fDibelRejectMaleTheftChance, "$MRT_SP_DIBEL_REJ_MALE_THEFT_SLIDER2", flg)
  OID_DIBEL_REJ_MALE_REPORT = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_REPORT_SLIDER1", MainScript.fDibelRejectMaleReportChance, "$MRT_SP_DIBEL_REJ_MALE_REPORT_SLIDER2", flg)
  OID_DIBEL_REJ_MALE_MURDER = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_MURDER_SLIDER1", MainScript.fDibelRejectMaleMurderChance, "$MRT_SP_DIBEL_REJ_MALE_MURDER_SLIDER2", flg) 
  OID_DIBEL_REJ_MALE_SLAVERY = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_SLAVERY_SLIDER1", MainScript.fDibelRejectMaleSlaveryChance, "$MRT_SP_DIBEL_REJ_MALE_SLAVERY_SLIDER2", flg)
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf   
  OID_DIBEL_REJ_MALE_DD = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_DD_SLIDER1", MainScript.fDibelRejectMaleDeviceChance, "$MRT_SP_DIBEL_REJ_MALE_DD_SLIDER2", flg)
  flg = iflag
  AddEmptyOption()
  OID_DIBEL_REJ_FEMALE_ACCEPT = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_ACCEPT_SLIDER1", MainScript.fDibelRejectFemaleAcceptChance, "$MRT_SP_DIBEL_REJ_FEMALE_ACCEPT_SLIDER2", flg)        
  OID_DIBEL_REJ_FEMALE_RAPE = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_RAPE_SLIDER1", MainScript.fDibelRejectFemaleRapeChance, "$MRT_SP_DIBEL_REJ_FEMALE_RAPE_SLIDER2", flg)
  OID_DIBEL_REJ_FEMALE_ASSAULT = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_ASSAULT_SLIDER1", MainScript.fDibelRejectFemaleAssaultChance, "$MRT_SP_DIBEL_REJ_FEMALE_ASSAULT_SLIDER2", flg)    
  OID_DIBEL_REJ_FEMALE_THEFT = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_THEFT_SLIDER1", MainScript.fDibelRejectFemaleTheftChance, "$MRT_SP_DIBEL_REJ_FEMALE_THEFT_SLIDER2", flg)
  OID_DIBEL_REJ_FEMALE_REPORT = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_REPORT_SLIDER1", MainScript.fDibelRejectFemaleReportChance, "$MRT_SP_DIBEL_REJ_FEMALE_REPORT_SLIDER2", flg)   
  OID_DIBEL_REJ_FEMALE_MURDER = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_MURDER_SLIDER1", MainScript.fDibelRejectFemaleMurderChance, "$MRT_SP_DIBEL_REJ_FEMALE_MURDER_SLIDER2", flg) 
  OID_DIBEL_REJ_FEMALE_SLAVERY = AddSliderOption("$MRT_SP_DIBEL_REJ_FEMALE_SLAVERY_SLIDER1", MainScript.fDibelRejectFemaleSlaveryChance, "$MRT_SP_DIBEL_REJ_FEMALE_SLAVERY_SLIDER2", flg) 
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf    
  OID_DIBEL_REJ_FEMALE_DD = AddSliderOption("$MRT_SP_DIBEL_REJ_MALE_DD_SLIDER1", MainScript.fDibelRejectFemaleDeviceChance, "$MRT_SP_DIBEL_REJ_FEMALE_DD_SLIDER2", flg)
  AddEmptyOption()
  flg = iflag
  OID_DIBEL_REJ_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_DIBEL_REJ_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iDibelRejectEntrapmentLevel], flg)
  OID_DIBEL_REJ_THEFT_ONLYGOLD = AddToggleOption("$MRT_SP_DIBEL_REJ_THEFT_ONLYGOLD_TOGGLE", MainScript.bDibelRejectTheftOnlyGold, flg)
EndFunction

function defaultRejectOptions(Int iflag)
  int flg = iflag
  _AddHeaderOption("$MRT_SP_HEAD_REJECT_DEFAULT")
  OID_DEFAULT_REJ_MALE_ACCEPT = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_ACCEPT_SLIDER1", MainScript.fDefaultRejectMaleAcceptChance, "$MRT_SP_DIBEL_REJ_MALE_ACCEPT_SLIDER2", flg)
  OID_DEFAULT_REJ_MALE_RAPE = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_RAPE_SLIDER1", MainScript.fDefaultRejectMaleRapeChance, "$MRT_SP_DEFAULT_REJ_MALE_RAPE_SLIDER2", flg)
  OID_DEFAULT_REJ_MALE_ASSAULT = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_ASSAULT_SLIDER1", MainScript.fDefaultRejectMaleAssaultChance, "$MRT_SP_DEFAULT_REJ_MALE_ASSAULT_SLIDER2", flg)
  OID_DEFAULT_REJ_MALE_THEFT = AddSliderOption( "$MRT_SP_DEFAULT_REJ_MALE_THEFT_SLIDER1", MainScript.fDefaultRejectMaleTheftChance, "$MRT_SP_DEFAULT_REJ_MALE_THEFT_SLIDER2", flg)
  OID_DEFAULT_REJ_MALE_MURDER = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_MURDER_SLIDER1", MainScript.fDefaultRejectMaleMurderChance, "$MRT_SP_DEFAULT_REJ_MALE_MURDER_SLIDER2", flg) 
  OID_DEFAULT_REJ_MALE_SLAVERY = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_SLAVERY_SLIDER1", MainScript.fDefaultRejectMaleSlaveryChance, "$MRT_SP_DEFAULT_REJ_MALE_SLAVERY_SLIDER2", flg)
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf   
  OID_DEFAULT_REJ_MALE_DD = AddSliderOption("$MRT_SP_DEFAULT_REJ_MALE_DD_SLIDER1", MainScript.fDefaultRejectMaleDeviceChance, "$MRT_SP_DEFAULT_REJ_MALE_DD_SLIDER2", flg)
  flg = iflag
  AddEmptyOption()
  OID_DEFAULT_REJ_FEMALE_ACCEPT = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_ACCEPT_SLIDER1", MainScript.fDefaultRejectFemaleAcceptChance, "$MRT_SP_DEFAULT_REJ_FEMALE_ACCEPT_SLIDER2", flg)        
  OID_DEFAULT_REJ_FEMALE_RAPE = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_RAPE_SLIDER1", MainScript.fDefaultRejectFemaleRapeChance, "$MRT_SP_DEFAULT_REJ_FEMALE_RAPE_SLIDER2", flg)
  OID_DEFAULT_REJ_FEMALE_ASSAULT = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_ASSAULT_SLIDER1", MainScript.fDefaultRejectFemaleAssaultChance, "$MRT_SP_DEFAULT_REJ_FEMALE_ASSAULT_SLIDER2", flg)    
  OID_DEFAULT_REJ_FEMALE_THEFT = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_THEFT_SLIDER1", MainScript.fDefaultRejectFemaleTheftChance, "$MRT_SP_DEFAULT_REJ_FEMALE_THEFT_SLIDER2", flg)
  OID_DEFAULT_REJ_FEMALE_MURDER = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_MURDER_SLIDER1", MainScript.fDefaultRejectFemaleMurderChance, "$MRT_SP_DEFAULT_REJ_FEMALE_MURDER_SLIDER2", flg) 
  OID_DEFAULT_REJ_FEMALE_SLAVERY = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_SLAVERY_SLIDER1", MainScript.fDefaultRejectFemaleSlaveryChance, "$MRT_SP_DEFAULT_REJ_FEMALE_SLAVERY_SLIDER2", flg) 
  if (iflag == OPTION_FLAG_NONE) && (MainScript.bIsDDIntegrationActive && MainScript.bIsDDExpansionActive)
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf  
  OID_DEFAULT_REJ_FEMALE_DD = AddSliderOption("$MRT_SP_DEFAULT_REJ_FEMALE_DD_SLIDER1", MainScript.fDefaultRejectFemaleDeviceChance, "$MRT_SP_DEFAULT_REJ_FEMALE_DD_SLIDER2", flg) 
  AddEmptyOption()
  OID_DEFAULT_REJ_ENTRAPMENT_LVL_M = AddMenuOption("$MRT_SP_DEFAULT_REJ_ENTRAPMENT_LVL", sGetEntrapmentLevels()[MainScript.iDefaultRejectEntrapmentLevel], flg)
  flg = iflag
  OID_DEFAULT_REJ_THEFT_ONLYGOLD = AddToggleOption("$MRT_SP_DEFAULT_REJ_THEFT_ONLYGOLD_TOGGLE", MainScript.bDefaultRejectTheftOnlyGold, flg)
EndFunction

Function approachOptions(Int iflag)
  int flg = iflag
  OID_CUSTOMER_APPROACH_INTERVAL =  AddSliderOption("$MRT_SP_CUSTOMER_APPROACH_INTERVAL_SLIDER1", MainScript.iCustomerApproachTimer as Float, "$MRT_SP_CUSTOMER_APPROACH_INTERVAL_SLIDER2", flg)
  AddEmptyOption()
  OID_CUSTOMER_APPROACH_CHANCE =  AddSliderOption("$MRT_SP_CUSTOMER_APPROACH_CHANCE_SLIDER1", MainScript.fCustomerApproachChance, "$MRT_SP_CUSTOMER_APPROACH_CHANCE_SLIDER2", flg)
  OID_MAX_DISTANCE_APPROACH = AddSliderOption("$MRT_SP_MAX_DISTANCE_APPROACH_SLIDER1", MainScript.fMaxApproachDistance, "$MRT_SP_MAX_DISTANCE_APPROACH_SLIDER2", flg)
  OID_MALE_CUSTOMER_APPROACH = AddToggleOption("$MRT_SP_MALE_CUSTOMER_APPROACH_TOGGLE", MainScript.bMaleCustomerApproach, flg)
  OID_FEMALE_CUSTOMER_APPROACH = AddToggleOption("$MRT_SP_FEMALE_CUSTOMER_APPROACH_TOGGLE", MainScript.bFemaleCustomerApproach, flg)
  OID_ONLY_LOS_APPROACH = AddToggleOption("$MRT_SP_ONLY_LOS_APPROACH_TOGGLE", MainScript.bOnlyLOSApproach, flg)
  OID_ONLY_INTERIOR_APPROACH = AddToggleOption("$MRT_SP_ONLY_INTERIOR_APPROACH_TOGGLE", MainScript.bOnlyInteriorApproach, flg)
  OID_ONLY_LICENSED_APPROACH = AddToggleOption("$MRT_SP_ONLY_LICENSED_APPROACH_TOGGLE", MainScript.bOnlyLicensedApproach, flg)
  OID_ONLY_WHORE_CLOTHING_APPROACH = AddToggleOption("$MRT_SP_ONLY_WHORE_CLOTHING_APPROACH_TOGGLE", MainScript.bOnlyWhoreClothingApproach, flg)
  OID_GUARDS_MAY_APPROACH = AddToggleOption("$MRT_SP_GUARDS_MAY_APPROACH_TOGGLE", MainScript.bGuardsMayApproach, flg)
  if  (iflag == OPTION_FLAG_NONE) && MainScript.bGuardsMayApproach
    flg = OPTION_FLAG_NONE
  else
    flg = OPTION_FLAG_DISABLED
  endIf
  OID_CRUEL_GUARDS_APPROACH = AddToggleOption("$MRT_SP_CRUEL_GUARDS_APPROACH_TOGGLE", MainScript.bGuardsAreCruel, flg)
  flg = iflag
  OID_ELDER_MAY_APPROACH = AddToggleOption("$MRT_SP_ELDER_MAY_APPROACH_TOGGLE", MainScript.bEldersMayApproach, flg)
EndFunction

Function DD_Options(Int iFlag)
  int flg = iFlag
  OID_DEVIOUS_NIP_PRC = AddSliderOption("$MRT_SP_DEVIOUS_NIP_PRC_SLIDER1", MainScript.fDeviousNipplePiercingChance, "$MRT_SP_DEVIOUS_NIP_PRC_SLIDER2", flg)
  OID_DEVIOUS_VAG_PRC = AddSliderOption("$MRT_SP_DEVIOUS_VAG_PRC_SLIDER1", MainScript.fDeviousVaginalPiercingChance, "$MRT_SP_DEVIOUS_VAG_PRC_SLIDER2", flg)
  OID_DEVIOUS_ANL_PLUG = AddSliderOption("$MRT_SP_DEVIOUS_ANL_PLUG_SLIDER1", MainScript.fDeviousAnalPlugChance, "$MRT_SP_DEVIOUS_ANL_PLUG_SLIDER2", flg)
  OID_DEVIOUS_VAG_PLUG = AddSliderOption("$MRT_SP_DEVIOUS_VAG_PLUG_SLIDER1", MainScript.fDeviousVaginalPlugChance, "$MRT_SP_DEVIOUS_VAG_PLUG_SLIDER2", flg)
  OID_DEVIOUS_ARM_CUF = AddSliderOption("$MRT_SP_DEVIOUS_ARM_CUF_SLIDER1", MainScript.fDeviousArmCuffChance, "$MRT_SP_DEVIOUS_ARM_CUF_SLIDER2", flg)
  OID_DEVIOUS_LEG_CUF = AddSliderOption("$MRT_SP_DEVIOUS_LEG_CUF_SLIDER1", MainScript.fDeviousLegCuffChance, "$MRT_SP_DEVIOUS_LEG_CUF_SLIDER2", flg)
  OID_DEVIOUS_COLLAR = AddSliderOption("$MRT_SP_DEVIOUS_COLLAR_SLIDER1", MainScript.fDeviousCollarChance, "$MRT_SP_DEVIOUS_COLLAR_SLIDER2", flg)
  OID_DEVIOUS_GLOVES = AddSliderOption("$MRT_SP_DEVIOUS_GLOVES_SLIDER1", MainScript.fDeviousGlovesChance, "$MRT_SP_DEVIOUS_GLOVES_SLIDER2", flg)
  OID_DEVIOUS_BOOTS = AddSliderOption("$MRT_SP_DEVIOUS_BOOTS_SLIDER1", MainScript.fDeviousBootsChance, "$MRT_SP_DEVIOUS_BOOTS_SLIDER2", flg)
  OID_DEVIOUS_CORSET = AddSliderOption("$MRT_SP_DEVIOUS_CORSET_SLIDER1", MainScript.fDeviousCorsetChance, "$MRT_SP_DEVIOUS_CORSET_SLIDER2", flg)
  OID_DEVIOUS_HARNESS = AddSliderOption("$MRT_SP_DEVIOUS_HARNESS_SLIDER1", MainScript.fDeviousHarnessesChance, "$MRT_SP_DEVIOUS_HARNESS_SLIDER2", flg)
  OID_DEVIOUS_GAG_RING = AddSliderOption("$MRT_SP_DEVIOUS_GAG_RING_SLIDER1", MainScript.fDeviousGagRingChance, "$MRT_SP_DEVIOUS_GAG_RING_SLIDER2", flg)
  OID_DEVIOUS_GAG_ALL = AddSliderOption("$MRT_SP_DEVIOUS_GAG_ALL_SLIDER1", MainScript.fDeviousGagAllChance, "$MRT_SP_DEVIOUS_GAG_ALL_SLIDER2", flg)
  OID_DEVIOUS_BELT_OPEN = AddSliderOption("$MRT_SP_DEVIOUS_BELT_OPEN_SLIDER1", MainScript.fDeviousChastityBeltOpenChance, "$MRT_SP_DEVIOUS_BELT_OPEN_SLIDER2", flg)
  OID_DEVIOUS_BELT_CLOSE = AddSliderOption("$MRT_SP_DEVIOUS_BELT_CLOSE_SLIDER1", MainScript.fDeviousChastityBeltCloseChance, "$MRT_SP_DEVIOUS_BELT_CLOSE_SLIDER2", flg)
  OID_DEVIOUS_BRA = AddSliderOption("$MRT_SP_DEVIOUS_BRA_SLIDER1", MainScript.fDeviousChastityBrasChance, "$MRT_SP_DEVIOUS_BRA_SLIDER2", flg)
  OID_DEVIOUS_HOOD = AddSliderOption("$MRT_SP_DEVIOUS_HOOD_SLIDER1", MainScript.fDeviousHoodChance, "$MRT_SP_DEVIOUS_HOOD_SLIDER2", flg)
  OID_DEVIOUS_BLINDFOLD = AddSliderOption("$MRT_SP_DEVIOUS_BLINDFOLD_SLIDER1", MainScript.fDeviousBlindfoldChance, "$MRT_SP_DEVIOUS_BLINDFOLD_SLIDER2", flg)
  OID_DEVIOUS_HEAVY_RESTRAINT = AddSliderOption("$MRT_SP_DEVIOUS_HEAVY_RESTRAINT_SLIDER1", MainScript.fDeviousHeavyRestraintChance, "$MRT_SP_DEVIOUS_HEAVY_RESTRAINT_SLIDER2", flg)
  OID_DEVIOUS_SUIT = AddSliderOption("$MRT_SP_DEVIOUS_SUIT_SLIDER1", MainScript.fDeviousSuitsChance, "$MRT_SP_DEVIOUS_SUIT_SLIDER2", flg)
EndFunction

String[] function sGetEntrapmentLevels()
  String[] sEntrapmentLevels = new String[4]
  sEntrapmentLevels[0] = "$DD_ENTRAPMENT_LVL1"
  sEntrapmentLevels[1] = "$DD_ENTRAPMENT_LVL2"
  sEntrapmentLevels[2] = "$DD_ENTRAPMENT_LVL3"
  sEntrapmentLevels[3] = "$DD_ENTRAPMENT_LVL4"
  return sEntrapmentLevels
endfunction

Int OID_BEG_GUARDS_SEX_OFFER
Int OID_GUARDS_MAY_APPROACH
Int OID_CRUEL_GUARDS_APPROACH
Int OID_BEG_REJ_MALE_ACCEPT
Int OID_BEG_REJ_FEMALE_ACCEPT
Int OID_BEG_REJ_MALE_THEFT
Int OID_BEG_REJ_FEMALE_THEFT
Int OID_BEG_REJ_MALE_ASSAULT
Int OID_BEG_REJ_FEMALE_ASSAULT
Int OID_BEG_REJ_MALE_SLAVERY
Int OID_BEG_REJ_FEMALE_SLAVERY

Int OID_WHORE_REJ_MALE_ACCEPT 
Int OID_WHORE_REJ_FEMALE_ACCEPT 
Int OID_WHORE_REJ_MALE_REPORT 
Int OID_WHORE_REJ_FEMALE_REPORT 
Int OID_WHORE_REJ_MALE_RAPE 
Int OID_WHORE_REJ_FEMALE_RAPE 
Int OID_WHORE_REJ_MALE_THEFT 
Int OID_WHORE_REJ_FEMALE_THEFT 
Int OID_WHORE_REJ_MALE_ASSAULT 
Int OID_WHORE_REJ_FEMALE_ASSAULT 
Int OID_WHORE_REJ_MALE_SLAVERY
Int OID_WHORE_REJ_FEMALE_SLAVERY

Int OID_DIBEL_REJ_MALE_ACCEPT 
Int OID_DIBEL_REJ_FEMALE_ACCEPT 
Int OID_DIBEL_REJ_MALE_REPORT 
Int OID_DIBEL_REJ_FEMALE_REPORT 
Int OID_DIBEL_REJ_MALE_RAPE 
Int OID_DIBEL_REJ_FEMALE_RAPE 
Int OID_DIBEL_REJ_MALE_THEFT 
Int OID_DIBEL_REJ_FEMALE_THEFT 
Int OID_DIBEL_REJ_MALE_ASSAULT 
Int OID_DIBEL_REJ_FEMALE_ASSAULT 
Int OID_DIBEL_REJ_MALE_SLAVERY
Int OID_DIBEL_REJ_FEMALE_SLAVERY
Int OID_DIBEL_REJ_FEMALE_MURDER
Int OID_DIBEL_REJ_MALE_MURDER
Int OID_WHORE_REJ_MALE_MURDER
Int OID_WHORE_REJ_FEMALE_MURDER
Int OID_BEG_REJ_MALE_MURDER
Int OID_BEG_REJ_FEMALE_MURDER

Int OID_BEG_REJ_THEFT_ONLYGOLD
Int OID_WHORE_REJ_THEFT_ONLYGOLD
Int OID_DIBEL_REJ_THEFT_ONLYGOLD

Int OID_FEMALE_CUSTOMER_APPROACH
Int OID_MALE_CUSTOMER_APPROACH
Int OID_CUSTOMER_APPROACH_CHANCE
Int OID_CUSTOMER_APPROACH_INTERVAL

Int OID_ONLY_INTERIOR_APPROACH
Int OID_ONLY_WHORE_CLOTHING_APPROACH
Int OID_ONLY_LICENSED_APPROACH
Int OID_BEG_ONLY_LICENSED_SEX_OFFER
Int OID_BEG_ONLY_INTERIOR_SEX_OFFER
Int OID_CRIME_BOUNTY

Int OID_DEFAULT_REJ_MALE_ACCEPT
Int OID_DEFAULT_REJ_FEMALE_ACCEPT
Int OID_DEFAULT_REJ_MALE_RAPE
Int OID_DEFAULT_REJ_FEMALE_RAPE
Int OID_DEFAULT_REJ_MALE_ASSAULT
Int OID_DEFAULT_REJ_FEMALE_ASSAULT
Int OID_DEFAULT_REJ_MALE_THEFT
Int OID_DEFAULT_REJ_FEMALE_THEFT
Int OID_DEFAULT_REJ_MALE_SLAVERY
Int OID_DEFAULT_REJ_FEMALE_SLAVERY
Int OID_DEFAULT_REJ_MALE_MURDER
Int OID_DEFAULT_REJ_FEMALE_MURDER
Int OID_DEFAULT_REJ_THEFT_ONLYGOLD
Int OID_BEG_REJ_WALKAWAY_CHECK

Int OID_ONLY_LOS_APPROACH
Int OID_MAX_DISTANCE_APPROACH

Int OID_DEVIOUS_VAG_PRC
Int OID_DEVIOUS_NIP_PRC
Int OID_DEVIOUS_VAG_PLUG
Int OID_DEVIOUS_ANL_PLUG
Int OID_DEVIOUS_ARM_CUF
Int OID_DEVIOUS_LEG_CUF
Int OID_DEVIOUS_COLLAR
Int OID_DEVIOUS_GLOVES
Int OID_DEVIOUS_BOOTS
Int OID_DEVIOUS_CORSET
Int OID_DEVIOUS_HARNESS
Int OID_DEVIOUS_GAG_RING
Int OID_DEVIOUS_GAG_ALL
Int OID_DEVIOUS_BELT_OPEN
Int OID_DEVIOUS_BELT_CLOSE
Int OID_DEVIOUS_BRA
Int OID_DEVIOUS_HOOD
Int OID_DEVIOUS_BLINDFOLD
Int OID_DEVIOUS_HEAVY_RESTRAINT
Int OID_DEVIOUS_SUIT
Int OID_BEG_ELDER_SEX_OFFER
Int OID_ELDER_MAY_APPROACH

Int OID_BEG_REJ_ENTRAPMENT_LVL_M
Int OID_WHORE_REJ_ENTRAPMENT_LVL_M
Int OID_DIBEL_REJ_ENTRAPMENT_LVL_M
Int OID_DEFAULT_REJ_ENTRAPMENT_LVL_M

Int OID_BEG_ENTRAPMENT_LVL_M
Int OID_WHORE_ENTRAPMENT_LVL_M
Int OID_DIBEL_ENTRAPMENT_LVL_M

Int OID_WHORE_DD_CHANCE
Int OID_DIBEL_DD_CHANCE
Int OID_BEG_DD_CHANCE

Int OID_BEG_REJ_FEMALE_DD
Int OID_BEG_REJ_MALE_DD
Int OID_WHORE_REJ_FEMALE_DD
Int OID_WHORE_REJ_MALE_DD
Int OID_DIBEL_REJ_FEMALE_DD
Int OID_DIBEL_REJ_MALE_DD
Int OID_DEFAULT_REJ_FEMALE_DD
Int OID_DEFAULT_REJ_MALE_DD