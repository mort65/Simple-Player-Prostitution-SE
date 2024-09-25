Scriptname zzzmrt_sp_ddx_interface extends Quest

import zzzmrt_sp_utility

Quest zadxQuest
Bool property bChecked = False Auto Hidden

Form[] Black_Leather_Set
Form[] White_Leather_Set
Form[] Red_Leather_Set

Form[] Black_Ebonite_Set
Form[] White_Ebonite_Set
Form[] Red_Ebonite_Set

event OnEndState()
  Utility.Wait(5.0)
  setVars()
endevent

Function setVars()
  zadxQuest = Game.GetFormFromFile(0x00ca01, "Devious Devices - Expansion.esm") as Quest
	setDevArrs()
  Debug.Notification("Simple Prostitution: Devious Devices Expansion detected.")
endfunction

Bool Function bCheckVars()
  return True
endfunction

Bool function GetIsInterfaceActive()
  if GetState() == "Installed"
    return true
  endif
  return false
endfunction

Bool Function lockRandomDeviceOnActor(Actor akActor, Int iLevel = 0, Int[] chanceArray, Int setIndex = -1)
  Return false
endfunction

Bool function isAnallyPlugged(Actor akActor)
	return False
endfunction

Bool function isVaginallyPlugged(Actor akActor)
	return False
endfunction

Bool function isPlugged(Actor akActor)
	return False
endfunction

Bool Function isBounded(Actor akActor)
  Return false
EndFunction

Bool Function isGagged(Actor akActor)
  Return false
EndFunction

Bool Function isBelted(Actor akActor)
  Return false
EndFunction

Bool Function isBlindfolded(Actor akActor)
  Return false
EndFunction

Bool function deviceHaveKeywordConflict(Actor akActor, Armor akDevice)
  return false
EndFunction

Function lockDeviousDevice(Actor akActor, Armor akDevice, Bool bForce = False)
EndFunction


Bool Function TightenRandomDevice(Actor akActor, Form[] akDevices)
  return False
EndFunction

Function MoanAndPlayHornyAnimation(Actor akActor)
endfunction

function InflateRandomPlug(Actor akActor)
endfunction

function PlayerLoadsGame(Bool bForce = False)
  Debug.trace("Simple Prostitution: PlayerLoadsGame() triggered for " + self)

  ; Is the soft dependency installed and is our script in the right state? If not change state.
  if isPluginFound("Devious Devices - Expansion.esm")
    if GetState() != "Installed"
      GoToState("Installed")
    elseif bForce || !bCheckVars()
      setVars()
    endif
  else
    if GetState() != ""
      GoToState("")
    endif
  endif
  bChecked = True
endfunction

state Installed
  
  Bool Function bCheckVars()
    return isFormValid(zadxQuest) && bDevArrsValid(16)
  endfunction
  
  Bool Function lockRandomDeviceOnActor(Actor akActor, Int iLevel = 0, Int[] chanceArray, Int setIndex = -1)
		return zzzmrt_sp_int_ddx._lockRandomDeviceOnActor(zadxQuest, akActor,  iLevel, chanceArray, corsets_regular, getDevArr(setIndex))
  endfunction
	
	Bool function isPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool function isAnallyPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isAnallyPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool function isVaginallyPlugged(Actor akActor)
     return zzzmrt_sp_int_ddx._isVaginallyPlugged(zadxQuest, akActor)
  endfunction 
	
	Bool Function isBounded(Actor akActor)
    return zzzmrt_sp_int_ddx._isBounded(zadxQuest, akActor)
  endfunction
  
  Bool Function isGagged(Actor akActor)
    return zzzmrt_sp_int_ddx._isGagged(zadxQuest, akActor)
  endfunction
  
  Bool Function isBelted(Actor akActor)
    return zzzmrt_sp_int_ddx._isBelted(zadxQuest, akActor)
  endfunction
  
  Bool Function isBlindfolded(Actor akActor)
    return zzzmrt_sp_int_ddx._isBlindfolded(zadxQuest, akActor)
  endfunction

  Bool function deviceHaveKeywordConflict(Actor akActor, Armor akDevice)
    return zzzmrt_sp_int_ddx._deviceHaveKeywordConflict(zadxQuest, akActor, akDevice)
  EndFunction

  Function LockDeviousDevice(Actor akActor, Armor akDevice, Bool bForce = False)
    zzzmrt_sp_int_ddx._LockDeviousDevice(zadxQuest, akActor, akDevice, bForce)
  endfunction

  Bool Function TightenRandomDevice(Actor akActor, Form[] akDevices)
    return zzzmrt_sp_int_ddx._TightenRandomDevice(zadxQuest, akActor, akDevices)
  EndFunction

  function InflateRandomPlug(Actor akActor)
    zzzmrt_sp_int_ddx._InflateRandomPlug(zadxQuest, akActor)
  endfunction
	
	Function MoanAndPlayHornyAnimation(Actor akActor)
		zzzmrt_sp_int_ddx._MoanAndPlayHornyAnimation(zadxQuest, akActor)
	endfunction

