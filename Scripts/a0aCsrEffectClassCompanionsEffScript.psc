Scriptname a0aCsrEffectClassCompanionsEffScript extends activemagiceffect  

Faction Property a0aCoreFactionEffectClassCompanion Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if(akTarget.IsInFaction(a0aCoreFactionEffectClassCompanion))
	else
		akTarget.AddToFaction(a0aCoreFactionEffectClassCompanion)
		akTarget.KeepOffsetFromActor(akCaster, afOffsetX=0.0, afOffsetY=64.0, afOffsetZ=0.0, afOffsetAngleX = 0.0, afOffsetAngleY = 0.0,  afOffsetAngleZ = 0, afCatchUpRadius = 64.0, afFollowRadius = 64.0)
	endif
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(akTarget.GetDistance(akCaster) > 380 || akTarget.IsInCombat()==0 || akCaster.IsDead())
;		debug.MessageBox("FAR ENUF")
		akTarget.RemoveFromFaction(a0aCoreFactionEffectClassCompanion)
		akTarget.ClearKeepOffsetFromActor()
	endif
endEvent