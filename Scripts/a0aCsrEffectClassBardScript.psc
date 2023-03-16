Scriptname a0aCsrEffectClassBardScript extends activemagiceffect  

objectReference NPCref
actor NPCact
int HealVal
String EventToWatch = "weaponSwing"

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCact=akTarget
	NPCref=(akTarget as ObjectReference)
	;Debug.MessageBox(akTarget+"is in combat with"+akTarget.GetCombatTarget())
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == NPCref) && (asEventName == EventToWatch )
		;Debug.Messagebox ("We got the animation graph event from ourselves that we were looking for!")
		if(NPCact.GetCombatTarget())
			HealVal=(NPCact.GetCombatTarget().GetLevel()/5)+5
		else
			HealVal=(NPCact.GetLevel()/10)+2
		endif
		
		NPCact.RestoreActorValue("Health",HealVal)
		NPCact.RestoreActorValue("Magicka",HealVal*2)
		NPCact.RestoreActorValue("Fatigue",HealVal*2)
	endIf
endEvent
