Scriptname zzzmrt_sp_customer_approach_script extends Quest  Conditional

Quest Property ApproachMonitorQst Auto
Quest property MainQuest auto
zzzmrt_sp_appr_monitor_qst_script property ApproachMonitorScr Auto
zzzmrt_sp_main_qst_script property MainScript auto
ReferenceAlias property approachingCustomerAlias Auto

Actor approachingActor

Event OnInit()
	if approachingCustomerAlias.GetActorRef()
		approachingActor = approachingCustomerAlias.GetActorRef()
		Form approachingActorBase = approachingActor.GetLeveledActorBase()
		String sName = approachingActorBase.GetName()
		if sName == "" && MainScript.bIsPO3ExtenderActive
			sName = PO3_SKSEFunctions.GetFormEditorID(approachingActor)
		endif
		Debug.trace("Simple Prostitution: " + approachingActor + " | " + approachingActorBase  +  " : " + sName + " approaching player.")
    endif
EndEvent
