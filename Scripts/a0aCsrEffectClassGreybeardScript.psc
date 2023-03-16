Scriptname a0aCsrEffectClassGreybeardScript extends activemagiceffect  
objectReference NPCref
actor NPCact
String EventToWatch = "NPCshoutStart"

Quest Property a0aCoreQuest Auto
Spell Property a0aCsrSpellClassForswornEff Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCact=akTarget
	NPCref=(akTarget as ObjectReference)
	RegisterForAnimationEvent(akTarget, EventToWatch)
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == NPCref) && (asEventName == EventToWatch )
		Debug.Messagebox ("We got the animation graph event from ourselves that we were looking for!")
		actor[] TempArray= (a0aCoreQuest as a0aCoreScript).FollowerArray
	endIf
endEvent

