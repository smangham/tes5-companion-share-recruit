Scriptname a0aCsrClassScript extends Quest  


Spell Property a0aCsrAbilityClassAssassin Auto
Spell Property a0aCsrAbilityClassBard Auto
Spell Property a0aCsrAbilityClassCompanions Auto
Spell Property a0aCsrAbilityClassForsworn Auto
Spell Property a0aCsrAbilityClassGreybeard Auto
Spell Property a0aCsrAbilityClassGuard Auto
Spell Property a0aCsrAbilityClassHousecarl Auto
Spell Property a0aCsrAbilityClassLegion Auto
Spell Property a0aCsrAbilityClassOfficer Auto
Spell Property a0aCsrAbilityClassOrc Auto
Spell Property a0aCsrAbilityClassMage Auto
Spell Property a0aCsrAbilityClassStormcloak Auto
Spell Property a0aCsrAbilityClassThalmor Auto
Spell Property a0aCsrAbilityClassThief Auto
Spell Property a0aCsrAbilityClass Auto
Spell Property a0aCsrAbilityClassMerch Auto
Spell Property a0aCsrAbilityClassCommoner Auto

Faction Property a0aCsrFactionClass Auto
Faction Property a0aCoreFactionAbility Auto

Faction Property a0aCsrFactionClassAlchemist Auto
Faction Property JobApothecaryFaction Auto
Class Property VendorApothecary Auto

Faction Property a0aCsrFactionClassAssassin Auto
Faction Property DarkBrotherhoodFaction Auto
Faction Property MS08AlikrFaction Auto

Faction Property a0aCsrFactionClassBard Auto
Faction Property JobBardFaction Auto

Faction Property a0aCsrFactionClassCompanions Auto
Faction Property CompanionsFaction Auto

Faction Property a0aCsrFactionClassCommoner Auto
Faction Property JobMinerFaction Auto
Faction Property JobFarmerFaction Auto
Class Property Miner Auto
Class Property Farmer Auto

Faction Property a0aCsrFactionClassForsworn Auto
Faction Property ForswornFaction Auto

Faction Property a0aCsrFactionClassGreybeard Auto
Faction Property GreybeardFaction Auto

Faction Property a0aCsrFactionClassGuard Auto
Faction Property IsGuardFaction Auto

Faction Property a0aCsrFactionClassHousecarl Auto
Faction Property JobHousecarlFaction Auto
Faction Property PlayerHousecarlFaction Auto

Faction Property a0aCsrFactionClassHunter Auto
Faction Property HunterFaction Auto

Faction Property a0aCsrFactionClassLegionary Auto
Faction Property CWImperialFaction Auto

Faction Property a0aCsrFactionClassMage Auto
Faction Property CollegeofWinterholdFaction Auto
Faction Property JobCourtWizardFaction Auto
Faction Property JobTrainerConjurationFaction Auto

Faction Property a0aCsrFactionClassMerch Auto
Faction Property JobMerchantFaction Auto

Faction Property a0aCsrFactionClassOfficer Auto
Faction Property JobJarlFaction Auto
Faction Property CWJobFortCommanderFaction Auto
Faction Property JobGuardCaptainFaction Auto
Armor Property ArmorImperialHelmetOfficer Auto

Faction Property a0aCsrFactionClassOrc Auto
Faction Property CrimeFactionOrcs Auto

Faction Property a0aCsrFactionClassPriest Auto
Faction Property JobPriestFaction Auto
Class Property Priest Auto

Faction Property a0aCsrFactionClassSmith Auto
Faction Property JobBlacksmithFaction Auto

Faction Property a0aCsrFactionClassStormcloak Auto
Faction Property CWSonsFaction Auto

Faction Property ThalmorSplinterFaction Auto
Faction Property a0aCsrFactionClassThalmor Auto
Faction Property ThalmorFaction Auto

Faction Property a0aCsrFactionClassThief Auto
Faction Property ThievesGuildFaction Auto

Faction Property a0aCoreFactionHeal Auto

ObjectReference Property CSRfurnSmithObj Auto
ImageSpaceModifier Property a0aCsrImodFadeToBlack Auto
Faction Property a0aCsrFactionGearWeap1Hdual Auto
Faction Property a0aCsrFactionGearWeap1Hmagic Auto
Faction Property a0aCsrFactionGearWeap1Hshield Auto
Faction Property a0aCsrFactionGearWeap2H Auto
Faction Property a0aCsrFactionGearWeapBow Auto
Faction Property a0aCsrFactionGearWeapMagic Auto
Faction Property a0aCsrFactionGearArmourLight Auto
Faction Property a0aCsrFactionGearArmourHeavy Auto
Faction Property a0aCsrFactionGearArmourMagic Auto

