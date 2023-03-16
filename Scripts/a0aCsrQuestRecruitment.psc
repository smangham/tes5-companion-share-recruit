Scriptname a0aCsrQuestRecruitment extends Quest

Int Property iClass Auto
;1	Guard
;2	Legionary
;3	Housecarl
;4	Companion
;5	Bard
;6	Officer
;7	Priest
;8	Alchemist
;9	Assassin
;10	Thief
;11	Stormcloak
;12	Tribal Orc
;13	Thalmor
;14	Forsworn
;15	Mage
;16	Greybeard


Keyword Property JewelryExpensive Auto
Keyword Property ClothingRich Auto
Keyword Property ClothingPoor Auto
FormList Property GiftGenericFemale Auto
FormList Property GiftGenericMale Auto

VisualEffect Property FXGreybeardAbsorbEffect Auto
EffectShader Property GreybeardPowerAbsorbFXS Auto
EffectShader Property GreybeardPlayerPowerAbsorbFXS Auto
ImageSpaceModifier Property a0aCsrImodFadeToBlack Auto
sound property NPCDragonDeathSequenceWind auto
sound property NPCDragonDeathSequenceExplosion auto

Quest Property a0aCsrQuest Auto

Idle Property bleedOutStart Auto
Idle Property bleedOutStop Auto

faction Property a0aCsrFactionAddedShout auto
faction Property a0aCsrFactionAddedSpell auto

VisualEffect Property a0aCsrVFXLearnSpell Auto
VisualEffect Property a0aCsrVFXForgetSpell auto
VisualEffect Property MAGDragonPowerAbsorbEffect auto

referenceAlias Property CSRrecipient Auto

spell Property a0aCsrSpellShoutDisarm Auto
spell Property a0aCsrSpellShoutForce Auto
spell Property a0aCsrSpellShoutFire Auto
spell Property a0aCsrSpellShoutFrost Auto
Int Property iShout Auto
;1	Disarm
;2	Force
;4	Fire
;5	Frost


Function AddClass(actor NPCref)
	(a0aCsrQuest as a0aCsrClassScript).AddClass(NPCref,iClass)
EndFunction
Function FadeToBlack()
	a0aCsrImodFadeToBlack.Apply()
EndFunction

Function AddShout(actor NPCref)
	spell sShout
	if(iShout==1)
		sShout=a0aCsrSpellShoutDisarm
	elseif(iShout==2)
		sShout=a0aCsrSpellShoutForce
	elseif(iShout==3)
		sShout=a0aCsrSpellShoutFire	
		debug.messagebox("fireshout")
	elseif(iShout==4)
		sShout=a0aCsrSpellShoutFrost
	endif
	
	NPCref.addSpell(sShout)
	NPCref.PlayIdle(bleedOutStart)
	FXGreybeardAbsorbEffect.Play(Game.GetPlayer(), 4, NPCref)
	GreybeardPowerAbsorbFXS.Play(Game.GetPlayer(), 4)
	GreybeardPlayerPowerAbsorbFXS.Play(NPCref, 4)
	NPCDragonDeathSequenceWind.play(NPCref) 
	NPCDragonDeathSequenceExplosion.play(NPCref) 
	Game.GetPlayer().DamageAV("DragonSouls",1)
	utility.wait(3.0)
	NPCref.PlayIdle(bleedOutStop)

EndFunction

Function RemoveShouts(actor NPCref)
	debug.Notification("Shouts removed")
	NPCref.PlayIdle(bleedOutStart)
	FXGreybeardAbsorbEffect.Play(NPCref, 3, game.getPlayer())
	GreybeardPowerAbsorbFXS.Play(NPCref, 3)
	
	int iShouts=0
	if(NPCref.hasspell(a0aCsrSpellShoutDisarm))
		iShouts=iShouts+1
	endif
	if(NPCref.hasspell(a0aCsrSpellShoutForce ))
		iShouts=iShouts+1
	endif
	if(NPCref.hasspell(a0aCsrSpellShoutFire  ))
		iShouts=iShouts+1
	endif
	if(NPCref.hasspell(a0aCsrSpellShoutFrost ))
		iShouts=iShouts+1
	endif
	
	Game.GetPlayer().RestoreAV("DragonSouls",iShouts)	
	GreybeardPlayerPowerAbsorbFXS.Play(game.GetPlayer(), 3)
	NPCDragonDeathSequenceWind.play(game.getPlayer()) 
	NPCDragonDeathSequenceExplosion.play(game.GetPlayer())
	utility.wait(2.0)
	NPCref.PlayIdle(bleedOutStop)
EndFunction

Function AddSpell(Actor NPCref)
	int iSpellsAdded=0
	if(Game.GetPlayer().GetEquippedSpell(0))
		if(NPCref.AddSpell(Game.GetPlayer().GetEquippedSpell(0)))
			iSpellsAdded=iSpellsAdded+1
			NPCref.EquipSpell(Game.GetPlayer().GetEquippedSpell(0),0)
			debug.Notification("Left hand spell taught")
			if(NPCref.IsInFaction(a0aCsrFactionAddedSpell))
				NPCref.modFactionRank(a0aCsrFactionAddedSpell,1)
			else
				NPCref.setFactionRank(a0aCsrFactionAddedSpell,1)
			endif
		else
			debug.Notification("Left hand spell already known")
		endif
	EndIf
	if(Game.GetPlayer().GetEquippedSpell(1))
		if(NPCref.AddSpell(Game.GetPlayer().GetEquippedSpell(1)))
			iSpellsAdded=iSpellsAdded+1
			NPCref.EquipSpell(Game.GetPlayer().GetEquippedSpell(1),1)
			debug.Notification("Right hand spell taught")
			if(NPCref.IsInFaction(a0aCsrFactionAddedSpell))
				NPCref.modFactionRank(a0aCsrFactionAddedSpell,1)
			else
				NPCref.setFactionRank(a0aCsrFactionAddedSpell,1)
			endif
		else
			debug.Notification("Right hand spell already known")
		endif
	EndIf
	if(iSpellsAdded>0)
		a0aCsrVFXLearnSpell.play(NPCref,6)
	else
		debug.notification("No spells equipped")
	endif
