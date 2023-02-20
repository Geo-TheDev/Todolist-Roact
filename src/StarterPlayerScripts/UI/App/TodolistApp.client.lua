local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.Roact)

local Todolist = require(script.Parent.Parent.Todolist.Todolist)

local e = Roact.createElement

local app = e("ScreenGui", { ResetOnSpawn = false }, {
    UI = e(Todolist, {})
})

Roact.mount(app, Players.LocalPlayer.PlayerGui, "PlayerUI")