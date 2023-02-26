local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local e = Roact.createElement

local Inputbox = require(script.Parent.InputBox)

return function(target)
	Inputbox = Roact.mount(e(Inputbox), target, "Todolist")

	return function()
		Roact.unmount(Inputbox)
	end
end
