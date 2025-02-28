Scriptname zzzmrt_sp_int_licenses Hidden

import zzzmrt_sp_utility

Bool Function bHasWhoreLicenseBM(Quest BMLicenses) Global
	BM_Licenses Licenses = BMLicenses as BM_Licenses
	if Licenses
		return Licenses.hasWhoreLicense
	endif
	return True
EndFunction

Function setWhoreViolationBM(Quest BMLicenses) Global
	BM_Licenses Licenses = BMLicenses as BM_Licenses
	if Licenses
		Licenses.isWhoreViolation = true
	endif
EndFunction


Bool Function bFlagWhoreViolationBM(Quest BMLicenses) Global
	BM_Licenses Licenses = BMLicenses as BM_Licenses
	if !Licenses
		return False
	endif
	String[] sVersionArr = StringUtil.Split(Licenses.bmlmcm.GetModVersion(), ".")
	if (sVersionArr.Length < 3) || !isInteger(sVersionArr[0]) || !isInteger(sVersionArr[1])
	    logText("[Licenses] Could not detect the mod version.", false, true, 2)
		return False
	endif
	Int iMajorVersion = sVersionArr[0] as Int
	Int iMinorVersion = sVersionArr[1] as Int
	;Int iPatchVersion = sVersionArr[2] as Int
	if (iMajorVersion < 1) || (iMinorVersion < 0)
	    logText("[Licenses] Unknown version.", false, true, 2)
		return False
	elseif iMajorVersion == 1
		if iMinorVersion < 15 ;No isWhoreViolation variable
			return False
		elseif iMinorVersion == 15 ;Old method
			setWhoreViolationBM(BMLicenses)
			return Licenses.isWhoreViolation
		elseif iMinorVersion == 16
			return Licenses.bmlUtility.FlagViolation(10)
		else
			return Licenses.bmlUtility.FlagViolation(Licenses.bmlUtility.getLicenseID("Whore"))
		endif
	else
		return Licenses.bmlUtility.FlagViolation(Licenses.bmlUtility.getLicenseID("Whore"))
	endif
EndFunction
