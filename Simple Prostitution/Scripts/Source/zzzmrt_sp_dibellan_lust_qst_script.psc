Scriptname zzzmrt_sp_dibellan_lust_qst_script extends Quest Conditional

GlobalVariable property DibellanLustCustomers_g Auto
Int property iRequiredTotalCustomers = 10 Auto Hidden Conditional
Quest property DibellanLust_Qst Auto
zzzmrt_sp_main_qst_script property MainScript auto

Function updateQuest(int iNum)
	if (iNum < 1)
		return
	endif
	if (DibellanLust_Qst.isrunning() && DibellanLust_Qst.getStage() == 1)	
	  if DibellanLust_Qst.ModObjectiveGlobal(iNum, DibellanLustCustomers_g, 0, iRequiredTotalCustomers)
			DibellanLust_Qst.setStage(5)
		endif
	endif
endfunction