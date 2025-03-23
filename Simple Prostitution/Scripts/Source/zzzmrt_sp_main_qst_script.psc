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
zzzmrt_sp_ddx_interface property DDX_Interface auto
zzzmrt_sp_slsfr_interface property SLSFR_Interface auto
zzzmrt_sp_sla_interface property SLA_Interface auto
zzzmrt_sp_slhh_interface Property SLHH_Interface Auto
zzzmrt_sp_dibellan_lust_qst_script property dibellan_lust_qst_script auto
zzzmrt_sp_player_qst_script	Property playerScript Auto
zzzmrt_sp_reapproach_qst_script	Property ReApproachScript Auto
zzzmrt_sp_inn_work_qst_script property InnWorkScript Auto
zzzmrt_sp_reward_handler_script property RewardHandlerScript Auto
Quest Property InnWorkQst Auto
Quest Property SLA_Interface_Qst Auto
Quest Property OStimInterfaceQst Auto
Quest Property FlowerGirlsInterfaceQst Auto
Quest Property SexLabInterfaceQst Auto
Quest Property LicensesInterfaceQst Auto
Quest Property DDI_Interface_Qst Auto
Quest Property DDX_Interface_Qst Auto
Quest Property SLSFR_Interface_Qst Auto
Quest Property SLHH_InterFace_Qst Auto
zzzmrt_sp_mcm_qst_script property MCMScript auto
zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto
Bool Property bAssaulted = false Auto Hidden Conditional
Weapon Property assaultDagger Auto
Weapon Property unArmed Auto
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
Message property PositionMenu auto
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
Bool property bDibelAmulet=False auto Hidden Conditional
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
Bool Property bIsAELStruggleOK=False Auto Hidden Conditional
Bool Property bDibelAllowAggressive=True Auto Hidden Conditional
Bool Property bWhoreAllowAggressive=True Auto Hidden Conditional
Bool Property bTryAllInterfaces=True Auto Hidden Conditional
Bool Property bIsDDIntegrationActive=False Auto Hidden Conditional
Bool Property bIsDDExpansionActive=False Auto Hidden Conditional
Bool Property bIs_SLSFR_Active=False Auto Hidden Conditional
Bool Property bIs_SLA_Active=False Auto Hidden Conditional
Bool Property bIs_SLHH_Active=False Auto Hidden Conditional
Bool Property bDibelNeedWhoreOralReward = False Auto Hidden Conditional
Bool Property bDibelNeedWhoreAnalReward = False Auto Hidden Conditional
Bool Property bDibelNeedWhoreVaginalReward = False Auto Hidden Conditional
ImageSpaceModifier property blackScreen auto
Formlist property currentAllowedLocations auto
Formlist property alwaysAllowedLocations auto
Formlist property whoreCustomerList Auto
Formlist property dibelCustomerList Auto
Formlist Property currentCustomerList Auto
FormList property extraHealers Auto
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
Spell property ApproachDelaySpell Auto

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
Bool Property bBeggarPlayerIsKnownWhore = False Auto Hidden Conditional
ReferenceAlias Property entrapperAlias Auto

Bool Property bDibelPositionMenu = False Auto Hidden Conditional
Bool Property bWhorePositionMenu = False Auto Hidden Conditional

Bool Property bShowVaginalInPositionMenu = True Auto Hidden Conditional

Bool property bBeggarPayUseBaseSpeech = True Auto Hidden Conditional
Bool property bWhorePayUseBaseSpeech = True Auto Hidden Conditional
Bool property bDibelPayUseBaseSpeech = True Auto Hidden Conditional

Package Property entrapperPackage Auto
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
Float Property fBeggingMaleRapistChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleMurderChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectMaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fBeggarRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float Property fBeggingFemaleRapistChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleMurderChance = 0.0 Auto Hidden Conditional
Float property fBeggarRejectFemaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fWhoreRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fWhoreRejectMaleRapeChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleReportChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleMurderChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectMaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fWhoreRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleRapeChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleReportChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleMurderChance = 0.0 Auto Hidden Conditional
Float property fWhoreRejectFemaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fDibelRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDibelRejectMaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleReportChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleMurderChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectMaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fDibelRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDibelRejectFemaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleReportChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleMurderChance = 0.0 Auto Hidden Conditional
Float property fDibelRejectFemaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fDefaultRejectMaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDefaultRejectMaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectMaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectMaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectMaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectMaleMurderChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectMaleDeviceChance = 0.0 Auto Hidden Conditional

Float property fDefaultRejectFemaleAcceptChance = 100.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleRapeChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleAssaultChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleTheftChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleSlaveryChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleMurderChance = 0.0 Auto Hidden Conditional
Float property fDefaultRejectFemaleDeviceChance = 0.0 Auto Hidden Conditional


Int property iCustomerApproachTimer = 3 Auto Hidden Conditional
Float property fCustomerApproachTimer = 3.0 Auto Hidden Conditional
Bool property bDibelCustomerApproach = False Auto Hidden Conditional
Int Property iTotalCustomerPaidGold = 0 Auto Hidden Conditional
Bool property bRejectAssaultRape = False Auto Hidden Conditional
Bool property bRejectAssaultTheft = False Auto Hidden Conditional
Bool property bOnlyInteriorApproach = False Auto Hidden Conditional
Bool property bOnlyWhoreClothingApproach = False Auto Hidden Conditional
Bool property bOnlyInteriorBeggarOfferSex = False Auto Hidden Conditional
Float property fSLSFR_MinApproachRequiredFame = 50.0 Auto hidden Conditional
Float property fSLSFR_MinBeggarSexOfferRequiredFame = 25.0 Auto hidden Conditional
Float property fSLSFR_MinGainFame = 1.0 Auto hidden Conditional
Float property fSLSFR_MaxGainFame = 10.0 Auto hidden Conditional
Float property fSLSFR_FameGainChance = 100.0 Auto hidden Conditional
Int property iSLSFR_CurrentWhoreFame = 0 Auto hidden Conditional

Float property fSLSFR_Talk_MinGainFame = 1.0 Auto hidden Conditional
Float property fSLSFR_Talk_MaxGainFame = 2.0 Auto hidden Conditional
Float property fSLSFR_Talk_FameGainChance = 100.0 Auto hidden Conditional

FormList Property whoreClothingList Auto

Bool Property bISWhoreCustomerAroused = False Auto hidden Conditional
Bool Property bIsDibelCustomerAroused = False Auto hidden Conditional
Bool Property bIsBeggarHelperArroused = False Auto hidden Conditional
Bool Property bIsPCAroused = False Auto hidden Conditional
Bool property bIsPlayerGettingHarassed = False Auto hidden Conditional

Int property iSLA_MinApproachArousal = 0 Auto Hidden Conditional
Int property iSLA_MinWhoreCustomerArousal = 0 Auto Hidden Conditional
Int property iSLA_MinDibelCustomerArousal = 0 Auto Hidden Conditional
Int property iSLA_MinBeggarSexOfferArousal = 0 Auto Hidden Conditional
Int property iSLA_MinPCArousal = 0 Auto Hidden Conditional
Int Property iSLA_CurrentCustomerArousal = 0 Auto Hidden Conditional
Int Property iSLA_PCArousal = 0 Auto Hidden Conditional

Bool Property bSLHH_MaleRapist = True Auto Hidden Conditional
Bool Property bSLHH_FemaleRapist = False Auto Hidden Conditional

Float property fTempleClientMinExtraPay = 100.0 Auto Hidden Conditional
Float property fTempleClientMaxExtraPay = 200.0 Auto Hidden Conditional
Float Property fTempleMinMarkReward = 1.0 Auto Hidden Conditional
Float Property fTempleMaxMarkReward = 1.0 Auto Hidden Conditional
Float Property fDibelTempleMarkChance = 0.0 Auto Hidden Conditional
Float Property fTempleTaskSeptimCost = 0.0 Auto Hidden Conditional
Float Property fTempleTaskMarkCost = 0.0 Auto Hidden Conditional
GlobalVariable property templeTaskSeptimCostDisplay auto Conditional
GlobalVariable property templeTaskMarkCostDisplay auto Conditional
Form Property currentEscortClient Auto Hidden Conditional
Bool property bIsTempleClient = False Auto Hidden Conditional
Bool Property bMaleTempleClient = true Auto Hidden Conditional
Bool Property bFemaleTempleClient = true Auto Hidden Conditional

Quest property TempleEscort_Qst Auto
Quest property DibellanLust_Qst Auto

Formlist Property raceList Auto
Formlist Property vampireRacelist Auto
FormList Property checkedItems Auto

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
Keyword Property NotCustomer_KWD Auto
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
Bool property bBeggarRejectWalkAwayCheck = False Auto Hidden Conditional

Bool Property bDibelRejectTheftOnlyGold = True Auto Hidden Conditional
Bool Property bWhoreRejectTheftOnlyGold = True Auto Hidden Conditional
Bool Property bBeggarRejectTheftOnlyGold = True Auto Hidden Conditional
Bool Property bDefaultRejectTheftOnlyGold = True Auto Hidden Conditional

Int[] property iDeviceChanceArr Auto Hidden Conditional

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
Int Property iRejectMurderChance = 0 Auto Hidden Conditional
Int Property iRejectDeviceChance = 0 Auto Hidden Conditional
Bool property bRejectTheftOnlyGold = True Auto Hidden Conditional
Bool property bRejectDibel = False Auto Hidden Conditional
Bool property bRejectWhore = False Auto Hidden Conditional
Bool property bRejectBeggar = False Auto Hidden Conditional
Bool property bRejectApproach = False Auto Hidden Conditional

Bool Property bGuardsAreCruel = True Auto Hidden Conditional
Bool Property bGuardsMayApproach = True Auto Hidden Conditional
Bool Property bBeggarGuardsSexOffer = True Auto Hidden Conditional
Bool Property bBeggarElderSexOffer = True Auto Hidden Conditional
Bool Property bEldersMayApproach = True Auto Hidden Conditional

Int property iCrimeBounty = 50 Auto Hidden Conditional
Int property iTotalCrimes = 0 Auto Hidden Conditional

Package Property drawWeaponPackage  Auto 
Package Property customerForceGreetPackage Auto
Package Property FollowPackage Auto

Bool Property bOnlyLicensedApproach = true Auto Hidden Conditional
Bool Property bOnlyLicensedBeggarSexOffer = true Auto Hidden Conditional

Bool Property bOnlyLOSApproach = True Auto Hidden Conditional
Float Property fMaxApproachDistance = 5000.0 Auto Hidden Conditional
GlobalVariable Property maxApproachDistance Auto 

Int Property iEntrapmentLevel = 0 Auto Hidden Conditional
Int Property iBeggarRejectEntrapmentLevel = 1 Auto Hidden Conditional
Int Property iWhoreRejectEntrapmentLevel = 1 Auto Hidden Conditional
Int Property iDibelRejectEntrapmentLevel = 1 Auto Hidden Conditional
Int Property iDefaultRejectEntrapmentLevel = 1 Auto Hidden Conditional

Int Property iDeviousDeviceSet = 0 Auto Hidden Conditional

Int Property iBeggarEntrapmentLevel = 0 Auto Hidden Conditional
Int Property iWhoreEntrapmentLevel = 0 Auto Hidden Conditional
Int Property iDibelEntrapmentLevel = 0 Auto Hidden Conditional

Float Property fWhoreDeviceChance = 0.0 Auto Hidden Conditional
Float Property fDibelDeviceChance = 0.0 Auto Hidden Conditional
Float Property fBeggarDeviceChance = 0.0 Auto Hidden Conditional

Float property fDeviousNipplePiercingChance = 50.0 Auto hidden Conditional
Float property fDeviousVaginalPiercingChance = 50.0 Auto hidden Conditional
Float property fDeviousVaginalPlugChance = 50.0 Auto hidden Conditional
Float property fDeviousAnalPlugChance = 50.0 Auto hidden Conditional
Float property fDeviousArmCuffChance = 50.0 Auto hidden Conditional
Float property fDeviousLegCuffChance = 50.0 Auto hidden Conditional
Float property fDeviousCollarChance = 50.0 Auto hidden Conditional
Float property fDeviousGlovesChance = 50.0 Auto hidden Conditional
Float property fDeviousBootsChance = 50.0 Auto hidden Conditional
Float property fDeviousCorsetChance = 50.0 Auto hidden Conditional
Float property fDeviousHarnessesChance = 50.0 Auto hidden Conditional
Float property fDeviousGagRingChance = 50.0 Auto hidden Conditional
Float property fDeviousChastityBeltOpenChance = 50.0 Auto hidden Conditional
Float property fDeviousChastityBeltCloseChance = 50.0 Auto hidden Conditional
Float property fDeviousChastityBrasChance = 50.0 Auto hidden Conditional
Float property fDeviousGagAllChance = 50.0 Auto hidden Conditional
Float property fDeviousHoodChance = 50.0 Auto hidden Conditional
Float property fDeviousBlindfoldChance = 50.0 Auto hidden Conditional
Float property fDeviousHeavyRestraintChance = 50.0 Auto hidden Conditional
Float property fDeviousSuitsChance = 50.0 Auto hidden Conditional

;Current player status
GlobalVariable property isWhoring_g Auto
GlobalVariable property isDibeling_g Auto
GlobalVariable property isWhore_g Auto
GlobalVariable property isDibel_g Auto

Float property fWhorePersuadeChance = 50.0 Auto Hidden Conditional
Float property fBeggarPersuadeChance = 30.0 Auto Hidden Conditional
Float property fDibelPersuadeChance = 70.0 Auto Hidden Conditional

Bool property isDibel = False Auto Hidden Conditional ;for starting customer approach and checking dibel license
Bool property isWhore = False Auto Hidden Conditional ;for starting customer approach

Bool property bDibelClientOrgasmed = False Auto hidden Conditional
Bool property bWhoreClientOrgasmed = False Auto hidden Conditional
Int property iWhoreClientsPayment = 0 Auto hidden Conditional
Int property iDibelClientsPayment = 0 Auto hidden Conditional

Bool property bDibelPayAfterSex = False Auto hidden Conditional
Bool property bWhorePayAfterSex = False Auto hidden Conditional
Bool property bWhoreOnlyPayIfClientOrgasmed = False Auto hidden Conditional
Bool property bDibelOnlyPayIfClientOrgasmed = False Auto hidden Conditional
Bool property bWhorePunishIfClientNotOrgasmed = False Auto hidden Conditional
Bool property bDibelPunishIfClientNotOrgasmed = False Auto hidden Conditional

Quest Property ReApproachQst Auto
ReferenceAlias property ReApproachingAlias auto
Package Property customerForceGreetAgainPackage Auto
Bool Property bRejectOrgasm = False Auto Hidden Conditional

FormList Property Ench_Armor_Lists Auto
FormList Property Ench_Clothing_Lists Auto
FormList Property Ench_Weapon_Lists Auto
LeveledItem Property LItemTempleReward Auto

