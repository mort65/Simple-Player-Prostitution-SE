Scriptname zzzmrt_sp_temple_escort_qst_script extends Quest  Conditional

ReferenceAlias Property ClientAlias Auto
zzzmrt_sp_main_qst_script property MainScript auto

Event OnInit()
	actor client = ClientAlias.GetReference() as Actor
	Debug.trace("Simple Prostitution: Temple of Dibella client: "+ client.GetDisplayName() + " | " + client)
EndEvent



