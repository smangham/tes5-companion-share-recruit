Scriptname a0aCsrEffectClassThaneScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.startCombat(akCaster)
endEvent