Float Property fDibelTempleExtraRewardChance = 0.0 Auto Hidden Conditional
Float Property fDibelTempleExtraRewardEnchantedChance = 0.0 Auto Hidden Conditional
Bool Property bTeamMatesMayApproach = False Auto Hidden Conditional

Float Property fDibelExtraRewardChance = 0.0 Auto Hidden Conditional
Float Property fDibelExtraRewardEnchantedChance = 0.0 Auto Hidden Conditional
Float Property fWhoreExtraRewardChance = 0.0 Auto Hidden Conditional
Float Property fWhoreExtraRewardEnchantedChance = 0.0 Auto Hidden Conditional
Float Property fBeggarExtraRewardChance = 0.0 Auto Hidden Conditional
Float Property fBeggarExtraRewardEnchantedChance = 0.0 Auto Hidden Conditional

Float Property fDibelTempleMinExtraReward = 1.0 Auto Hidden Conditional
Float Property fDibelTempleMaxExtraReward = 1.0 Auto Hidden Conditional

Float Property fNormalMarkChance = 0.0 Auto Hidden Conditional
Bool property bNormalNoRewardWhenVictim = True Auto Hidden Conditional
Bool Property bNormalOnlyRewardIfPartnerOrgasmed = False Auto Hidden Conditional
Bool Property bNormalPCPartnerOrgasmed = False Auto Hidden Conditional

Int Property iDefaultColor = 0x9F00FF  Auto Hidden Conditional 
Int Property iSuccessColor = 0x00FF00  Auto Hidden Conditional
Int Property iInfoColor = 0x00FFFF  Auto Hidden Conditional
Int Property iWarningColor = 0xFFFF00  Auto Hidden Conditional
Int Property iErrorColor = 0xFF0000 Auto Hidden Conditional
Int Property iSeparatorColor = 0xFFFFFF Auto Hidden Conditional
String Property sDefaultColor = "9F00FF"  Auto Hidden Conditional 
String Property sSuccessColor = "00FF00"  Auto Hidden Conditional
String Property sInfoColor = "00FFFF"  Auto Hidden Conditional
String Property sWarningColor = "FFFF00"  Auto Hidden Conditional
String Property sErrorColor = "FF0000" Auto Hidden Conditional
String Property sSeparatorColor = "FFFFFF" Auto Hidden Conditional
Bool property bShowNotification = True Auto Hidden Conditional
Bool property bPreventFruitlessApproaches = True Auto Hidden Conditional 
Float property fGroupSexChance = 100.0 Auto Hidden Conditional
Float property fWhoreNotPayChance = 0.0 Auto Hidden Conditional 
Float property fDibelNotPayChance = 0.0 Auto Hidden Conditional 
Bool property bWhoreNotPayOnlyIfAlone = False Auto Hidden Conditional
Float property fWhorePunishByUnpayClientChance = 0.0 Auto Hidden Conditional
Float property fDibelPunishByUnpayClientChance = 0.0 Auto Hidden Conditional
Bool property bNearbyMalesMayJoinSex = False Auto Hidden Conditional
Bool property bNearbyFemalesMayJoinSex = False Auto Hidden Conditional

Quest Property participantDetector Auto
ReferenceAlias Property Participant1 Auto
ReferenceAlias Property Participant2 Auto

Quest property WerewolfQuest Auto
Quest property VampireLordQuest Auto
Race Property WereWolfBeastRace Auto
Race Property DLC1VampireBeastRace Auto

Bool Property bWhoreClientNotPaid = False Auto Hidden Conditional
Bool Property bDibelClientNotPaid = False Auto Hidden Conditional

Bool property bStruggleVictimEscaped = False Auto Hidden Conditional
Bool property bStruggleEnded = False Auto Hidden Conditional

Bool property bReverseSTDProgression = False Auto Hidden Conditional

Float Property fAELStruggleDifficulty = 30.0 Auto Hidden Conditional

Int property iNumRapist = 0 Auto Hidden Conditional

function log(String sText, Bool bNotification = False, Bool bTrace = True, Int iSeverity = 1, Bool bForceNotif = False)
	logText(sText, (bNotification && (bShowNotification || (iSeverity != 1) || bForceNotif)), bTrace, iSeverity, "SPP", sDefaultColor, sSuccessColor, sInfoColor, sWarningColor, sErrorColor, sSeparatorColor)
endFunction

function testNotifications()
	log("Success Test Message", True, False, 0)
	log("Info Test Message", True, False, 1)
	log("Warning Test Message", True, False, 2)
	log("Error Test Message", True, False, 3)
endFunction

function shutDown()
	stopApproach(true)
	ReApproachScript.stopReapproach(True)
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(False)
	SLSFR_Interface.SLSFR_toggle_WhoreEventFlag(False)
	snitchDetector.stop()
	ApproachMonitorQst.stop()
	participantDetector.Stop()
	STD_Script.cureActorSTDs(player, False)
	STD_Quest.Stop()
	if pimpTracker.isRunning()
		pimpTracker.setstage(10)
	endif
	if DibellanLust_Qst.isrunning()
		DibellanLust_Qst.setstage(10)
	endif
	if TempleEscort_Qst.isrunning()
		TempleEscort_Qst.setstage(10)
	endif
	if InnWorkQst.isRunning()
		InnWorkScript.Succeed()
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
	isWhore_g.SetValueInt(0)
	isDibel_g.SetValueInt(0)
	FlowerGirlsInterface.bChecked = False
	SexLabInterface.bChecked = False 
	OStimInterface.bChecked = False 
	LicensesInterface.bChecked = False 
	DDI_Interface.bChecked = False 
	DDX_Interface.bChecked = False 
	SLSFR_Interface.bChecked = False 
	SLA_Interface.bChecked = False
	SLHH_Interface.bChecked = False
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
	setDeviceChanceArray()
	if fWhoreOwnerShare > 0.0
		pimpTracker.start()
	endif
	startCalcSTDCurePrice()
	RegisterForEvents()
	checkCurrentLocation()
	if !ApproachMonitorScr
		ApproachMonitorScr = ApproachMonitorQst as zzzmrt_sp_appr_monitor_qst_script
	endif
	if ApproachMonitorQst.isRunning()
		ApproachMonitorScr.RegisterForEvents()
	else
		ApproachMonitorQst.start()
	endif
	ApproachMonitorScr.updateApproach(False)
EndFunction

Function RegisterForEvents()
	RegisterForModEvent("AnimationStart", "on_spp_sexlab_Sex_Start")
	RegisterForModEvent("AnimationEnding", "on_spp_sexlab_Sex_Ending")
	RegisterForModEvent("HookAnimationEnd", "on_spp_sexlab_Sex_End")
	RegisterForModEvent("ostim_start", "on_spp_ostim_Sex_Start")
	RegisterForModEvent("ostim_end", "on_spp_ostim_Sex_End")
	RegisterForModEvent("ostim_orgasm", "on_spp_ostim_Orgasm")
	RegisterForModEvent("SexLabOrgasmSeparate", "on_spp_sexlab_OrgasmSeparate")
	RegisterForModEvent("OrgasmStart", "on_spp_sexlab_Orgasm")
EndFunction

Function setDeviceChanceArray()
	if iDeviceChanceArr.Length != 20
		iDeviceChanceArr = new Int[20]
	endif
	iDeviceChanceArr[0]  = (fDeviousNipplePiercingChance * 10.0) as Int
	iDeviceChanceArr[1]  = (fDeviousVaginalPiercingChance * 10.0) as Int
	iDeviceChanceArr[2]  = (fDeviousAnalPlugChance * 10.0) as Int
	iDeviceChanceArr[3]  = (fDeviousVaginalPlugChance * 10.0) as Int
	iDeviceChanceArr[4]  = (fDeviousArmCuffChance * 10.0) as Int
	iDeviceChanceArr[5]  = (fDeviousLegCuffChance * 10.0) as Int
	iDeviceChanceArr[6]  = (fDeviousCollarChance * 10.0) as Int
	iDeviceChanceArr[7]  = (fDeviousGlovesChance * 10.0) as Int
	iDeviceChanceArr[8]  = (fDeviousBootsChance * 10.0) as Int
	iDeviceChanceArr[9]  = (fDeviousCorsetChance * 10.0) as Int
	iDeviceChanceArr[10] = (fDeviousHarnessesChance * 10.0) as Int
	iDeviceChanceArr[11] = (fDeviousGagRingChance * 10.0) as Int
	iDeviceChanceArr[12] = (fDeviousChastityBeltOpenChance * 10.0) as Int
	iDeviceChanceArr[13] = (fDeviousChastityBeltCloseChance * 10.0) as Int
	iDeviceChanceArr[14] = (fDeviousChastityBrasChance * 10.0) as Int
	iDeviceChanceArr[15] = (fDeviousGagAllChance * 10.0) as Int
	iDeviceChanceArr[16] = (fDeviousHoodChance * 10.0) as Int
	iDeviceChanceArr[17] = (fDeviousBlindfoldChance * 10.0) as Int
	iDeviceChanceArr[18] = (fDeviousHeavyRestraintChance * 10.0) as Int
	iDeviceChanceArr[19] = (fDeviousSuitsChance * 10.0) as Int
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
		isWhore_g.SetValueInt(1)
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
		if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
			SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
		endif
		log("Work allowed in " + currentAllowedLocations.GetAt(0) + " that's owned by " + akOwner)
		log("Prostitution enabled for current location.", True, False, 0)
	endif
endfunction

Function ownerPayWhore(Actor whore)
	if iCurrentOwnerSeptims > 0
		int payment = maxInt(0, ((iCurrentOwnerSeptims as float) * ((100.0 - fWhoreOwnerShare) / 100.0)) as int)
		whore.Additem(gold, payment)
		if (Owner.getActorReference() != None) && (iCurrentOwnerSeptims - payment) > 0
			Owner.getActorReference().Additem(gold,(iCurrentOwnerSeptims - payment))
		else
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
		payBeggar(player, False)
		addExtraRewardsToPlayer(fBeggarExtraRewardChance, fBeggarExtraRewardEnchantedChance, 1)
		debug.sendanimationevent(akActor, "IdleGive")
		persuade(fBeggarPersuasionXPMult)
	endif
	setGlobalVaues()
endfunction

Float function getBaseVersion()
	return 1.0
endfunction

Float function getCurrentVersion()
	return getBaseVersion() + 0.61
endfunction

Function persuade(Float fSpeechSkillMult)
	if fSpeechSkillMult <= 0.0
		return
	endif
	Game.AdvanceSkill("Speechcraft", fSpeechSkillMult * player.GetActorValue("Speechcraft"))
	;Game.IncrementStat("Persuasions")
endFunction

Bool function bRandomSexWithPlayer(Actor akActor, Bool bAggressive = False, Bool bGroup = False)
	if !akActor
		return False
	endif
	string interface = sGetCurAnimInteface()
	int iTotalRapist = 1
	Actor[] partners
	iNumRapist = 0
	if bGroup && (bNearbyMalesMayJoinSex || bNearbyFemalesMayJoinSex)
		participantDetector.Start()
		if Participant1.GetActorReference()
			iTotalRapist += 1
			log(Participant1.GetActorReference().getdisplayname() + " is joining.", true, true, 1)
		endif
		if (Participant2.GetActorReference() && randInt(0,1))
			iTotalRapist += 1
			log(Participant2.GetActorReference().getdisplayname() + " is joining.", true, true, 1)
		endif
		if iTotalRapist > 1
		   if (iTotalRapist == 3) && (Participant1.GetActorReference() && Participant2.GetActorReference())
		     partners = new Actor[3]
			 partners[0] = akActor
			 partners[1] = Participant1.GetActorReference()
			 partners[2] = Participant2.GetActorReference()
		   elseif (iTotalRapist == 2) && Participant1.GetActorReference() 
		     partners = new Actor[2]
			 partners[0] = akActor
			 partners[1] = Participant1.GetActorReference()
		   elseif (iTotalRapist == 2) && Participant2.GetActorReference() 
		     partners = new Actor[2]
			 partners[0] = akActor
			 partners[1] = Participant2.GetActorReference()
		   endif
		endif
	endif	
	Bool bResult
	if interface == "sexlab"
		if bIsSexlabActive
			if Partners && (Partners.Length > 1)
				bResult = SexLabInterface.bHaveGroupSexWithPlayer(partners ,true, true)
				if bResult
					iNumRapist = partners.Length
					return true
				else
				    log("Couldn't start the animation. Please check the log.", true, true, 3)
					iNumRapist = 1
					return SexLabInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
				endif
			endif
			iNumRapist = 1
			return SexLabInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
		endif
	elseif interface == "ostim"
		if bIsOstimActive
			if Partners && (Partners.Length > 1)
				bResult = OStimInterface.bHaveGroupSexWithPlayer(partners ,true)
				if bResult
					iNumRapist = partners.Length
					return true
				else
				    log("Couldn't start the animation. Please check the log.", true, true, 3)
					iNumRapist = 1
					return OStimInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
				endif
			endif
			iNumRapist = 1
			return OStimInterface.bHaveRandomSexWithPlayer(akActor, bAggressive)
		endif   
	elseif interface == "flowergirls"
		if bIsFlowerGirlsActive
			if Partners && (Partners.Length > 1)
				bResult = FlowerGirlsInterface.bHaveGroupSexWithPlayer(partners)
				if bResult
				    iNumRapist = partners.Length
					registerForSingleUpdate(1.0)
					return True
				else
					log("Couldn't start the animation. Please check the log.", true, true, 3)
					if FlowerGirlsInterface.bHaveRandomSexWithPlayer(akActor)
					    iNumRapist = 1
						registerForSingleUpdate(1.0)
						return True
					endif
				endif
			elseif FlowerGirlsInterface.bHaveRandomSexWithPlayer(akActor)
			    iNumRapist = 1
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
		iNumRapist = 1
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
		log("Couldn't start the animation. Please check the log.", true, true, 3)
		if bTryAllInterfaces && iGetCurTotalAnimInterfaces() > 1
		    log("Retrying with other interfaces.", true, true, 2)
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
		    log("Couldn't find any suitable animation.", true, true, 3)
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
		Bool bAllowGroupSex
		while !bResult && (currentCustomerList.GetSize() > 0)
			bAllowGroupSex = (randInt(0, 999) < (fGroupSexChance * 10) as Int)
			if bAllowGroupSex && (bNearbyMalesMayJoinSex || bNearbyFemalesMayJoinSex) && (currentCustomerList.GetSize() < 4)
				participantDetector.Start()
				Bool bClientAdded = False
				if Participant1.GetActorReference()
					currentCustomerList.AddForm(Participant1.GetActorReference())
					log(Participant1.GetActorReference().getdisplayname() + " is joining.", true, true, 1)
					bClientAdded = true
				endif
				if (Participant2.GetActorReference() && (currentCustomerList.GetSize() < 4) && randInt(0,1))
					currentCustomerList.AddForm(Participant2.GetActorReference())
					log(Participant2.GetActorReference().getdisplayname() + " is joining.", true, true, 1)
					bClientAdded = true
				endif
				if bClientAdded
					partners = formListToActorArray(currentCustomerList)
				endif
			endif
			if (!bAllowGroupSex || (currentCustomerList.GetSize() == 1))
				if !(currentCustomerList.GetAt(0) as Actor) || (origCustomersArr.Find(currentCustomerList.GetAt(0) as Actor) < 0)
					currentCustomerList.revert()
					partners = formListToActorArray(currentCustomerList)
					log("Client is invalid.", true, true, 3)
					participantDetector.Stop()
					return False
				endif
				iIndex = origCustomersArr.Find(currentCustomerList.GetAt(0) as Actor)
				iPosition = iPositions[iIndex]
				if iPosition < 0
					iPosition = randInt(0,2)
				endif
				int iResult = haveSex(currentCustomerList.GetAt(0) as Actor, interface, bAllowAggressive, bAllowAll)
				iPositions[iIndex] = iResult
				bResult = (iResult > -1)
				if bResult
					if currentCustomerList.GetSize() > 1 ;For When group sex disabled
						Form lastCustomer = currentCustomerList.GetAt(0)
						currentCustomerList.revert()
						currentCustomerList.addform(lastCustomer)
					endif
				else
					currentCustomerList.revert()
					partners = formListToActorArray(currentCustomerList)
					log("Couldn't start the animation. Please check the log.", true, true, 3)
				endif
				participantDetector.Stop()
				return bResult
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
		participantDetector.Stop()
		return bResult
	endif
