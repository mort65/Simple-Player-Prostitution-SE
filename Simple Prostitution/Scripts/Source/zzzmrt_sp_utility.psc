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
  if SKSE.getVersion() < 2
    return (Game.getModByName(pluginName) != 255)
  endif
  return Game.isPluginInstalled(pluginName)
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
    kPlayerDialogueTarget = Game.findRandomActorFromRef(kPlayer , 200.0)
    If kPlayerDialogueTarget && (kPlayerDialogueTarget != kPlayer) && kPlayerDialogueTarget.IsInDialogueWithPlayer() 
      Return kPlayerDialogueTarget
    EndIf
  EndWhile
  Return None
EndFunction

Int function randomIntWithExclusionArray(Int iFrom, Int iTo, Bool[] iFlagArray, bool bUsePo3 = false) Global
{Generates a random integer between iFrom and iTo (inclusive), excluding false values with the same index in a bool array}
  if iFrom == iTo
    if iFlagArray[iFrom]
      return iFrom
    endif
    return -1
  elseif iFrom > iTo
    Int iTemp = iFrom
    iFrom = iTo
    iTo = iTemp
  endif
  Int ExcludeCount = 0
  Int iIndex = iFrom
  while iIndex <= iTo
    if (!iFlagArray[iIndex])
      ExcludeCount += 1
    endif
    iIndex += 1
  endwhile
  if ExcludeCount > (iTo - iFrom)
    return -1
  endif
  Int iRandom 
  if bUsePo3
	iRandom = PO3_SKSEFunctions.generateRandomInt(iFrom, iTo - ExcludeCount)
  else
	iRandom = RandomInt(iFrom, iTo - ExcludeCount)
  endif
  if ExcludeCount > 0
    iIndex = iFrom
    while (iIndex <= iTo)
      if (iRandom < iIndex)
        return iRandom
      elseif ((iRandom >= iIndex) && !iFlagArray[iIndex])
        iRandom += 1
      endif
      iIndex += 1
    endwhile
  endif
  return iRandom
endfunction

Form Function getRandomItemFromLeveledListFast(LeveledItem akItemList, Int iMaxStepBacksLeveledItem = 5) Global
	{Retrieves a random form from a given leveledlist.}
    Form loc_form = none
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
        if loc_size > -1
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

Form Function getRandomItemFromLeveledList(LeveledItem akItemList, bool bUsePo3 = false) Global
	{Retrieves a random form from a given leveledlist.}
    Form loc_form = none
    Int loc_size = akItemList.GetNumForms()
    If loc_size < 1
        return none
    EndIf
    LeveledItem loc_nestedLL = akItemList
	Bool[] loc_flags
	Int iIndex
    While (loc_nestedLL) ;check if form is LL, otherwise do nothing
        ;it's a nested LeveledItem list
        loc_size = loc_nestedLL.GetNumForms()
        if loc_size > 0
			loc_flags = createBoolArray(loc_size, False)
			iIndex = 0
			While iIndex < loc_size
				loc_form = loc_nestedLL.GetNthForm(iIndex)
				if isFormValid(loc_form)
					if (loc_form as LeveledItem)
						loc_flags[iIndex] = (((loc_form as LeveledItem).GetNumForms() > 0) && isFormValid((loc_form as LeveledItem).GetNthForm(0)))
					else
						loc_flags[iIndex] = true
					endif
				endif
				iIndex += 1
			endWhile
			if loc_flags.Find(True) < 0 ;All Empty
				return None
			endif
			if loc_flags.Find(False) < 0
				if bUsePo3
					loc_form = loc_nestedLL.GetNthForm(PO3_SKSEFunctions.GenerateRandomInt(0, loc_size - 1))
				else
					loc_form = loc_nestedLL.GetNthForm(RandomInt(0, loc_size - 1))
				endif
			else
				loc_form = loc_nestedLL.GetNthForm(RandomIntWithExclusionArray(0, loc_size - 1, loc_flags, bUsePo3))
			endif
            waitMenuMode(0.01) ;little wait time in case of error
        else
			return none
        endif
        loc_nestedLL = loc_form As LeveledItem
    EndWhile
    Return loc_form
