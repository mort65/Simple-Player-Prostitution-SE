Scriptname zzzmrt_sp_utility hidden

import Utility

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

String function shortenString(String sString, Int iLimit) Global
	{Shortens the input string and put ... at the end of it.}
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