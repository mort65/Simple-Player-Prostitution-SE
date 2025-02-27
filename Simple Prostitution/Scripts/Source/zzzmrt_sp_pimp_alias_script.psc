Scriptname zzzmrt_sp_pimp_alias_script extends ReferenceAlias  Conditional

import zzzmrt_sp_utility

event OnReset()
  logText("Pimp is gone.")
  GetOwningQuest().SetStage(10)
endevent

event OnDying(Actor akKiller)
  logText("Pimp is dying.")
  GetOwningQuest().SetStage(10)
endevent