Function Classify(Actor NPCref)
	if(NPCref.IsInFaction(JobApothecaryFaction)|| NPCref.GetActorBase().GetClass()==VendorApothecary)
		NPCref.AddToFaction(a0aCsrFactionClassAlchemist)
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
		NPCref.AddToFaction(a0aCsrFactionClass)
		NPCref.SetFactionRank(a0aCoreFactionAbility,1)
	Elseif(NPCref.IsInFaction(DarkBrotherhoodFaction)||NPCref.IsInFaction(MS08AlikrFaction))
		NPCref.AddToFaction(a0aCsrFactionClassAssassin)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(JobBardFaction))
		NPCref.AddToFaction(a0aCsrFactionClassBard)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(JobMinerFaction) || NPCref.IsInFaction(JobFarmerFaction) || NPCRef.GetActorBase().GetClass() == Farmer || NPCRef.GetActorBase().GetClass() == Miner)
		NPCref.AddToFaction(a0aCsrFactionClassCommoner)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(CompanionsFaction))
		NPCref.AddToFaction(a0aCsrFactionClassCompanions)		
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(ForswornFaction))
		NPCref.AddToFaction(a0aCsrFactionClassForsworn)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(GreybeardFaction))
		NPCref.AddToFaction(a0aCsrFactionClass)
		NPCref.AddToFaction(a0aCsrFactionClassGreybeard)
	ElseIf(NPCref.IsInFaction(IsGuardFaction))
		NPCref.AddToFaction(a0aCsrFactionClassGuard)	
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(PlayerHousecarlFaction)||NPCref.IsInFaction(JobHousecarlFaction))
		NPCref.AddToFaction(a0aCsrFactionClassHousecarl)		
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(HunterFaction))
		NPCref.AddToFaction(a0aCsrFactionClassHunter)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(CWImperialFaction))
		NPCref.AddToFaction(a0aCsrFactionClass)
		NPCref.AddToFaction(a0aCsrFactionClassLegionary)
	ElseIf(NPCref.IsInFaction(JobCourtWizardFaction)||NPCref.IsInFaction(CollegeofWinterholdFaction)||NPCref.IsInFaction(JobTrainerConjurationFaction))
		NPCref.AddToFaction(a0aCsrFactionClassMage)
		NPCref.AddToFaction(a0aCsrFactionClass)
		NPCref.AddToFaction(a0aCoreFactionAbility)
	ElseIf(NPCref.IsInFaction(JobMerchantFaction) && NPCref.IsInFaction(JobBlacksmithFaction)==0)
		NPCref.AddToFaction(a0aCsrFactionClassMerch)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(JobJarlFaction)||NPCref.IsInFaction(CWJobFortCommanderFaction)||NPCref.IsInFaction(JobGuardCaptainFaction)||NPCref.IsEquipped(ArmorImperialHelmetOfficer))
		NPCref.AddToFaction(a0aCsrFactionClassOfficer)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(CrimeFactionOrcs))
		NPCref.AddToFaction(a0aCsrFactionClassOrc)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(JobPriestFaction)|| NPCref.GetActorBase().GetClass()==Priest)
		NPCref.AddToFaction(a0aCsrFactionClassPriest)
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
		NPCref.AddToFaction(a0aCsrFactionClass)
		NPCref.SetFactionRank(a0aCoreFactionAbility,1)
	ElseIf(NPCref.IsInFaction(JobBlacksmithFaction))
		NPCref.AddToFaction(a0aCsrFactionClassSmith)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(CWSonsFaction))
		NPCref.AddToFaction(a0aCsrFactionClassStormcloak)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(ThalmorFaction)||NPCref.IsInFaction(ThalmorSplinterFaction))
		NPCref.AddToFaction(a0aCsrFactionClassThalmor)
		NPCref.AddToFaction(a0aCsrFactionClass)
	ElseIf(NPCref.IsInFaction(ThievesGuildFaction))
		NPCref.AddToFaction(a0aCsrFactionClassThief)
		NPCref.AddToFaction(a0aCsrFactionClass)
	EndIf
EndFunction

