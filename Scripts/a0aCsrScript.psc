Scriptname a0aCsrScript extends Quest Conditional

Import Debug

Bool Property HasHunter Auto
Bool Property HasMerch Auto
Bool Property HasSmith Auto
Bool Property HasCommoner Auto

referenceAlias Property CsrNPC1 auto
referenceAlias Property CsrNPC2 auto
referenceAlias Property CsrNPC3 auto
referenceAlias Property CsrNPC4 auto
referenceAlias Property CsrNPC5 auto
Perk Property a0aCsrPerk1 Auto
Perk Property a0aCsrPerk2 Auto
Perk Property a0aCsrPerk3 Auto
Perk Property a0aCsrPerk4 Auto
Perk Property a0aCsrPerk5 Auto
Perk Property a0aCsrPerkLev2Ment Auto
referenceAlias Property a0aCsrNeedsHealing1 Auto
referenceAlias Property a0aCsrNeedsHealing2 Auto
referenceAlias Property a0aCsrNeedsHealing3 Auto
referenceAlias Property CsrText Auto
Actor Property CsrHealer1 Auto
Actor Property CsrHealer2 Auto
Actor Property CsrHealer3 Auto

Quest Property a0aCoreQuest Auto
Quest Property a0aCsrQuest Auto
Quest Property a0aCsrRecruitment Auto

Message Property a0aCsrMessageLeave Auto
Message Property a0aCsrMessageDead Auto
Message Property a0aCsrMessageJoin Auto

Faction Property a0aCoreFactionHeal Auto
Faction Property a0aCoreFactionHealed Auto
Faction Property a0aCsrFaction Auto
Faction Property a0aCsrFactionClassHunter Auto
Faction Property a0aCsrFactionClassCommoner Auto
Faction Property a0aCsrFactionClassSmith Auto
Faction Property a0aCsrFactionClassMerch Auto
Faction Property a0aCoreFactionAbility Auto
Faction Property a0aCSRfactionHorse Auto

Faction Property a0aCsrFactionSpellConjuration Auto
Faction Property a0aCsrFactionSpellRestoration Auto
Faction Property a0aCsrFactionSpellDestruction Auto

GlobalVariable Property a0aCsrCount Auto
GlobalVariable Property a0aCsrClassHasCommoner Auto
GlobalVariable Property a0aCsrClassHasHunter Auto
GlobalVariable Property a0aCsrClassHasMerch Auto
GlobalVariable Property a0aCsrClassHasSmith Auto
GlobalVariable Property a0aCsrInvOpen Auto

Faction Property a0aCsrFactionLevel Auto
Spell Property a0aCsrAbLevelPerkIllusion Auto
Spell Property a0aCsrAbLevelPerkDestruction Auto
Spell Property a0aCsrAbLevelPerkBlock Auto
Spell Property a0aCsrAbLevelPerkLightArmour Auto
Spell Property a0aCsrAbLevelPerkHeavyArmour Auto
Spell Property a0aCsrAbLevelPerkOneHanded Auto
Spell Property a0aCsrAbLevelPerkTwoHanded Auto
Spell Property a0aCsrAbLevelPerkMarksman Auto

Formlist Property a0aCsrSpellListAlteration Auto
Formlist Property a0aCsrSpellListDestruction Auto
Formlist Property a0aCsrSpellListConjuration Auto
Formlist Property a0aCsrSpellListRestoration Auto

Float CsrCount = 0.0
Float Property fTradeVal Auto
bool Property bTrading Auto


Perk Property a0aCsrInventoryPerk Auto
Spell PRoperty a0aCsrAbilityClassHunter Auto
Spell Property a0aCsrAbilityNoMagicka Auto
Spell Property a0aCsrAbilityNoMarksman Auto

message Property a0aCsrMessageDisp Auto
message Property a0aCSRmessageDispFAIL Auto
faction Property PlayerMarriedFaction Auto
faction Property PlayerHousecarlFaction Auto

Actor[] Property FriendArray Auto

formlist Property WEHealingPotions auto
VisualEffect Property a0aCsrVFXHealTarget Auto

bool bInCombat

Event OnInit()
	FriendArray = New Actor[128]
	RegisterForSingleUpdate(1.0)