EndFunction

String function sDecToHex(Int iDec) Global
{Converts a decimal integer to hexadecimal}
  Bool bNegetive = False
  if iDec <= 0
    if iDec == 0
      return "00000000"
    else
      iDec *= -1
      bNegetive = True
    endif
  endif
  String sHexes = "0123456789ABCDEF"
  String r = ""
  Bool bAddOne = True
  Int n = iDec
  Int i
  while True
    if bNegetive
      i = 15 - (n % 16)
      if bAddOne
        i += 1
        if i == 16
          i = 0
        else
          bAddOne = False
        endif
      endif
    else
      i = n % 16
    endif
    r += GetNthChar(sHexes, i)
    n = (n / 16) As Int
    if n == 0
      String sResult = ""
      n = GetLength(r)
      while n > 0
        n -= 1
        sResult += GetNthChar(r, n)
      endwhile
      if GetLength(sResult) < 8
        if bNegetive
          return Substring("FFFFFFFF", 0, 8 - GetLength(sResult)) + sResult
        else
          return Substring("00000000", 0, 8 - GetLength(sResult)) + sResult
        endif
      endif
      return sResult
    endif
  endwhile
endfunction

Function logText(String asText, Bool bNotification = False, Bool bTrace = True, Int aiSeverity = 1, String asSender = "SPP", String asDefaultColor = "9F00FF", String asSuccessColor = "00FF00", String asInfoColor = "00FFFF", String asWarningColor = "FFFF00", String asErrorColor = "FF0000", String asSeparatorColor = "FFFFFF") Global
	{Outputs a formatted message to log or/and on the screen. aiSeverity = (0,1,2,3) = (Success, Info, Warning, Error)}
	If !asText || (!bTrace && !bNotification)
		return
	endif
	String sColor
	String sType
	Int iSeverity
	If aiSeverity >= 3
		sColor = asErrorColor
		iSeverity = 2
		sType = "(Error)"
	elseif aiSeverity == 2
		sColor = asWarningColor
		iSeverity = 1
		sType = "(Warning)"
	elseif aiSeverity == 1
		sColor = asInfoColor
		iSeverity = 0
		sType = "(Info)"
	else
		sColor = asSuccessColor
		iSeverity = 0
		sType = "(Success)"
	endif
	if bTrace
		Debug.trace(asSender + " " + sType + " -:- " + asText, iSeverity)
	endif
	if 	bNotification
		Debug.Notification("<font color='#" +  asDefaultColor + "'>" + asSender + "</font>" + "<font color='#" + asSeparatorColor +"'>" + " -:- " + "</font>" + "<font color='#" + sColor  + "'>" + asText + "</font>")
	endif
EndFunction

Function reduceFormList(Formlist fList, int iSize) Global
	;Decrease the size of a formlist by removing items.
	;If iSize is negative, it indicates the number of items that should be removed.
	;If it is positive, it indicates the new size of the formlist.
	if (!fList || (fList.GetSize() < 1))
		return
	endif
	int iNewSize
	if iSize < 0
		iNewSize = maxInt(0, fList.GetSize() + iSize)
	else
		iNewSize = iSize
	endif
	While fList.GetSize() > iNewSize
		fList.RemoveAddedForm(fList.GetAt(fList.GetSize() - 1))
	EndWhile
EndFunction

Function Teleport(objectReference akObject, objectReference akTarget, float afXOffset = 0.0, float afYOffset = 0.0, float afZOffset = 0.0, bool abMatchRotation = true) Global
	if (!akObject || !akTarget)
		return
	endif
	akObject.DisableNoWait()
	akObject.MoveTo(akTarget, afXOffset, afYOffset, afZOffset, abMatchRotation)
	akObject.EnableNoWait()
	(akObject as actor) && (akObject as actor).EvaluatePackage()
EndFunction