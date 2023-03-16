Scriptname a0aCsrEffectClassThiefScript extends activemagiceffect  

FormList Property a0aCsrListClassThief Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.RemoveItem(a0aCsrListClassThief,1,true,akCaster)
endEvent