EndEvent
Event onUpdate()
	if(bInCombat != game.getPlayer().isincombat())	
		bInCombat = game.getPlayer().isincombat()
		if(!bInCombat)
			if(CSRhealer1)
				PartyFollow(CSRhealer1)
				CSRhealer1=NONE
			endif
			if(CSRhealer2)
				PartyFollow(CSRhealer2)
				CSRhealer2=NONE
			endif
			if(CSRhealer3)
				PartyFollow(CSRhealer3)
				CSRhealer3=NONE
			endif
			if(a0aCsrNeedsHealing1)
				a0aCsrNeedsHealing1.getActorRef().RemoveFromFaction(a0aCoreFactionHealed)
				a0aCsrNeedsHealing1.clear()
			endif
			if(a0aCsrNeedsHealing2)
				a0aCsrNeedsHealing2.getActorRef().RemoveFromFaction(a0aCoreFactionHealed)
				a0aCsrNeedsHealing2.clear()
			endif
			if(a0aCsrNeedsHealing3)
				a0aCsrNeedsHealing3.getActorRef().RemoveFromFaction(a0aCoreFactionHealed)
				a0aCsrNeedsHealing3.clear()
			endif
		endif
	endif
	RegisterForSingleUpdate(1.0)
endEvent

bool Function PartyPotion(actor NPCref,bool bTimer)
	if(game.getPlayer().GetItemCount(WEHealingPotions)>0)	
		if(bTimer)
			NPCref.setNoBleedoutRecovery(FALSE)
			NPCref.DamageAV("Health",10)
			NPCref.RestoreAV("Health",100)
		endif
			
		a0aCsrVFXHealTarget.play(NPCref,1)
		int iLoop=0
		form fLoopItem
		while(iLoop < WEHealingPotions.GetSize())
			fLoopItem=WEHealingPotions.GetAt(iLoop)
			if(game.GetPlayer().GetItemCount(fLoopItem))
				game.GetPlayer().RemoveItem(fLoopItem,1)
				iLoop=99999
			endif
			iLoop=iLoop+1
		endwhile
		return TRUE
	else	
		return FALSE
	endif
endFunction

bool Function RelationshipMod(actor NPCref, int iMod)
	if(!NPCref.isInFaction(PlayerMarriedFaction)&&!NPCref.isinFaction(PlayerHousecarlFaction))
		int iRelation=NPCref.GetRelationshipRank(game.GetPlayer()) + iMod
		NPCref.setRelationshipRank(game.GetPlayer(),iRelation)
	endif
endFunction

Function PartyHorse(actor NPCref)
	if(NPCref.getFactionRank(a0aCSRfactionHorse)>1)
		NPCref.setfactionrank(a0aCSRfactionHorse,1)
		NPCref.dismount()
	else
		NPCref.setfactionrank(a0aCSRfactionHorse,0)
	endif
EndFunction
Function PartyNoMarksman(actor NPCref)
	if(NPCref.HasSpell(a0aCsrAbilityNoMarksman))
		NPCref.RemoveSpell(a0aCsrAbilityNoMarksman)
	else
		NPCref.AddSpell(a0aCsrAbilityNoMarksman)
	endif
EndFunction
Function PartyNoMagicka(actor NPCref)
	if(NPCref.HasSpell(a0aCsrAbilityNoMagicka))
		NPCref.RemoveSpell(a0aCsrAbilityNoMagicka)
	else
		NPCref.AddSpell(a0aCsrAbilityNoMagicka)
	endif
EndFunction

Function PartyInventory(actor NPCref)
	if((NPCref as Actor))
		fTradeVal = 0.0
		bTrading = TRUE
		NPCref.openInventory(true)
		utility.wait(0.1)

		while(utility.isInMenuMode())	;Wait for inventory to close
			utility.wait(0.05)
		endwhile
					
		bTrading = FALSE

		if(!NPCref.isInFaction(PlayerMarriedFaction)&&NPCref.isinFaction(PlayerHousecarlFaction))
			(a0aCsrRecruitment as a0aCsrQuestRecruitment).DispositionRecalc(NPCref,fTradeVal,FALSE)
			if(NPCref.getRelationshipRank(game.GetPlayer())<1)	
				PartyLastChance(NPCref)
			endif
		endif
	endif
endFunction

Function PartyLastChance(Actor NPCref)
	CsrText.forceRefTo(NPCref)
	a0aCSRmessageDisp.show()
	(a0aCsrRecruitment as a0aCsrQuestRecruitment).FriendGift(NPCref)
	if(NPCref.getRelationshipRank(game.GetPlayer())<1)
		a0aCSRmessageDispFAIL.show()
		PartyLeave(NPCref, TRUE)
	endif
