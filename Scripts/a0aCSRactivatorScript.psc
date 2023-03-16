Scriptname a0aCSRactivatorScript extends ObjectReference  
{SKSE-Requiring Perk-Adding Tome}

message property a0aCSRmessagePerk1 auto
message property a0aCSRmessagePerk2 auto
message property a0aCSRmessagePerkNO auto

perk property Haggling00 auto
perk property a0aCsrPerk1 auto
perk property a0aCsrPerk2 auto
perk property a0aCsrPerk3 auto
perk property a0aCsrPerk4 auto
perk property a0aCsrPerk5 auto

perk property a0aCsrPerkConf1 auto
perk property a0aCsrPerkConf2Inspire auto
perk property a0aCsrPerkEdu1 auto
perk property a0aCsrPerkEdu2Shout auto
perk property a0aCsrPerkLev1 auto
perk property a0aCsrPerkLev2Ment auto
perk property a0aCsrPerkTiming1 auto

sound property a0aCsrPerkSound auto

perk pAdd
bool bSuccess
bool bTestDone
bool bTestResults

int iVer
int iButton
bool bOnce

Event OnLoad()
	bTestDone=1
	bTestResults=0
	if(SKSE.getVersion())
		bTestResults=1
	endif
endEvent

Event OnActivate(ObjectReference akActionRef)
	if(bTestDone==0)
		if(SKSE.getVersion())
			bTestResults=1
		endif
	endif

	if(akActionRef==game.GetPlayer())
		if(bTestResults)
			if(Game.GetPerkPoints()<1)
				debug.Messagebox("You have no perk points to spend")
				return
			endif

			pAdd=NONE
			iButton=a0aCSRmessagePerk1.show()
			if(iButton==0)
				return
			elseif(iButton==1)
				if(game.GetPlayer().HasPerk(Haggling00))
					pAdd=a0aCsrPerk1
				endif
			elseif(iButton==2)
				if(game.GetPlayer().HasPerk(a0aCsrPerk1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=25)
					pAdd=a0aCsrPerk2
				endif
			elseif(iButton==3)
				if(game.GetPlayer().HasPerk(a0aCsrPerk2)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=50)
					pAdd=a0aCsrPerk3
				endif	
			elseif(iButton==4)
				if(game.GetPlayer().HasPerk(a0aCsrPerk3)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=75)
					pAdd=a0aCsrPerk2
				endif
			elseif(iButton==5)
				if(game.GetPlayer().HasPerk(a0aCsrPerk4)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=100)
					pAdd=a0aCsrPerk2
				endif
			else
				iButton=a0aCSRmessagePerk2.show()
				if(iButton==0)
					return
				elseif(iButton==1)
					if(game.GetPlayer().HasPerk(a0aCsrPerk1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=40)
						pAdd=a0aCsrPerkConf1 
					endif
				elseif(iButton==2)
					if(game.GetPlayer().HasPerk(a0aCsrPerkConf1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=40)
						pAdd=a0aCsrPerkEdu1 
					endif
				elseif(iButton==3)
					if(game.GetPlayer().HasPerk(a0aCsrPerk1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=50)
						pAdd=a0aCsrPerkEdu1 
					endif
				elseif(iButton==4)
					if(game.GetPlayer().HasPerk(a0aCsrPerkEdu1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=75)
						pAdd=a0aCsrPerkEdu2Shout 
					endif
				elseif(iButton==5)
					if(game.GetPlayer().HasPerk(a0aCsrPerk1)&&Game.GetPlayer().GetBaseAV("Speechcraft")>=25)
						pAdd=a0aCsrPerkLev1 
					endif
				elseif(iButton==6)
					if(game.GetPlayer().HasPerk(a0aCsrPerkLev1 )&&Game.GetPlayer().GetBaseAV("Speechcraft")>=40)
						pAdd=a0aCsrPerkLev2Ment
					endif
				elseif(iButton==7)
					if(game.getPlayer().getBaseAV("Speechcraft")>=40)
						pAdd=a0aCsrPerkTiming1
					endif
				endif
			endif

			if(pAdd)
				game.modPerkPoints(-1)
				game.getPlayer().addPerk(pAdd)
				a0aCsrPerkSound.play(game.getPlayer())
				debug.notification("Perk taken")
			else
				a0aCSRmessagePerkNO.Show()
			endif
	
		else
			debug.messageBox("This tome holds nothing for you")
			if(bOnce==0)
				debug.messageBox("[If you are using SKSE, you can use this book to take the Companion Share & Recruit perks]")
				bOnce=1
			endif
		endif
	endif
endEvent