Scriptname a0aCsrNPCscript extends ReferenceAlias

GlobalVariable Property a0aCsrClassOrcCount Auto
Quest Property a0aCsrQuest Auto
Quest Property a0aCoreQuest Auto
Faction Property a0aCoreFactionHealed Auto
Faction Property a0aCoreFactionHeal Auto 
Faction Property a0aCoreFactionAbility Auto 
faction Property a0aCsrFactionLevel auto
Keyword Property MagicRestoreHealth auto
Perk Property a0aCsrPerkConf1 Auto
GlobalVariable Property CsrBleedoutNoDeath Auto
float iDeathTimer
float iHealCooldown
float iHealingCooldown
bool bDespair
int iTemp
int iLevel
int iMod
actor HealingRequest
message Property a0aCSRmessageDown1 Auto
message Property a0aCSRmessageDown2 Auto
message Property a0aCSRmessageDown3 Auto
message Property a0aCSRmessageDown3b Auto
keyword property VendorItemArrow auto
keyword property VendorItemWeapon auto
keyword property VendorItemClothing auto
keyword property VendorItemArmor auto
actor aRef

Event OnActivate(ObjectReference akActionRef)
	if(getActorRef().isBleedingOut())
		bool bSuccess
		if(iHealingCooldown<1)
			bSuccess=(a0aCsrQuest as a0aCsrScript).PartyPotion(getActorRef(),TRUE)
		else
			bSuccess=(a0aCsrQuest as a0aCsrScript).PartyPotion(getActorRef(),FALSE)
		endif
		if(bSuccess)
			iHealingCooldown=20
			iDeathTimer=30
		endif
	endif
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	aRef=getActorRef()
	aRef.RestoreAV("Health",999)
	aRef.SetNoBleedoutRecovery(FALSE)										;Cancel
	iHealCooldown=0
	iHealingCooldown=0
	iDeathTimer=30
	
	if(!getActorRef().isinCombat()&&!game.getPlayer().isinCombat())		;COMBAT OVER
		UnRegisterForUpdate()
		(a0aCsrQuest as a0aCsrScript).CsrHealer1=NONE
		(a0aCsrQuest as a0aCsrScript).CsrHealer2=NONE
		(a0aCsrQuest as a0aCsrScript).CsrHealer3=NONE
		a0aCsrClassOrcCount.SetValue(0)
		
		aRef.setNoBleedoutRecovery(FALSE)
		if(aRef.getRelationshipRank(game.GetPlayer())<1&&!aRef.isDead())	
			(a0aCsrQuest as a0aCsrScript).PartyLastChance(aRef)
		elseif(aRef.IsInFaction(a0aCsrFactionLevel))
			if(game.getPlayer().getLevel()>iLevel)
				(a0aCsrQuest as a0aCsrScript).AdvanceLevel(aRef)
			endif
			iLevel=game.getPlayer().getLevel()
		endif

	elseIf (akTarget == Game.GetPlayer())								;COMBAT BEGUN WITH PLAYER- BOO!
		(a0aCsrQuest as a0aCsrScript).PartyLeave(aRef,True)
		
	else																;COMBAT BEGUN
		RegisterForUpdate(1.0)		
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	aRef=getActorRef()
	If(aRef.GetAVPercentage("Health")<0.5)
		if(!aRef.IsInFaction(a0aCoreFactionHealed))
			(a0aCoreQuest as a0aCoreScript).HealingRequest = aRef
		endif
	EndIf
EndEvent

Event OnEnterBleedout()
	aRef=getActorRef()

	if(aRef.isInCombat())
		;aref.AllowBleedoutDialogue(TRUE)
		(a0aCsrQuest as a0aCsrScript).CSRtext.ForceRefTo(aRef)
		a0aCSRmessageDown1.Show()
		
		if(!aRef.getNoBleedoutRecovery()&& !aRef.IsInFaction(a0aCoreFactionHealed))
			(a0aCoreQuest as a0aCoreScript).HealingRequest = aRef
		endif
		
		
		if(game.GetPlayer().hasPerk(a0aCsrPerkConf1))
			iDeathTimer=45
		else
			iDeathTimer=30
		endif
		bDespair=FALSE
		a0aCsrClassOrcCount.SetValueInt(a0aCsrClassOrcCount.GetValueInt()+1)
	else
		aRef.RestoreAV("Health",999)
	endif
EndEvent