endState

Bool function bDevArrsValid(Int iSize = 1)
	if (Black_Leather_Set.Length < iSize) || (isFormArrayHasInvalid(Black_Leather_Set))
	elseif (White_Leather_Set.Length < iSize) || (isFormArrayHasInvalid(White_Leather_Set))
	elseif (Red_Leather_Set.Length < iSize) || (isFormArrayHasInvalid(Red_Leather_Set))
	elseif (Black_Ebonite_Set.Length < iSize) || (isFormArrayHasInvalid(Black_Ebonite_Set))
	elseif (White_Ebonite_Set.Length < iSize) || (isFormArrayHasInvalid(White_Ebonite_Set))
	elseif (Red_Ebonite_Set.Length < iSize) || (isFormArrayHasInvalid(Red_Ebonite_Set))
	else
		return true
	endif
	return false
endfunction

Form[] function getDevArr(Int setIndex)
	form[] devArr
	if setIndex == 0
		devArr = Black_Leather_Set
	elseif setIndex == 1
		devArr = White_Leather_Set
	elseif setIndex == 2
		devArr = Red_Leather_Set
	elseif setIndex == 3
		devArr = Black_Ebonite_Set
	elseif setIndex == 4
		devArr = White_Ebonite_Set
	elseif setIndex == 5
		devArr = Red_Ebonite_Set
	endif
	return devArr
endfunction

