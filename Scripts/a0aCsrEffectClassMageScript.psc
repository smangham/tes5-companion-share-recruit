Scriptname a0aCsrEffectClassMageScript extends activemagiceffect  

Quest Property a0aCoreQuest Auto
Faction Property a0aCsrFactionClassMageSiphon Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(akTarget.IsDead() && !akTarget.IsInFaction(a0aCsrFactionClassMageSiphon ))
		;debug.MessageBox("I gone died!")
		Actor[] TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
		actor LoopItem
		Int LoopVar=0
		Float RestoreVal=akTarget.GetLevel()+1
	
		akTarget.AddToFaction(a0aCsrFactionClassMageSiphon)
		Game.GetPlayer().RestoreAV("RightItemCharge",RestoreVal)
		Game.GetPlayer().RestoreAV("LeftItemCharge",RestoreVal)

		While(LoopVar<TempArray.length)
			LoopItem=TempArray[LoopVar]
			if(LoopItem)
				LoopItem.RestoreAV("RightItemCharge",RestoreVal)
				LoopItem.RestoreAV("LeftItemCharge",RestoreVal)
			EndIf	
			LoopVar=LoopVar+1
		EndWhile
		;debug.MessageBox("I gone died! ! !")
	endif
endEvent