EndFunction
Function RemoveSpell(Actor NPCref)
	a0aCsrVFXForgetSpell.play(NPCref,6)
	if(Game.GetPlayer().GetEquippedSpell(0))
		NPCref.UnequipSpell(Game.GetPlayer().GetEquippedSpell(0),0)
		if(NPCref.RemoveSpell(Game.GetPlayer().GetEquippedSpell(0)))
			debug.Notification("Left hand spell forgotten")
		else
			debug.Notification("Left hand spell not known")
		endif
	EndIf
	if(Game.GetPlayer().GetEquippedSpell(1))
		NPCref.UnequipSpell(Game.GetPlayer().GetEquippedSpell(1),1)
		if(NPCref.RemoveSpell(Game.GetPlayer().GetEquippedSpell(1)))
			debug.Notification("Right hand spell forgotten")
			NPCref.modFactionRank(a0aCsrFactionAddedSpell ,-1)
		else
			debug.Notification("Left hand spell not known")
			NPCref.modFactionRank(a0aCsrFactionAddedSpell ,-1)
		endif
	EndIf
EndFunction

Function PartyJoin(Actor NPCref, bool bVerbose)
	(a0aCsrQuest as a0aCsrScript).PartyJoin(NPCref,bVerbose)
EndFunction

Function DispositionRecalc(actor NPCref, float fGiftVal, bool bVerbose)
	float SuccessMult = 1.0
	int iRelations = NPCref.getRelationshipRank(game.getPlayer())
		
	if((NPCref.WornHasKeyword(ClothingRich)||NPCref.WornHasKeyword(JewelryExpensive)))
		SuccessMult = 0.25
	elseif((NPCref.WornHasKeyword(ClothingPoor)))
		SuccessMult = 4
	EndIf
		
	SuccessMult=SuccessMult*((6-(Math.Abs((iRelations as float))))/6)*((100-NPCref.GetLevel()) as float)*0.01
	int SuccessOdds = ((fGiftVal*SuccessMult) as int)
			
	if(successOdds>0)	;If the success chance is >0, player net gave things
		if(SuccessOdds > 95)
			SuccessOdds = 95
		elseif(SuccessOdds < 5)
			SuccessOdds = 5
		endif
		
		if(iRelations<3)		;Can't increase disposition above ally
			if(Utility.RandomInt(0,100) < SuccessOdds)
				Game.AdvanceSkill("Speechcraft",fGiftVal*1.5)
				(a0aCsrQuest as a0aCsrScript).RelationshipMod(NPCref,1)
				if(bVerbose)
					Debug.Notification("Gift successful ("+SuccessOdds+"% chance)")
				else
					Debug.Notification("Disposition increased")
				endif
			Else
				int FailOdds = 100 - SuccessOdds
				Game.AdvanceSkill("Speechcraft",fGiftVal)
				if(bVerbose)
					Debug.Notification("Gift failed ("+FailOdds+"% chance)")
				endif
			EndIf
		EndIf
	else				;If the success chance is <0, player net took things
		SuccessOdds=-SuccessOdds
		if(SuccessOdds > 95)
			SuccessOdds = 95
		elseif(SuccessOdds < 5)
			SuccessOdds = 5
		endif
		
		if(iRelations>-1)	;Can't change disposition below rival
			if(Utility.RandomInt(0,100) < SuccessOdds)
				Game.AdvanceSkill("Speechcraft",fGiftVal*1.5)
				(a0aCsrQuest as a0aCsrScript).RelationshipMod(NPCref,-1)
				if(bVerbose)
					Debug.Notification("Gift successful ("+SuccessOdds+"% chance)")
				else
					Debug.Notification("Disposition decreased")
				endif
			Else
				int FailOdds = 100 - SuccessOdds
				Game.AdvanceSkill("Speechcraft",fGiftVal)
				if(bVerbose)
					Debug.Notification("Gift failed ("+FailOdds+"% chance)")
				endif
			EndIf
		EndIf			
	EndIf

EndFunction

int Relations
formList GiftList
float iGiftVal
Function FriendGift(Actor NPCref)
	if(NPCref as Actor)
		CSRrecipient.ForceRefTo(NPCref)
		Relations = NPCref.GetRelationshipRank(Game.GetPlayer())
		;Debug.MessageBox("step 2")
		if(Relations < 1)
			if((NPCRef.GetBaseObject() as ActorBase).GetSex())
				GiftList = GiftGenericFemale
			Else
				GiftList = GiftGenericMale
			EndIf
		else
			GiftList = NONE
		EndIf
		iGiftVal=NPCref.ShowGiftMenu(TRUE,giftList)
		DispositionRecalc(NPCref, (iGiftVal as float), TRUE )
		CSRrecipient.Clear()
	EndIf
EndFunction

Function FriendLend(Actor NPCref)
	if((NPCref as Actor))
		iGiftVal = NPCref.ShowGiftMenu(False)
		DispositionRecalc(NPCref, -(iGiftVal as float), TRUE )
	EndIf
EndFunction

Function AdvanceLevel(Actor NPCref)
	(a0aCsrQuest as a0aCsrScript).AdvanceLevel(NPCref)	
EndFunction
