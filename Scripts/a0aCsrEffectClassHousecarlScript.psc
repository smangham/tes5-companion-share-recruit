Scriptname a0aCsrEffectClassHousecarlScript extends activemagiceffect  

objectReference NPCref
actor NPCact
int HealVal
String EventToWatch = "weaponSwing"

Spell Property a0aCsrSpellClassHousecarlEff Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCact=akTarget
	NPCref=(akTarget as ObjectReference)
	;Debug.MessageBox(akTarget+"is in combat with"+akTarget.GetCombatTarget())
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == NPCref) && (asEventName == EventToWatch )
		NPCact.GetCombatTarget().StartCombat(NPCact)
		NPCact.DoCombatSpellApply(a0aCsrSpellClassHousecarlEff,NPCact.GetCombatTarget())
	endIf
endEvent
