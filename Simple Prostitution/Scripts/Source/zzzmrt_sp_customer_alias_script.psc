Scriptname zzzmrt_sp_customer_alias_script extends ReferenceAlias  Conditional

Quest property MainQuest auto
zzzmrt_sp_main_qst_script property MainScript auto
ReferenceAlias property myAlias Auto
Package property myPackage Auto

Actor mySelf

Event OnInit()
	if myAlias.GetActorRef() 
		if (mySelf != myAlias.GetActorRef())
			mySelf = myAlias.GetActorRef()
			Form myActorBase = mySelf.GetLeveledActorBase()
			String sName = myActorBase.GetName()
			if sName == "" && MainScript.bIsPO3ExtenderActive
				sName = PO3_SKSEFunctions.GetFormEditorID(mySelf)
			endif
			Debug.trace("Simple Prostitution: " + mySelf + " | " + myActorBase  +  " : " + sName + " following player for sex.")
		endif
		if MainScript.bIsPapyrusUtilActive && MainScript.fAliasCheckTimer > 0.0
			registerForSingleUpdate(MainScript.fAliasCheckTimer)
		endif
	endif
EndEvent

Event OnUpdate()
	;Debug.trace("Simple Prostitution: OnUpdate() triggered for " + self.GetName())
	if MainScript.bIsPapyrusUtilActive
		if MainQuest.isRunning()
			if myAlias.GetActorRef()
				if mySelf == myAlias.GetActorRef()
					if (mySelf.GetCurrentPackage() != myPackage) && !MainScript.isActorHavingSex(mySelf)
						ActorUtil.RemovePackageOverride(mySelf, myPackage)
						ActorUtil.AddPackageOverride(mySelf, myPackage, 100)
						mySelf.EvaluatePackage()
					endif
				else
					OnInit()
					return
				endif
				if MainScript.fAliasCheckTimer > 0.0
					registerForSingleUpdate(MainScript.fAliasCheckTimer)
				endif
			endif
		Endif
	endif
EndEvent