EndFunction

Bool Function playerGroupSexOS(Actor[] akActors, Bool bAllowAggressive= False)
	if !bIsOstimActive
		return False
	endif
	if OStimInterface.bHaveGroupSexWithPlayer(akActors, bAllowAggressive)
	  RegisterForModEvent("ostim_start", "on_spp_ostim_Sex_Start")
	  RegisterForModEvent("ostim_orgasm", "on_spp_ostim_Orgasm")
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
		RegisterForModEvent("AnimationStart", "on_spp_sexlab_Sex_Start")
		RegisterForModEvent("SexLabOrgasmSeparate", "on_spp_sexlab_OrgasmSeparate")
		RegisterForModEvent("OrgasmStart", "on_spp_sexlab_Orgasm")
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
	if !akActor || isCustomer(akActor)
		return
	endif
	int iPayment = 0
	if (bPay || (akActor.GetCurrentScene() == None))
		customerSpell.Cast(akActor, akActor)
	else
		String msg = akActor.getDisplayName() + " is busy."
		log(msg, True, False, 1)
		Scene curScene = akActor.GetCurrentScene()
		log(msg + " | Scene: " + curScene + " | Quest: " + curScene.GetOwningQuest())
		return
	endif
	if bPay
		if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
			if bWhorePositionMenu && (whoreCustomerList.GetSize() == 0)
				iWhorePosition = positionChooserByMenu(False)
				if (iWhorePosition < 1) || (iWhorePosition > 2)
					iWhorePosition = positionChooser(0, fWhoreAnalChance as Int, fWhoreOralChance as Int)
				endif
			else
				iWhorePosition = positionChooser(0, fWhoreAnalChance as Int, fWhoreOralChance as Int)
			endif
		else
			if bWhorePositionMenu && (whoreCustomerList.GetSize() == 0)
				iWhorePosition = positionChooserByMenu(True)
				if (iWhorePosition < 0) || (iWhorePosition > 2)
					iWhorePosition = positionChooser(fWhoreVagChance as Int, fWhoreAnalChance as Int, fWhoreOralChance as Int)
				endif
			else
				iWhorePosition = positionChooser(fWhoreVagChance as Int, fWhoreAnalChance as Int, fWhoreOralChance as Int)
			endif
		endif
		if iWhorePosition > -1
			iPayment = payWhore(player, iWhorePosition)
			!bWhorePayAfterSex && (iPayment > 0) && debug.sendanimationevent(akActor, "IdleGive")
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
			forceRefAndPackageTo(akActor, whoreCustomerAlias, FollowPackage)
			iWhorePositions[0] = iWhorePosition
			iPaidGoldCustomer1 = iPayment
			iPaidGoldAllCustomers += iPaidGoldCustomer1 
		elseif whoreCustomerList.GetSize() == 1
			forceRefAndPackageTo(akActor, whoreCustomerAlias2, FollowPackage)
			iWhorePositions[1] = iWhorePosition
			iPaidGoldCustomer2 = iPayment
			iPaidGoldAllCustomers += iPaidGoldCustomer2
		elseif whoreCustomerList.GetSize() == 2
			forceRefAndPackageTo(akActor, whoreCustomerAlias3, FollowPackage)
			iWhorePositions[2] = iWhorePosition
			iPaidGoldCustomer3 = iPayment
			iPaidGoldAllCustomers += iPaidGoldCustomer3
		elseif whoreCustomerList.GetSize() == 3
			forceRefAndPackageTo(akActor, whoreCustomerAlias4, FollowPackage)
			iWhorePositions[3] = iWhorePosition
			iPaidGoldCustomer4 = iPayment
			iPaidGoldAllCustomers += iPaidGoldCustomer4
		endif
		akActor.EvaluatePackage()
		whoreCustomerList.AddForm(akActor)
		iTotalWhoreCustomers = whoreCustomerList.GetSize()
	endif
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
	if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
		SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
	endif
EndFunction

Function setDibelCustomer(Actor akActor, bool bPay = true )
	if !akActor || isCustomer(akActor)
		return
	endif
	if (bPay || (akActor.GetCurrentScene() == None))
		customerSpell.Cast(akActor, akActor)
	else
		String msg = akActor.getDisplayName() + " is busy."
		log(msg, true, false, 1)
		Scene curScene = akActor.GetCurrentScene()
		log(msg + " | Scene: " + curScene + " | Quest: " + curScene.GetOwningQuest())
		return
	endif
	int iPayment = 0
	if bPay
		if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
			if bDibelPositionMenu && (dibelCustomerList.GetSize() == 0)
				iDibelPosition = positionChooserByMenu(False)
				if (iDibelPosition < 1) || (iDibelPosition > 2)
					iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
				endif
			else
				iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
			endif
		else
			if bDibelPositionMenu && (dibelCustomerList.GetSize() == 0)
				iDibelPosition = positionChooserByMenu(True)
				if (iDibelPosition < 0) || (iDibelPosition > 2)
					iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
				endif
			else
				iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
			endif
		endif
		if iDibelPosition > -1
			iPayment = payDibel(player, iDibelPosition, false)
			!bDibelPayAfterSex && (iPayment > 0) && debug.sendanimationevent(akActor, "IdleGive")
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
			forceRefAndPackageTo(akActor, dibelCustomerAlias, FollowPackage)
			iDibelPositions[0] = iDibelPosition
			iPaidGoldDibelCustomer1 = iPayment
		elseif dibelCustomerList.GetSize() == 1
			forceRefAndPackageTo(akActor, dibelCustomerAlias2, FollowPackage)
			iDibelPositions[1] = iDibelPosition
			iPaidGoldDibelCustomer2 = iPayment
		elseif dibelCustomerList.GetSize() == 2
			forceRefAndPackageTo(akActor, dibelCustomerAlias3, FollowPackage)
			iDibelPositions[2] = iDibelPosition
			iPaidGoldDibelCustomer3 = iPayment
		elseif dibelCustomerList.GetSize() == 3
			forceRefAndPackageTo(akActor, dibelCustomerAlias4, FollowPackage)
			iDibelPositions[3] = iDibelPosition
			iPaidGoldDibelCustomer4 = iPayment
		endif
		akActor.EvaluatePackage()
		dibelCustomerList.AddForm(akActor)
		iTotalDibelCustomers = dibelCustomerList.GetSize()
	endif
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
	if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
		SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
	endif
EndFunction

Function setTempleClient(Actor akActor)
	if !akActor || isCustomer(akActor)
		return
	endif
	int iPayment = 0
	if !player.GetActorBase().GetSex() && !akActor.GetLeveledActorBase().GetSex()
		if bDibelPositionMenu && (dibelCustomerList.GetSize() == 0)
			iDibelPosition = positionChooserByMenu(False)
			if (iDibelPosition < 1) || (iDibelPosition > 2)
				iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
			endif
		else
			iDibelPosition = positionChooser(0, fDibelAnalChance as Int, fDibelOralChance as Int)
		endif
	else
		if bDibelPositionMenu && (dibelCustomerList.GetSize() == 0)
			iDibelPosition = positionChooserByMenu(True)
			if (iDibelPosition < 0) || (iDibelPosition > 2)
				iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
			endif
		else
			iDibelPosition = positionChooser(fDibelVagChance as Int, fDibelAnalChance as Int, fDibelOralChance as Int)
		endif
	endif
	if iDibelPosition > -1
		iPayment = payDibel(player, iDibelPosition, true)
		!bDibelPayAfterSex && (iPayment > 0) && debug.sendanimationevent(akActor, "IdleGive")
	endif
	if iDibelPositions.length != 4
		iDibelPositions = new int[4]
		iDibelPositions[0] = -1
		iDibelPositions[1] = -1
		iDibelPositions[2] = -1
		iDibelPositions[3] = -1
	endif
	if iDibelPosition > -1
		if dibelCustomerList.GetSize() == 0
			forceRefAndPackageTo(akActor, dibelCustomerAlias, FollowPackage)
			iDibelPositions[0] = iDibelPosition
			iPaidGoldDibelCustomer1 = iPayment
		elseif dibelCustomerList.GetSize() == 1
			forceRefAndPackageTo(akActor, dibelCustomerAlias2, FollowPackage)
			iDibelPositions[1] = iDibelPosition
			iPaidGoldDibelCustomer2 = iPayment
		elseif dibelCustomerList.GetSize() == 2
			forceRefAndPackageTo(akActor, dibelCustomerAlias3, FollowPackage)
			iDibelPositions[2] = iDibelPosition
			iPaidGoldDibelCustomer3 = iPayment
		elseif dibelCustomerList.GetSize() == 3
			forceRefAndPackageTo(akActor, dibelCustomerAlias4, FollowPackage)
			iDibelPositions[3] = iDibelPosition
			iPaidGoldDibelCustomer4 = iPayment
		endif
		akActor.EvaluatePackage()
		dibelCustomerList.AddForm(akActor)
		iTotalDibelCustomers = dibelCustomerList.GetSize()
		currentEscortClient = akActor as Form
	endif
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
	if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
		SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
	endif
EndFunction

Function setRejectingCustomerResult(Actor akActor, Bool bWhore = False, Bool bDibel = False, Bool bBeggar = False, Bool bApproach = False)
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
	iRejectMurderChance = 0
	iRejectDeviceChance = 0
	if bDibel
		if bFemaleNPC
			iRejectAcceptChance = (fDibelRejectFemaleAcceptChance * 10.0) as Int
			iRejectReportChance = (fDibelRejectFemaleReportChance * 10.0) as Int
			iRejectTheftChance = (fDibelRejectFemaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fDibelRejectFemaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fDibelRejectFemaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fDibelRejectFemaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fDibelRejectFemaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fDibelRejectFemaleDeviceChance * 10.0) as Int
		else
			iRejectAcceptChance = (fDibelRejectMaleAcceptChance * 10.0) as Int
			iRejectReportChance = (fDibelRejectMaleReportChance * 10.0) as Int
			iRejectTheftChance = (fDibelRejectMaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fDibelRejectMaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fDibelRejectMaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fDibelRejectMaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fDibelRejectMaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fDibelRejectMaleDeviceChance * 10.0) as Int
		endif
		bRejectTheftOnlyGold = bDibelRejectTheftOnlyGold
		iEntrapmentLevel = iDibelRejectEntrapmentLevel
	elseif bWhore
		if bFemaleNPC
			iRejectAcceptChance = (fWhoreRejectFemaleAcceptChance * 10.0) as Int
			iRejectReportChance = (fWhoreRejectFemaleReportChance * 10.0) as Int
			iRejectTheftChance = (fWhoreRejectFemaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fWhoreRejectFemaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fWhoreRejectFemaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fWhoreRejectFemaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fWhoreRejectFemaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fWhoreRejectFemaleDeviceChance * 10.0) as Int
		else
			iRejectAcceptChance = (fWhoreRejectMaleAcceptChance * 10.0) as Int
			iRejectReportChance = (fWhoreRejectMaleReportChance * 10.0) as Int
			iRejectTheftChance = (fWhoreRejectMaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fWhoreRejectMaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fWhoreRejectMaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fWhoreRejectMaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fWhoreRejectMaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fWhoreRejectMaleDeviceChance * 10.0) as Int
		endif
		bRejectTheftOnlyGold = bWhoreRejectTheftOnlyGold
		iEntrapmentLevel = iWhoreRejectEntrapmentLevel
	elseif bBeggar
		if bFemaleNPC
			iRejectAcceptChance = (fBeggarRejectFemaleAcceptChance * 10.0) as Int
			iRejectReportChance = 0
			iRejectTheftChance = (fBeggarRejectFemaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fBeggarRejectFemaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fBeggarRejectFemaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fBeggingFemaleRapistChance * 10.0) as Int
			iRejectMurderChance = (fBeggarRejectFemaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fBeggarRejectFemaleDeviceChance * 10.0) as Int
		else
			iRejectAcceptChance = (fBeggarRejectMaleAcceptChance * 10.0) as Int
			iRejectReportChance = 0
			iRejectTheftChance = (fBeggarRejectMaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fBeggarRejectMaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fBeggarRejectMaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fBeggingMaleRapistChance * 10.0) as Int
			iRejectMurderChance = (fBeggarRejectMaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fBeggarRejectMaleDeviceChance * 10.0) as Int
		endif
		bRejectTheftOnlyGold = bBeggarRejectTheftOnlyGold
		iEntrapmentLevel = iBeggarRejectEntrapmentLevel
	else
		if bFemaleNPC
			iRejectAcceptChance = (fDefaultRejectFemaleAcceptChance * 10.0) as Int
			iRejectReportChance = 0
			iRejectTheftChance = (fDefaultRejectFemaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fDefaultRejectFemaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fDefaultRejectFemaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fDefaultRejectFemaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fDefaultRejectFemaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fDefaultRejectFemaleDeviceChance * 10.0) as Int
		else
			iRejectAcceptChance = (fDefaultRejectMaleAcceptChance * 10.0) as Int
			iRejectReportChance = 0
			iRejectTheftChance = (fDefaultRejectMaleTheftChance * 10.0) as Int
			iRejectAssaultChance = (fDefaultRejectMaleAssaultChance * 10.0) as Int
			iRejectSlaveryChance = (fDefaultRejectMaleSlaveryChance * 10.0) as Int
			iRejectRapeChance = (fDefaultRejectMaleRapeChance * 10.0) as Int
			iRejectMurderChance = (fDefaultRejectMaleMurderChance * 10.0) as Int
			iRejectDeviceChance = (fDefaultRejectMaleDeviceChance * 10.0) as Int
		endif
		bRejectTheftOnlyGold = bDefaultRejectTheftOnlyGold
		iEntrapmentLevel = iDefaultRejectEntrapmentLevel
	endif

	if !bIsDDExpansionActive || !bIsDDIntegrationActive
		iRejectDeviceChance = 0
	endif

	if akActor.isGuard() && !bGuardsAreCruel
		iRejectTheftChance = 0
		iRejectAssaultChance = 0
		iRejectSlaveryChance = 0
		iRejectRapeChance = 0
		iRejectMurderChance = 0
	endif

	if !bCanAssault(akActor)
		iRejectAssaultChance = 0
		iRejectSlaveryChance = 0
		iRejectMurderChance = 0 
	endif

	if (bApproach || !akActor.GetCrimeFaction())
		iRejectReportChance = 0
	endif

	int[] resultWeights = new int[9]
	resultWeights[0] = iRejectAcceptChance
	resultWeights[1] = iRejectReportChance
	resultWeights[2] = iRejectTheftChance
	resultWeights[3] = iRejectAssaultChance
	resultWeights[4] = iRejectSlaveryChance
	resultWeights[5] = iRejectRapeChance
	resultWeights[6] = minInt(iRejectRapeChance,iRejectTheftChance)
	resultWeights[7] = iRejectMurderChance
	resultWeights[8] = iRejectDeviceChance
	iRand = weightedRandInt(resultWeights)

	if (iRand == 3) ;Assault
		bRejectAssaultRape = (randInt(0, 999) < iRejectRapeChance)
		bRejectAssaultTheft = (randInt(0, 999) < iRejectTheftChance)
	elseif (iRand == 4) ;Slavery
		bRejectAssaultTheft = (randInt(0, 999) < iRejectTheftChance)
	endif

	iWhoringRejectResult = maxInt(0, iRand)
	bRejectWhore = bWhore
	bRejectDibel = bDibel
	bRejectBeggar = bBeggar
	bRejectApproach = bApproach
	bIsBusy = false
