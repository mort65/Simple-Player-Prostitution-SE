Scriptname zzzmrt_sp_cure_mild_std_script extends ActiveMagicEffect  

zzzmrt_sp_std_qst_script property STD_Script Auto

Event OnEffectStart(Actor Target, Actor Caster)
	STD_Script.cureActorSTDs(Target, False, maxStage = 1, maxCures = 1)
endEvent