Function setDevArrs()
	String sDDX = "Devious Devices - Expansion.esm"
	String sDDI = "Devious Devices - Integration.esm"
	
	corsets_regular = Game.GetFormFromFile(0x0022F1, sDDX) as LeveledItem
	
	Black_Leather_Arm_Cuff = Game.GetFormFromFile(0x032744, sDDI) 
	Black_Leather_Leg_Cuff = Game.GetFormFromFile(0x032743, sDDI)
	Black_Leather_Collar = Game.GetFormFromFile(0x032745, sDDI)
	Black_Leather_Glove = Game.GetFormFromFile(0x04DBEC, sDDI)
	Black_Leather_Boot = Game.GetFormFromFile(0x0138DA, sDDX)
	Black_Leather_Corset = Game.GetFormFromFile(0x04DBF0, sDDI)
	Black_Leather_Harness = Game.GetFormFromFile(0x001E39, sDDX)
	Black_Leather_Gag_Ring = Game.GetFormFromFile(0x34255, sDDI)
	Black_belt_open = Game.GetFormFromFile(0x0584FC, sDDX)
	Black_belt_Close = Game.GetFormFromFile(0x05845E, sDDX)
	Black_Bra = Game.GetFormFromFile(0x058462, sDDX)
	Black_Leather_Gag = Game.GetFormFromFile(0x034253, sDDI)
	Black_Leather_Hood = Game.GetFormFromFile(0x03D850, sDDX)
	Black_Leather_Blindfold = Game.GetFormFromFile(0x031C6F, sDDI)
	Black_Leather_ArmBinder = Game.GetFormFromFile(0x028A5A, sDDI)
	Black_Leather_Hobble = Game.GetFormFromFile(0x020733, sDDX)
	
	White_Leather_Arm_Cuff = Game.GetFormFromFile(0x00F023, sDDX) ;
	White_Leather_Leg_Cuff = Game.GetFormFromFile(0x00F029, sDDX) ;
	White_Leather_Collar = Game.GetFormFromFile(0x00F01D, sDDX) ;
	White_Leather_Glove = Game.GetFormFromFile(0x01597C, sDDX) ;
	White_Leather_Boot = Game.GetFormFromFile(0x01597E, sDDX) ;
	White_Leather_Corset = Game.GetFormFromFile(0x015973, sDDX) ;
	White_Leather_Harness = Game.GetFormFromFile(0x057351, sDDX) ;
	White_Leather_Gag_Ring = Game.GetFormFromFile(0x00F060, sDDX) ;
	White_belt_open = Game.GetFormFromFile(0x0584FF, sDDX) ;
	White_belt_Close = Game.GetFormFromFile(0x05845C, sDDX) ;
	White_Bra = Game.GetFormFromFile(0x058460, sDDX) ;
	White_Leather_Gag = Game.GetFormFromFile(0x00F05C, sDDX) ;
	White_Leather_Hood = Game.GetFormFromFile(0x000D65, sDDX) ;
	White_Leather_Blindfold = Game.GetFormFromFile(0x00F02F, sDDX) ;
	White_Leather_ArmBinder = Game.GetFormFromFile(0x00F013, sDDX) ;
	White_Leather_Hobble = Game.GetFormFromFile(0x025831, sDDX) ;
	
	Red_Leather_Arm_Cuff = Game.GetFormFromFile(0x011102, sDDX) ;
	Red_Leather_Leg_Cuff = Game.GetFormFromFile(0x011106, sDDX) ;
	Red_Leather_Collar = Game.GetFormFromFile(0x0110FE, sDDX) ;
	Red_Leather_Glove = Game.GetFormFromFile(0x015990, sDDX) ;
	Red_Leather_Boot = Game.GetFormFromFile(0x015992, sDDX) ;
	Red_Leather_Corset = Game.GetFormFromFile(0x01598C, sDDX) ;
	Red_Leather_Harness = Game.GetFormFromFile(0x001E38, sDDX) ;
	Red_Leather_Gag_Ring = Game.GetFormFromFile(0x011148, sDDX) ;
	Red_belt_open = Game.GetFormFromFile(0x058502, sDDX) ;
	Red_belt_Close = Game.GetFormFromFile(0x05845A, sDDX) ;
	Red_Bra = Game.GetFormFromFile(0x058458, sDDX) ;
	Red_Leather_Gag = Game.GetFormFromFile(0x011144, sDDX) ;
	Red_Leather_Hood = Game.GetFormFromFile(0x05850E, sDDX) ;
	Red_Leather_Blindfold = Game.GetFormFromFile(0x011110, sDDX) ;
	Red_Leather_ArmBinder = Game.GetFormFromFile(0x0110F0, sDDX)
	Red_Leather_Hobble = Game.GetFormFromFile(0x02582F, sDDX) ;
	
	Black_Ebonite_Arm_Cuff = Game.GetFormFromFile(0x00D4E1, sDDX) ;
	Black_Ebonite_Leg_Cuff = Game.GetFormFromFile(0x00D4E3, sDDX) ;
	Black_Ebonite_Collar = Game.GetFormFromFile(0x00D4DF, sDDX) ;
	Black_Ebonite_Glove = Game.GetFormFromFile(0x0159AC, sDDX) ;
	Black_Ebonite_Boot = Game.GetFormFromFile(0x0159AE, sDDX) ;
	Black_Ebonite_Corset = Game.GetFormFromFile(0x0159A8, sDDX) ;
	Black_Ebonite_Harness = Game.GetFormFromFile(0x001E3B, sDDX) ;
	Black_Ebonite_Gag_Ring = Game.GetFormFromFile(0x00D4F8, sDDX) ;
	Black_belt_open = Game.GetFormFromFile(0x0584FC, sDDX) ; 
	Black_belt_Close = Game.GetFormFromFile(0x05845E, sDDX) ;
	Black_Bra = Game.GetFormFromFile(0x058462, sDDX) ;
	Black_Ebonite_Gag = Game.GetFormFromFile(0x00D4F6, sDDX) ;
	Black_Ebonite_Hood = Game.GetFormFromFile(0x03D2D7, sDDX) ;
	Black_Ebonite_Blindfold = Game.GetFormFromFile(0x00D4E6, sDDX) ;
	Black_Ebonite_ArmBinder = Game.GetFormFromFile(0x00D4D6, sDDX) ;
	Black_Ebonite_Hobble = Game.GetFormFromFile(0x024288, sDDX) ;
	
	White_Ebonite_Arm_Cuff = Game.GetFormFromFile(0x00F026, sDDX) ;
	White_Ebonite_Leg_Cuff = Game.GetFormFromFile(0x00F02C, sDDX) ;
	White_Ebonite_Collar = Game.GetFormFromFile(0x00F020, sDDX) ;
	White_Ebonite_Glove = Game.GetFormFromFile(0x0159BD, sDDX) ;
	White_Ebonite_Boot = Game.GetFormFromFile(0x0159BF, sDDX) ;
	White_Ebonite_Corset = Game.GetFormFromFile(0x0159B8, sDDX) ;
	White_Ebonite_Harness = Game.GetFormFromFile(0x057358, sDDX) ;
	White_Ebonite_Gag_Ring = Game.GetFormFromFile(0x00F062, sDDX) ;
	White_belt_open = Game.GetFormFromFile(0x0584FF, sDDX) ;
	White_belt_Close = Game.GetFormFromFile(0x05845C, sDDX) ;
	White_Bra = Game.GetFormFromFile(0x058460, sDDX) ;
	White_Ebonite_Gag = Game.GetFormFromFile(0x00F05E, sDDX)
	White_Ebonite_Hood = Game.GetFormFromFile(0x0012D0, sDDX)
	White_Ebonite_Blindfold = Game.GetFormFromFile(0x00F036, sDDX)
	White_Ebonite_ArmBinder = Game.GetFormFromFile(0x00F016, sDDX)
	White_Ebonite_Hobble = Game.GetFormFromFile(0x025845, sDDX)
	
	Red_Ebonite_Arm_Cuff = Game.GetFormFromFile(0x011104, sDDX) ;
	Red_Ebonite_Leg_Cuff = Game.GetFormFromFile(0x011108, sDDX) ;
	Red_Ebonite_Collar = Game.GetFormFromFile(0x011100, sDDX) ;
	Red_Ebonite_Glove = Game.GetFormFromFile(0x0159D1, sDDX) ;
	Red_Ebonite_Boot = Game.GetFormFromFile(0x0159D3, sDDX) ;
	Red_Ebonite_Corset = Game.GetFormFromFile(0x0159CD, sDDX) ;
	Red_Ebonite_Harness = Game.GetFormFromFile(0x05735A, sDDX) ;
	Red_Ebonite_Gag_Ring = Game.GetFormFromFile(0x01114A, sDDX) ;
	Red_belt_open = Game.GetFormFromFile(0x058502, sDDX) ;
	Red_belt_Close = Game.GetFormFromFile(0x05845A, sDDX) ;
	Red_Bra = Game.GetFormFromFile(0x058458, sDDX) ;
	Red_Ebonite_Gag = Game.GetFormFromFile(0x011146, sDDX) ;
	Red_Ebonite_Hood = Game.GetFormFromFile(0x0012CE, sDDX) ;
	Red_Ebonite_Blindfold = Game.GetFormFromFile(0x011112, sDDX) ;
	Red_Ebonite_ArmBinder = Game.GetFormFromFile(0x0110F2, sDDX) ;
	Red_Ebonite_Hobble = Game.GetFormFromFile(0x025843, sDDX) ;
	
	Black_Leather_Set = new Form[16]
	Black_Leather_Set[00] = Black_Leather_Arm_Cuff
	Black_Leather_Set[01] = Black_Leather_Leg_Cuff
	Black_Leather_Set[02] = Black_Leather_Collar
	Black_Leather_Set[03] = Black_Leather_Glove
	Black_Leather_Set[04] = Black_Leather_Boot
	Black_Leather_Set[05] = Black_Leather_Corset
	Black_Leather_Set[06] = Black_Leather_Harness
	Black_Leather_Set[07] = Black_Leather_Gag_Ring
	Black_Leather_Set[08] = Black_belt_open
	Black_Leather_Set[09] = Black_belt_Close
	Black_Leather_Set[10] = Black_Bra
	Black_Leather_Set[11] = Black_Leather_Gag
	Black_Leather_Set[12] = Black_Leather_Hood
	Black_Leather_Set[13] = Black_Leather_Blindfold
	Black_Leather_Set[14] = Black_Leather_ArmBinder
	Black_Leather_Set[15] = Black_Leather_Hobble
	
	White_Leather_Set = new Form[16]
	White_Leather_Set[00] = White_Leather_Arm_Cuff
	White_Leather_Set[01] = White_Leather_Leg_Cuff
	White_Leather_Set[02] = White_Leather_Collar
	White_Leather_Set[03] = White_Leather_Glove
	White_Leather_Set[04] = White_Leather_Boot
	White_Leather_Set[05] = White_Leather_Corset
	White_Leather_Set[06] = White_Leather_Harness
	White_Leather_Set[07] = White_Leather_Gag_Ring
	White_Leather_Set[08] = White_belt_open
	White_Leather_Set[09] = White_belt_Close
	White_Leather_Set[10] = White_Bra
	White_Leather_Set[11] = White_Leather_Gag
	White_Leather_Set[12] = White_Leather_Hood
	White_Leather_Set[13] = White_Leather_Blindfold
	White_Leather_Set[14] = White_Leather_ArmBinder
	White_Leather_Set[15] = White_Leather_Hobble
	
	Red_Leather_Set = new Form[16]
	Red_Leather_Set[00] = Red_Leather_Arm_Cuff
	Red_Leather_Set[01] = Red_Leather_Leg_Cuff
	Red_Leather_Set[02] = Red_Leather_Collar
	Red_Leather_Set[03] = Red_Leather_Glove
	Red_Leather_Set[04] = Red_Leather_Boot
	Red_Leather_Set[05] = Red_Leather_Corset
	Red_Leather_Set[06] = Red_Leather_Harness
	Red_Leather_Set[07] = Red_Leather_Gag_Ring
	Red_Leather_Set[08] = Red_belt_open
	Red_Leather_Set[09] = Red_belt_Close
	Red_Leather_Set[10] = Red_Bra
	Red_Leather_Set[11] = Red_Leather_Gag
	Red_Leather_Set[12] = Red_Leather_Hood
	Red_Leather_Set[13] = Red_Leather_Blindfold
	Red_Leather_Set[14] = Red_Leather_ArmBinder
	Red_Leather_Set[15] = Red_Leather_Hobble
	
	Black_Ebonite_Set = new Form[16]
	Black_Ebonite_Set[00] = Black_Ebonite_Arm_Cuff
	Black_Ebonite_Set[01] = Black_Ebonite_Leg_Cuff
	Black_Ebonite_Set[02] = Black_Ebonite_Collar
	Black_Ebonite_Set[03] = Black_Ebonite_Glove
	Black_Ebonite_Set[04] = Black_Ebonite_Boot
	Black_Ebonite_Set[05] = Black_Ebonite_Corset
	Black_Ebonite_Set[06] = Black_Ebonite_Harness
	Black_Ebonite_Set[07] = Black_Ebonite_Gag_Ring
	Black_Ebonite_Set[08] = Black_belt_open
	Black_Ebonite_Set[09] = Black_belt_Close
	Black_Ebonite_Set[10] = Black_Bra
	Black_Ebonite_Set[11] = Black_Ebonite_Gag
	Black_Ebonite_Set[12] = Black_Ebonite_Hood
	Black_Ebonite_Set[13] = Black_Ebonite_Blindfold
	Black_Ebonite_Set[14] = Black_Ebonite_ArmBinder
	Black_Ebonite_Set[15] = Black_Ebonite_Hobble
	
	White_Ebonite_Set = new Form[16]
	White_Ebonite_Set[00] = White_Ebonite_Arm_Cuff
	White_Ebonite_Set[01] = White_Ebonite_Leg_Cuff
	White_Ebonite_Set[02] = White_Ebonite_Collar
	White_Ebonite_Set[03] = White_Ebonite_Glove
	White_Ebonite_Set[04] = White_Ebonite_Boot
	White_Ebonite_Set[05] = White_Ebonite_Corset
	White_Ebonite_Set[06] = White_Ebonite_Harness
	White_Ebonite_Set[07] = White_Ebonite_Gag_Ring
	White_Ebonite_Set[08] = White_belt_open
	White_Ebonite_Set[09] = White_belt_Close
	White_Ebonite_Set[10] = White_Bra
	White_Ebonite_Set[11] = White_Ebonite_Gag
	White_Ebonite_Set[12] = White_Ebonite_Hood
	White_Ebonite_Set[13] = White_Ebonite_Blindfold
	White_Ebonite_Set[14] = White_Ebonite_ArmBinder
	White_Ebonite_Set[15] = White_Ebonite_Hobble

	Red_Ebonite_Set = new Form[16]
	Red_Ebonite_Set[00] = Red_Ebonite_Arm_Cuff
	Red_Ebonite_Set[01] = Red_Ebonite_Leg_Cuff
	Red_Ebonite_Set[02] = Red_Ebonite_Collar
	Red_Ebonite_Set[03] = Red_Ebonite_Glove
	Red_Ebonite_Set[04] = Red_Ebonite_Boot
	Red_Ebonite_Set[05] = Red_Ebonite_Corset
	Red_Ebonite_Set[06] = Red_Ebonite_Harness
	Red_Ebonite_Set[07] = Red_Ebonite_Gag_Ring
	Red_Ebonite_Set[08] = Red_belt_open
	Red_Ebonite_Set[09] = Red_belt_Close
	Red_Ebonite_Set[10] = Red_Bra
	Red_Ebonite_Set[11] = Red_Ebonite_Gag
	Red_Ebonite_Set[12] = Red_Ebonite_Hood
	Red_Ebonite_Set[13] = Red_Ebonite_Blindfold
	Red_Ebonite_Set[14] = Red_Ebonite_ArmBinder
	Red_Ebonite_Set[15] = Red_Ebonite_Hobble