endfunction

Function rejectCusomer(Actor akCustomer)
	gotostate("rejecting")
	bIsBusy = true
	int iWhatToDo
	if bRejectDibel
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
	elseif bRejectWhore
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
	elseif bRejectBeggar
		iTotalCustomerPaidGold = player.getItemCount(Gold)
	endif
	iWhatToDo = iWhoringRejectResult
	if akCustomer.IsInFaction(DibelCustomerFaction)
		clearDibelCustomers()
		clearDibelPositions()
	endif
	if akCustomer.IsInFaction(WhoreCustomerFaction)
		clearWhoreCustomers() 
		clearWhorePositions()
	endif 
	if akCustomer && bIsPapyrusUtilActive
		ActorUtil.RemovePackageOverride(akCustomer, customerForceGreetAgainPackage)
		ActorUtil.RemoveAllPackageOverride(customerForceGreetAgainPackage)
	endif
	if (iWhatToDo == 0)
		if !bRejectBeggar && !bRejectApproach && (iTotalCustomerPaidGold > 0)
			debug.sendanimationevent(player, "IdleGive")
			utility.wait(1.0)
			player.removeItem(gold, iTotalCustomerPaidGold, false, akCustomer)
		endif
	elseif iWhatToDo == 1
		iTotalCrimes = iTotalCrimes + 1
		if bRejectDibel
			if !isSnitchOK(angryDibelCustomer)
				angryDibelCustomer = akCustomer
				if (randInt(0, 999) < iRejectDeviceChance)
					entrapPlayer(akCustomer)
				endif
			endif
		elseif bRejectWhore
			if !isSnitchOK(angryWhoreCustomer)
				angryWhoreCustomer = akCustomer
				if (randInt(0, 999) < iRejectDeviceChance)
					entrapPlayer(akCustomer)
				endif
			endif
		endif
	elseif iWhatToDo == 2
		if akCustomer.IsOnMount()
			akCustomer.Dismount()
			Utility.wait(3.0)
		endif
		debug.sendanimationevent(akCustomer, "idleforcedefaultstate")
		utility.wait(1.0)
		debug.sendanimationevent(akCustomer, "IdleTake")
		utility.wait(0.5)
		StaggerSpell.Cast(player)
		stealFromPlayer(akCustomer)
	elseif (iWhatToDo == 3 || iWhatToDo == 4 || iWhatToDo == 7)
		AssaultPlayer(akCustomer, (iWhatToDo == 4), bRejectAssaultRape, bRejectAssaultTheft, (iWhatToDo == 7))
	elseif iWhatToDo == 5
		rapePlayer(akCustomer)
	elseif iWhatToDo == 6
		if akCustomer.IsOnMount()
			akCustomer.Dismount()
			Utility.wait(3.0)
		endif
		debug.sendanimationevent(akCustomer, "idleforcedefaultstate")
		utility.wait(1.0)
		debug.sendanimationevent(akCustomer, "IdleTake")
		utility.wait(0.5)
		StaggerSpell.Cast(player)
		stealFromPlayer(akCustomer)
		Utility.wait(0.5)
		rapePlayer(akCustomer)
	elseif iWhatToDo == 8
		entrapPlayer(akCustomer)
	endif
	ApproachDelaySpell.cast(akCustomer)
	iWhoringRejectResult = -1
	bRejectOrgasm = False
	bIsBusy = false
	gotostate("")
EndFunction

Function SetFaceToFace(Actor akActor1, Actor akActor2, float fDistance = 75.0)
	akActor1.setposition(akActor2.GetPositionX() + fDistance * math.sin(akActor2.GetAngleZ()), akActor2.GetPositionY() + fDistance * math.cos(akActor2.GetAngleZ()), akActor2.GetPositionZ())
	akActor1.SetAngle(akActor2.GetAngleX(), akActor2.GetAngleY(), akActor2.GetAngleZ() + 180)
EndFunction

Function AssaultPlayer(Actor akAssaulter, Bool bEnslave = false, Bool bRape = false, Bool bSteal = false, Bool bMurder = False)
	log(akAssaulter.getdisplayname() + " assaulting player.")
	bEnslave && log(akAssaulter.getdisplayname() + " want to enslave player.")
	bRape && log(akAssaulter.getdisplayname() + " want to rape player.")
	bSteal && log(akAssaulter.getdisplayname() + " want to steal from player.")
	bMurder && log(akAssaulter.getdisplayname() + " want to murder player.")
	Debug.SetGodMode(true)
	Game.setPlayerAiDriven(true)
	if akAssaulter.IsOnMount()
		akAssaulter.Dismount()
		Utility.wait(3.0)
	endif
	If bIsPO3ExtenderActive
		PO3_SKSEFunctions.PreventActorDetection(akAssaulter)
		PO3_SKSEFunctions.PreventActorDetection(akAssaulter)
	Endif
	debug.sendanimationevent(akAssaulter, "idleforcedefaultstate")
	utility.wait(1.0)
	akAssaulter.SetDontMove(true)
	if bSteal
		debug.sendanimationevent(akAssaulter, "IdleTake")
		utility.wait(0.5)
		StaggerSpell.Cast(player)
		stealFromPlayer(akAssaulter)
		Debug.SetGodMode(true)
		Game.setPlayerAiDriven(true)
		akAssaulter.SetDontMove(true)
	endif
	utility.wait(0.5)
	forceRefAndPackageTo(akAssaulter, Assaulter, drawWeaponPackage)
	(akAssaulter as Actor).EvaluatePackage()
	utility.wait(0.5)
	form weap = akAssaulter.GetEquippedObject(1)
	Float fDamage = 25.0
	Int weapType = 0
	if weap as Weapon
		if weap == unArmed
			weapType = 1
		elseif weap.HasKeywordstring("WeapTypeBow")
			weapType = 2
		else
			weapType = 3
		endif
	endif
	if bMurder
		if (weaptype != 3) || (weap as Weapon).GetEnchantment()
			akAssaulter.additem(assaultDagger, 1, true)
			utility.wait(0.5)
			akAssaulter.EquipItemEx(assaultDagger, 1, true, false)
		endif
	else
		if weapType > 0
			if (bEnslave || (weapType == 2) || ((weapType == 3) && (weap as Weapon).GetEnchantment()) || randInt(0, 1))
				akAssaulter.UnequipItemEx(weap, 1, true)
			else
				fDamage = 50.0
			endif
		endif
	endif
	float fReach = 100.0 
	if (akAssaulter.GetEquippedObject(1) as Weapon)
		fReach = maxInt(50, ((akAssaulter.GetEquippedObject(1) as Weapon).GetReach() * 100.0) as Int)
	endif
	setFaceToFace(Player, akAssaulter, maxInt(50, (fReach - 20.0) as Int))
	akAssaulter.SetLookAt(player)
	utility.wait(1.5)
	if !akAssaulter.isWeaponDrawn()
		forceRefAndPackageTo(akAssaulter, Assaulter, drawWeaponPackage)
		(akAssaulter as Actor).EvaluatePackage()
		akAssaulter.DrawWeapon()
		utility.wait(1.5)
	endif
	bAssaulted = False
	float fwaitedTime = 0.0
	float fAttackTime = -1.0
	sendModEvent("SPP_StartDetectAssault")
	Debug.sendAnimationEvent(akAssaulter, "attackStart")
	Bool isAttacking = akAssaulter.GetAnimationVariableBool("IsAttacking")
	While !bAssaulted && (fWaitedTime < 9.0)
		if isAttacking
			if fAttackTime < 0.0
				fAttackTime = fWaitedTime
			elseif (fWaitedTime - fAttackTime) > 3.0
				fReach = 100.0
				if akAssaulter.GetEquippedObject(1) != assaultDagger
					akAssaulter.additem(assaultDagger, 1, true)
					utility.wait(0.5)
					akAssaulter.EquipItemEx(assaultDagger, 1, true, false)
					utility.wait(1.5)
				endif
				if (akAssaulter.GetEquippedObject(1) as Weapon)
					fReach = maxInt(50, ((akAssaulter.GetEquippedObject(1) as Weapon).GetReach() * 100.0) as Int)
				endif
				setFaceToFace(Player, akAssaulter, maxInt(50, (fReach - 5.0) as Int))
				utility.wait(0.5)
				if !akAssaulter.isWeaponDrawn()
					forceRefAndPackageTo(akAssaulter, Assaulter, drawWeaponPackage)
					akAssaulter.EvaluatePackage()
					akAssaulter.DrawWeapon()
					utility.wait(1.5)
				endif
				fAttackTime = fWaitedTime + 0.2
				isAttacking = false
			endif
			utility.wait(0.2)
			fWaitedTime += 0.2
		else
			isAttacking = akAssaulter.GetAnimationVariableBool("IsAttacking")
			if !isAttacking
				Debug.sendAnimationEvent(akAssaulter, "attackStart")
				utility.wait(0.2)
				fWaitedTime += 0.2
			endif
		endif
	endWhile
	sendModEvent("SPP_StopDetectAssault")
	utility.wait(0.5)
	if (bMurder || bEnslave) && struggleToEscape(akAssaulter, player)
		log("Player won the struggle and won't be murdered or enslaved.")
		bMurder = False
		bEnslave = False
	endif 
	if bMurder
		Game.setPlayerAiDriven(false)
		player.SetDontMove(false)
		Debug.SetGodMode(false)
		if bAssaulted && player.GetActorValue("Health") >= 0.0 
			player.DamageActorValue("Health", player.GetActorValue("Health") + 30)
		endif
		Assaulter.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(akAssaulter, drawWeaponPackage)
		if akAssaulter.isInCombat()
			akAssaulter.StopCombat()
			akAssaulter.StopCombatAlarm()
		endif
		akAssaulter.SetDontMove(false)
		akAssaulter.ClearLookAt()
		akAssaulter.UnequipItemEx(assaultDagger)
		utility.wait(0.5)
		akAssaulter.RemoveItem(assaultDagger, akAssaulter.GetItemCount(assaultDagger), true)
		utility.wait(0.5)
		if weap && (weap != unArmed) && (akAssaulter.GetEquippedObject(1) != weap)
			akAssaulter.equipItemEx(weap, 1)
			utility.wait(0.5)
		endif
		If bIsPO3ExtenderActive
			PO3_SKSEFunctions.ResetActorDetection(akAssaulter)
		Endif
		akAssaulter.EvaluatePackage() 
		return
	elseif bAssaulted
		StaggerSpell.Cast(player)
	endif
	utility.wait(4.0)
	if akAssaulter.isInCombat()
		akAssaulter.StopCombat()
		akAssaulter.StopCombatAlarm()
	endif
	if akAssaulter.getItemCount(assaultDagger) > 0
		akAssaulter.RemoveItem(assaultDagger, akAssaulter.GetItemCount(assaultDagger), true)
		utility.wait(0.5)
	endif
	if weap && (weap != unArmed) && (fDamage == 50.0) && (akAssaulter.GetEquippedObject(1) != weap)
		akAssaulter.equipItemEx(weap, 1)
		utility.wait(0.5)
	endif
	akAssaulter.ClearLookAt()
	If bIsPO3ExtenderActive
		PO3_SKSEFunctions.ResetActorDetection(akAssaulter)
	Endif
	if !bEnslave && bRape
		Game.setPlayerAiDriven(false)
		player.SetDontMove(true)
		Assaulter.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(akAssaulter, drawWeaponPackage)
		akAssaulter.EvaluatePackage()
		player.SetDontMove(false)
		akAssaulter.SetDontMove(false)
		rapePlayer(akAssaulter)
	else
		Assaulter.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(akAssaulter, drawWeaponPackage)
		akAssaulter.SetDontMove(false)
		akAssaulter.EvaluatePackage()
	endif
	if bEnslave
		Game.setPlayerAiDriven(false)
		Debug.SetGodMode(false)
		sendModEvent("SSLV Entry")
	else
		Float fOldHP = player.GetActorValue("Health")
		Float fNewHP = maxFloat(100.0 - fDamage, (player.GetBaseActorValue("Health") * ((100.0 - fDamage)/ 100.0)))
		if fOldHP > fNewHP
			player.DamageActorValue("Health", fOldHP - fNewHP)
		endif
		Game.setPlayerAiDriven(false)
		Debug.SetGodMode(false)
	endif
endFunction

