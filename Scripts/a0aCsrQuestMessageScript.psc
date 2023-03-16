Scriptname a0aCsrQuestMessageScript extends Quest  
{Holding Area for Messages}

Quest Property a0aCsrQuest Auto

Message Property a0aCSRmessageDown1s1 Auto
Message Property a0aCSRmessageDown2s1 Auto
Message Property a0aCSRmessageDown3s1 Auto
Message Property a0aCSRmessageDown4s1 Auto
Message Property a0aCSRmessageDown5s1 Auto

Message Property a0aCSRmessageDown1s2 Auto
Message Property a0aCSRmessageDown2s2 Auto
Message Property a0aCSRmessageDown3s2 Auto
Message Property a0aCSRmessageDown4s2 Auto
Message Property a0aCSRmessageDown5s2 Auto

Message Property a0aCSRmessageDown1s3 Auto
Message Property a0aCSRmessageDown2s3 Auto
Message Property a0aCSRmessageDown3s3 Auto
Message Property a0aCSRmessageDown4s3 Auto
Message Property a0aCSRmessageDown5s3 Auto

Function MessageDown1(actor NPCref)	;Bleeding
	if((NPCref as Actor))
		if(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC1.GetActorRef())
			a0aCSRmessageDown1s1.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC2.GetActorRef())
			a0aCSRmessageDown2s1.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC3.GetActorRef())
			a0aCSRmessageDown3s1.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC4.GetActorRef())
			a0aCSRmessageDown4s1.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC5.GetActorRef())
			a0aCSRmessageDown5s1.show()
		EndIf
	EndIf
endFunction
Function MessageDown2(actor NPCref)	;Loss of disposition
	if((NPCref as Actor))
		if(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC1.GetActorRef())
			a0aCSRmessageDown1s2.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC2.GetActorRef())
			a0aCSRmessageDown2s2.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC3.GetActorRef())
			a0aCSRmessageDown3s2.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC4.GetActorRef())
			a0aCSRmessageDown4s2.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC5.GetActorRef())
			a0aCSRmessageDown5s2.show()
		EndIf
	EndIf
endFunction
Function MessageDown3(actor NPCref)	;DEATH
	if((NPCref as Actor))
		if(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC1.GetActorRef())
			a0aCSRmessageDown1s3.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC2.GetActorRef())
			a0aCSRmessageDown2s3.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC3.GetActorRef())
			a0aCSRmessageDown3s3.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC4.GetActorRef())
			a0aCSRmessageDown4s3.show()
		Elseif(NPCRef == (a0aCsrQuest as a0aCsrScript).CsrNPC5.GetActorRef())
			a0aCSRmessageDown5s3.show()
		EndIf
	EndIf
endFunction