endfunction

LeveledItem corsets_regular ;zad_dev_corsets_regular [LVLI:060022F1]

Form Black_Leather_Arm_Cuff ;zad_cuffsLeatherArmsInventory "Black Leather Cuffs (Arms)" [ARMO:05032744]
Form White_Leather_Arm_Cuff ;zadx_WTLcuffsLArmsInventory "White Leather Cuffs (Arms)" [ARMO:0600F023]
Form Red_Leather_Arm_Cuff ;zadx_RDLcuffsLArmsInventory "Red Leather Cuffs (Arms)" [ARMO:06011102]

Form Black_Ebonite_Arm_Cuff ;zadx_cuffs_EboniteArmsInventory "Black Ebonite Cuffs (Arms)" [ARMO:0600D4E1]
Form White_Ebonite_Arm_Cuff ;zadx_WTECuffsEArmsInventory "White Ebonite Cuffs (Arms)" [ARMO:0600F026]
Form Red_Ebonite_Arm_Cuff ;zadx_RDECuffsEArmsInventory "Red Ebonite Cuffs (Arms)" [ARMO:06011104]

Form Black_Leather_Leg_Cuff ;zad_cuffsLeatherLegsInventory "Black Leather Cuffs (Legs)" [ARMO:05032743]
Form White_Leather_Leg_Cuff ;zadx_WTLcuffsLLegsInventory "White Leather Cuffs (Legs)" [ARMO:0600F029]
Form Red_Leather_Leg_Cuff ;zadx_RDLcuffsLLegsInventory "Red Leather Cuffs (Legs)" [ARMO:06011106]

