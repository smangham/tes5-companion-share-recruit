Scriptname a0aCsrEffectClassCompanionsScript extends activemagiceffect  

objectReference NPCref
actor NPCact
String EventToWatch = "weaponSwing"

Spell Property a0aCsrSpellClassCompanionsEff Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCact=akTarget
	NPCref=(akTarget as ObjectReference)
;	Debug.MessageBox(akTarget+"is in combat with"+akTarget.GetCombatTarget())
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == NPCref) && (asEventName == EventToWatch )
;		Debug.Messagebox ("We got the animation graph event from ourselves that we were looking for!")
		NPCact.DoCombatSpellApply(a0aCsrSpellClassCompanionsEff,NPCact.GetCombatTarget())
	endIf
endEvent

