Scriptname a0aCsrEffectMicromanageScript extends activemagiceffect  

actor Employee
float angleX
float angleZ
float scratch

float UpTime = 0.01
float RotSpeed = 1.0

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	Employee=akTarget
	Game.GetPlayer().SetPlayerControls(false)
;	Game.GetPlayer().EnableAI(false)
;	Game.EnablePlayerControls(true, true,true,false, true, false,true, false, 0)
	Employee.SetPlayerControls(true)
	Employee.EnableAI(true)
	RegisterForUpdate(UpTime)
ENDEVENT

Event OnUpdate()
	if(Employee.GetCombatState())
		Dispel()
	elseif(Employee.IsSprinting())
		Dispel()
	else
		if(Game.GetPlayer().GetHeadingAngle(Employee)>5)
			Game.GetPlayer().PlaySubGraphAnimation("ActionTurnRight")
		elseif(Game.GetPlayer().GetHeadingAngle(Employee)<-5)
			Game.GetPlayer().PlaySubGraphAnimation("ActionTurnLeft")
		else
			Game.GetPlayer().PlaySubGraphAnimation("ActionIdle")	
		endif
		scratch = (Employee.GetHeight()+Employee.GetPositionZ()-Game.GetPlayer().GetPositionZ())/Game.GetPlayer().GetDistance(Employee)
	endif
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Employee.SetPlayerControls(false)
	Employee.EnableAI(true)
	Game.GetPlayer().SetPlayerControls(true)
	Game.GetPlayer().EnableAI(true)
 endEvent