Form Black_Ebonite_Leg_Cuff ;zadx_cuffs_EboniteLegsInventory "Black Ebonite Cuffs (Legs)" [ARMO:0600D4E3]
Form White_Ebonite_Leg_Cuff ;zadx_WTECuffsELegsInventory "White Ebonite Cuffs (Legs)" [ARMO:0600F02C]
Form Red_Ebonite_Leg_Cuff ;zadx_RDECuffsELegsInventory "Red Ebonite Cuffs (Legs)" [ARMO:06011108] 

Form Black_Leather_Collar ;zad_cuffsLeatherCollarInventory "Black Leather Collar" [ARMO:05032745]
Form White_Leather_Collar ;zadx_WTLcuffsLCollarInventory "White Leather Collar" [ARMO:0600F01D]
Form Red_Leather_Collar ;zadx_RDLcuffsLCollarInventory "Red Leather Collar" [ARMO:060110FE]

Form Black_Ebonite_Collar ;zadx_cuffs_EboniteCollarInventory "Black Ebonite Collar" [ARMO:0600D4DF]
Form White_Ebonite_Collar ;zadx_WTECuffsECollarInventory "White Ebonite Collar" [ARMO:0600F020]
Form Red_Ebonite_Collar ;zadx_RDECuffsECollarInventory "Red Ebonite Collar" [ARMO:06011100]

