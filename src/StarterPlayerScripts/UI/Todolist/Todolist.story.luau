local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local e = Roact.createElement

local Todolist = require(script.Parent.Todolist)

return function (target)
    Todolist = Roact.mount(e(Todolist), target, "Todolist")

    return function ()
        Roact.unmount(Todolist)
    end
end