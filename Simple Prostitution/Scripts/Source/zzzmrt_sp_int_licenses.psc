Scriptname zzzmrt_sp_int_licenses Hidden

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