Form Black_Leather_Glove ;zad_restrictiveGlovesInventory "Black Leather Restrictive Gloves" [ARMO:0504DBEC]
Form White_Leather_Glove ;zadx_WTLrestrictiveGlovesInventory "White Leather Restrictive Gloves" [ARMO:0601597C]
Form Red_Leather_Glove ;zadx_RDLrestrictiveGlovesInventory "Red Leather Restrictive Gloves" [ARMO:06015990]

Form Black_Ebonite_Glove ;zadx_EbRestrictiveGlovesInventory "Black Ebonite Restrictive Gloves" [ARMO:060159AC]
Form White_Ebonite_Glove ;zadx_WTErestrictiveGlovesInventory "White Ebonite Restrictive Gloves" [ARMO:060159BD]
Form Red_Ebonite_Glove ;zadx_RDErestrictiveGlovesInventory "Red Ebonite Restrictive Gloves" [ARMO:060159D1]

Form Black_Leather_Boot ;zadx_restrictiveBootsInventory "Black Leather Restrictive Boots" [ARMO:060138DA]
Form White_Leather_Boot ;zadx_WTLrestrictiveBootsInventory "White Leather Restrictive Boots" [ARMO:0601597E]
Form Red_Leather_Boot ;zadx_RDLrestrictiveBootsInventory "Red Leather Restrictive Boots" [ARMO:06015992]