Event OnUpdate()
	if(aRef.isBleedingOut())												;If we're dying
		iDeathTimer=iDeathTimer - 1												;Reduce timer
		if(iDeathTimer<=0)														;If timer is 0
			if(CsrBleedoutNoDeath.GetValueInt()>0)									;If we've got a 'No death' policy
				iDeathTimer=30															;Just reset the timer
			else																	;Otherwise, we've got a death
				UnregisterForUpdate()
				aRef.SetNoBleedoutRecovery(FALSE)										;Cancel
				(a0aCsrQuest as a0aCsrScript).PartyLeave(getActorRef(),TRUE)			;KILL THEM
				utility.wait(1.0)
				(a0aCsrQuest as a0aCsrScript).CSRtext.ForceRefTo(getActorRef())			;Set the right name
				if(aRef.IsEssential())
					a0aCSRmessageDown3b.Show()												;Show message
					iMod=((-1)-aref.getRelationshipRank(game.getPlayer()))
					(a0aCsrQuest as a0aCsrScript).RelationshipMod(aRef,iMod)				;Reduce relationship to rival
				else
					a0aCSRmessageDown3.Show()												;Show message
					aRef.kill(game.getPlayer())
				endif
				RETURN
			endif
		elseif(iDeathTimer<15)													;If we're on timer 15
			if(!bDespair)															;If we haven't already despaired
				bDespair=TRUE															;Set flag
				(a0aCsrQuest as a0aCsrScript).RelationshipMod(aRef,-1)					;Reduce relationship
				(a0aCsrQuest as a0aCsrScript).CSRtext.ForceRefTo(aRef)
				a0aCSRmessageDown2.Show()												;Show message
			endif
			(a0aCoreQuest as a0aCoreScript).HealingRequest=aRef
		
		elseif(!aRef.IsInFaction(a0aCoreFactionHealed))						;If we're not being healed
			if(!aRef.getNoBleedoutRecovery())										;If we can be healed
				(a0aCoreQuest as a0aCoreScript).HealingRequest=aRef						;File a request with head office
			endif
		endif
		
	elseif(aRef.getFactionRank(a0aCoreFactionHeal)>0)
		if(iHealingCooldown<1)
			HealingRequest=(a0aCoreQuest as a0aCoreScript).HealingRequest
		
			if(HealingRequest)		
				
				If(!(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing1.GetRef())
					iTemp = 1
					(a0aCsrQuest as a0aCsrScript).CsrHealer1=aRef
					(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing1.ForceRefTo(HealingRequest)
					aRef.SetAV("WaitingForPlayer",-11)
				Elseif(!(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing2.GetRef())
					iTemp = 2
					(a0aCsrQuest as a0aCsrScript).CsrHealer2=aRef
					(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing2.ForceRefTo(HealingRequest)
					aRef.SetAV("WaitingForPlayer",-12)
				Elseif(!(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing3.GetRef())
					iTemp = 3
					(a0aCsrQuest as a0aCsrScript).CsrHealer3=aRef
					(a0aCsrQuest as a0aCsrScript).a0aCsrNeedsHealing3.ForceRefTo(HealingRequest)
					aRef.SetAV("WaitingForPlayer",-13)
				Else
					iTemp =0
				EndIf	
				if(iTemp>0)
					iHealingCooldown=1
					HealingRequest.AddToFaction(a0aCoreFactionHealed)
					(a0aCoreQuest as a0aCoreScript).HealingRequest=None
					Utility.Wait(0.1)
					aRef.StopCombat()
					aRef.StopCombatAlarm()
					Utility.Wait(0.1)
					aRef.EvaluatePackage()
				endif
			endif
		elseif(iHealingCooldown==20)
			iHealingCooldown=0
			HealingRequest.RemoveFromFaction(a0aCoreFactionHealed)
			aRef.SetAV("WaitingForPlayer",0)
			aRef.EvaluatePackage()
			(a0aCsrQuest as a0aCsrScript).PartyTidyup(healingRequest)
		else
			iHealingCooldown=iHealingCooldown+1
			if(iTemp==1 && (a0aCsrQuest as a0aCsrScript).CSRHealer1 != aRef)
				(a0aCsrQuest as a0aCsrScript).PartyFollow(aRef)
			elseif(iTemp==2 && (a0aCsrQuest as a0aCsrScript).CSRHealer2 != aRef)
				(a0aCsrQuest as a0aCsrScript).PartyFollow(aRef)
			elseif(iTemp==3 && (a0aCsrQuest as a0aCsrScript).CSRHealer3 != aRef)
				(a0aCsrQuest as a0aCsrScript).PartyFollow(aRef)
			endif
		endif
	endif

			
	if(aRef.getNoBleedoutRecovery())
		iHealCooldown = iHealCooldown - 1
		if(iHealCooldown == 0)
			aRef.setNoBleedoutRecovery(FALSE)
		endif
	endif
	RegisterForSingleUpdate(1.0)											;Perpetual update	
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	if(akEffect.HasKeyword(MagicRestoreHealth))									;If we're hit with a heal spell
		aRef=getActorRef()
		if(aRef.isBleedingOut())											;And we're bleeding out
			if(aRef.getNoBleedoutRecovery())									;If recovery is currently blocked
				iDeathTimer=30															;Reset the timer
			elseif(aRef.IsInCombat()||game.getPlayer().IsInCombat())			;If we're in combat
				aRef.RestoreAV("Health",aRef.GetBaseAV("Health")*0.3)
				aRef.setNoBleedoutRecovery(TRUE)								;Block future recoveries
				iHealCooldown=20														;Set cooldown timer
			endif																	;Otherwise, we're out of combat
		endif																			;So do nothing, heal as normal
	endif
endEvent

Event OnDeath(Actor akKiller)
	UnregisterForUpdate()
	(a0aCsrQuest as a0aCsrScript).PartyTidyup(GetActorReference())
	(a0aCsrQuest as a0aCsrScript).PartyLeaveA(self,True)
EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If((a0aCSRquest as a0aCsrScript).bTrading)
		float fTradeVal=akBaseItem.getGoldValue()*aiItemCount
		if(fTradeVal > 0)
			(a0aCSRquest as a0aCsrScript).fTradeVal=(a0aCSRquest as a0aCsrScript).fTradeVal+fTradeVal
		endif
	EndIf
	if(akBaseItem.hasKeyword(VendorItemArrow))
		aRef.EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemWeapon))
		aRef.EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemArmor))
		aRef.EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemClothing))
		aRef.EquipItem(akBaseItem)
	endif
endEvent
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If((a0aCSRquest as a0aCsrScript).bTrading)
		float fTradeVal=akBaseItem.getGoldValue()*aiItemCount
		if(fTradeVal > 0)
			(a0aCSRquest as a0aCsrScript).fTradeVal=(a0aCSRquest as a0aCsrScript).fTradeVal-fTradeVal
		endif
	EndIf
endEvent
Function HealFeedback(bool bSuccess)
	if(bSuccess)
		iHealCooldown=20
	else
		iDeathTimer=30
	endif
EndFunction