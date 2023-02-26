local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local e = Roact.createElement

local InputBox = require(script.Parent.InputBox)

return function(target)
	InputBox = Roact.mount(e(InputBox), target, "Todolist")

	return function()
		Roact.unmount(InputBox)
	end
end
