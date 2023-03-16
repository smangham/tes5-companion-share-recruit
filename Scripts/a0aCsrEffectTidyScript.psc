Scriptname a0aCsrEffectTidyScript extends activemagiceffect  

Faction Property a0aCoreFactionHealed Auto
Quest Property a0aCsrQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.RemoveFromFaction(a0aCoreFactionHealed)
	if(akCaster.GetAV("WaitingForPlayer")<=10)
		(a0aCsrQuest as a0aCsrScript).PartyTidyup(akCaster)
	EndIf
endEvent
