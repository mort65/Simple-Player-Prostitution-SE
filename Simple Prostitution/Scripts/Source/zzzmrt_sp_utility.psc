Scriptname zzzmrt_sp_utility hidden

import Utility
import StringUtil

Form[] Function formlistToArr(Formlist flist) Global
	{Convert a formlist to an array.}
	Form[] fArr
	if !flist || (flist.GetSize() < 1)
		return fArr
	endif
	fArr = createFormArray(flist.GetSize())
	int iIndex = fArr.Length
	while iIndex > 0
		iIndex -= 1
		fArr[iIndex] = flist.GetAt(iIndex)
	endWhile
	return fArr
EndFunction

Form[] Function shuffleFormArr(Form[] fArr) Global
	{Shuffle a form array.}
	if !fArr || (fArr.Length < 2)
		return fArr
	endif
	int iIndex = fArr.Length
	int jIndex
	Form tmp
	While iIndex > 1
		iIndex -= 1
		jIndex = randomInt(0,iIndex)
		tmp = fArr[jIndex]
		fArr[jIndex] = fArr[iIndex]
		fArr[iIndex] = tmp
	endWhile
	return fArr
EndFunction


Int function maxInt(Int var1, Int var2) Global
	{find maximum of two integers.}
  if var1 > var2
    return var1
  endif
  return var2
endfunction

Int function minInt(Int var1, Int var2) Global
	{find minimum of two integers.}
  if var1 < var2
    return var1
  endif
  return var2
endfunction

Float function maxFloat(Float var1, Float var2) Global
	{find maximum of two floats.}
  if var1 > var2
    return var1
  endif
  return var2
endfunction

Float function minFloat(Float var1, Float var2) Global
	{find minimum of two floats.}
  if var1 < var2
    return var1
  endif
  return var2
endfunction

String function shortenString(String sString, Int iLimit) Global
	{Shortens the input string and put ... at the end of it.}
  Int iLen = GetLength(sString)
  if iLimit < 4
    if iLimit < 1
      return sString
    endif
    if iLen > iLimit
      return Substring(sString, 0, iLimit)
    endif
    return sString
  elseif iLen < 4
    return sString
  endif
  if iLen > iLimit
    return Substring(sString, 0, len=iLimit - 3) + "..."
  endif
  return sString
endfunction

Int[] Function initIntArray(Int[] arr, Int len, Int def = 0) Global
	{Initialize an integer array with Len as its size, while preserving its values.}
  if (len < 0) || (arr.Length == len)
    return arr
  endif
  Int iIndex
  Int[] newArr = createIntArray(len, def)
  iIndex = minInt(arr.Length, newArr.Length)
  While iIndex > 0
    iIndex -= 1
    newArr[iIndex] = arr[iIndex]
  endWhile
  return newArr
EndFunction

Function endDialogueWithPlayer(ObjectReference objTarget) Global
  {Ends a dialogue with player by pressing menu key (default is ESC).}
  int iPauseKey = input.GetMappedKey("Pause")
  if iPauseKey > 0
    if !IsInMenuMode() 
      if objTarget && objTarget.IsInDialogueWithPlayer()
        Input.tapkey(iPauseKey)
      Endif
    Endif
  endif
EndFunction

Bool Function bSucessCalculator(float fSuccessPercent, int iRounds = 1) Global
  {Checks for at least one success after multiple attempts based on input probability : P(at least one success) = 1 - (1 - p)^n}
  if iRounds < 1 || fSuccessPercent <= 0.0
    return False
  endif
  ;return (1.0 - Math.Pow(1.0 - (fSuccessPercent / 100.0), iRounds as Float)) > utility.randomInt(0,99)
  
  int iIndex = 0
  While iIndex < iRounds
    if fSuccessPercent > (utility.randomInt(0,999) / 10.0)
      return True
    endIf
    iIndex += 1
  endWhile
  return False
EndFunction


Int function iAddRandomItemToRef(ObjectReference akRef, Form[] akItemArr, Int aiTotalToAdd = 1) Global
  {Adds random forms from an array to an objectreference and returns how many added.}
  if (aiTotalToAdd < 1) || (akItemArr.Length < 1)
    return 0
  endif
  Int iResult = 0
  Int iTotalItems = akItemArr.Length
  Int[] itemNumToAdd = utility.createIntArray(iTotalItems, 0)
  Int jIndex
  Int iIndex = 0
  while iIndex < aiTotalToAdd
    jIndex = Utility.RandomInt(0, iTotalItems - 1)
    itemNumToAdd[jIndex] = itemNumToAdd[jIndex] + 1
    iIndex += 1
  endWhile
  iIndex = iTotalItems
  While iIndex > 0
    iIndex -= 1
    jIndex = itemNumToAdd[iIndex]
    if akItemArr[iIndex] && jIndex > 0
      akRef.Additem(akItemArr[iIndex], jIndex)
      iResult += jIndex
    endif
  EndWhile
  return iResult
