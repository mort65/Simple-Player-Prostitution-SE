Scriptname zzzmrt_sp_int_sla Hidden

Int Function _GetActorArousal(Quest sla_Framework, Actor akActor) Global
	slaFrameworkScr SLA = sla_Framework as slaFrameworkScr
	if !akActor || !SLA
		return -3
	endif
	return SLA.GetActorArousal(akActor)
EndFunction