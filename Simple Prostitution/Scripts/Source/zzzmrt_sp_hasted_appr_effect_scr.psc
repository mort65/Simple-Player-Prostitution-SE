Scriptname zzzmrt_sp_hasted_appr_effect_scr extends activemagiceffect  

zzzmrt_sp_main_qst_script property MainScript auto

Actor mySelf

event onEffectStart(Actor akTarget, Actor akCaster)
	if akTarget
		akTarget.ModActorValue("CarryWeight", 0.1)
		akTarget.ModActorValue("CarryWeight", -0.1)
		if akTarget == MainScript.ApproachMonitorScr.approachingRef.GetActorReference()
			mySelf = akTarget
			if MainScript.bIsPapyrusUtilActive && !MainScript.isActorHavingSex(mySelf)
				ActorUtil.AddPackageOverride(akTarget, MainScript.customerForceGreetPackage, 100, 1)
				akTarget.EvaluatePackage()
			endif
		endif
	endif
endEvent

event onEffectFinish(Actor akTarget, Actor akCaster)
	Actor target = akTarget
	if !akTarget
		target = mySelf
	endif
	if target
		target.ModActorValue("CarryWeight", 0.1)
		target.ModActorValue("CarryWeight", -0.1)
		if target && MainScript.bIsPapyrusUtilActive
			ActorUtil.RemovePackageOverride(target, MainScript.customerForceGreetPackage)
			if !MainScript.isCustomer(target)
				MainScript.removeSceneFlagFromActor(target)
		    endif
			target.EvaluatePackage()
		endif
	endif
endEvent
