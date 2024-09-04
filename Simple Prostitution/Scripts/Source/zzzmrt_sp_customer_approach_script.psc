Scriptname zzzmrt_sp_customer_approach_script extends Quest  Conditional

Quest Property ApproachMonitorQst Auto
Quest property MainQuest auto
zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto
zzzmrt_sp_main_qst_script property MainScript auto
ReferenceAlias property approachingCustomerAlias Auto

Actor approachingActor

Event OnInit()
	if approachingCustomerAlias.GetActorRef() && (approachingActor != approachingCustomerAlias.GetActorRef())
		approachingActor = approachingCustomerAlias.GetActorRef()
		Form approachingActorBase = approachingActor.GetLeveledActorBase()
		String sName = approachingActorBase.GetName()
		if sName == "" && MainScript.bIsPO3ExtenderActive
			sName = PO3_SKSEFunctions.GetFormEditorID(approachingActor)
		endif
		Debug.trace("Simple Prostitution: " + approachingActor + " | " + approachingActorBase  +  " : " + sName + " approaching player.")
    endif
	if MainScript.bIsPapyrusUtilActive && MainScript.fAliasCheckTimer > 0.0
		registerForSingleUpdate(MainScript.fAliasCheckTimer)
	endif
EndEvent

Event OnUpdate()
	;Debug.trace("Simple Prostitution: OnUpdate() triggered for " + self.GetName())
	if MainScript.bIsPapyrusUtilActive
		if approachingActor && approachingCustomerAlias.GetActorRef()
			if approachingActor == approachingCustomerAlias.GetActorRef()
				if (approachingActor.GetCurrentPackage() != MainScript.customerForceGreetPackage) && !MainScript.isActorHavingSex(approachingActor)
					ActorUtil.RemovePackageOverride(approachingActor, MainScript.customerForceGreetPackage)
					ActorUtil.AddPackageOverride(approachingActor, MainScript.customerForceGreetPackage, 100)
					approachingActor.EvaluatePackage()
				endif
				if MainScript.fAliasCheckTimer > 0.0
					registerForSingleUpdate(MainScript.fAliasCheckTimer)
				endif
			endif
		endif
    endif
EndEvent