EndFunction

Function PartyJoin(Actor NPCref, bool bVerbose)
	if((NPCref as Actor))
		bool bSuccess = True
		
		if(CsrNPC1.GetActorRef() == None)
			CsrNPC1.ForceRefTo(NPCref)
			SetObjectiveDisplayed(1,true,true)
		Elseif(CsrNPC2.GetActorRef() == None)
			CsrNPC2.ForceRefTo(NPCref)
			SetObjectiveDisplayed(2,true,true)
		Elseif(CsrNPC3.GetActorRef() == None)
			CsrNPC3.ForceRefTo(NPCref)
			SetObjectiveDisplayed(3,true,true)
		Elseif(CsrNPC4.GetActorRef() == None)
			CsrNPC4.ForceRefTo(NPCref)
			SetObjectiveDisplayed(4,true,true)
		Elseif(CsrNPC5.GetActorRef() == None)
			CsrNPC5.ForceRefTo(NPCref)
			SetObjectiveDisplayed(5,true,true)
		Else
			bSuccess = False
		EndIf
		
		If(bSuccess)
			(a0aCoreQuest as a0aCoreScript).FollowerJoin(NPCref)
			(a0aCsrQuest as a0aCsrClassScript).ClassJoin(NPCref)
			
			PartyAssess()	
			if(bVerbose)
				a0aCsrMessageJoin.Show(CsrCount)
			EndIf
		EndIf
	EndIf
EndFunction

Function PartyLeave(Actor NPCref, bool bVerbose)
	if((NPCref as Actor))
		ReferenceAlias NPCalias
		if(NPCRef == CsrNPC1.GetActorRef())
			NPCalias = CsrNPC1
		Elseif(NPCRef == CsrNPC2.GetActorRef())
			NPCalias = CsrNPC2
		Elseif(NPCRef == CsrNPC3.GetActorRef())
			NPCalias = CsrNPC3
		Elseif(NPCRef == CsrNPC4.GetActorRef())
			NPCalias = CsrNPC4
		Elseif(NPCRef == CsrNPC5.GetActorRef())
			NPCalias = CsrNPC5		
		EndIf
		if(NPCalias)
			PartyLeaveA(NPCalias,bVerbose)
		EndIf
	EndIf
EndFunction

Function PartyLeaveA(ReferenceAlias NPCalias, bool bVerbose)
	Actor NPCref = NPCalias.GetActorRef()

	if(NPCref.IsPlayerTeammate()||NPCref.IsDead())
		NPCref.RemoveSpell(a0aCsrAbilityNoMagicka)
		NPCref.RemoveSpell(a0aCsrAbilityNoMarksman)
		
		(a0aCoreQuest as a0aCoreScript).FollowerLeave(NPCref)
		(a0aCsrQuest as a0aCsrClassScript).ClassJoin(NPCref)
	
		PartyAssess()
		
		if(bVerbose)
			if(NPCref.IsDead())
				a0aCsrMessageLeave.Show(CsrCount)
			Else
				a0aCsrMessageDead.Show()
			EndIf
		endif
		if(NPCalias==CsrNPC1)
			SetObjectiveDisplayed(1,false,true)
		elseif(NPCalias==CsrNPC2)
			SetObjectiveDisplayed(2,false,true)
		elseif(NPCalias==CsrNPC3)
			SetObjectiveDisplayed(3,false,true)
		elseif(NPCalias==CsrNPC4)
			SetObjectiveDisplayed(4,false,true)
		elseif(NPCalias==CsrNPC5)
			SetObjectiveDisplayed(5,false,true)
		EndIf
		NPCalias.Clear()
		
		int LoopVar=0
		While (LoopVar < FriendArray.length)	
			if(FriendArray[LoopVar])
				LoopVar = LoopVar +1
			else
				FriendArray[LoopVar]=NPCref
				LoopVar = 999
			endif
		EndWhile
	endif
EndFunction

