Scriptname zzzmrt_sp_temple_qst_client_alias_scr extends ReferenceAlias  Conditional

event OnReset()
  Debug.Trace("Simple Prostitution: Client is gone.")
  GetOwningQuest().setStage(10)
endevent

event OnDying(Actor akKiller)
  Debug.Trace("Simple Prostitution: Client is dying.")
  GetOwningQuest().setStage(10)
endevent