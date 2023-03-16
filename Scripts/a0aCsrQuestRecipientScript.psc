Scriptname a0aCsrQuestRecipientScript extends ReferenceAlias  

keyword property VendorItemArrow auto
keyword property VendorItemWeapon auto
keyword property VendorItemClothing auto
keyword property VendorItemArmor auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if(akBaseItem.hasKeyword(VendorItemArrow))
		getActorRef().EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemWeapon))
		getActorRef().EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemArmor))
		getActorRef().EquipItem(akBaseItem)
	elseif(akBaseItem.hasKeyword(VendorItemClothing))
		getActorRef().EquipItem(akBaseItem)
	endif
endEvent