Function GearSet(Actor NPCref)
	;1=1h dual
	;2=2h
	;3=marksman
	;4=destruction
	;5=1h Magic
	;6=1h shield
	
	;1=heavy
	;2=light
	;3=magic
	
	int WeapType = 1
	float MaxVal = NPCref.GetAV("OneHanded")
	if( NPCref.GetAV("TwoHanded")>MaxVal)
		MaxVal=NPCref.GetAV("TwoHanded")
		WeapType = 2
	Elseif( NPCref.GetAV("Marksman")>MaxVal)
		MaxVal=NPCref.GetAV("Marksman")
		WeapType = 3
	Elseif(NPCref.GetAV("Destruction")>MaxVal)
		MaxVal=NPCref.GetAV("Destruction")
		WeapType = 4
	EndIf
	if(WeapType==4)
		if((MaxVal-NPCref.GetAV("OneHanded")<10) && NPCref.GetAV("OneHanded")>=20)
			WeapType = 5
		EndIf
	Elseif(WeapType==1)
		if((MaxVal-NPCref.GetAV("Destruction")<10) && NPCref.GetAV("Destruction")>=20)
			WeapType = 5
		elseif((MaxVal-NPCref.GetAV("Block")<10) && NPCref.GetAV("Block")>=20)
			WeapType = 6
		EndIf
	EndIf
	
	int ArmourType = 1
	MaxVal = NPCref.GetAV("HeavyArmor")
	if( NPCref.GetAV("LightArmor")>MaxVal)
		MaxVal = NPCref.GetAV("LightArmor")
		ArmourType=2
	ElseIf( NPCref.GetAV("Alteration")>MaxVal)
		MaxVal = NPCref.GetAV("Alteration")
		ArmourType=3
	ElseIf( NPCref.GetAV("Restoration")>MaxVal)
		MaxVal = NPCref.GetAV("Restoration")
		ArmourType=3
	EndIf
	
	NPCref.RemoveFromFaction(a0aCsrFactionGearArmourLight)
	NPCref.RemoveFromFaction(a0aCsrFactionGearArmourHeavy)
	NPCref.RemoveFromFaction(a0aCsrFactionGearArmourMagic)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeap1Hdual)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeap1Hshield)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeap1Hmagic)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeap2H)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeapBow)
	NPCref.RemoveFromFaction(a0aCsrFactionGearWeapMagic)
	if(WeapType==1)
		NPCref.AddToFaction(a0aCsrFactionGearWeap1Hdual)
	Elseif(WeapType==2)
		NPCref.AddToFaction(a0aCsrFactionGearWeap2H)
	Elseif(WeapType==3)
		NPCref.AddToFaction(a0aCsrFactionGearWeapBow)
	Elseif(WeapType==4)
		NPCref.AddToFaction(a0aCsrFactionGearWeapMagic)
	Elseif(WeapType==5)
		NPCref.AddToFaction(a0aCsrFactionGearWeap1Hmagic)
	Else
		NPCref.AddToFaction(a0aCsrFactionGearWeap1Hshield)
	EndIf
	If(ArmourType==1)
		NPCref.AddToFaction(a0aCsrFactionGearArmourHeavy)
	ElseIf(ArmourType==2)
		NPCref.AddToFaction(a0aCsrFactionGearArmourLight)
	Else
		NPCref.AddToFaction(a0aCsrFactionGearArmourMAgic)
	EndIf
		
EndFunction

Function ClassJoin(actor NPCref)
	if(NPCref.IsInFaction(a0aCsrFactionClassAssassin))
		NPCref.AddSpell(a0aCsrAbilityClassAssassin)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassBard))
		NPCref.AddSpell(a0aCsrAbilityClassBard)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassCompanions))
		NPCref.AddSpell(a0aCsrAbilityClassCompanions)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassForsworn))
		NPCref.AddSpell(a0aCsrAbilityClassForsworn)
	ElseIf(NPCref.IsInFaction(a0aCsrFactionClassGreybeard))	
		NPCref.AddSpell(a0aCsrAbilityClassGreybeard)
	ElseIf(NPCref.IsInFaction(a0aCsrFactionClassGuard))
		NPCref.AddSpell(a0aCsrAbilityClassGuard)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassHousecarl))
		NPCref.AddSpell(a0aCsrAbilityClassHousecarl)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassLegionary))
		NPCref.AddSpell(a0aCsrAbilityClassLegion)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassMage))
		NPCref.AddSpell(a0aCsrAbilityClassMage)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassOfficer))
		NPCref.AddSpell(a0aCsrAbilityClassOfficer)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassOrc))
		NPCref.AddSpell(a0aCsrAbilityClassOrc)		
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassStormcloak))	
		NPCref.AddSpell(a0aCsrAbilityClassStormcloak)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassThalmor))
		NPCref.AddSpell(a0aCsrAbilityClassThalmor)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassThief))
		NPCref.AddSpell(a0aCsrAbilityClassThief)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassMerch))
		NPCref.AddSpell(a0aCsrAbilityClassMerch)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassCommoner))	
		NPCref.AddSpell(a0aCsrAbilityClassCommoner)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassPriest))
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
	Elseif(NPCref.IsInFaction(a0aCsrFactionClassAlchemist))
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
	EndIf
	NPCref.AddSpell(a0aCsrAbilityClass)
