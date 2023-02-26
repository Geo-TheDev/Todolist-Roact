local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local e = Roact.createElement

local ToDoList = require(ReplicatedStorage.Gui.App.ToDoList)

return function(target)
	ToDoList = Roact.mount(e(ToDoList), target, "ToDoList")

	return function()
		Roact.unmount(ToDoList)
	end
end
