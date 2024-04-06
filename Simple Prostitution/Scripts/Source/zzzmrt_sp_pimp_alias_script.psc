Scriptname zzzmrt_sp_pimp_alias_script extends ReferenceAlias  Conditional

event OnReset()
  Debug.Trace("Simple Prostitution: Pimp is gone.")
  GetOwningQuest().SetStage(10)
endevent

event OnDying(Actor akKiller)
  Debug.Trace("Simple Prostitution: Pimp is dying.")
  GetOwningQuest().SetStage(10)
endevent