Form Black_Ebonite_Boot ;zadx_EbRestrictiveBootsInventory "Black Ebonite Restrictive Boots" [ARMO:060159AE]
Form White_Ebonite_Boot ;zadx_WTErestrictiveBootsInventory "White Ebonite Restrictive Boots" [ARMO:060159BF]
Form Red_Ebonite_Boot ;zadx_RDErestrictiveBootsInventory "Red Ebonite Restrictive Boots" [ARMO:060159D3]

Form Black_Leather_Corset ;zad_restrictiveCorsetInventory "Black Leather Restrictive Corset" [ARMO:0504DBF0]
Form White_Leather_Corset ;zadx_WTLrestrictiveCorsetInventory "White Leather Restrictive Corset" [ARMO:06015973]
Form Red_Leather_Corset ;zadx_RDLrestrictiveCorsetInventory "Red Leather Restrictive Corset" [ARMO:0601598C]

Form Black_Ebonite_Corset ;zadx_EbRestrictiveCorsetInventory "Black Ebonite Restrictive Corset" [ARMO:060159A8]
Form White_Ebonite_Corset ;zadx_WTErestrictiveCorsetInventory "White Ebonite Restrictive Corset" [ARMO:060159B8]
Form Red_Ebonite_Corset ;zadx_RDErestrictiveCorsetInventory "Red Ebonite Restrictive Corset" [ARMO:060159CD]

Form Black_Leather_Harness ;zadx_LeatherHarnessRegNCInventory "Black Leather Slave Harness, No Collar" [ARMO:06001E39]
Form White_Leather_Harness ;zadx_WTLeatherHarnessRegNCInventory "White Leather Slave Harness, No Collar" [ARMO:06057351]
Form Red_Leather_Harness ;zadx_RDLeatherHarnessRegNCInventory "Red Leather Slave Harness, No Collar" [ARMO:06001E38]

Form Black_Ebonite_Harness ;zadx_EboniteHarnessRegNCInventory "Black Ebonite Slave Harness, No Collar" [ARMO:06001E3B]
Form White_Ebonite_Harness ;zadx_WTEboniteHarnessRegNCInventory "White Ebonite Slave Harness, No Collar" [ARMO:06057358]
Form Red_Ebonite_Harness ;zadx_RDEboniteHarnessRegNCInventory "Red Ebonite Slave Harness, No Collar" [ARMO:0605735A]

Form Black_Leather_Gag_Ring ;zad_gagStrapRingInventory "Black Leather Gag (Ring) (Simple)" [ARMO:05034255]
Form White_Leather_Gag_Ring ;zadx_WTLgagStrapRingInventory "White Leather Gag (Ring) (Simple)" [ARMO:0600F060]
Form Red_Leather_Gag_Ring ;zadx_RDLgagStrapRingInventory "Red Leather Gag (Ring) (Simple)" [ARMO:06011148]

Form Black_Ebonite_Gag_Ring ;zadx_GagEboniteStrapRingInventory "Black Ebonite Gag (Ring) (Simple)" [ARMO:0600D4F8]
Form White_Ebonite_Gag_Ring ;zadx_WTEGagEbStrapRingInventory "White Ebonite Gag (Ring) (Simple)" [ARMO:0600F062]
Form Red_Ebonite_Gag_Ring ;zadx_RDEGagEbStrapRingInventory "Red Ebonite Gag (Ring) (Simple)" [ARMO:0601114A]

Form Black_belt_open ;zadx_chastitybelt_PaddedOpen_Black_Inventory "Black Chastity Belt (Padded) (Open)" [ARMO:060584FC]
Form White_belt_open ;zadx_chastitybelt_PaddedOpen_White_Inventory "White Chastity Belt (Padded) (Open)" [ARMO:060584FF]
Form Red_belt_open ;zadx_chastitybelt_PaddedOpen_Red_Inventory "Red Chastity Belt (Padded) (Open)" [ARMO:06058502]

Form Black_belt_Close ;zadx_chastitybelt_Padded_Black_Inventory "Black Chastity Belt (Padded)" [ARMO:0605845E]
Form White_belt_Close ;zadx_chastitybelt_Padded_White_Inventory "White Chastity Belt (Padded)" [ARMO:0605845C]
Form Red_belt_Close ;zadx_chastitybelt_Padded_Red_Inventory "Red Chastity Belt (Padded)" [ARMO:0605845A]

Form Black_Bra ;zadx_chastitybra_Padded_Black_Inventory "Black Chastity Bra (Padded)" [ARMO:06058462]
Form White_Bra ;zadx_chastitybra_Padded_White_Inventory "White Chastity Bra (Padded)" [ARMO:06058460]
Form Red_Bra ;zadx_chastitybra_Padded_Red_Inventory "Red Chastity Bra (Padded)" [ARMO:06058458]