Function PartyAssess()
	Int LoopVar = 0
	Actor LoopItem
	Actor[] TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
	
	Int FollowerCount = 0
	a0aCsrClassHasCommoner.SetValue(0)
	a0aCsrClassHasHunter.SetValue(0)
	a0aCsrClassHasMerch.SetValue(0)
	a0aCsrClassHasSmith.SetValue(0)
	
	While(LoopVar<TempArray.Length)
		LoopItem=TempArray[LoopVar]
		If(LoopItem)
			if(LoopItem.IsInFaction(a0aCsrFaction))
				FollowerCount = FollowerCount +1
				LoopItem.RemoveSpell(a0aCsrAbilityClassHunter)
				if(LoopItem.IsInFaction(a0aCsrFactionClassCommoner))
					a0aCsrClassHasCommoner.SetValue(1)
				Elseif(LoopItem.IsInFaction(a0aCsrFactionClassHunter))
					a0aCsrClassHasHunter.SetValue(1)
				Elseif(LoopItem.IsInFaction(a0aCsrFactionClassMerch))
					a0aCsrClassHasMerch.SetValue(1)
				Elseif(LoopItem.IsInFaction(a0aCsrFactionClassSmith))
					a0aCsrClassHasSmith.SetValue(1)
				EndIf
			EndIf
		EndIf
		LoopVar=LoopVar+1
	EndWhile
	CsrCount = (FollowerCount as float)
	a0aCsrCount.SetValue(FollowerCount)	
	
	if(a0aCsrClassHasHunter.GetValue()>0)
		LoopVar=0
		While(LoopVar<TempArray.Length)
			if(LoopItem.IsInFaction(a0aCsrFaction))	
				LoopItem.AddSpell(a0aCsrAbilityClassHunter)
			EndIf
		EndWhile
		LoopVar=LoopVar+1
	EndIf
	
EndFunction

Function PartyFollowWait(Actor NPCref)
	if((NPCref as Actor))
		if(NPCref.IsPlayerTeammate())
			if(NPCref.GetActorValue("WaitingForPlayer")>0)
				(a0aCoreQuest as a0aCoreScript).FollowerFollow(NPCref)
			Else
				(a0aCoreQuest as a0aCoreScript).FollowerWait(NPCref)
			EndIf	
		Else
			(a0aCoreQuest as a0aCoreScript).FollowerJoin(NPCref)
			(a0aCsrQuest as a0aCsrClassScript).ClassJoin(NPCref)
			PartyAssess()
		EndIf
	EndIf
EndFunction

Function PartyWait(Actor NPCref)
	if((NPCref as Actor))
		(a0aCoreQuest as a0aCoreScript).FollowerWait(NPCref)
	EndIf
EndFunction
Function PartyFollow(Actor NPCref)
	if((NPCref as Actor))
		if(NPCref.IsPlayerTeammate())
			(a0aCoreQuest as a0aCoreScript).FollowerFollow(NPCref)
		Else
			(a0aCoreQuest as a0aCoreScript).FollowerJoin(NPCref)
			(a0aCsrQuest as a0aCsrClassScript).ClassJoin(NPCref)
			PartyAssess()
		EndIf
	EndIf
EndFunction

Function PartyDeploy(Actor NPCref, int iMode)
	if((NPCref as Actor))	
		(a0aCoreQuest as a0aCoreScript).FollowerLeave(NPCref)
		(a0aCsrQuest as a0aCsrClassScript).ClassJoin(NPCref)
		PartyAssess()
		NPCref.SetAV("WaitingForPlayer",iMode)
	EndIf
EndFunction

Function PartyTidyup(Actor NPCref)
	if((NPCref as Actor))
		if(NPCref == CsrHealer1)
			CsrHealer1=None
			a0aCsrNeedsHealing1.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
			a0aCsrNeedsHealing1.Clear()
		elseif(NPCref == CsrHealer2)
			CsrHealer2=None
			a0aCsrNeedsHealing2.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
			a0aCsrNeedsHealing2.Clear()
		elseif(NPCref == CsrHealer3)
			CsrHealer3=None
			a0aCsrNeedsHealing3.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
			a0aCsrNeedsHealing3.Clear()
		endif
		PartyFollow(NPCref)
	EndIf
EndFunction

Function PartyStance(Actor NPCref)
	if((NPCref as Actor))
		if(NPCref.GetActorValue("Aggression")>0)
			(a0aCoreQuest as a0aCoreScript).FollowerStancePassive(NPCref)
		Else
			(a0aCoreQuest as a0aCoreScript).FollowerStanceAggressive(NPCref)
		EndIf	
	EndIf
EndFunction

effectshader property AbsorbBlueFXS auto
Function PartyAbility(Actor NPCref)
	if(NPCref as Actor)
		if(NPCRef.GetFactionRank(a0aCoreFactionAbility)>0)
			(a0aCoreQuest as a0aCoreScript).FollowerAbilityDisable(NPCref)
		Else
			(a0aCoreQuest as a0aCoreScript).FollowerAbilityEnable(NPCref)
		EndIf		
	EndIf