Bool Function stealFromPlayer(Actor Thief)
	log(Thief.getdisplayname() + " stealing from player.")
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
		log(Thief + " : " + Thief.GetDisplayName() + " stole " + iGoldToRemove + " septim.")
		bRobbed = true
	endif
	Form[] QuestItemsArr
	if !bRejectTheftOnlyGold && ((iGoldToRemove < iTotalCustomerPaidGold) || (randInt(0, 999) < maxInt(500, 1000 - iRejectTheftChance)))
		itemToRob = player.GetWornForm(Armor.GetMaskForSlot(32))
		if itemToRob && !hasInvalidKeyword(itemToRob) && (itemToRob.GetGoldValue() > 0)
			player.removeItem(itemToRob, 1, false, Thief)
			log(Thief + " : " + Thief.GetDisplayName() + " stole " + itemToRob)
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
						elseif hasInvalidKeyword(itemToRob)
						else
							if itemToRob.GetGoldValue() > 0
								player.removeItem(itemToRob, 1, false, Thief)
								log(Thief + " : " + Thief.GetDisplayName() + " stole " + itemToRob)
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
		if !bRejectTheftOnlyGold && (!bRobbed ||  (randInt(0,999) < maxInt(500, 1000 - iRejectTheftChance))) ; The lower the chance, the less likely theft will happen, so it should be a good theft.
			if bIsPyramidUtilsOK && bIsPapyrusUtilActive
				keyword[] forbidenkw
				form[] items = PyramidUtils.GetItemsByKeyword(player, forbidenkw)
				if forbidenArmorKeywords.length != 14
					forbidenArmorKeywords = new keyword[14]
					forbidenArmorKeywords[0] = keyword.GetKeyword("zad_inventorydevice")
					forbidenArmorKeywords[1] = keyword.GetKeyword("zzzmoa_ignoreitem")
					forbidenArmorKeywords[2] = keyword.GetKeyword("zzzmrt_ignoreitem_kwd")
					forbidenArmorKeywords[3] = keyword.GetKeyword("sos_underwear")
					forbidenArmorKeywords[4] = keyword.GetKeyword("zbfworndevice")
					forbidenArmorKeywords[5] = keyword.GetKeyword("zad_questitem")
					forbidenArmorKeywords[6] = keyword.GetKeyword("zad_lockable")
					forbidenArmorKeywords[7] = keyword.GetKeyword("sos_genitals")
					forbidenArmorKeywords[8] = keyword.GetKeyword("toystoy")
					forbidenArmorKeywords[9] = keyword.GetKeyword("vendornosale")
					forbidenArmorKeywords[10] = keyword.GetKeyword("magicdisallowenchanting")
					forbidenArmorKeywords[11] = keyword.GetKeyword("clothingpoor")
					forbidenArmorKeywords[12] = ProstituteClothing_kwd
					forbidenArmorKeywords[13] = BeggarClothing_kwd
				endif
				forbidenkw = forbidenArmorKeywords
				items = PyramidUtils.FilterFormsByKeyword(items, forbidenkw, false, true)
				items = PyramidUtils.FilterFormsByGoldValue(items, 1)
				Int iVal
				int j
				int i = 0
				itemToRob = None
				Int iNumToCheck = 10 ;check 10 random items and 10 sequenced items
				int iLen = items.Length
				int max = minInt(iLen, iNumToCheck)
				int k = randInt(0, maxInt(0, (iLen - iNumToCheck)))
				checkedItems.revert()
				while (i < max )
					j = randInt(0, iLen - 1) 
					if items[j] && !checkedItems.hasform(items[j])
						if (QuestItemsArr.find(items[j]) < 0) && (player.getItemCount(items[j]) > 0)
							if items[j].GetGoldValue() > iVal
								itemToRob = items[j]
								iVal = items[j].GetGoldValue()
							endif
						endif
						checkedItems.addform(items[j])
					endif
					if (k < iLen) && (k != j)
						if items[k] && !checkedItems.hasform(items[k])
							if (QuestItemsArr.find(items[k]) < 0) && (player.getItemCount(items[k]) > 0)
								if items[k].GetGoldValue() > iVal
									itemToRob = items[k]
									iVal = items[k].GetGoldValue()
								endif
							endif
							checkedItems.addform(items[k])
						endif
					endif
					i += 1
					k += 1
				endwhile
				if iVal > 0
					player.removeItem(itemToRob, 1, false, thief)
					log(Thief + " : " + Thief.GetDisplayName() + " stole " + itemToRob)
					bRobbed = true
				endif
				checkedItems.revert()
			endif
		endif
	EndIf
	if  (randInt(0, 999) < iRejectDeviceChance) || (!bRobbed && (iRejectDeviceChance > 0))
		entrapPlayer(Thief)
	endif
	return bRobbed
EndFunction

Function entrapPlayerBeggar(Actor akActor)
	if randInt(0, 999) < (fBeggarDeviceChance * 10.0) as Int
		iEntrapmentLevel = iBeggarEntrapmentLevel
		entrapPlayer(akActor)
	endif
EndFunction

Function entrapPlayer(Actor akEntrapper)
	log(akEntrapper.getdisplayname() + " is putting DD items on player.")
	Bool bAnimEntrapper = false
	if !bIsDDExpansionActive || !bIsDDIntegrationActive
		return
	elseif akEntrapper && (akEntrapper != player)
		actor dialogueTarget = getPlayerDialogueTarget(bIsPyramidUtilsOK)
		if (dialogueTarget && (dialogueTarget != akEntrapper))
			return
		endif
		bAnimEntrapper = (!isActorHavingSex(akEntrapper) && !isActorHavingSex(player) && !akEntrapper.GetCurrentScene() && (akEntrapper.GetSitState() != 3))
	endif
	Bool bWasBusy = false
	if bIsBusy
		bWasBusy = true
	else
		bIsBusy = true
	endif
	Debug.SetGodMode(true)
	Game.setPlayerAiDriven(true)
	if bAnimEntrapper
		if akEntrapper.IsOnMount()
			akEntrapper.Dismount()
			Utility.wait(3.0)
		endif
		Debug.sendAnimationEvent(akEntrapper, "idleforcedefaultstate")
		Utility.Wait(1.0)
		akEntrapper.SetDontMove(true)
		Utility.Wait(0.5)
		setFaceToFace(player, akEntrapper, 50.0)
		akEntrapper.SetLookAt(player)
		Utility.Wait(1.0)
		forceRefAndPackageTo(akEntrapper, entrapperAlias, entrapperPackage)
	endif
	Bool vagPlugged = DDX_Interface.isVaginallyPlugged(player)
	Bool anlPlugged = DDX_Interface.isAnallyPlugged(player)
	float fTimeStart = Utility.GetCurrentRealTime()
	Form  kDev = DDX_Interface.lockRandomDeviceOnActor(player, iEntrapmentLevel, iDeviceChanceArr, iDeviousDeviceSet - 1)
	Bool bResult = isFormValid(kDev)
	if bResult
		log(kDev.GetName() + " equipped.", True, False, 1)
	endif
	float fTimeEnd = Utility.GetCurrentRealTime()
	float fTotalTime = fTimeEnd - fTimeStart
	if bAnimEntrapper
		if (fTotalTime < 2.5)
			Utility.Wait(3.0 - fTotalTime)
		endif
		entrapperAlias.clear()
		if bIsPapyrusUtilActive
			ActorUtil.RemovePackageOverride(akEntrapper, entrapperPackage)
		endif
		akEntrapper.ClearLookAt()
		akEntrapper.EvaluatePackage()
		akEntrapper.SetDontMove(false)
	endif
	if bResult
		if (!vagPlugged && DDX_Interface.isVaginallyPlugged(player)) || (!anlPlugged && DDX_Interface.isAnallyPlugged(player))
			DDX_Interface.MoanAndPlayHornyAnimation(player)
		endif
	elseif randInt(0,1)
		DDX_Interface.InflateRandomPlug(player)
	endif
	Game.setPlayerAiDriven(false)
	Debug.SetGodMode(false)
	iEntrapmentLevel = 0
	if !bWasBusy
		bIsBusy = false
	endif
EndFunction

Bool Function hasInvalidKeyword(Form kItem)
	if (kItem.HasKeyword(ProstituteClothing_kwd) || kItem.HasKeyword(BeggarClothing_kwd))
	elseif kItem.HasKeywordString("clothingpoor")
	elseif kItem.HasKeywordString("vendornosale")
	elseif kItem.HasKeywordString("magicdisallowenchanting")
	elseif kItem.HasKeywordString("sos_underwear")
	elseif kItem.HasKeywordString("sos_genitals")
	elseif kItem.HasKeywordString("zad_questitem")
	elseif kItem.HasKeywordString("zad_lockable")
	elseif kItem.HasKeywordString("zad_inventorydevice")
	elseif kItem.HasKeywordString("zbfworndevice")
	elseif kItem.HasKeywordString("toystoy")
	elseif kItem.HasKeywordString("zzzmrt_ignoreitem_kwd")
	elseif kItem.HasKeywordString("zzzmoa_ignoreitem")
	else
		return false
	endif
	return true
endfunction

function ProstitutePlayerTo(Actor akCustomer, bool bAccept=true)
	setGlobalVaues()
	if akCustomer
		if (bAccept || (akCustomer.GetCurrentScene() == None))
			customerSpell.Cast(akCustomer, akCustomer)
		else
			String msg = akCustomer.getDisplayName() + " is busy."
			log(msg, true, false)
			Scene curScene = akCustomer.GetCurrentScene()
			log(msg + " | Scene: " + curScene + " | Quest: " + curScene.GetOwningQuest())
			return
		endif
		if !bAccept
			if !isSnitchOK(whoreSnitch) && !playerHasWhoreLicense()
				checkSnitch(akCustomer, false, false)
			endif
			if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
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
		if (bAccept || (akActor.GetCurrentScene() == None))
			customerSpell.Cast(akActor, akActor)
		else
			String msg = akActor.getDisplayName() + " is busy."
			log(msg, True, False, 1)
			Scene curScene = akActor.GetCurrentScene()
			log(msg + " | Scene: " + curScene + " | Quest: " + curScene.GetOwningQuest())
			return
		endif
		if !bAccept
			if !isSnitchOK(dibelSnitch) && !playerHasDibelLicence()
				checkSnitch(akActor)
			endif
			if randInt(0, 999) < (fSLSFR_Talk_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_Talk_MinGainFame as Int, fSLSFR_Talk_MaxGainFame as Int)
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
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias2.getActorReference()
	if Customer
		dibelCustomerAlias2.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias3.getActorReference()
	if Customer
		dibelCustomerAlias3.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias4.getActorReference()
	if Customer
		dibelCustomerAlias4.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias.getActorReference()
	if Customer
		whoreCustomerAlias.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias2.getActorReference()
	if Customer
		whoreCustomerAlias2.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias3.getActorReference()
	if Customer
		whoreCustomerAlias3.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias4.getActorReference()
	if Customer
		whoreCustomerAlias4.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	whoreCustomerList.revert()
	dibelCustomerList.Revert()
	iTotalWhoreCustomers = 0
	iTotalDibelCustomers = 0
	iPaidGoldDibelCustomer1 = 0
	iPaidGoldDibelCustomer2 = 0
	iPaidGoldDibelCustomer3 = 0
	iPaidGoldDibelCustomer4 = 0
	iPaidGoldAllDibelCustomers = 0
	iPaidGoldCustomer1 = 0
	iPaidGoldCustomer2 = 0
	iPaidGoldCustomer3 = 0
	iPaidGoldCustomer4 = 0
	iPaidGoldAllCustomers = 0
	bWhoreClientNotPaid = False
	bDibelClientNotPaid = False
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
EndFunction

Function clearDibelCustomers()
	Actor Customer = dibelCustomerAlias.getActorReference()
	if Customer
		dibelCustomerAlias.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias2.getActorReference()
	if Customer
		dibelCustomerAlias2.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias3.getActorReference()
	if Customer
		dibelCustomerAlias3.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = dibelCustomerAlias4.getActorReference()
	if Customer
		dibelCustomerAlias4.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	dibelCustomerList.Revert()
	iTotalDibelCustomers = 0
	iPaidGoldDibelCustomer1 = 0
	iPaidGoldDibelCustomer2 = 0
	iPaidGoldDibelCustomer3 = 0
	iPaidGoldDibelCustomer4 = 0
	iPaidGoldAllDibelCustomers = 0
	bDibelClientNotPaid = False
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
EndFunction

Function clearWhoreCustomers()
	Actor Customer = whoreCustomerAlias.getActorReference()
	if Customer
		whoreCustomerAlias.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias2.getActorReference()
	if Customer
		whoreCustomerAlias2.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias3.getActorReference()
	if Customer
		whoreCustomerAlias3.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	Customer = whoreCustomerAlias4.getActorReference()
	if Customer
		whoreCustomerAlias4.Clear()
		bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(Customer, FollowPackage)
		Customer.EvaluatePackage()
	endif
	whoreCustomerList.revert()
	iTotalWhoreCustomers = 0
	iPaidGoldCustomer1 = 0
	iPaidGoldCustomer2 = 0
	iPaidGoldCustomer3 = 0
	iPaidGoldCustomer4 = 0
	iPaidGoldAllCustomers = 0
	bWhoreClientNotPaid = False
	SLSFR_Interface.SLSFR_toggle_WhoreFlag(isPlayerDibeling() || isPlayerWhoring())
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
		RegisterForModEvent("SexLabOrgasmSeparate", "on_spp_sexlab_OrgasmSeparate")
		RegisterForModEvent("AnimationStart", "on_spp_sexlab_Sex_Start")
		RegisterForModEvent("OrgasmStart", "on_spp_sexlab_Orgasm")
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
	  RegisterForModEvent("ostim_start", "on_spp_ostim_Sex_Start")
	  RegisterForModEvent("ostim_orgasm", "on_spp_ostim_Orgasm")
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

Int function payBeggar(Actor beggar, Bool bBonus = True, Bool bOnlyCalc = False)
	Int minBonus = 0
	Int maxBonus = 0
	Float fSpeech
	if bBeggarPayUseBaseSpeech
		fSpeech = beggar.GetBaseActorValue("Speechcraft")
	else
		fSpeech = beggar.getActorValue("Speechcraft")
	endif
	if bBonus
		minBonus = maxInt(0, ((fSpeech * fMinSpeechBegBonusMult) As Int) + 1)
		maxBonus = maxInt(0, ((fSpeech * fMaxSpeechBegBonusMult) As Int) + 1)
		minBonus = minInt(minBonus,maxBonus)
		maxBonus = maxInt(minBonus,maxBonus)
	endif
	int begPayMin = minInt(fBegPayMin As Int, fBegPayMax As Int)
	int begPayMax = maxInt(fBegPayMin As Int, fBegPayMax As Int)
	Int totalPay = maxInt(0, randInt(begPayMin, BegPayMax) + randInt(minBonus, maxBonus))
	totalPay = maxInt(0, totalPay)
	if !bOnlyCalc
		beggar.Additem(gold, totalPay)
	endif
	return totalPay
endfunction

