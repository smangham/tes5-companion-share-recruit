Scriptname a0aCsrEffectClassForswornScript extends activemagiceffect  

objectReference NPCref
actor NPCact
String EventToWatch = "weaponSwing"

Spell Property a0aCsrSpellClassForswornEff Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCact=akTarget
	NPCref=(akTarget as ObjectReference)
;	Debug.MessageBox(akTarget+"is in combat with"+akTarget.GetCombatTarget())
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == NPCref) && (asEventName == EventToWatch )
;		Debug.Messagebox ("We got the animation graph event from ourselves that we were looking for!")
		NPCact.DoCombatSpellApply(a0aCsrSpellClassForswornEff,NPCact.GetCombatTarget())
	endIf
endEvent