EndFunction

Function PartyMedic(Actor NPCref)
	if((NPCref as Actor))
		if(NPCRef.GetFactionRank(a0aCoreFactionHeal)>0)
			(a0aCoreQuest as a0aCoreScript).FollowerMedicStop(NPCref)
		Else
			(a0aCoreQuest as a0aCoreScript).FollowerMedicStart(NPCref)
		EndIf		
	EndIf
EndFunction

Function AdvanceLevel(Actor NPCref)
	int iLevel
	if(NPCref.IsInFaction(a0aCsrFactionLevel))
		iLevel = Game.GetPlayer().GetLevel() - NPCref.GetFactionRank(a0aCsrFactionLevel)
	Else
		iLevel = Game.GetPlayer().GetLevel() - NPCref.GetLevel()
	EndIf
	
	if(iLevel>0)
		NPCref.SetFactionRank(a0aCsrFactionLevel,Game.GetPlayer().GetLevel())

		spell sSpell
		int iSkillThresh = 20
		int iTotal = NPCref.GetLevel()+NPCref.GetFactionRank(a0aCsrFactionLevel)
		float fSkillUp = 2 * (iLevel as float)
		float fScratch
	
		NPCref.modAV("Health",(iLevel as float)*3)
		NPCref.modAV("Magicka",(iLevel as float)*3)
		NPCref.modAV("Stamina",(iLevel as float)*3)
		
		if(NPCref.GetBaseAV("Illusion") >= iSkillThresh)
			if(NPCref.GetAV("Illusion")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Illusion")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Illusion",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkIllusion)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("Restoration") >= iSkillThresh)
			if(NPCref.GetAV("Restoration")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Restoration")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Restoration",fScratch)
			
			if(!NPCref.IsInFaction(a0aCsrFactionSpellRestoration))
				NPCref.AddToFaction(a0aCsrFactionSpellRestoration)
				NPCref.AddSpell(((a0aCsrSpellListRestoration.GetAt(0) as formList).GetAt(utility.RandomInt(0,1)) as spell))
			EndIf
			if(NPCref.GetFactionRank(a0aCsrFactionSpellRestoration)==0)
				if(NPCref.GetAV("Restoration")>=25)
					NPCref.SetFactionRank(a0aCsrFactionSpellRestoration,1)
					NPCref.AddSpell((a0aCsrSpellListRestoration.GetAt(0) as formList).GetAt(utility.RandomInt(0,1)) as spell)
					NPCref.AddSpell((a0aCsrSpellListRestoration.GetAt(1) as formList).GetAt(utility.RandomInt(0,1)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellRestoration)==1)
				if(NPCref.GetAV("Restoration")>=50)
					NPCref.SetFactionRank(a0aCsrFactionSpellRestoration,2)
					NPCref.AddSpell((a0aCsrSpellListRestoration.GetAt(1) as formList).GetAt(utility.RandomInt(0,1)) as spell)
					NPCref.AddSpell((a0aCsrSpellListRestoration.GetAt(2) as formList).GetAt(utility.RandomInt(0,1)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellRestoration)==2)
				if(NPCref.GetAV("Restoration")>=75)
					NPCref.SetFactionRank(a0aCsrFactionSpellRestoration,3)
					NPCref.AddSpell((a0aCsrSpellListRestoration.GetAt(2) as formList).GetAt(utility.RandomInt(0,1)) as spell)
				EndIf
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("Destruction") >= iSkillThresh)
			if(NPCref.GetAV("Destruction")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Destruction")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Destruction",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddToFaction(a0aCsrFactionSpellDestruction)
				NPCref.AddSpell(a0aCsrAbLevelPerkDestruction)
			EndIf

			if(!NPCref.IsInFaction(a0aCsrFactionSpellDestruction))
				NPCref.AddSpell(((a0aCsrSpellListDestruction.GetAt(0) as formList).GetAt(utility.RandomInt(0,2)) as spell))
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellDestruction)==0)
				if(NPCref.GetAV("Destruction")>=25)
					NPCref.SetFactionRank(a0aCsrFactionSpellDestruction,1)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(0) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(1) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellDestruction)==1)
				if(NPCref.GetAV("Destruction")>=50)
					NPCref.SetFactionRank(a0aCsrFactionSpellDestruction,2)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(1) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(2) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellDestruction)==2)
				if(NPCref.GetAV("Destruction")>=75)
					NPCref.SetFactionRank(a0aCsrFactionSpellDestruction,3)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(2) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListDestruction.GetAt(3) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
			
		EndIf
		
		if(NPCref.GetBaseAV("Conjuration") >= iSkillThresh)
			if(NPCref.GetAV("Conjuration")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Conjuration")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Conjuration",fScratch)
			
			if(!NPCref.IsInFaction(a0aCsrFactionSpellConjuration))
				NPCref.AddSpell(((a0aCsrSpellListConjuration.GetAt(0) as formList).GetAt(utility.RandomInt(0,2)) as spell))
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellConjuration)==0)
				if(NPCref.GetAV("Conjuration")>=25)
					NPCref.SetFactionRank(a0aCsrFactionSpellConjuration,1)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(0) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(1) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellConjuration)==1)
				if(NPCref.GetAV("Conjuration")>=50)
					NPCref.SetFactionRank(a0aCsrFactionSpellConjuration,2)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(1) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(2) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
			if(NPCref.getFactionRank(a0aCsrFactionSpellConjuration)==2)
				if(NPCref.GetAV("Conjuration")>=75)
					NPCref.SetFactionRank(a0aCsrFactionSpellConjuration,3)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(2) as formList).GetAt(utility.RandomInt(0,2)) as spell)
					NPCref.AddSpell((a0aCsrSpellListConjuration.GetAt(3) as formList).GetAt(utility.RandomInt(0,2)) as spell)
				EndIf
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("Alteration") >= iSkillThresh)
			if(NPCref.GetAV("Alteration")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Alteration")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Alteration",fScratch)
			
			NPCref.AddSpell(a0aCsrSpellListAlteration.GetAt(0) as spell)
			if(NPCref.GetAV("Alteration") >= 25)
				NPCref.AddSpell(a0aCsrSpellListAlteration.GetAt(1) as spell)
			EndIf
			if(NPCref.GetAV("Alteration") >= 50)
				NPCref.AddSpell(a0aCsrSpellListAlteration.GetAt(2) as spell)
			EndIf
			if(NPCref.GetAV("Alteration") >= 75)
				NPCref.AddSpell(a0aCsrSpellListAlteration.GetAt(3) as spell)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("OneHanded") >= iSkillThresh)
			if(NPCref.GetAV("OneHanded")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("OneHanded")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("OneHanded",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkOneHanded)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("TwoHanded") >= iSkillThresh)
			if(NPCref.GetAV("TwoHanded")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("TwoHanded")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("TwoHanded",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkTwoHanded)
			Endif
		EndIf
		
		if(NPCref.GetBaseAV("Marksman") >= iSkillThresh)
			if(NPCref.GetAV("Marksman")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Marksman")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Marksman",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkMarksman)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("LightArmor") >= iSkillThresh)
			if(NPCref.GetAV("LightArmor")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("LightArmor")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("LightArmor",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkLightArmour)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("HeavyArmor") >= iSkillThresh)
			if(NPCref.GetAV("HeavyArmor")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("HeavyArmor")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("HeavyArmor",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkHeavyArmour)
			endif
		EndIf
		
		if(NPCref.GetBaseAV("Block") >= iSkillThresh)
			if(NPCref.GetAV("Block")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Block")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Block",fScratch)
			if(Game.GetPlayer().HasPerk(a0aCsrPerkLev2Ment))
				NPCref.AddSpell(a0aCsrAbLevelPerkBlock)
			EndIf
		EndIf
		
		if(NPCref.GetBaseAV("Sneak") >= iSkillThresh)
			if(NPCref.GetAV("Sneak")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Sneak")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Sneak",fScratch)
		EndIf
		
		if(NPCref.GetBaseAV("Enchanting") >= iSkillThresh)
			if(NPCref.GetAV("Enchanting")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Enchanting")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Enchanting",fScratch)
		EndIf
		
		if(NPCref.GetBaseAV("Lockpicking") >= iSkillThresh)
			if(NPCref.GetAV("Lockpicking")+fSkillUp > 100)
				fScratch = 100 - NPCref.GetAV("Lockpicking")
			Else
				fScratch = fSkillUp
			EndIf
			NPCref.modAV("Lockpicking",fScratch)
		EndIf
		
		(a0aCsrQuest as a0aCsrClassScript).GearSet(NPCref)		
	EndIf
EndFunction