EndFunction

Function ClassLeave(actor NPCref)
	NPCref.RemoveSpell(a0aCsrAbilityClassAssassin)
	NPCref.RemoveSpell(a0aCsrAbilityClassBard)
	NPCref.RemoveSpell(a0aCsrAbilityClassCompanions)
	NPCref.RemoveSpell(a0aCsrAbilityClassForsworn)
	NPCref.RemoveSpell(a0aCsrAbilityClassGreybeard)
	NPCref.RemoveSpell(a0aCsrAbilityClassGuard)
	NPCref.RemoveSpell(a0aCsrAbilityClassHousecarl)
	NPCref.RemoveSpell(a0aCsrAbilityClassLegion)
	NPCref.RemoveSpell(a0aCsrAbilityClassMage)
	NPCref.RemoveSpell(a0aCsrAbilityClassOfficer)
	NPCref.RemoveSpell(a0aCsrAbilityClassOrc)
	NPCref.RemoveSpell(a0aCsrAbilityClassStormcloak)
	NPCref.RemoveSpell(a0aCsrAbilityClassThalmor)
	NPCref.RemoveSpell(a0aCsrAbilityClassThief)
	NPCref.RemoveSpell(a0aCsrAbilityClass)
	NPCref.RemoveSpell(a0aCsrAbilityClassMerch)
	NPCref.RemoveSpell(a0aCsrAbilityClassCommoner)
EndFunction

Function SmithSharpen(actor NPCref)
	CSRfurnSmithObj.Activate(game.GetPlayer())
	;utility.Wait(0.5)
	;utility.WaitGameTime(0.02)
	
EndFunction

Function AddClass(actor NPCref, int iClass)
;1	Guard
;2	Legionary
;3	Housecarl
;4	Companion
;5	Bard
;6	Officer
;7	Priest
;8	Alchemist
;9	Assassin
;10	Thief
;11	Stormcloak
;12	Tribal Orc
;13	Thalmor
;14	Forsworn
;15	Mage
;16	Greybeard
	if(iClass==1)
		NPCref.AddToFaction(a0aCsrFactionClassGuard)
	Elseif(iClass==2)
		NPCref.AddToFaction(a0aCsrFactionClassLegionary)
	Elseif(iClass==3)
		NPCref.AddToFaction(a0aCsrFactionClassHousecarl)
	Elseif(iClass==4)
		NPCref.AddToFaction(a0aCsrFactionClassCompanions)
	Elseif(iClass==5)
		NPCref.AddToFaction(a0aCsrFactionClassBard)
	Elseif(iClass==6)
		NPCref.AddToFaction(a0aCsrFactionClassOfficer)
	Elseif(iClass==7)
		NPCref.AddToFaction(a0aCsrFactionClassPriest)
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
		NPCref.AddToFaction(a0aCoreFactionAbility)
	Elseif(iClass==8)
		NPCref.AddToFaction(a0aCsrFactionClassAlchemist)
		NPCref.SetFactionRank(a0aCoreFactionHeal,1)
		NPCref.AddToFaction(a0aCoreFactionAbility)
	Elseif(iClass==9)
		NPCref.AddToFaction(a0aCsrFactionClassAssassin)
	Elseif(iClass==10)
		NPCref.AddToFaction(a0aCsrFactionClassThief)
	Elseif(iClass==11)
		NPCref.AddToFaction(a0aCsrFactionClassStormcloak)
	Elseif(iClass==12)
		NPCref.AddToFaction(a0aCsrFactionClassOrc)
	Elseif(iClass==13)
		NPCref.AddToFaction(a0aCsrFactionClassThalmor)
	Elseif(iClass==14)
		NPCref.AddToFaction(a0aCsrFactionClassForsworn)
	Elseif(iClass==15)
		NPCref.AddToFaction(a0aCsrFactionClassMage)
		NPCref.AddToFaction(a0aCoreFactionAbility)
	EndIf
	NPCref.AddToFaction(a0aCsrFactionClass)
	if(NPCref.IsPlayerTeammate())
		ClassJoin(NPCref)
	EndIf
	a0aCsrImodFadeToBlack.Apply()
EndFunction