Form Black_Leather_Gag ;zad_gagStrapBallInventory "Black Leather Gag (Ball) (Simple)" [ARMO:05034253]
Form White_Leather_Gag ;zadx_WTLgagStrapBallInventory "White Leather Gag (Ball) (Simple)" [ARMO:0600F05C]
Form Red_Leather_Gag ;zadx_RDLgagStrapBallInventory "Red Leather Gag (Ball) (Simple)" [ARMO:06011144]

Form Black_Ebonite_Gag ;zadx_GagEboniteStrapBallInventory "Black Ebonite Gag (Ball) (Simple)" [ARMO:0600D4F6]
Form White_Ebonite_Gag ;zadx_WTEGagEbStrapBallInventory "White Ebonite Gag (Ball) (Simple)" [ARMO:0600F05E]
Form Red_Ebonite_Gag ;zadx_RDEGagEbStrapBallInventory "Red Ebonite Gag (Ball) (Simple)" [ARMO:06011146]

Form Black_Leather_Hood ;zadx_hood_leather_black_Inventory "Black Leather Hood" [ARMO:0603D850]
Form White_Leather_Hood ;zadx_hood_leather_white_Inventory "White Leather Hood" [ARMO:06000D65]
Form Red_Leather_Hood ;zadx_hood_leather_red_Inventory "Red Leather Hood" [ARMO:0605850E]

Form Black_Ebonite_Hood ;zadx_hood_rubber_black_Inventory "Black Ebonite Hood" [ARMO:0603D2D7]
Form White_Ebonite_Hood ;zadx_hood_ebonite_white_Inventory "White Ebonite Hood" [ARMO:060012D0]
Form Red_Ebonite_Hood ;zadx_hood_ebonite_red_Inventory "Red Ebonite Hood" [ARMO:060012CE]

Form Black_Leather_Blindfold ;zad_blindfoldInventory "Black Leather Blindfold" [ARMO:05031C6F]
Form White_Leather_Blindfold ;zadx_WTLblindfoldInventory "White Leather Blindfold" [ARMO:0600F02F]
Form Red_Leather_Blindfold ;zadx_RDLblindfoldInventory "Red Leather Blindfold" [ARMO:06011110]

Form Black_Ebonite_Blindfold ;zadx_EboniteBlindfoldInventory "Black Ebonite Blindfold" [ARMO:0600D4E6]
Form White_Ebonite_Blindfold ;zadx_WTEEBlindfoldInventory "White Ebonite Blindfold" [ARMO:0600F036]
Form Red_Ebonite_Blindfold ;zadx_RDEEBlindfoldInventory "Red Ebonite Blindfold" [ARMO:06011112]

Form Black_Leather_ArmBinder ;zad_armBinderInventory "Black Leather Armbinder" [ARMO:05028A5A]
Form White_Leather_ArmBinder ;zadx_WTLarmbinderInventory "White Leather Armbinder" [ARMO:0600F013]
Form Red_Leather_ArmBinder ;zadx_RDLarmbinderInventory "Red Leather Armbinder" [ARMO:060110F0]

Form Black_Ebonite_ArmBinder ;zadx_EboniteArmbinderInventory "Black Ebonite Armbinder" [ARMO:0600D4D6]
Form White_Ebonite_ArmBinder ;zadx_WTEarmbinderInventory "White Ebonite Armbinder" [ARMO:0600F016]
Form Red_Ebonite_ArmBinder ;zadx_RDEarmbinderInventory "Red Ebonite Armbinder" [ARMO:060110F2]

Form Black_Leather_Hobble ;zadx_HobbleDressInventory "Black Leather Hobble Dress (Extreme)" [ARMO:06020733]
Form White_Leather_Hobble ;zadx_HobbleDressWhiteInventory "White Leather Hobble Dress (Extreme)" [ARMO:06025831]
Form Red_Leather_Hobble ;zadx_HobbleDressRedInventory "Red Leather Hobble Dress (Extreme)" [ARMO:0602582F]

Form Black_Ebonite_Hobble ;zadx_HobbleDressLatexInventory "Black Ebonite Hobble Dress (Extreme)" [ARMO:06024288]
Form White_Ebonite_Hobble ;zadx_HobbleDressLatexWhiteInventory "White Ebonite Hobble Dress (Extreme)" [ARMO:06025845]
Form Red_Ebonite_Hobble ;zadx_HobbleDressLatexRedInventory "Red Ebonite Hobble Dress (Extreme)" [ARMO:06025843]