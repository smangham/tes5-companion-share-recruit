Scriptname a0aCsrEffectClassGreybeardEffScript extends activemagiceffect  

objectReference NPCref
actor NPCact
int HealVal
String EventToWatch = "weaponSwing"

spell Property a0aCsrSpellClassGreybeardEff2 auto

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
			float chance= ((NPCact.GetLevel()-NPCact.GetCombatTarget().GetLevel()) as float)+20
			if(Utility.RandomFloat(0,99)<chance)
				NPCact.DoCombatSpellApply(a0aCsrSpellClassGreybeardEff2 ,NPCact.GetCombatTarget())
			endif
		endif
	endIf
endEvent
