local oldinit = init

function init()
  oldinit()
	effect.addStatModifierGroup({{stat = "pat_oiled", amount = 1}})
end