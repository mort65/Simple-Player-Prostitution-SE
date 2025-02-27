Scriptname zzzmrt_sp_temple_qst_client_alias_scr extends ReferenceAlias  Conditional

import zzzmrt_sp_utility

event OnReset()
  logText("Client is gone.")
  GetOwningQuest().setStage(10)
endevent

event OnDying(Actor akKiller)
  logText("Client is dying.")
  GetOwningQuest().setStage(10)
endevent