Int function payDibel(Actor Dibel, int position, bool bSentByTemple = false)
	Float fSpeech
	if bDibelPayUseBaseSpeech
		fSpeech = Dibel.GetBaseActorValue("Speechcraft")
	else
		fSpeech = Dibel.getActorValue("Speechcraft")
	endif
	Int minBonus = maxInt(0, ((fSpeech * fMinSpeechDibelBonusMult) As Int) + 1)
	Int maxBonus = maxInt(0, ((fSpeech * fMaxSpeechDibelBonusMult) As Int) + 1)
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
	if bSentByTemple
		totalPay += randInt(fTempleClientMinExtraPay as Int, fTempleClientMaxExtraPay as Int)
	endif
	totalPay = maxInt(0, totalPay)
	if bDibelPayAfterSex
		if !bSentByTemple && (randInt(0, 999) < (fDibelNotPayChance * 10) as Int)
			totalPay = 0
			bDibelClientNotPaid = True
		else
			iDibelClientsPayment = iDibelClientsPayment + totalPay
		endif
	else
		Dibel.Additem(gold, totalPay)
	endif
	return totalPay
endfunction

Function giveTempleQuestReward()
	Player.additem(gold, randint(fTempleClientMinExtraPay as Int, fTempleClientMaxExtraPay as Int))
	addDibelMarkToPlayer(fDibelTempleMarkChance, 1, fTempleMinMarkReward as Int, fTempleMaxMarkReward as Int)
	addExtraRewardsToPlayer(fDibelTempleExtraRewardChance, fDibelTempleExtraRewardEnchantedChance, randInt(fDibelTempleMinExtraReward as Int, fDibelTempleMaxExtraReward as Int))
endfunction

Int function payWhore(actor whore, int position)
	int totalPay = 0
	float fSpeech
	Actor ownerActor = getOwner() as Actor
	Bool bMayNotpay = (!bWhoreNotPayOnlyIfAlone || !(ownerActor && (ownerActor != player) && (ownerActor.getParentCell() == player.getParentCell())))
	if !isWhoringAllowedInCurrentLocation
		totalPay = payBeggar(whore, True, bWhorePayAfterSex)
		if bWhorePayAfterSex
			if bMayNotpay && (randInt(0, 999) < (fWhoreNotPayChance * 10) as Int)
				totalPay = 0
				bWhoreClientNotPaid = True
			else
				iWhoreClientsPayment = iWhoreClientsPayment + totalPay
			endif
		endif
		return totalPay
	endif
	if bWhorePayUseBaseSpeech
		fSpeech = whore.GetBaseActorValue("Speechcraft")
	else
		fSpeech = whore.getActorValue("Speechcraft")
	endif
	Int minBonus = maxInt(0, ((fSpeech * fMinSpeechWhoreBonusMult) As Int) + 1)
	Int maxBonus = maxInt(0, ((fSpeech * fMaxSpeechWhoreBonusMult) As Int) + 1)
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
	if  (InnWorkScript.isPlayerInDebt() && InnWorkScript.innWorkOwnerHere())
		if bWhorePayAfterSex
			if bMayNotpay && (randInt(0, 999) < (fWhoreNotPayChance * 10) as Int)
				totalPay = 0
				bWhoreClientNotPaid = True
			else
				iWhoreClientsPayment = iWhoreClientsPayment + totalPay
			endif
		else
			log(totalPay + " septim added to " + InnWorkScript.InnOwner.GetActorReference().getDisplayName(), true, true, 0)
			InnWorkScript.updateDebt(-1 * totalPay)
		endif
	elseif !bWhorePayAfterSex && (fWhoreOwnerShare > 0.0) && ownerActor && (ownerActor != player) && (ownerActor.getParentCell() == whore.getParentCell())
		iCurrentOwnerSeptims = iCurrentOwnerSeptims + totalPay
		currentOwnerSeptimDisplay.SetValueInt(iCurrentOwnerSeptims)
		UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
		pimpTracker.UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
		log(totalPay + " septim added to " + ownerActor.getDisplayName(), true, true, 0)
	elseif isWhoringAlwaysAllowedInCurrentLocation || (ownerActor && (ownerActor.getParentCell() == whore.getParentCell()))
		if bWhorePayAfterSex
			if bMayNotpay && (randInt(0, 999) < (fWhoreNotPayChance * 10) as Int)
				totalPay = 0
				bWhoreClientNotPaid = True
			else
				iWhoreClientsPayment = iWhoreClientsPayment + totalPay
			endif
		else
			whore.Additem(gold, totalPay)
		endif
	else
		totalPay = payBeggar(whore, True, bWhorePayAfterSex)
		if bWhorePayAfterSex
			if bMayNotpay && (randInt(0, 999) < (fWhoreNotPayChance * 10) as Int)
				totalPay = 0
				bWhoreClientNotPaid = True
			else
				iWhoreClientsPayment = iWhoreClientsPayment + totalPay
			endif
		endif
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
	WhoreFailureChance.SetValueInt(maxInt(0, (100.0 - fWhorePersuadeChance) as Int))
	DibelFailureChance.SetValueInt(maxInt(0, (100.0 - fDibelPersuadeChance) as Int))
	BeggarFailureChance.SetValueInt(maxInt(0, (100.0 - fBeggarPersuadeChance) as Int))
	BeggarNoSexOfferChance.SetValueInt(maxInt(0, (100.0 - fBeggarSexOfferChance) as Int))
	maxApproachDistance.SetValueInt(fMaxApproachDistance as Int)
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

Int Function positionChooserByMenu(Bool bVaginalPosition = True)
	Int iPos = -1
	bShowVaginalInPositionMenu = bVaginalPosition
	While iPos == -1
		iPos = positionMenu.show()
	endWhile
	return iPos
endfunction

Bool Function bCheckPapyrusUtil()
	return papyrusutil.GetVersion() >= 30
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

Bool Function bCheckAELStruggle()
	return AELStruggle.Get() as Bool
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

	if !npc || (npc == player) || (Snitch && !Snitch.isDead() && snitch.GetCrimeFaction())
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
				log(npc.GetDisplayName() + " (" + npc + ") wants to snitch on player.")
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
			log(npc.GetDisplayName() + " (" + npc + ") wants to snitch on player.")
			Return True
		endif
	endif
	Return False
EndFunction

Bool function bCanSnitch(Actor npc, Bool bComplete = true)
	if !npc
		return False
	endif
	if npc.isDead() || npc.isDisabled()
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
	return snitch && !snitch.isDead() && snitch.getcrimefaction()
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

Bool function playerNeedWhoreLicense()
	return ((isDibel && bDibelNeedLicense) || bWhoreNeedLicense)
endFunction

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
			RegisterForSingleUpdateGameTime(randInt(4,8) As Float)
		endif
	endif
	if snitch
		if snitch.getcrimefaction()
			String msg
			if (iTotalCrimes > 1) && ((snitch == angryDibelCustomer) || (snitch == angryWhoreCustomer))
				msg = "You have been reported to the guards."
			elseif snitch.GetDisplayName()
				msg = snitch.GetDisplayName() + " reported you."
			elseif snitch.GetLeveledActorBase().GetName()
				msg = snitch.GetLeveledActorBase().GetName() + " reported you."
			else
				msg = "Someone reported you."
			endif
			log(msg, True, False, 2)
			log(msg + " (" + snitch + ")")
			if ((snitch == angryDibelCustomer) || (snitch == angryWhoreCustomer)) || !LicensesInterface.bFlagWhoreViolation()
				if !player.GetCurrentLocation() || !player.GetCurrentLocation().HasKeywordstring("loctypejail")
					if iTotalCrimes > 0
						snitch.getcrimefaction().ModCrimeGold(minInt(1000000, iTotalCrimes * iCrimeBounty))
						iTotalCrimes = 0
					else
						snitch.getcrimefaction().ModCrimeGold(iCrimeBounty)
					endif
				endIf
			endif
		endif
		iTotalCrimes = 0
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

Bool Function IsExcludable(Actor npc)
	if !npc
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

Form Function getOwner()
	Form ownerRef = player as Form
	if Owner
		ownerRef = Owner.getReference()
		if !isFormValid(ownerRef) || (ownerRef as Actor).isDead()
			owner.clear()
			if pimpTracker.isRunning()
				pimpTracker.setstage(10)
			endif
			ownerRef = player as Form
		endif
	else
		if pimpTracker.isRunning()
			pimpTracker.setstage(10)
		endif
	endif
	return ownerRef
endFunction

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

Bool function bCanReceiveAnyPerkReward()
	Int iZeroIndex
	if !MCMScript.bWhoreOralPerkRewardReceived
		iZeroIndex = iWhoreOralStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	if !MCMScript.bWhoreAnalPerkRewardReceived
		iZeroIndex = iWhoreAnalStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	if !MCMScript.bWhoreVaginalPerkRewardReceived
		iZeroIndex = iWhoreVaginalStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	if !MCMScript.bDibelOralPerkRewardReceived
		iZeroIndex = iDibelOralStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	if !MCMScript.bDibelAnalPerkRewardReceived
		iZeroIndex = iDibelAnalStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	if !MCMScript.bDibelVaginalPerkRewardReceived
		iZeroIndex = iDibelVaginalStatArr.Find(0)
		if (iZeroIndex < 0) || (iZeroIndex > (iTotalRaces - 2))
			return True
		endif
	endif
	return False
endFunction

Function checkPerkRewards()
	if bCanReceiveAnyPerkReward()
		log("Perk reward is Available.", true, true, 1)
	endif
endfunction

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

function addDibelMarkToPlayer(float fChance, int iNumPartners = 1, int iMinAmount = 1, int iMaxAmount = 1)
	Int iAmount = 0
	int iIndex = iNumPartners
	while iIndex > 0
		iIndex -= 1
		if (randInt(0,999) / 10.0) < fChance as Int
			iAmount = iAmount + randInt(iMinAmount, iMaxAmount)
		endif
	endWhile
	if iAmount > 0
		player.Additem(dibelMark, iAmount, true)
		log(iAmount + " dibella mark added.", true, true, 0)
	endif
endFunction

Event OnInit()
EndEvent

Bool function isCheckingIntegrations()
	if !FlowerGirlsInterface.bChecked
	elseif !SexLabInterface.bChecked
	elseif !OStimInterface.bChecked
	elseif !LicensesInterface.bChecked
	elseif !DDI_Interface.bChecked
	elseif !DDX_Interface.bChecked
	elseif !SLSFR_Interface.bChecked
	elseif !SLA_Interface.bChecked
	elseif !SLHH_Interface.bChecked
	else
		return False
	endif
	return True
endfunction

event onUpdate()
EndEvent

Event OnUpdateGameTime()
	snitch()
endEvent

Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	if SexLabInterface.HasPlayer(argString)
		bNormalPCPartnerOrgasmed = False
	endif
endEvent

Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
	if SexLabInterface.HasPlayer(argString)
		bNormalPCPartnerOrgasmed = True
	endif
endevent
	
Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
	if player != (ActorRef as Actor)
		if SexLabInterface.HasPlayer(Thread as String)
			bNormalPCPartnerOrgasmed = true
		endif
	endif
endevent

Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	actor[] actorList = SexLabInterface.HookActors(argString)
	Bool hasplayer = SexLabInterface.HasPlayer(argString)
	Bool hasSpouse = False
	if hasplayer && actorList.Length > 1
		if actorList.Length == 2
			int i = 2
			while i > 0
				i -= 1
				if actorList[i] && (actorList[i] != player) && player.HasAssociation(spouse, actorList[i])
					hasSpouse = true
				endif
			endWhile
		endif
		if !hasSpouse
			startInfectingPlayer(getState(), actorList.Length - 1)
		endif
		if (!bNormalOnlyRewardIfPartnerOrgasmed || bNormalPCPartnerOrgasmed)
			if (!bNormalNoRewardWhenVictim || !SexLabInterface.isActorVictim(argString as Int, player))
				addDibelMarkToPlayer(fNormalMarkChance, actorList.Length - 1)
			endif
		endif
		bNormalPCPartnerOrgasmed = False
	endif
EndEvent

event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
EndEvent

Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	 ;No need to check for NPC scenes because NPC scenes aren't on main thread of OStim standalone.
	 bNormalPCPartnerOrgasmed = False
endEvent

Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
	if sender && (player != (sender as Actor))
		bNormalPCPartnerOrgasmed = True
	endif
endevent

Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
	actor[] actorList = OStimInterface.getActors()
	if actorList.Length > 1
		Bool hasPlayer = False ;useless check
		Bool hasSpouse = False
		int i = actorList.Length
		while i > 0
			i -= 1
			if actorList[i]
				if actorList[i] == player
					hasPlayer = true
				elseif (actorList.Length == 2) && player.HasAssociation(spouse, actorList[i])
					hasSpouse = true
				endif
			endif
		endWhile
		if hasPlayer
			if !hasSpouse
				StartInfectingplayer(getState(), actorList.Length - 1)
			endif
			if (!bNormalOnlyRewardIfPartnerOrgasmed || bNormalPCPartnerOrgasmed)
				if (!bNormalNoRewardWhenVictim || !OStimInterface.isActorVictim(player))
					addDibelMarkToPlayer(fNormalMarkChance, actorList.Length - 1)
				endif
			endif
			bNormalPCPartnerOrgasmed = False
		endif
	endif
endEvent