EndFunction

Bool function isInteger(String str) Global
  {Checks whether the given string is an integer or not.}
  int iIndex = getLength(str)
  if iIndex == 0
    return False
  endif
  while iIndex > 0
    iIndex -= 1
    if !isDigit(getNthChar(str, iIndex))
      return False
    endIf
  endWhile
  return True
EndFunction


Int function weightedRandInt(int[] weights, bool bUsePo3 = false) Global 
	{Generates weighted random integers.}
	if weights.Length < 1
		return -1
	endif
	Int iLen = weights.Length
  int[] cumulWeights = Utility.createIntArray(iLen)
  int iIndex = 0
  int jIndex = 0
  while iIndex < iLen
  	jIndex = 0
  	cumulWeights[iIndex] = 0
  	while jIndex < iIndex + 1
  		cumulWeights[iIndex] = cumulWeights[iIndex] + weights[jIndex]
  		jIndex += 1
  	endWhile
  	iIndex += 1
  endWhile
  if bUsePo3
  	jIndex = PO3_SKSEFunctions.GenerateRandomInt(1, cumulWeights[iLen - 1])
  else
  	jIndex = utility.randomInt(1,cumulWeights[iLen - 1])
  endif
  iIndex = 0
  while iIndex < cumulWeights.Length
    if jIndex <= cumulWeights[iIndex]
      return iIndex
    endIf
    iIndex += 1
  endWhile
  return -1
endfunction

Bool function isFormValid(Form akForm) Global
  {checks if the form not empty and has a usable value.}
  return akForm && (akForm != None) && (akForm.getFormID() != 0)
endfunction

Bool function isFormArrayHasInvalid(Form[] akFormArr) Global
  {checks if the form array has empty or unusable item.}
	int i = akFormArr.length
	form item
	while i > 0
		i -= 1
		item = akFormArr[i]
		if (!item || (item == None) || (item.getFormID() == 0))
			return true
		endif
	endWhile
  return False
endfunction

Bool function isPluginFound(string pluginName) Global
  {Checks if the plugin installed. Works for LE and SE}
  if SKSE.GetVersion() < 2
    return (Game.GetModByName(pluginName) != 255)
  endif
  return Game.IsPluginInstalled(pluginName)
endfunction

Actor Function getPlayerDialogueTarget(Bool bPyramidUtil = False) Global
	{Obtains the actor that player is currently in dialogue with.}
	if bPyramidUtil
		return PyramidUtils.GetPlayerSpeechTarget()
	endif
	Actor kPlayer = Game.GetPlayer()
	Actor kPlayerDialogueTarget
  Int iLoopCount = 10
  While iLoopCount > 0
    iLoopCount -= 1
    kPlayerDialogueTarget = Game.FindRandomActorFromRef(kPlayer , 200.0)
    If kPlayerDialogueTarget && (kPlayerDialogueTarget != kPlayer) && kPlayerDialogueTarget.IsInDialogueWithPlayer() 
      Return kPlayerDialogueTarget
    EndIf
  EndWhile
  Return None
EndFunction

Form Function GetRandomItemFromLeveledItem(LeveledItem akItemList, Int iMaxStepBacksLeveledItem = 10) Global
	{Retrieves a random form from a given leveledlist.}
    Form loc_form = none
    Form loc_startLeveledList = akItemList
    Int loc_size = akItemList.GetNumForms() - 1
    If loc_size < 0
        return none
    EndIf
    Form loc_prevForm = akItemList
    loc_form = akItemList.GetNthForm(RandomInt(0, loc_size))
    LeveledItem loc_nestedLL = loc_form As LeveledItem
    Int loc_stepsBacks = iMaxStepBacksLeveledItem
    While (loc_nestedLL) ;check if form is LL, otherwise do nothing
        ;it's a nested LeveledItem list
        loc_size = loc_nestedLL.GetNumForms() - 1
        if loc_size > 0
            loc_prevForm = loc_form
            loc_form = loc_nestedLL.GetNthForm(RandomInt(0, loc_size))
            waitMenuMode(0.01) ;little wait time in case of error
        else
            ;empty LeveledList entered, do step back
            if loc_stepsBacks
                loc_stepsBacks -= 1
                loc_form = loc_prevForm
            else
                ;no more chances, return none
                return none
            endif
        endif
        loc_nestedLL = loc_form As LeveledItem
    EndWhile
    Return loc_form
EndFunction