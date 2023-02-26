local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)

local e = Roact.createElement
local ToDoList = require(ReplicatedStorage.Gui.App.ToDoList)

local app = e("ScreenGui", {
	ResetOnSpawn = false,
	IgnoreGuiInset = true
}, {
	ToDoList = e(ToDoList, {}),
})

Roact.mount(app, Players.LocalPlayer.PlayerGui, "PlayerUI")
