Scriptname a0aCsrEffectClassThief2 extends activemagiceffect  

objectReference ThiefRef
actor ThiefAct
String EventToWatch = "weaponSwing"

FormList Property a0aCsrListClassThief Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	thiefAct=akTarget
	thiefRef=(akTarget as ObjectReference)
	;Debug.MessageBox(akTarget+"is in combat with"+akTarget.GetCombatTarget())
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == thiefRef) && (asEventName == EventToWatch )
		;Debug.Messagebox ("We got the animation graph event from ourselves that we were looking for!")
		ThiefAct.GetCombatTarget().RemoveItem(a0aCsrListClassThief,1,true,ThiefAct)
	endIf
endEvent

