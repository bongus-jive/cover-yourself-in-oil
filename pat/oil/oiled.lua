require "/scripts/interp.lua"

function init()
  animator.setParticleEmitterOffsetRegion("oildrips", mcontroller.boundBox())
  animator.setParticleEmitterActive("oildrips", true)
	
	self.wetTime = 0
	self.waterTime = 0
end

function update(dt)
	local inWater = (mcontroller.liquidId() == 1)

	--because this game sucks and doesnt give you wet immediately when you leave water god i hate you tiy
	self.waterTime = inWater and 1 or math.max(0, self.waterTime - dt)
	if self.waterTime > 0 then
		status.addEphemeralEffect("wet")
	end

	if status.stat("pat_oiled") == 1 or inWater then
		self.wetTime = math.min(5, self.wetTime + dt)
		mcontroller.setYVelocity(interp.linear(self.waterTime, math.min(0, mcontroller.yVelocity()), mcontroller.yVelocity()) + (self.wetTime ^ 2))
	else
		self.wetTime = math.max(0, self.wetTime - (dt * 75))
	end
end