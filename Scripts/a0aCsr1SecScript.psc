Scriptname a0aCsr1SecScript extends Quest  

Keyword Property a0aCsrKeyword Auto
Quest Property a0aCoreQuest Auto
Quest Property a0aCsrQuest Auto
Faction Property a0aCoreFactionHealed Auto
Faction Property a0aCoreFactionHeal Auto
Faction Property a0aCsrFaction Auto
Keyword Property a0aCoreKeywordHealCooldown Auto
Bool NeedsHealing
Actor [] TempArray
Int TempInt
Actor LoopItem
Actor HealingRequest
Actor HealerFound

Event OnInit()
	RegisterForUpdate(1.0)
EndEvent

Event OnUpdate()
	RegisterForSingleUpdate(1.0)
EndEvent