State Dibeling
	Event OnBeginState()
		bIsBusy = True
		isDibel = true
		bDibelClientOrgasmed = False
		isDibel_g.SetValueInt(1)
		SLSFR_Interface.SLSFR_toggle_WhoreEventFlag(true)
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
				if currentEscortClient && dibelCustomerList.hasform(currentEscortClient)
					bIsTempleClient = true ;to add dibel mark using temple chance
					currentEscortClient = None
				endif
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
		if iDibelClientsPayment > 0
			if !bDibelOnlyPayIfClientOrgasmed || bDibelClientOrgasmed
				player.Additem(gold, iDibelClientsPayment)
			endif
			iDibelClientsPayment = 0
		endif
		Bool bPunish = False
		if bDibelClientNotPaid
			log("Some Client(s) didn't pay.", True, true, 2)
			bDibelClientNotPaid = False
			bPunish = (randInt(0, 999) < (fDibelPunishByUnpayClientChance * 10) as Int)
		endif
		if (!bDibelClientOrgasmed || bPunish) && (origCustomersArr.length > 0)
		    !bDibelClientOrgasmed && log("Client not satisfied.", true, true, 2)
			if (bPunish || bDibelPunishIfClientNotOrgasmed)
				i = randint(0,origCustomersArr.length - 1)
				if origCustomersArr[i] as Actor
					Actor act = origCustomersArr[i] as Actor
					if act && !ReApproachQst.isRunning() && ReApproachScript.canPunishPlayer(act)
						ReApproachQst.start()
						forceRefAndPackageTo(act, ReApproachingAlias, customerForceGreetAgainPackage)
						ReApproachScript.bIsDibelCustomer = True
					endif
				endif
			endif
		endif
		bDibelClientOrgasmed = False
		clearDibelCustomers()
		clearDibelPositions()
		checkPerkRewards()
	EndEvent

	Event OnEndState()
		SLSFR_Interface.SLSFR_toggle_WhoreEventFlag(false)
		bIsBusy = False
	endEvent
	
	Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	endEvent
	
	Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
		if SexLabInterface.HasPlayer(argString)
			actor[] actorList = SexLabInterface.HookActors(argString)
			if actorList.length > 1
				int i = actorList.length
				while i > 0
					i -= 1
					if actorList[i] && isDibelCustomer(actorList[i])
						bDibelClientOrgasmed = true
						return
					endif
				endWhile
			endif
		endif
	endevent
	
	Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
		if player != (ActorRef as Actor)
			if isDibelCustomer(ActorRef as Actor) && SexLabInterface.HasPlayer(Thread as String)
				bDibelClientOrgasmed = true
			endif
		endif
	endevent

	Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	EndEvent

	event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
		if HasPlayer
			if ((!bDibelOnlyPayIfClientOrgasmed || bDibelClientOrgasmed) && !bDibelClientNotPaid)
				if bIsTempleClient
					addDibelMarkToPlayer(fDibelTempleMarkChance, 1, fTempleMinMarkReward as Int, fTempleMaxMarkReward as Int)
					addExtraRewardsToPlayer(fDibelTempleExtraRewardChance, fDibelTempleExtraRewardEnchantedChance, randInt(fDibelTempleMinExtraReward as Int, fDibelTempleMaxExtraReward as Int))
					if iDibelPartners > 1
						addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners - 1)
						addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners - 1)
					endif
					bIsTempleClient = False
				else
					addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
					addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners)
				endif
				dibellan_lust_qst_script.updateQuest(iDibelPartners)
			endif
			startInfectingPlayer(GetState(), iDibelPartners)
			bDibelAnimEnded = true
			if dibelCustomerlist.GetSize() == 0
				;if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				;	SLSFR_Interface.SLSFR_ManualWhoreFameGain()
				;endif
				if randInt(0, 999) < (fDibelDeviceChance * 10) as Int
					iEntrapmentLevel = iDibelEntrapmentLevel
					entrapPlayer(player)
				endif
				GoToState("")
			endif
			iDibelPartners = 0
		endif
	endEvent
	
	Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	endEvent
	
	Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
		if sender && (player != (sender as Actor))
			if isDibelCustomer(sender as Actor)
				bDibelClientOrgasmed = true
			endif
		endif
	endevent

	Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
		if ((!bDibelOnlyPayIfClientOrgasmed || bDibelClientOrgasmed) && !bDibelClientNotPaid)
			if bIsTempleClient
				addDibelMarkToPlayer(fDibelTempleMarkChance, 1, fTempleMinMarkReward as Int, fTempleMaxMarkReward as Int)
				addExtraRewardsToPlayer(fDibelTempleExtraRewardChance, fDibelTempleExtraRewardEnchantedChance, randInt(fDibelTempleMinExtraReward as Int, fDibelTempleMaxExtraReward as Int))
				if iDibelPartners > 1
					addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners - 1)
					addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners - 1)
				endif
				bIsTempleClient = False
			else
				addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
				addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners)
			endif
			dibellan_lust_qst_script.updateQuest(iDibelPartners)
		endif
		startInfectingPlayer(GetState(), iDibelPartners)
		bDibelAnimEnded = true
		if dibelCustomerlist.GetSize() == 0
			if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_MinGainFame as Int, fSLSFR_MaxGainFame as Int)
			endif
			if randInt(0, 999) < (fDibelDeviceChance * 10) as Int
				iEntrapmentLevel = iDibelEntrapmentLevel
				entrapPlayer(player)
			endif
			GoToState("")
		endif
		iDibelPartners = 0
	EndEvent

	event onUpdate()
		if ((!bDibelOnlyPayIfClientOrgasmed || bDibelClientOrgasmed) && !bDibelClientNotPaid)
			if bIsTempleClient
				addDibelMarkToPlayer(fDibelTempleMarkChance, 1, fTempleMinMarkReward as Int, fTempleMaxMarkReward as Int)
				addExtraRewardsToPlayer(fDibelTempleExtraRewardChance, fDibelTempleExtraRewardEnchantedChance, randInt(fDibelTempleMinExtraReward as Int, fDibelTempleMaxExtraReward as Int))
				if iDibelPartners > 1
					addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners - 1)
					addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners - 1)
				endif
				bIsTempleClient = False
			else
				addDibelMarkToPlayer(fDibelMarkChance, iDibelPartners)
				addExtraRewardsToPlayer(fDibelExtraRewardChance, fDibelExtraRewardEnchantedChance, iDibelPartners)
			endif
			dibellan_lust_qst_script.updateQuest(iDibelPartners)
		endif
		startInfectingPlayer(GetState(), iDibelPartners)
		bDibelAnimEnded = true
		if dibelCustomerlist.GetSize() == 0
			if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_MinGainFame as Int, fSLSFR_MaxGainFame as Int)
			endif
			if randInt(0, 999) < (fDibelDeviceChance * 10) as Int
				iEntrapmentLevel = iDibelEntrapmentLevel
				entrapPlayer(player)
			endif
			GoToState("")
		endif
		iDibelPartners = 0
		bDibelClientOrgasmed = true
	endEvent

	event OnUpdateGameTime()
		RegisterForSingleUpdateGameTime(1.0)
	endEvent

	function snitch()
	EndFunction

	Function offerDibelMarks(Actor akActor)
	endFunction
	
	Function rejectCusomer(Actor akCustomer)
	endfunction

EndState

State Whoring
	Event OnBeginState()
		bIsBusy = True
		isWhore = True
		bWhoreClientOrgasmed = False
		isWhore_g.SetValueInt(1)
		SLSFR_Interface.SLSFR_toggle_WhoreEventFlag(True)
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
		if iWhoreClientsPayment > 0
			if !bWhoreOnlyPayIfClientOrgasmed || bWhoreClientOrgasmed
				if  (InnWorkScript.isPlayerInDebt() && InnWorkScript.innWorkOwnerHere())
					log(iWhoreClientsPayment + " septim added to " + InnWorkScript.InnOwner.GetActorReference().getDisplayName(), true, true, 0)
					InnWorkScript.updateDebt(-1 * iWhoreClientsPayment)
				else
					Actor ownerActor = getOwner() As Actor
					if (fWhoreOwnerShare > 0.0) && ownerActor && (ownerActor != player) && (ownerActor.getParentCell() == player.getParentCell())
						iCurrentOwnerSeptims = iCurrentOwnerSeptims + iWhoreClientsPayment
						currentOwnerSeptimDisplay.SetValueInt(iCurrentOwnerSeptims)
						UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
						pimpTracker.UpdateCurrentInstanceGlobal(currentOwnerSeptimDisplay)
						log(iWhoreClientsPayment + " septim added to " + ownerActor.getDisplayName(), true, true, 0)
					else
						player.Additem(gold, iWhoreClientsPayment)
					endif
				endif
			endif
			iWhoreClientsPayment = 0
		endif
		Bool bPunish = False
		if bWhoreClientNotPaid
			log("Some Client(s) didn't pay.", True, true, 2)
			bWhoreClientNotPaid = False
			bPunish = (randInt(0, 999) < (fWhorePunishByUnpayClientChance * 10) as Int)
		endif
		if (!bWhoreClientOrgasmed || bPunish) && (origCustomersArr.length > 0)
		    !bWhoreClientOrgasmed && log("The client not satisfied.", True, true, 2)
			if (bPunish || bWhorePunishIfClientNotOrgasmed)
				i = randint(0,origCustomersArr.length - 1)
				if origCustomersArr[i] as Actor
					Actor act = origCustomersArr[i] as Actor
					if act && !act.isDead() && !act.isDisabled() && act.Is3DLoaded() && !ReApproachQst.isRunning()
						ReApproachQst.start()
						forceRefAndPackageTo(act, ReApproachingAlias, customerForceGreetAgainPackage)
						ReApproachScript.bIsDibelCustomer = False
					endif
				endif
			endif
		endif
		bWhoreClientOrgasmed = False
		clearWhoreCustomers()
		clearWhorePositions()
		checkPerkRewards()
	EndEvent

	Event OnEndState()
		SLSFR_Interface.SLSFR_toggle_WhoreEventFlag(false)
		bIsBusy = False
	EndEvent
	
	Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	endEvent

	Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
		if SexLabInterface.HasPlayer(argString)
			actor[] actorList = SexLabInterface.HookActors(argString)
			if actorList.length > 1
				int i = actorList.length
				while i > 0
					i -= 1
					if actorList[i] && isWhoreCustomer(actorList[i])
						bWhoreClientOrgasmed = true
						return
					endif
				endWhile
			endif
		endif
	endevent
	
	Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
		if player != (ActorRef as Actor)
			if isWhoreCustomer(ActorRef as Actor) && SexLabInterface.HasPlayer(Thread as String)
				bWhoreClientOrgasmed = true
			endif
		endif
	endevent
	
	Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	EndEvent

	event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
		if HasPlayer
			if ((!bWhoreOnlyPayIfClientOrgasmed || bWhoreClientOrgasmed) && !bWhoreClientNotPaid)
				addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
				addExtraRewardsToPlayer(fWhoreExtraRewardChance, fWhoreExtraRewardEnchantedChance, iWhorePartners)
			endif
			startInfectingPlayer(GetState(), iWhorePartners)
			bWhoreAnimEnded = true
			if whoreCustomerlist.GetSize() == 0
				;if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				;	SLSFR_Interface.SLSFR_ManualWhoreFameGain()
				;endif
				if randInt(0, 999) < (fWhoreDeviceChance * 10) as Int
					iEntrapmentLevel = iWhoreEntrapmentLevel
					entrapPlayer(player)
				endif
				GoToState("")
			endif
			iWhorePartners = 0
		endif
	endEvent
	
	Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	EndEvent
	
	Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
		if sender && (player != (sender as Actor))
			if isWhoreCustomer(sender as Actor)
				bWhoreClientOrgasmed = true
			endif
		endif
	endevent

	Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
		if ((!bWhoreOnlyPayIfClientOrgasmed || bWhoreClientOrgasmed) && !bWhoreClientNotPaid)
			addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
			addExtraRewardsToPlayer(fWhoreExtraRewardChance, fWhoreExtraRewardEnchantedChance, iWhorePartners)
		endif
		startInfectingPlayer(GetState(), iWhorePartners)
		bWhoreAnimEnded = true
		if whoreCustomerlist.GetSize() == 0
			if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_MinGainFame as Int, fSLSFR_MaxGainFame as Int)
			endif
			if randInt(0, 999) < (fWhoreDeviceChance * 10) as Int
				iEntrapmentLevel = iWhoreEntrapmentLevel
				entrapPlayer(player)
			endif
			GoToState("")
		endif
		iWhorePartners = 0
	EndEvent

	event onUpdate()
		if ((!bWhoreOnlyPayIfClientOrgasmed || bWhoreClientOrgasmed) && !bWhoreClientNotPaid)
			addDibelMarkToPlayer(fWhoreMarkChance, iWhorePartners)
			addExtraRewardsToPlayer(fWhoreExtraRewardChance, fWhoreExtraRewardEnchantedChance, iWhorePartners)
		endif
		startInfectingPlayer(GetState(), iWhorePartners)
		bWhoreAnimEnded = true
		if whoreCustomerlist.GetSize() == 0
			if randInt(0, 999) < (fSLSFR_FameGainChance * 10) as Int
				SLSFR_Interface.SLSFR_ManualWhoreFameGain(fSLSFR_MinGainFame as Int, fSLSFR_MaxGainFame as Int)
			endif
			if randInt(0, 999) < (fWhoreDeviceChance * 10) as Int
				iEntrapmentLevel = iWhoreEntrapmentLevel
				entrapPlayer(player)
			endif
			GoToState("")
		endif
		iWhorePartners = 0
		bWhoreClientOrgasmed = true
	endEvent

	event OnUpdateGameTime()
		RegisterForSingleUpdateGameTime(1.0)
	endEvent

	function snitch()
	EndFunction

	Function offerDibelMarks(Actor akActor)
	endFunction
	
	Function rejectCusomer(Actor akCustomer)
	endfunction

EndState

Auto State Init

	Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	endEvent

	Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
	endevent
	
	Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
	endevent
	
	Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	EndEvent

	event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
	endEvent
	
	Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	endEvent
	
	Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
	endevent

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
		While isCheckingIntegrations()
			Utility.wait(0.5)
		endWhile
		MCMScript.loadSettingsAtStart()
		SetVars()
		bIsBusy = False
	endevent

	function snitch()
	EndFunction

	Function offerDibelMarks(Actor akActor)
	endFunction
	
	Function rejectCusomer(Actor akCustomer)
	endfunction
EndState

State offeringToDibella

	Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	endEvent
	
	Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
	endevent
	
	Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
	endevent
	
	Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	EndEvent

	event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
		if HasPlayer
			STD_Script.cureActorSTDs(player, False)
			GoToState("")
		endif
	endEvent
	
	Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	endEvent
	
	Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
	endevent

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
	
	Function rejectCusomer(Actor akCustomer)
	endfunction
EndState

State raped

	Event on_spp_sexlab_Sex_Start(string eventName, string argString, float argNum, form sender)
	endEvent
	
	Event on_spp_sexlab_Orgasm(string eventName, string argString, float argNum, form sender)
	endevent
	
	Event on_spp_sexlab_OrgasmSeparate(Form ActorRef, Int Thread)
	endevent
	
	Event on_spp_sexlab_Sex_Ending(string eventName, string argString, float argNum, form sender)
	EndEvent

	event on_spp_sexlab_Sex_End(int tid, bool HasPlayer)
		if HasPlayer
			startInfectingPlayer("", iNumRapist)
			GoToState("")
		endif
	endEvent
	
	Event on_spp_ostim_Sex_Start(string eventName, string strArg, float numArg, Form sender)
	endEvent

	Event on_spp_ostim_Orgasm(String EventName, String sceneId, Float index, Form Sender)
	endevent

	Event on_spp_ostim_Sex_End(string eventName, string argString, float argNum, form sender)
		startInfectingPlayer("", iNumRapist)
		GoToState("")
	EndEvent

	event onUpdate()
		startInfectingPlayer("", iNumRapist)
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
	
	Function rejectCusomer(Actor akCustomer)
	endfunction

EndState

State rejecting
	Function rejectCusomer(Actor akCustomer)
	endfunction
endstate

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
	If !(akAggressor as actor)
		return
	endif
	if akAggressor.IsOnMount()
		akAggressor.Dismount()
		Utility.wait(3.0)
	endif
	if bIs_SLHH_Active
		if isPlayerGettingHarassed()
			return
		endif
		if (!akAggressor.IsOnMount() && (akAggressor.GetSitState() == 0))
			Bool isFemale = akAggressor.GetLeveledActorBase().GetSex()
			if (isFemale && bSLHH_FemaleRapist) || (!isFemale && bSLHH_MaleRapist)
				SLHH_Interface.SLHHActivate(akAggressor)
				return
			endif
		endif
	endif
	
	if struggleToEscape(akAggressor, player)
		log("Player won the struggle and won't be raped.")
		return
	endif
	bIsBusy = True
	gotostate("raped")
	if !bRandomSexWithPlayer(akAggressor, True, (randInt(0, 999) < (fGroupSexChance * 10) as Int))
		GoToState("")
	endIf
	return
