Scriptname a0aCsrEffectClassCompanionsEff2Script extends activemagiceffect  

Faction Property a0aCoreFactionEffectClassCompanion auto
MagicEffect  Property a0aCsrEffectClassCompanionsEff Auto
Actor NPCref

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCref=akTarget
	RegisterForSingleUpdate(6.5)
endEvent

Event OnUpdate()
	debug.MessageBox("Removal Tiiiiime!")
	NPCref.RemoveFromFaction(a0aCoreFactionEffectClassCompanion )
	NPCref.clearkeepoffsetfromactor()
EndEvent