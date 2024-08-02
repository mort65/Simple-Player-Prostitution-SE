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