EndFunction

Bool Function struggleToEscape(Actor akAggressor, Actor akVictim)
	if !bIsAELStruggleOK
		log("“Flash Games - Struggling QTE” not found or skipped.")
		return False
	Endif
	Float fDifficulty
	if (fAELStruggleDifficulty < 0.0) || (fAELStruggleDifficulty > 100.0)
		fDifficulty = randFloat(0.0,100.0)
	else
		fDifficulty = 100.0 - fAELStruggleDifficulty
	endif
	playerScript.gotostate("struggle")
	if (AELStruggle.Get() as AELStruggle).MakeStruggle(akAggressor, player, "SPP_AELStruggle", fDifficulty, 0.0)
		int i = 0
		while !bStruggleEnded && (i < 60)
			Utility.wait(0.5)
			i -= 1
		endwhile
		if !bStruggleEnded
			log("Flash Games — Struggling QTE took too long, so it won't be used until reload.", true, true, 2)
			bIsAELStruggleOK = False
		endif
	else
		if playerScript.GetState() == "struggle"
			playerScript.gotoState("")
		endif
		return False
	endif
	if playerScript.GetState() == "struggle"
		playerScript.gotoState("")
	endif
	return bStruggleVictimEscaped
endFunction

Int function randInt(int iMin, int iMax)
	int _min =minInt(iMin, iMax)
	int _max =maxInt(iMin, iMax)
	if bIsPO3ExtenderActive
		return PO3_SKSEFunctions.GenerateRandomInt(_min, _max)
	else
		return utility.randomInt(_min, _max)
	endif
endFunction

Float function randFloat(float fMin, float fMax)
	float _min = minFloat(fMin, fMax)
	float _max = maxFloat(fMin, fMax)
	if bIsPO3ExtenderActive
		return PO3_SKSEFunctions.GenerateRandomFloat(_min, _max)
	else
		return utility.randomFloat(_min, _max)
	endif
endFunction

Bool function bCanAssault(Actor akActor)
	if !akActor
	elseif akActor.IsFlying()
	elseif akActor.IsSwimming()
	elseif akActor.GetRelationshipRank(player) > 0
	else
		return true
	endif
	return false
endFunction

Function stopApproach(Bool bConfirm = true)
	ApproachMonitorScr.stopApproach(bConfirm)
EndFunction

Bool function isActorHavingSex(Actor akActor)
	if !akActor
		return false
	elseif OStimInterface.IsActorActive(akActor)
	elseif SexLabInterface.IsActorActive(akActor)
	elseif FlowerGirlsInterface.IsActorActive(akActor)
	else
		return False
	endif
	return true
EndFunction

Function forceRefAndPackageTo(Actor akActor, ReferenceAlias akRef, Package akPackage)
	if !akActor || !akRef
		return
	endif
	if bIsPapyrusUtilActive && akPackage
		ActorUtil.AddPackageOverride(akActor, akPackage, 100, 1)
	endif
	akRef.ForceRefTo(akActor)
EndFunction

Function CheckAliases()
	if bIsBusy || !(self as Quest).isRunning()
		return
	endif
	actor act
	if Owner
		act = Owner.getActorReference()
		if !isFormValid(act) || act.isDead()
			owner.clear()
			if pimpTracker.isRunning()
				pimpTracker.setstage(10)
			endif
		endif
	else
		if pimpTracker.isRunning()
			pimpTracker.setstage(10)
		endif
	endif

	int totalCustomers = 4
	if whoreCustomerAlias
		act = whoreCustomerAlias.getActorReference()
		if (!isFormValid(act))
			whoreCustomerAlias.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			whoreCustomerAlias.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			whoreCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if whoreCustomerAlias2
		act = whoreCustomerAlias2.getActorReference()
		if (!isFormValid(act))
			whoreCustomerAlias2.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			whoreCustomerAlias2.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			whoreCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if whoreCustomerAlias3
		act = whoreCustomerAlias3.getActorReference()
		if (!isFormValid(act))
			whoreCustomerAlias3.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			whoreCustomerAlias3.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			whoreCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if whoreCustomerAlias4
		act = whoreCustomerAlias4.getActorReference()
		if (!isFormValid(act))
			whoreCustomerAlias4.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			whoreCustomerAlias4.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			whoreCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	iTotalWhoreCustomers = totalCustomers
	if iTotalWhoreCustomers < 1
		whoreCustomerList.Revert()
	endif

	totalCustomers = 4
	if dibelCustomerAlias
		act = dibelCustomerAlias.getActorReference()
		if (!isFormValid(act))
			dibelCustomerAlias.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			dibelCustomerAlias.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			dibelCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if dibelCustomerAlias2
		act = dibelCustomerAlias2.getActorReference()
		if (!isFormValid(act))
			dibelCustomerAlias2.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			dibelCustomerAlias2.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			dibelCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if dibelCustomerAlias3
		act = dibelCustomerAlias3.getActorReference()
		if (!isFormValid(act))
			dibelCustomerAlias3.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			dibelCustomerAlias3.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			dibelCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	if dibelCustomerAlias4
		act = dibelCustomerAlias4.getActorReference()
		if (!isFormValid(act))
			dibelCustomerAlias4.Clear()
			totalCustomers -= 1
		elseif act.isDead()
			dibelCustomerAlias4.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, FollowPackage)
			act.EvaluatePackage()
			dibelCustomerList.RemoveAddedForm(act)
			totalCustomers -= 1
		endif
	else
		totalCustomers -= 1
	endif
	iTotalDibelCustomers = totalCustomers
	if iTotalDibelCustomers < 1
		dibelCustomerList.Revert()
	endif
	if Assaulter
		act = Assaulter.getActorReference()
		if !isFormValid(act)
			Assaulter.Clear()
		elseif act.isDead() || (act.getParentCell() != player.getParentCell())
			act.SetDontMove(false)
			Assaulter.Clear()
			bIsPapyrusUtilActive && ActorUtil.RemovePackageOverride(act, drawWeaponPackage)
			act.EvaluatePackage()
		endif
	endif
	
	If ReApproachQst.isrunning()
		ReApproachScript.stopReapproach()
	endif
	log("Aliases were checked.")
EndFunction

Bool Function isCustomer(Actor akActor)
	if !akActor
		return False
	endif
	if (whoreCustomerAlias.getReference() As Actor) && (akActor == (whoreCustomerAlias.getReference() As Actor))
	elseif (whoreCustomerAlias2.getReference() As Actor) && (akActor == (whoreCustomerAlias2.getReference() As Actor))
	elseif (whoreCustomerAlias3.getReference() As Actor) && (akActor == (whoreCustomerAlias3.getReference() As Actor))
	elseif (whoreCustomerAlias4.getReference() As Actor) && (akActor == (whoreCustomerAlias4.getReference() As Actor))
	elseif (dibelCustomerAlias.getReference()  As Actor) && (akActor == (dibelCustomerAlias.getReference()  As Actor))
	elseif (dibelCustomerAlias2.getReference() As Actor) && (akActor == (dibelCustomerAlias2.getReference() As Actor))
	elseif (dibelCustomerAlias3.getReference() As Actor) && (akActor == (dibelCustomerAlias3.getReference() As Actor))
	elseif (dibelCustomerAlias4.getReference() As Actor) && (akActor == (dibelCustomerAlias4.getReference() As Actor))
	else
		return False
	endif
	return true
EndFunction

Bool Function isWhoreCustomer(Actor akActor)
	if !akActor
		return False
	endif
	if (whoreCustomerAlias.getReference() As Actor) && (akActor == (whoreCustomerAlias.getReference() As Actor))
	elseif (whoreCustomerAlias2.getReference() As Actor) && (akActor == (whoreCustomerAlias2.getReference() As Actor))
	elseif (whoreCustomerAlias3.getReference() As Actor) && (akActor == (whoreCustomerAlias3.getReference() As Actor))
	elseif (whoreCustomerAlias4.getReference() As Actor) && (akActor == (whoreCustomerAlias4.getReference() As Actor))
	else
		return False
	endif
	return true
endFunction

Bool Function isDibelCustomer(Actor akActor)
	if !akActor
		return False
	endif
	if (dibelCustomerAlias.getReference()  As Actor) && (akActor == (dibelCustomerAlias.getReference()  As Actor))
	elseif (dibelCustomerAlias2.getReference() As Actor) && (akActor == (dibelCustomerAlias2.getReference() As Actor))
	elseif (dibelCustomerAlias3.getReference() As Actor) && (akActor == (dibelCustomerAlias3.getReference() As Actor))
	elseif (dibelCustomerAlias4.getReference() As Actor) && (akActor == (dibelCustomerAlias4.getReference() As Actor))
	else
		return False
	endif
	return true
endFunction


Bool function isPlayerWhoring()
	if (whoreCustomerAlias.getReference() As Actor)
	elseif (whoreCustomerAlias2.getReference() As Actor)
	elseif (whoreCustomerAlias3.getReference() As Actor)
	elseif (whoreCustomerAlias4.getReference() As Actor)
	else
		isWhoring_g.SetValueInt(0)
		return False
	endif
	isWhoring_g.SetValueInt(1)
	return true
endfunction

Bool function isPlayerDibeling()
	if (dibelCustomerAlias.getReference() As Actor)
	elseif (dibelCustomerAlias2.getReference() as Actor)
	elseif (dibelCustomerAlias3.getReference() As Actor)
	elseif (dibelCustomerAlias4.getReference() As Actor)
	else
		isDibeling_g.SetValueInt(0)
		return False
	endif
	isDibeling_g.SetValueInt(1)
	return true
endfunction

Bool Function isPlayerKnownWhore(Bool bBegging = False)
	iSLSFR_CurrentWhoreFame = SLSFR_Interface.getWhoreFame()
	if bBegging
		bBeggarPlayerIsKnownWhore = (!bIs_SLSFR_Active || (iSLSFR_CurrentWhoreFame >= fSLSFR_MinBeggarSexOfferRequiredFame))
		return bBeggarPlayerIsKnownWhore
	elseif (isWhore || isDibel)
		return (!bIs_SLSFR_Active || (iSLSFR_CurrentWhoreFame >= fSLSFR_MinApproachRequiredFame))
	endif
	return False
endfunction


function checkWhoreCustomer(Actor akCustomer)
	iSLA_CurrentCustomerArousal = SLA_Interface.GetActorArousal(akCustomer)
	bISWhoreCustomerAroused = (!bIs_SLA_Active || ((iSLA_MinWhoreCustomerArousal == 0) || (iSLA_CurrentCustomerArousal >= iSLA_MinWhoreCustomerArousal)))
	if bIs_SLA_Active
		string actorName = akCustomer.getdisplayname()
		log(actorName + " arousal level is " +  iSLA_CurrentCustomerArousal)
		!bISWhoreCustomerAroused && log(actorName + " not aroused (" + iSLA_CurrentCustomerArousal + ")", true, false, 1)
	endif
endfunction

function checkDibelCustomer(Actor akCustomer)
	iSLA_CurrentCustomerArousal = SLA_Interface.GetActorArousal(akCustomer)
	bIsDibelCustomerAroused = (!bIs_SLA_Active || ((iSLA_MinDibelCustomerArousal == 0) || (iSLA_CurrentCustomerArousal >= iSLA_MinDibelCustomerArousal)))
	if bIs_SLA_Active
		string actorName = akCustomer.getdisplayname()
		log(actorName + " arousal level is " +  iSLA_CurrentCustomerArousal)
		!bIsDibelCustomerAroused && log(actorName + " not aroused (" + iSLA_CurrentCustomerArousal + ")", true, false, 1)
	endif
endfunction

function checkBeggarCustomer(Actor akCustomer)
	isPlayerKnownWhore(True)
	ApproachMonitorScr.playerHasLicense()
	ApproachMonitorScr.checkMOAStatus()
	ApproachMonitorScr.playerHavingSex = isActorHavingSex(player)
	ApproachMonitorScr.actorHavingSex = isActorHavingSex(akCustomer)
	iSLA_CurrentCustomerArousal = SLA_Interface.GetActorArousal(akCustomer)
	bIsBeggarHelperArroused = (!bIs_SLA_Active || ((iSLA_MinBeggarSexOfferArousal == 0) || (iSLA_CurrentCustomerArousal >= iSLA_MinBeggarSexOfferArousal)))
	bIs_SLA_Active && log(akCustomer.getDisplayName() + " arousal level is " +  iSLA_CurrentCustomerArousal)
	isPlayerAroused()
	isPlayerGettingHarassed()
	
	string actorName = akCustomer.getdisplayname()
	if bIs_SLA_Active
	    !bIsBeggarHelperArroused && log(actorName + " not aroused (" + iSLA_CurrentCustomerArousal + ")", true, true, 1)
		!bIsPCAroused && log("Player not aroused ("+ iSLA_PCArousal + ")", true, true, 1)
	endif
	!bBeggarPlayerIsKnownWhore && log("Player fame not enough (" + iSLSFR_CurrentWhoreFame + ")", true, true, 1)
	bOnlyLicensedBeggarSexOffer && !ApproachMonitorScr.hasLicense && log("Player doesn't have license.", true, true, 1)
endfunction

Bool function isPlayerAroused()
	iSLA_PCArousal = SLA_Interface.GetActorArousal(player)
	bIsPCAroused = (!bIs_SLA_Active || ((iSLA_MinPCArousal == 0) || (iSLA_PCArousal >= iSLA_MinPCArousal)))
	log("Player arousal level is " + iSLA_PCArousal)
	return bIsPCAroused
endfunction

Bool function isPlayerGettingHarassed()
	bIsPlayerGettingHarassed = SLHH_Interface.isPlayerGettingHarassed()
	return bIsPlayerGettingHarassed
endfunction


Function addExtraRewardsToPlayer(Float fRewardChance = 100.0, Float fRewardEnchantedChance = 100.0, int iCount = 1)
	int handle = ModEvent.Create("SPP_addRewardToPlayer")
	ModEvent.PushForm(handle, self)
	ModEvent.PushFloat(handle, fRewardChance)
	ModEvent.PushFloat(handle, fRewardEnchantedChance)
	ModEvent.PushInt(handle, iCount)
	ModEvent.Send(handle)
EndFunction


Bool function isPlayerInBeastForm()
  if WerewolfQuest.IsRunning() || VampireLordQuest.IsRunning()
    return True
  elseif player.HasKeywordstring("actortypecreature") || player.HasKeywordstring("actortypeanimal")
    return True
  elseif (player.GetRace() == WereWolfBeastRace) || (player.GetRace() == DLC1VampireBeastRace)
    return True
  endif
  return False
endfunction



