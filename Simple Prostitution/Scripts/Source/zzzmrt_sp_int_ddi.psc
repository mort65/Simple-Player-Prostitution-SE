Scriptname zzzmrt_sp_int_ddi Hidden


Int function _iAddRandomKeyToActor(ObjectReference akRef, Form[] akeyArr, Int aiNum = 1) Global
  if (aiNum < 1) || (akeyArr.Length < 1)
    return 0
  endif
  Int iResult = 0
  Int iTotalKeys = akeyArr.Length
  Int[] KeyNum = utility.createIntArray(iTotalKeys, 0)
  Int jIndex
  Int iIndex = 0
  while iIndex < aiNum
    jIndex = Utility.RandomInt(0, iTotalKeys - 1)
    KeyNum[jIndex] = KeyNum[jIndex] + 1
    iIndex += 1
  endWhile
  iIndex = iTotalKeys
  While iIndex > 0
    iIndex -= 1
    jIndex = KeyNum[iIndex]
    if akeyArr[iIndex] && jIndex > 0
      akRef.Additem(akeyArr[iIndex], jIndex)
      iResult += jIndex
    endif
  EndWhile
  return iResult
EndFunction