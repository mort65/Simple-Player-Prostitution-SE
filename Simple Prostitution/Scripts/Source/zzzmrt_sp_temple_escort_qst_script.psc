Scriptname zzzmrt_sp_temple_escort_qst_script extends Quest  Conditional

ReferenceAlias Property ClientAlias Auto
zzzmrt_sp_main_qst_script property MainScript auto

import zzzmrt_sp_utility

Event OnInit()
	If ClientAlias && ClientAlias.GetReference()
		actor client = ClientAlias.GetReference() as Actor
		MainScript.log("Temple of Dibella client: "+ client.GetDisplayName() + " | " + client)
	endif
EndEvent



